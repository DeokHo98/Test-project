//
//  Delegate.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import Foundation

protocol keyWordDelegate: AnyObject {
    func didSelectRowAt(keyword: String)
    func didSelectRowAt(viewModel: GIFViewModelList)
    func scrollCollectionView()
}
