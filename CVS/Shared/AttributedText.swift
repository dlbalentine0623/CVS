import SwiftUI
import WebKit

struct AttributedText: UIViewRepresentable {
    typealias UIViewType = UITextView

    var text: String

    func updateUIView(_ uiView: UITextView, context: Context) { }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false

        NSAttributedString.loadFromHTML(string: text) { attributedString, options, error in
            DispatchQueue.main.async {
                textView.attributedText = attributedString
                textView.setAttributedMarkedText(attributedString, selectedRange: NSMakeRange(0, text.count - 1))
            }
        }

        return textView
    }
}
