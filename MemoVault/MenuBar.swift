//
//  MenuBar.swift
//  MemoVault
//
//  Created by Wanounou Ilan on 28/08/2024.
//

import SwiftUI
import SwiftData

struct MenuBar: Scene {
    @StateObject private var clipboardObserver = ClipboardObserver()
    @Query private var items: [Item]
    @State var currentNumber: String = "1"
    var body: some Scene {
        MenuBarExtra("Utility App", systemImage: "hammer") {
            ForEach(items) { item in
                Button(item.text) {
                    clipboardObserver.past(text: item.text)
                }
            }
            Divider()
            Button("Clear") {
                
            }
            Divider()
            Button("Quit App") {
                
            }
        }
    }
}
/*#Preview {
    MenuBar()
}
*/
