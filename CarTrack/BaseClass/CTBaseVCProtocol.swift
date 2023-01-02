//
//  CTBaseVCProtocol.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation
protocol CTBaseVCProtocol {
    func reportNoNetwork()
    func reloadPage()
    func didBeginLoading()
    func didFinishLoading()
    func initializeVariables()
    func initializeViews()
    func loadContent()
    
}
