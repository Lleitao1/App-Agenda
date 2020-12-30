//
//  WebSafari.swift
//  Agenda
//
//  Created by Lucas Abdel Leitao on 24/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import SafariServices

class WebSafari: NSObject {
    
    func abrePaginaWeb(_ alunoSelecionado: Aluno, controller: UIViewController){
        if let urlDoAluno = alunoSelecionado.site {
            var urlFormatada = urlDoAluno
            
            if !urlFormatada.hasPrefix("http://") {
                urlFormatada = String(format: "http://%@", urlFormatada)
                                    }
            
        guard let url = URL(string: urlFormatada) else { return }
        let safariViewController = SFSafariViewController(url: url)
            controller.present(safariViewController, animated: true, completion: nil)
        }
    }
}
