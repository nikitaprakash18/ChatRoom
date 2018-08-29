//
//  ChartsViewController.swift
//  Chat
//
//  Created by NikitaPrakash Patil on 8/26/18.
//  Copyright © 2018 NikitaPrakash Patil. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var TableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CHARTS"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let l_months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
       let dollars1 = [5641.0,2234,8763,4453,4548,6236,7321,3458,2139,399,1311,5612]
       let dollars2 = [2000.0,9200,1700,8400,9500,3200,8300,6600,9000,650,6300,9545]
       let linemonthes = [String](l_months)
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for y2 in 0..<linemonthes.count {
            yVals1.append(ChartDataEntry(x: dollars1[y2], y: Double(y2)))
        }
        
        let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "Sales_1")
         set1.colors = [UIColor.red]
        
        var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
        for y1 in 0..<linemonthes.count {
            yVals2.append(ChartDataEntry(x: dollars2[y1], y: Double(y1)))
        }
        
        let set2: LineChartDataSet = LineChartDataSet(values: yVals2, label: "Sales_2")
        set2.colors = [UIColor.blue]
        let data = LineChartData(dataSets: [set1, set2])
        
        let months = ["Jan", "Feb", "Mar", "Apr"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0]
        
        let sales = DataGenerator.data()
        
        // Initialize an array to store chart data entries (values; y axis)
        var salesEntries = [ChartDataEntry]()
        // Initialize an array to store months (labels; x axis)
        var salesMonths = [String]()
        let salemon = [String](months)
        var values = [Double](unitsSold)
        var i = 0
        for sale in sales {
            // Create single chart data entry and append it to the array
            //let saleEntry = BarChartDataEntry(value: sale.value, xIndex: i)
            let saleEntry = BarChartDataEntry(x: Double(i), yValues: [sale.value])
            salesEntries.append(saleEntry)
          
            // Append the month to the array
            salesMonths.append(sale.month)
            
            i += 1
        }
        var dataEntries: [ChartDataEntry] = []
        for j in 0..<salemon.count {
            let dataEntry = BarChartDataEntry(x: Double(j), y: values[j])
            dataEntries.append(dataEntry)
        }
        
        //pie chart
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        pieChartDataSet.colors = ChartColorTemplates.joyful()
        
        let pieChartData = PieChartData()
        pieChartData.addDataSet(pieChartDataSet)
        
        //line chart
        let line1 = LineChartDataSet(values: salesEntries, label: "Sales_1")
        line1.colors = [NSUIColor.blue]
        
        let lineData = LineChartData()
        lineData.addDataSet(line1)
        
        // Create bar chart data set containing salesEntries
        let chartDataSet = BarChartDataSet(values: salesEntries, label: "Profit")
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        // Create bar chart data with data set and array with values for x axis  xVals: salesMonths,
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChartTableViewCell
        cell.barChart.data = chartData
        cell.barChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        cell.horizontalBarchart.data = chartData
        cell.horizontalBarchart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        cell.pieChart.data =  pieChartData
        cell.pieChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        cell.lineChart.data = lineData
        cell.lineChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        cell.dueLineChart.data = data
        cell.dueLineChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

struct Sale {
    var month: String
    var value: Double
}

class DataGenerator {
    
    static var randomizedSale: Double {
        return Double(arc4random_uniform(10000) + 1) / 10
    }
   
    static func data() -> [Sale] {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var sales = [Sale]()
        
        for month in months {
            let sale = Sale(month: month, value: randomizedSale)
           
            sales.append(sale)
            
        }
        
        return sales
    }
}

