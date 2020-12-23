//
//  Repositorio.swift
//  Agenda
//
//  Created by Lucas Abdel Leitao on 22/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    
    
    func recuperaAlunos(completion: @escaping(_ listaDeAlunos: Array<Aluno>)-> Void){
        var alunos = AlunoDAO().recuperaAluno()
        if alunos.count == 0{
            AlunoAPI().recuperaAlunos {
                alunos = AlunoDAO().recuperaAluno()
                completion(alunos)
            }
            
        }else{
            completion (alunos)
            
        }
    }
    
    func salvarAluno(aluno: Dictionary <String, String>){
        AlunoAPI().salvaAlunosNoServidor(parametros: [aluno])
        AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
    }
    
}
