//
//  EffectDetail.swift
//  In-appPuchases
//
//  Created by Diego Andrés Ramón Sanchís on 17/11/23.
//

import Foundation
import UIKit

class EffectDetail: UIViewController {

    var quicktitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = quicktitle
    }
}
