//
//  SupportedTypes.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/15/17.
//  Copyright © 2017 VladasZ All rights reserved.
//

import Foundation

public protocol NodeSupportedType { }

extension Bool   : NodeSupportedType { }
extension Int    : NodeSupportedType { }
extension Double : NodeSupportedType { }
extension String : NodeSupportedType { }
