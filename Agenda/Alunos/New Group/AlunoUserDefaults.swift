//
//  AlunoUserDefaults.swift
//  Agenda
//
//  Created by Lucas Abdel Leitao on 30/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class AlunoUserDefaults: NSObject {
    
    let preferencias = UserDefaults.standard
    
    func salvaVersao(_ json: Dictionary<String, Any>){
        guard let versao = json["momentoDaUltimaModificacao"] as? String else {return}
        
        preferencias.set(versao, forKey: "ultima-versao")
    }
    
    func recuperaUltimaVersao() -> String? {
        let versao = preferencias.object(forKey: "ultima-versao")as? String
        return versao
    }
}
