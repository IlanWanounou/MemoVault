//
//  ContentView.swift
//  MemoVault
//
//  Created by Wanounou Ilan on 24/08/2024.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @StateObject private var clipboardObserver = ClipboardObserver()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: ItemDetailView(item: item, clipboardObserver: clipboardObserver)) {
                        Text(item.text)
                    }
                }
                .onDelete(perform: deleteItems)
            }.navigationSplitViewColumnWidth(min: 180, ideal: 200)
        } detail: {
            Text("Select an item")
        }
        .onAppear {
            clipboardObserver.onClipboardChange = { copiedText in
                addItem(text: copiedText)
            }
        }
    }

    private func addItem(text: String) {
        withAnimation {
            let newItem = Item(text: text)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

struct ItemDetailView: View {
    let item: Item
    @ObservedObject var clipboardObserver: ClipboardObserver

    var body: some View {
        Text(item.text)
            .onAppear {
                clipboardObserver.past(text: item.text)
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
