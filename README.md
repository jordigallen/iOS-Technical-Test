# iOS - Technical Test

[![Build Status](https://travis-ci.org/jordigallen/ios-Technical-Test.svg?branch=develop)](https://travis-ci.org/jordigallen/ios-Technical-Test)
[![Coverage Status](https://coveralls.io/repos/github/jordigallen/ios-Technical-Test/badge.svg?branch=develop)](https://coveralls.io/github/jordigallen/ios-Technical-Test?branch=develop)
[![OS Version: iOS 14.2](https://img.shields.io/badge/iOS-14.2-green.svg)](https://www.apple.com/es/ios/ios-14/)
[![License](https://img.shields.io/cocoapods/l/Swinject.svg?style=flat)](http://cocoapods.org/pods/Swinject)
[![Swift Version](https://img.shields.io/badge/Swift-5.x-F16D39.svg?style=flat)](https://developer.apple.com/swift)

In this manuscript he explains how everything has been implemented, along with some additional tools and what the Challenge App for ElectroMaps offers us.

With a test percentage greater than: 75%

## Table of contents

- [ios-Technical-Test](#ios-Technical-Test)
  * [Table of contents](#table-of-contents)
  * [Before starting](#before-starting)
    + [Code styling](#code-styling)
    + [Architecture and design pattern](#architecture-and-design-pattern)
      - [Repository and Remote Manager](#repository-and-remote-manager)
      - [Model-View-Presenter architecture](#architecture-model-view-presenter)
      - [A comment on reactive programming](#a-comment-on-reactive-programming)
    + [Storyboards and XIB files](#storyboards-and-xib-files)
    + [Dependency injection](#dependency-injection)
  * [Feature implementation](#feature-implementation)
    + [iOS 14 and dark mode](#ios-14-and-dark-mode)
  * [Tests](#tests)
    + [Unit tests](#unit-tests)
    + [Snapshot tests](#snapshot-tests)
    + [UI tests](#ui-tests)
      - [MockServer](#mockserver)
  * [Third-party frameworks](#third-party-frameworks)
    + [AlamofireImage](#alamofireimage)
    + [PromiseKit](#promiseKit)
    + [Swinject](#swinject)
    + [SwinjectStoryboard](#swinjectStoryboard)
    + [SwiftGen](#swiftGen)
    + [SwiftLint](#swiftLint)
    + [SnapshotTesting](#snapshottesting)
  * [Tools](#tools)
    + [Continuous Integration server](#continuous-integration-server)
    + [Code coverage reports](#code-coverage-reports)

## Before starting

As a first step prior to implementing the requested function, we analyze the code provided to create a list of tasks to perform. With this analysis I concluded:
- Code style
- What architecture to use
- How to structure the project
- Which library to use
- Performing unit tests, screenshoot test and testUI


### Code styling

The original code base lacked of a homogeneous code style. Therefore, our first step in the refactor consisted in choosing a code style guide to use, and then refactor the code to conform to it. Since it's already a standard used by most developers, we chose the Swift code style guide from Ray Wenderlich which can be found [here](https://github.com/raywenderlich/swift-style-guide), with a minor exception in the [Spacing](https://github.com/raywenderlich/swift-style-guide#spacing) section: we use **4 spaces** instead of 2 to indent.

In addition, we have been running [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) locally at least once a day to make sure that our code followed the aforementioned guidelines.


### Architecture and design pattern

The next step in our set-up was to add some architecture. I wanted a modern design to divide responsibilities and concerns, trying to fully comply with the SOLID principles. Finally I decided to use the ** Model-View-Presenter ** architecture, adding the repositories with use cases.


#### Repository and Remote Manage

To create the callouts layer, I have designed it with two layers:

* Repository layer: The repository layer was in charge of making the requests. In the first step, prepare the call with the data that was needed, and in addition to notifying whoever is using it of the success or failure of the call, returning.

In this layer, in case of success and the results returned, through promises (PromiseKit pod) to work synchronously, once the retrieved results will be stored if we do not have them, or they will be updated if there are new results relative to those stored or directly if the response contains the same results that were already stored in Usser Defaults, it will leave the DB as it was.

In this case, the storage layer, since the data to store are basic types and with simple structures, I decided to create a generic Usser defaults. Create that it is important to understand the statement well and be clear about what we want to do to make decisions like this to use UD. Because I could also have used CoreData or Realm as I have worked on other projects. But it seemed to me about sizing the project, when really, both the data that had to be stored and the operations to be carried out, were enough with the power that the native iOS user defaults offers us and creating a good generic UD.

This layer, named `StorageManager` under a` StorageManagerProtocol` protocol, we can perform any type of operation on the database.
* Save
* Retrieve an item using a key
* Delete an element using a key
* Clear all items

* Remote Layer:

This layer can be compared to the UsserDefaults manager. Following the flow a bit, if we take a step back in the repository layer it has two instances using Swinject.

* A storage manager protocol
* A protocol of the remote manager

Going back to the remote layer, it has the four operations that can be done in a request to the API and they are:

* `POST`
* `GET`
* `PUT`
* `DELETE`

And all the previous points fall on a single site, also generic. It accepts any kind of input and output, and this is the `request` function. This function is responsible for making the call to server, if everything has gone well it will return the results with the type it touches. If there has been a problem. Whether it was unable to convert the data, a network connection problem, or a problem with the API server.

All this is processed with another error manager, the 'ErrorManager', which is able to distinguish what the error has been and be sent to the view through protocols / delegates. Since any View Controler that the App has inherits from a `BaseViewController`. And one of the functions that it has, and is to show a native iOS AlertView explaining what has happened and steps to follow.


#### Architecture Model-View-Presenter

Our next step after implementing the repository and remote layers was to adopt an MVP design pattern. This task included implementing presenter classes for any view or view controller in the application, and moving any logic that is not directly related to view creation, view update, or user interaction handling to the view model.

As is customary in the MVP pattern, views notify their view presenter of any user interaction, view models perform corresponding actions and request that views be updated via delegate (if necessary). As a result, several new delegates were created to handle two-way communication.

It is important to mention the communication between the view and the presenter. And it is because the view has no logic, it only takes care of the user's actions on the screen and painting the data that comes from deeper layers. All the business logic falls on the presenter, he is in charge of maintaining the proper state of the views. With this we achieve a greater decoupling that will improve us when testing and respecting the Single Responsibility Principle.

All communication between layers is done through protocols, respecting Interface Segregation Principle, with small interfaces and with its main function, without other functions being out of context.

And comment that each class and structure developed respects the Open / Closed Principle, to be able to be extended without having to be modified.

And obviously each module or each layer respects the Dependency Inversion Principle. That forces us to reduce the dependencies between the modules of the code, that is, to achieve a low coupling of the classes.


#### A comment on reactive programming

We thought deeply about whether to use reactive programming or not during this task. We finally decided not to do it for several reasons:
* Most of the Reactive programming frameworks (mainly [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) and [RxSwift](https://github.com/ReactiveX/RxSwift)) are **huge** Dependencies that increase either the size of the repository (if it was checked in to the repository) or the compile time due to the download and configuration process (if not). When using a CI server, the execution time is greatly increased if it is not cached.
* This task is a small application, which would not benefit much (or not benefit at all) from these frameworks. In fact, there are only a couple of places in the code that would really benefit from a reactive approach: the single service that makes asynchronous calls and the tap of a collection view cell on the home screen (which currently broadcasts the action to through two delegates). However, the completion and delegate blocks already meet our needs in both cases, respectively.
* [Combine](https://developer.apple.com/documentation/combine/), which is Apple's reactive framework, was released just a few months ago. Although it seems to be a good alternative, referring to what was before, it is not a test that justifies making it reactive.

#### A comment on BBDD Realm
I started the app with Realm. But seeing that the entity and operations we perform are on the app, I decided to use UsserDefaults. Where I create a Manager for it to be able to perform the basic functions in a DB (add, delete, delete everything, change) and with this we avoid external and unnecessary Pods for such a small app.

### Storyboards and XIB files

I have always used storyboards and xibs, and it is where I feel most comfortable, I am also used to using them, and avoid writing in all the positives writing graphic components programmatically. So I decided to use them in this task to further remove the code from the view classes and keep them * clean * and as short as possible.

### Dependency injection

In spite of that, I have worked with files 'Router' where each view that navigation has defines you. Lately in the projects that I have been working with Swinject and SwinjectStrory board, and I find a clean and comfortable way to inject dependency in the different parts of the chosen architecture.
From what we have, the project is divided into two views, one of the list and the other of detail and each one of them has a folder of 'DI' where by means of swinject, we inject the preseter, the use case and the repository And on the other hand we have using the SwinjectStoryboard, we inject the storyboard with its ViewController.

## Feature implementation

Once the requirements were sketched in mind, I described the specifications for the development of each of the tasks:
* All screen will support rotation both vertically and horizontally.
* The first screen displays a list of TV Shows.
* In case of error, an alert should be displayed to inform the user with a single button to close the alert.
* In case a result does not yield any results, the user must be informed without disturbing the normal use of the application (therefore, there are no alerts).
* The second screen shows the detail of the TVShow.
* The detail screen must allow rotation to the landscape.

These requirements lead to the implementation and final design that we show in the following GIF:

<img src="ElectroMapsTour.gif" width="300">

### iOS 14 and dark mode

I have implemented the app with iOS 14.0 or higher. The reasoning behind this is that iOS 14 included a lot of API changes, mainly due to the addition of * dark mode * in iOS, and therefore it was simpler to raise the deployment target to that version instead of handling each API not supported function invoked.

As a consequence, it should be mentioned that the application supports dark mode. Feel free to give it a try [by activating dark mode in the simulator!](Https://technikales.com/how-to-turn-on-dark-mode-in-ios-14-simulator/)

<img src="ElectroMapsTourDarkMode.gif" width="300">


## Tests

All the tests in the app are built under the triple A pattern, better known as 3A or AAA. The AAA (Arrange-Act-Assert) pattern has become almost a standard across the industry. It suggests that you should divide your test method into three sections: arrange, act and assert. Each one of them only responsible for the part in which they are named after.
App code should respect most, if not all, rules of production code. It should avoid meaningless magic numbers, should avoid violating principles like DRY, YAGNI, SRP and KISS.

I have implemented unit tests at the business logic level, as well as views in ScreenShots and UITest at the application flow level, all with the intention of reaching 100% coverage.

In the repository itself you can see the percentage of coverage that the project has, as well as whether all the tests are passing or not.

To do this I have created a CI server in the GitHub repository with [TravisCI](https://travis-ci.org/github/jordigallen/ios-Technical-Test) and [Coverals](https://coveralls.io/github/jordigallen/ios-Technical-Test).

The operation is basic, when I create a branch of type:
* feature / XXX (new feature to implement)
* refactor / XXX (code enhancement)
* bugfixing / XXX (fix some bug after doing QA or some test failure)
It is the nomenclature that I have followed in the project. Once I have finished with the branch and done the PR, they run the TravisCI test and if everything goes well it is integrated into the develop branch.

'Note: To be honest, I have not reached 100% due to lack of time, my idea is, after delivering this test, is to reach the goal'

## Third-party frameworks

Since the frameworks were not included in the original repository, one of the first things we had to do is perform a `pod install --repo-update` in the root folder to install dependencies. After that, we reviewed all the dependencies included in the `Podfile` and their usage in the code. As a consequence, we remove all of the dependencies except for `AlamofireImage`, which was the only one under use.

During the implementation of the search feature and the tests we decided to use some additional dependencies, which we discuss in the following.

**Note:** The `Pods/` folder in now checked into the repository, so that we can just download and press `Run` to execute the app in the simulator.

### AlamofireImage

`AlamofireImage` is a library that enables to easily manage downloading and setting images from the internet. It has a simple and clear API, and includes a built-in cache system to avoid downloading the same image again and again.

**Source:** [https://github.com/Alamofire/AlamofireImage](https://github.com/Alamofire/AlamofireImage)

### PromiseKit

Promises simplify asynchronous programming, freeing you up to focus on the more important things. They are easy to learn, easy to master and result in clearer, more readable code. Your co-workers will thank you.

**Source:** [https://github.com/mxcl/PromiseKit](https://github.com/mxcl/PromiseKit)

### Swinject

Dependency injection (DI) is a software design pattern that implements Inversion of Control (IoC) for resolving dependencies. In the pattern, Swinject helps your app split into loosely-coupled components, which can be developed, tested and maintained more easily. Swinject is powered by the Swift generic type system and first class functions to define dependencies of your app simply and fluently.

**Source:** [https://github.com/Swinject/Swinject](https://github.com/Swinject/Swinject)

### SwinjectStoryboard

SwinjectStoryboard is an extension of Swinject to automatically inject dependency to view controllers instantiated by a storyboard.

**Source:** [https://github.com/Swinject/SwinjectStoryboard](https://github.com/Swinject/SwinjectStoryboard)


### SwiftGen

SwiftGen is a tool to automatically generate Swift code for resources of your projects (like images, localised strings, etc), to make them type-safe to use.

**Source:** [https://github.com/SwiftGen/SwiftGen](https://github.com/SwiftGen/SwiftGen)


### SwiftLint

A tool to enforce Swift style and conventions, loosely based on GitHub's Swift Style Guide.

SwiftLint hooks into Clang and SourceKit to use the AST representation of your source files for more accurate results.

**Source:** [https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint)


### SnapshotTesting

`SnapshotTesting` is a library similar to [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case) (formerly maintained by Facebook, now maintained by Uber) developed by the awesome team of Point-Free. Contratry to `iOSSnapshotTestCase`, `SnapshotTesting` is written purely in Swift and is compatible with [Nimble](https://github.com/Quick/Nimble) using a plugin.

This library enables us to snapshot test views, server responses and more in several formats, from images to plain text files, which makes it outstandingly versatile.

**Source:** [https://github.com/pointfreeco/swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)

### Swifter

`Swifter` is a library providing a tiny http server engine written in Swift. Documentation is short at the very best in their GitHub, but the repository does include several examples and use cases which are really helpful. This is the base for the [MockServer](#mockserver) class introduced previously.


## Tools

In addition to the feature implementation, the code refactor and the tests implementation, we added several tools to the repository which helped us during this assignment.

### Continuous Integration server

Since this repository is *public* (since it's forked from a *public* repository), we created a Travis CI instance attached to it to run tests and perform additional tasks automatically when several conditions met. In combination with our branching strategy and some protection rules on `master` and `develop`, we ensure that no code was ever merged to these branches without passing the proper tests.

The current jobs and triggers are the following:
- **Compile**: Just compiles the app. This job is executed when a pull request to `master` or `develop` is opened, to prevent merging any change that breaks the app build. If this job fails, no further jobs are executed.
- **Run unit tests**: Runs the unit tests suite. This job is executed when a pull request to `master` or `develop` is opened.
- **Run UI tests**: Runs the UI tests suite. This job is executed when a pull request to `master` or `develop` is opened.
- **Gather code coverage data**: Runs the complete tests suites. If all test succeed, the coverage data is uploaded to Coveralls using Slather (see [Code coverage reports](#code-coverage-reports) below). This job is executed when a commit is pushed to either `master` or `develop`. Note that since both branches are protected and only pushes by means of pull requests are allowed, tests should always succeed (since they must succeed to enable merging).

You may take a look at all the jobs execute, and to the Travis CI instance, by following this link:

[https://travis-ci.com/github/jordigallen/ios-Technical-Test](https://github.com/jordigallen/ios-Technical-Test)

### Code coverage reports

Since this repository is *public* (since it's forked from a *public* repository), we created a Coveralls instance attached to it to gather code coverage data and display it as a report. This code coverage data is generated automatically by Xcode command line tools when running tests if properly set, and gathered and uploaded to Coveralls using [Slather](https://github.com/SlatherOrg/slather).

You may take a look at the code coverage reports for `master` in Coveralls by following this link:

[https://travis-ci.com/github/jordigallen/ios-Technical-Test](https://travis-ci.com/github/jordigallen/ios-Technical-Test)
