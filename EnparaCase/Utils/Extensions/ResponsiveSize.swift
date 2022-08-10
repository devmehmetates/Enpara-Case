//
//  ResponsiveSize.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 9.08.2022.
//

import UIKit

extension Double {
    
    var responsiveW: Double { UIScreen.main.bounds.size.width * self / 100 }
    var responsiveH: Double { UIScreen.main.bounds.size.height * self / 100 }
}
