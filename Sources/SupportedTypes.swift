//
//  SupportedTypes.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 6/15/17.
//  Copyright © 2017 VladasZ All rights reserved.
//

import Foundation

public protocol NodeSupportedType { }

public extension Bool   : NodeSupportedType { }
public extension Int    : NodeSupportedType { }
public extension Double : NodeSupportedType { }
public extension String : NodeSupportedType { }
