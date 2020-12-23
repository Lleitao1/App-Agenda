//
//  Repositorio.swift
//  Agenda
//
//  Created by Lucas Abdel Leitao on 22/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    
    func salvarAluno(aluno: Dictionary <String, String>){
        AlunoAPI().salvaAlunosNoServidor(parametros: [aluno])
        AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
    }
    
}
