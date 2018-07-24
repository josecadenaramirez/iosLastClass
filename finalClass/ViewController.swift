
import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var pieChart: BarChartView!
    @IBOutlet weak var number3: UISlider!
    @IBOutlet weak var number2: UISlider!
    @IBOutlet weak var number1: UISlider!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        //pieChartUpdate()
        barChart()
    }
    
    /*func pieChartUpdate () {
        
        let entry1 = PieChartDataEntry(value: Double(number1.value), label: "#1")
        let entry2 = PieChartDataEntry(value: Double(number2.value), label: "#2")
        let entry3 = PieChartDataEntry(value: Double(number3.value), label: "#3")
        let dataSet = PieChartDataSet(values: [entry1, entry2, entry3], label: "Widget Types")
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.drawHoleEnabled = false
        pieChart.entryLabelColor = .black
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .red
        pieChart.chartDescription?.text = "Share of Widgets by Type"
        //dataSet.colors = ChartColorTemplates.joyful()
        dataSet.colors = [#colorLiteral(red: 0, green: 0.8039215686, blue: 0.7254901961, alpha: 1),#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]
        pieChart.notifyDataSetChanged()
        pieChart.backgroundColor = UIColor.clear
        pieChart.holeColor = UIColor.clear
        pieChart.chartDescription?.textColor = UIColor.black
        pieChart.legend.textColor = UIColor.red
    }*/
    
    func barChart(){
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(number1.value))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(number2.value))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(number3.value))
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = BarChartData(dataSets: [dataSet])
        
        pieChart.data = data
        dataSet.barBorderColor = .green
        dataSet.colors = [.brown, .cyan, .yellow]
        
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        pieChart.notifyDataSetChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func renderCharts(_ sender: Any) {
        //pieChartUpdate()
        barChart()
    }
    
}

