//
//  Settings.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.09.2021.
//

import SwiftUI

struct Settings: View {
    struct FileItem: Hashable, Identifiable, CustomStringConvertible {
            var id: Self { self }
            var name: String
            var children: [FileItem]? = nil
            var description: String {
                switch children {
                case nil:
                    return "📄 \(name)"
                case .some(let children):
                    return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
                }
            }
        }
        let fileHierarchyData: [FileItem] = [
          FileItem(name: "users", children:
            [FileItem(name: "user1234", children:
              [FileItem(name: "Photos", children:
                [FileItem(name: "photo001.jpg"),
                 FileItem(name: "photo002.jpg")]),
               FileItem(name: "Movies", children:
                 [FileItem(name: "movie001.mp4")]),
                  FileItem(name: "Documents", children: [])
              ]),
             FileItem(name: "newuser", children:
               [FileItem(name: "Documents", children: [])
               ])
            ]),
            FileItem(name: "private", children: nil)
        ]
        var body: some View {
            List(fileHierarchyData, children: \.children) { item in
                Text(item.description)
            }
        }
    
}
//}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
