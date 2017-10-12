//
//  SupportedTypes.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 6/15/17.
//  Copyright © 2017 VladasZ All rights reserved.
//

import Foundation

public protocol BlockSupportedType { }

extension Bool   : BlockSupportedType { }
extension Int    : BlockSupportedType { }
extension Double : BlockSupportedType { }
extension String : BlockSupportedType { }
