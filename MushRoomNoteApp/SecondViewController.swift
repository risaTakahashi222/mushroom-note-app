//
//  SecondViewController.swift
//  MushRoomNoteApp
//
//  Created by Risa Takahashi on 2020/09/22.
//  Copyright © 2020 Risa Takahashi. All rights reserved.
//
import UIKit
import ScrollableGraphView
 
class SecondViewController: UIViewController, ScrollableGraphViewDataSource{
    // MARK: Data Properties

        private var numberOfDataItems = 29

        // Data for graphs with a single plot
        private lazy var simpleLinePlotData: [Double] = self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
        private lazy var darkLinePlotData: [Double] = self.generateRandomData(self.numberOfDataItems, max: 50, shouldIncludeOutliers: true)
        private lazy var dotPlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, variance: 4, from: 25)
        private lazy var barPlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
        private lazy var pinkLinePlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)

    var graphView: ScrollableGraphView!

    // 表示できる限界(bound)のサイズ
    var rect = CGRect.init(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 500);

     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
        // Compose the graph view by creating a graph, then adding any plots
        // and reference lines before adding the graph to the view hierarchy.
        let graphViewI = createSimpleGraph(rect)

        self.view.addSubview(graphViewI)
    }



    func label(atIndex pointIndex: Int) -> String {
        return "FEB \(pointIndex)"
    }

    // The simplest kind of graph
    // A single line plot, with no range adaption when scrolling
    // No animations
    // min: 0
    // max: 100
    func createSimpleGraph(_ frame: CGRect) -> ScrollableGraphView {

        // Compose the graph view by creating a graph, then adding any plots
        // and reference lines before adding the graph to the view hierarchy.
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)

        let linePlot = LinePlot(identifier: "simple") // Identifier should be unique for each plot.
        let referenceLines = ReferenceLines()

        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)

        return graphView
    }

    private func generateRandomData(_ numberOfItems: Int, max: Double, shouldIncludeOutliers: Bool = true) -> [Double] {
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            var randomNumber = Double(arc4random()).truncatingRemainder(dividingBy: max)

            if(shouldIncludeOutliers) {
                if(arc4random() % 100 < 10) {
                    randomNumber *= 3
                }
            }

            data.append(randomNumber)
        }
        return data
    }
    private func generateRandomData(_ numberOfItems: Int, variance: Double, from: Double) -> [Double] {

        var data = [Double]()
        for _ in 0 ..< numberOfItems {

            let randomVariance = Double(arc4random()).truncatingRemainder(dividingBy: variance)
            var randomNumber = from

            if(arc4random() % 100 < 50) {
                randomNumber = randomVariance
            }
            else {
                randomNumber -= randomVariance
            }

            data.append(randomNumber)
        }
        return data
    }
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "line":
            return simpleLinePlotData[pointIndex]
        default:
            return 0
        }
     }
 
    func numberOfPoints() -> Int {
        return numberOfDataItems
    }
 
 }

