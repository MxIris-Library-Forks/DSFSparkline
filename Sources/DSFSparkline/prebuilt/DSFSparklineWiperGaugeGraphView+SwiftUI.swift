//
//  DSFSparklineWiperGaugeGraphView+SwiftUI.swift
//
//  Copyright © 2023 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#if canImport(SwiftUI)

import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
public extension DSFSparklineWiperGaugeGraphView {

	/// The SwiftUI percent bar graph
	struct SwiftUI {
		/// Palette to use when coloring the chart
		let valueColor: DSFSparkline.FillContainer
		/// The value to display in the chart
		let value: Double
		/// Should changes to value be animated?
		let animated: Bool

		/// Create a sparkline graph that displays a 0 ... 1 value as a gauge
		/// - Parameters:
		///   - palette: The palette to use when presenting the value
		///   - value: The value to display
		///   - animated: Should updates to `value` be animated?
		public init(valueColor: DSFSparkline.FillContainer, value: Double, animated: Bool = false) {
			self.valueColor = valueColor
			self.value = value
			self.animated = animated
		}
	}
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
extension DSFSparklineWiperGaugeGraphView.SwiftUI: DSFViewRepresentable {
	#if os(macOS)
	public typealias NSViewType = DSFSparklineWiperGaugeGraphView
	#else
	public typealias UIViewType = DSFSparklineWiperGaugeGraphView
	#endif
	
	public class Coordinator: NSObject {
		let parent: DSFSparklineWiperGaugeGraphView.SwiftUI
		init(_ sparkline: DSFSparklineWiperGaugeGraphView.SwiftUI) {
			self.parent = sparkline
		}
	}
	
	public func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeWiperGauge(_: Context) -> DSFSparklineWiperGaugeGraphView {
		let view = DSFSparklineWiperGaugeGraphView(frame: .zero)
		view.valueColor = self.valueColor
		view.value = CGFloat(self.value)
		view.animated = self.animated
		return view
	}
}

// MARK: - iOS/tvOS Specific

@available(iOS 13.0, tvOS 13.0, macOS 9999.0, *)
public extension DSFSparklineWiperGaugeGraphView.SwiftUI {
	func makeUIView(context: Context) -> DSFSparklineWiperGaugeGraphView {
		return self.makeWiperGauge(context)
	}
	
	func updateUIView(_ view: DSFSparklineWiperGaugeGraphView, context _: Context) {
		self.updateView(view)
	}
}

// MARK: - macOS Specific

@available(macOS 10.15, iOS 9999.0, tvOS 9999.0, *)
public extension DSFSparklineWiperGaugeGraphView.SwiftUI {
	func makeNSView(context: Context) -> DSFSparklineWiperGaugeGraphView {
		return self.makeWiperGauge(context)
	}
	
	func updateNSView(_ view: DSFSparklineWiperGaugeGraphView, context _: Context) {
		self.updateView(view)
	}
}

// MARK: - Common updates

@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
public extension DSFSparklineWiperGaugeGraphView.SwiftUI {
	func updateView(_ view: DSFSparklineWiperGaugeGraphView) {
		view.animated = self.animated
		view.valueColor = self.valueColor
		view.value = CGFloat(self.value)
	}
}

#endif
