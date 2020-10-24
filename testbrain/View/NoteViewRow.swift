//
//  NoteViewRow.swift
//  testbrain
//
//  Created by 16997598 on 22.10.2020.
//  Copyright © 2020 Mikhail Seregin. All rights reserved.
//

import SwiftUI

struct NoteViewRow: View {
    let data: MomentResponse
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.title)
            Text(data.notes)
            Image(uiImage: UIImage(data: try! Data(contentsOf: u))!)
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
    
    var url: URL? {
        URL(string: data.photo?.url ?? "")
    }
    
    var u: URL {
        if let url = url {
            return url
        } else {
            return URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png")!
        }
    }
}
