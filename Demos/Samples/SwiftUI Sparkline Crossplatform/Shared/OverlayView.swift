//
//  OverlayView.swift
//  Demos
//
//  Created by Darren Ford on 17/2/21.
//

import SwiftUI
import DSFSparkline

extension DSFColor {
	static var primaryTextColor: DSFColor {
		#if os(macOS)
		return NSColor.textColor
		#else
		return UIColor.label
		#endif
	}
}

struct OverlayView: View {
	var body: some View {
		VStack {
			Text("Using ZStack to overlay two sparklines")

			ZStack {
				DSFSparklineBarGraphView.SwiftUI(
					dataSource: ds1,
					graphColor: .systemTeal,
					barSpacing: 1,
					showZeroLine: true,
					centeredAtZeroLine: true
				)
				DSFSparklineLineGraphView.SwiftUI(
					dataSource: ds1,
					graphColor: DSFColor.primaryTextColor,
					lineWidth: 1,
					interpolated: true,
					lineShading: false
				)
			}
			.frame(height: 60)
		}
		.frame(width: 300)
		.padding()
	}
}

var ds1: DSFSparkline.DataSource = {
	let d = DSFSparkline.DataSource(windowSize: 20, range: -55 ... 55, zeroLineValue: 0)
	d.set(values: [
				18, -5, 11, 12, -21, 48, 41, -19, -28, 3,
				28, -27, -21, -45, -48, -39, 33, -4, 35, 37]
	)
	return d
}()

struct OverlayView_Previews: PreviewProvider {
	static var previews: some View {
		OverlayView()
	}
}
