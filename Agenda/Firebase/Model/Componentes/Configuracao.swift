//
//  Configuracao.swift
//  Agenda
//
//  Created by Lucas Abdel Leitao on 30/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class Configuracao: NSObject {
    
    func getUrlPadrao() -> String? {
        
        
        guard let caminhoParaPlist = Bundle.main.path(forResource: "Info", ofType: "plist") else {return nil}
        guard let dicionario = NSDictionary(contentsOf: caminhoParaPlist) else {return nil}
        guard let urlPadrao = dicionario ["URLpadrao"] as? String else {return nil}
        
        return urlPadrao
    }

}
