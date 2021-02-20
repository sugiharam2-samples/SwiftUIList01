//
//  ContentView.swift
//  SwiftUIList01
//
//  Created by Mamoru Sugihara on 2021/02/16.
//

import SwiftUI

struct ContentView: View {
	@State var selected: UUID?
	@State var scrollTop = false

	var items = (0..<100).map { ItemData(value: $0 * 2 + 10001) }

	var body: some View {
		ScrollViewReader { proxy in
			NavigationView {
				List(items) { item in
					ItemView(item: Binding.constant(item), parent: Binding.constant(self))
				}
				.listStyle(PlainListStyle())
				.navigationBarTitle(Text("List01"), displayMode: .automatic)
				.navigationBarItems(trailing:
					Button(scrollTop ? "Top" : "Bottom") {
						withAnimation {
							proxy.scrollTo((scrollTop ? items.first : items.last)!.id, anchor: .top)
							scrollTop = !scrollTop
						}
					}
				)
			}
		}
	}
}

struct ItemData: Identifiable {
	var value = 0
	let id = UUID()

	var idString: String {
		get { return String(id.uuidString.prefix(5)) }
	}
}

struct ItemView: View {
	@Binding var item: ItemData
	@Binding var parent: ContentView

	var body: some View {
		VStack {
			let showDetail = parent.selected == item.id
			Text("\(showDetail ? "> " : "")Item \(item.idString) => \(item.value)")
				.frame(maxWidth: .infinity, alignment: .leading)
			Text(showDetail ? "Detail 1\nDetail 2\nDetail 3" : "--")
				.multilineTextAlignment(.trailing)
				.frame(maxWidth: .infinity, alignment: .trailing)
		}
		.contentShape(Rectangle())
		.onTapGesture {
			withAnimation() {
				parent.selected = parent.selected != item.id ? item.id : nil
			}
		}
	}

	init(item: Binding<ItemData>, parent: Binding<ContentView>) {
		_item = item
		_parent = parent
		print("init: \(item.wrappedValue.idString)")
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
