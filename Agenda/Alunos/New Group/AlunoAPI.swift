//
//  AlunoAPI.swift
//  Agenda
//
//  Created by Lucas Abdel Leitao on 22/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import Alamofire

class AlunoAPI: NSObject {
    
    lazy var url: String{
       guard let url = Configuracao().getUrlPadrao() else {return ""}
        
       return url
    }
    
    
    // MARK: - GET
    func recuperaAlunos(completion: @escaping() -> Void) {
        
        Alamofire.request(url + "/api/aluno", method: .get).responseJSON{ (response) in switch response.result {
        case .success:
            print (response.result.value!)
            if let resposta = response.result.value as? Dictionary<String, Any>{
                self.serializaAlunos(resposta)
                completion()
            }
            break
        case .failure:
            print (response.error!)
            completion()
            break
            }
            
        }
    }
    
    func recuperaUltimosAlunos(_ versao: String, completion: @escaping() -> Void){
        Alamofire.request(url + "api/aluno/diff", method: .get, headers: ["datahora": versao]).responseJSON{
            (response) in
            switch response.result{
            case .success :
                if let resposta = response.result.value as? Dictionary<String, Any>{
                    self.serializaAlunos(resposta)
                }
                completion()
                break
            case .failure:
                break
            }
        }
        
    }
    
    // MARK: - PUT
    func salvaAlunosNoServidor(parametros: Array<Dictionary<String, String>>){
        guard let urlPadrao = Configuracao().getUrlPadrao() else {return}
        
        guard let url = URL(string: urlPadrao + "api/aluno/lista") else {return}
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
        
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(requisicao)
    }
    
    //MARK: - DELETE
    
    func deletaAluno(id: String) {
        
        Alamofire.request(url + "/api/aluno/\(id)", method: .delete).responseJSON { (resposta) in
            switch resposta.result{
            case .failure:
                print (resposta.result.error!)
                break
            default:
                break
            }
        }
    }
    //MARK: - Serializacao
    func serializaAlunos(_ resposta: Dictionary<String, Any>){
        guard let listaDeAlunos = resposta["alunos"] as? Array<Dictionary<String,Any>> else{return}
        
        for dicionarioDeAluno in listaDeAlunos {
            guard let status = dicionarioDeAluno["desativado"] as? Bool else{return}
            
            if status {
                guard let idDoALuno = dicionarioDeAluno["id"] as? String else{return}
                guard let UUIDAluno = UUID(uuidString: idDoALuno) else{return}
                if let aluno = AlunoDAO().recuperaAlunos().filter({ $0.id == UUIDAluno}).first{
                    AlunoDAO().DeletaAluno(aluno: aluno)
                }
            }else{
                AlunoDAO.salvaAluno(dicionarioDeAluno: dicionarioDeAluno)
            }
        AlunoUserDefaults().salvaVersao(resposta)
        }
    }
}
