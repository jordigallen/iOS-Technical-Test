//
//  SwinjectAssembler.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Swinject

final class Assembler {
    static let shared: Assembler = Assembler()

    private let container: Container

    var resolver: Resolver {
        return self.container.synchronize()
    }

    private init() {
        self.container = Container()

        let assemblies = Assembler.assemblers

        for assembly in assemblies {
            assembly.assemble(container: self.container)
        }

        for assembly in assemblies {
            assembly.loaded(resolver: self.resolver)
        }
    }
}

extension Assembler {
    private static var assemblers: [Assembly] {
        return [CommonAssembly(),
                ListAssembly()]
    }
}
