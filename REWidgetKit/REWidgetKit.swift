//
//  REWidgetKit.swift
//  REWidgetKit
//
//  Created by Lucas Oliveira on 27/08/21.
//

import WidgetKit
import SwiftUI
import Intents
import REUIKit
import Services

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry

    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), title: "", local: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        if context.isPreview {
            let entry = SimpleEntry(date: .init(),
                                    title: "iPhone",
                                    local: "isPreview = \(context.isPreview.description)")
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {

        var entries = [SimpleEntry(date: Date(),
                                   title: "iPhone",
                                   local: "CEE CORREIOS FORTALEZA",
                                   fiveSecondsCounter: 1)]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let title: String
    let local: String
    var fiveSecondsCounter: Int = 0
}

struct REWidgetKitEntryView: View {
    var entry: Provider.Entry
    let gradient = Gradient(colors: [Color(.REYellow), Color(UIColor(red: 0.949, green: 0.686, blue: 0.38, alpha: 1))])

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            Rectangle()
                .fill(LinearGradient(gradient: gradient, startPoint: .bottom, endPoint: .top))

            VStack(alignment: .leading) {
                Link(destination: URL(string: "https://www.apple.com")!, label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 38, height: 38)
                            .cornerRadius(3.5)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: -3, y: 4)
                        Image(uiImage: .icShippingBox ?? .add)
                            .frame(width: 22, height: 22, alignment: .center)
                            .foregroundColor(Color(.REYellow))
                    }
                })
                Text(entry.title)
                    .padding(.init(top: 4, leading: 0, bottom: 0, trailing: 0))
                    .font(.REtitle)
                    .foregroundColor(Color(.REGray4))
                Text(entry.local)
                    .padding(.init(top: 1, leading: 0, bottom: 0, trailing: 0))
                    .font(.RESubtitle)
                    .foregroundColor(Color(.REGray4))
            }
            .padding(.init(top: 0, leading: 14, bottom: 22, trailing: 0))
        }
    }
}

@main
struct REWidgetKit: Widget {
    let kind: String = "REWidgetKit"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), content: { entry  in
            REWidgetKitEntryView(entry: entry)
        })
        .configurationDisplayName("Rastreia Pacote")
        .supportedFamilies([.systemMedium])
    }
}

struct REWidgetKit_Previews: PreviewProvider {
    static var previews: some View {
        REWidgetKitEntryView(entry: SimpleEntry(date: Date(), title: "iPhone", local: "CEE CORREIOS FORTALEZA"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
