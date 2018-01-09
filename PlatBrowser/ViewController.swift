//
//  ViewController.swift
//  PlatBrowser
//
//  Created by Platiplus on 29/12/17.
//  Copyright © 2017 Platiplus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UIWebViewDelegate {
    
    
    @IBOutlet weak var webSearch: UISearchBar!
    @IBOutlet weak var webScreen: UIWebView!
    
    //Funcionalidade: Voltar a Página
    @IBAction func backButton(_ sender: Any) {
        if webScreen.canGoBack{
            webScreen.goBack()
        }
    }
    
    //Funcionalidade: Atualizar a Página
    @IBAction func refreshButton(_ sender: Any) {
        webScreen.reload()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //Esconde o Teclado
        webSearch.resignFirstResponder()
        
        //Declara o endereço digitado como uma constante
        let link = webSearch.text
        
        //Checa se o link contém um prefixo válido, em caso positivo, manda a request de carregamento da página.
        if (link?.isValidURL())!{
            webScreen.loadRequest(URLRequest(url: URL(string: link!)!))
        }
        //Em caso negativo, declara uma String com o prefixo padrão e adiciona o endereço digitado pelo usuário para enviar a solicitação.
        else {
            var defaultPrefix = "http://"
            defaultPrefix.append(link!)
            webScreen.loadRequest(URLRequest(url: URL(string: defaultPrefix)!))
        }
    }
    
    //Mostra na barra um indicador de que a página está carregando, no caso de páginas mais pesadas.
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    //Desliga o indicador na barra que mostra que a página está carregando.
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    //Funcionalidade: Avançar a Página
    @IBAction func fwdButton(_ sender: Any) {
        if webScreen.canGoForward{
            webScreen.goForward()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Define no carregamento do programa a página inicial
        webScreen.loadRequest(URLRequest(url: URL(string: "http://www.google.com")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

//Extende a classe String para checagem do prefixo nas URLS.
extension String {
    
    func isValidURL() -> Bool{
        if self.lowercased().hasPrefix("http://") || self.lowercased().hasPrefix("https://"){
            return true
        }
        return false
    }
}
