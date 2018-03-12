import UIKit

class CalculationMethodTableViewController: UITableViewController {
    let model = CalculationMethodViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calculation Method"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.calculationMethods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = model.calculationMethods[indexPath.row].0
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.width))
//        view.backgroundColor = UIColor.lightGray
//
//        switch section {
//        case 0:
//            view.addSubview(calculationMethodLabel)
//            NSLayoutConstraint.activate([calculationMethodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), calculationMethodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), calculationMethodLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
//        case 1:
//            view.addSubview(changeLocationLabel)
//            NSLayoutConstraint.activate([changeLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), changeLocationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), changeLocationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
//        default:
//            fatalError("no section available")
//        }
        return view
    }

}
