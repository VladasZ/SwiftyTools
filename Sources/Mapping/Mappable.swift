//
//  Mappable.swift
//  Actors Pocket Guide
//
//  Created by Vladas Zakrevskis on 05.10.2020.
//  Copyright © 2020 Atomichronica. All rights reserved.
//

import EVReflection


public class Mappable : EVObject {
    public var toString: String {
       toJsonString()
    }
}
