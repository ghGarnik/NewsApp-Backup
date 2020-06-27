//
//  FavouriteButtonState.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum FavouriteButtonState {
       case buttonOn
       case buttonOff
       
       var imageName: String {
           switch self {
           case .buttonOn:
               return "favIconOn"
           case .buttonOff:
               return "favIconOff"
           }
       }
   }
