//
//  Errors.swift
//  SwiftyTools
//
//  Created by Vladas Zakrevskis on 6/14/17.
//  Copyright © 2017 VladasZ All rights reserved.
//

import Foundation

public class FailedToInitializeBlockError : Error {
    var localizedDescription: String { return "Failed to initialize block" }
}

public class FailedToConvertBlockError : Error {
    var localizedDescription: String { return "Failed to convert block" }
}

public class FailedToExtractBlockError : Error {
    var localizedDescription: String { return "Failed to extract block" }
}
