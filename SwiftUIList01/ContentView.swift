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
	@State var openCell = false

	var body: some View {
		ZStack {
			Color.blue.opacity(0.3)
			VStack {
				Text("Item \(item.idString) => \(item.value)")
					.frame(maxWidth: .infinity, alignment: .leading)
				Text("--")
					.multilineTextAlignment(.trailing)
					.frame(maxWidth: .infinity, alignment: .trailing)
				Spacer()
			}
			.opacity(openCell ? 0 : 1)
			VStack {
				Text((0..<(openCell ? 5 : 1)).map { "Detail \($0)" }.joined(separator: "\n"))
					.multilineTextAlignment(.trailing)
					.frame(maxWidth: .infinity, alignment: .trailing)
			}
			.opacity(openCell ? 1 : 0)
		}
		.fixedSize(horizontal: false, vertical: true)
		.modifier(AnimatingCellHeight(height: openCell ? 120 : 60))
		.animation(.linear)
		.contentShape(Rectangle())
		.onTapGesture {
			openCell.toggle()
		}
	}

	init(item: Binding<ItemData>, parent: Binding<ContentView>) {
		_item = item
		_parent = parent
		print("init: \(item.wrappedValue.idString)")
	}
}

struct AnimatingCellHeight: AnimatableModifier {
	var height: CGFloat = 0

	var animatableData: CGFloat {
		get { height }
		set { height = newValue }
	}

	func body(content: Content) -> some View {
		content.frame(height: height)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
