import UIKit

class WeightViewController: UIViewController {
    
    
    @IBOutlet weak var actualCount: UILabel!
    @IBOutlet weak var finalCount: UILabel!
    @IBOutlet weak var actualWeight: UILabel!
    @IBOutlet weak var totalWeightSensor: UILabel!
    @IBOutlet weak var singleItemWeight: UILabel!
    @IBOutlet weak var containerWeight: UILabel!
    @IBOutlet weak var clearFinalCountData: UIImageView!
    @IBOutlet weak var clearTotalWeightData: UIImageView!
    @IBOutlet weak var getTotalWeightData: UIImageView!
    @IBOutlet weak var clearSingleItemWeightData: UIImageView!
    @IBOutlet weak var getSingleItemWeightData: UIImageView!
    @IBOutlet weak var clearContainerWeightData: UIImageView!
    @IBOutlet weak var getContainerWeightData: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    
    var fetchCase: FetchCase!
    
    var actualCountVal: Int = 0
    var singleItemWeightVal: Double?
    var containerWeightVal: Double!
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        actualCountVal = Int(sender.value)
        actualCount.text = "Actual Count: \(actualCountVal) units"
        
        if let singleItemWeightVal = singleItemWeightVal {
            let actualTotalWeight = singleItemWeightVal*Double(actualCountVal)
            actualWeight.text = "Actual Weight: \(actualTotalWeight)"
        }
    }
    
    @IBAction func resetAllAction(_ sender: Any) {
        self.resetUI()
    }
    
    let viewModel = WeightViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerViewModelListeners()
        
        addTapGestures()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resetUI()
    }
    
    /// This function registers ViewModels.
    ///
    /// Handles the success and failure cases for the API calls.
    func registerViewModelListeners() {
        viewModel.isFetchWeightsSuccess.bind { [weak self] success in
            if success {
                ActivityIndicator.sharedInstance.hideActivityIndicator()
                self?.updateUI()
            } else {
                ActivityIndicator.sharedInstance.hideActivityIndicator()
                AlertView.sharedInstance.showAlert(header: StringConstants.defaultErrorHeader, message: self?.viewModel.errorMessage ?? StringConstants.defaultError, actionTitle: StringConstants.okTitle)
            }
        }
    }
    
    func resetUI() {
        containerWeight.text = "- -"
        singleItemWeight.text = "- -"
        totalWeightSensor.text = "- -"
        actualWeight.text = "Actual Weight: - -"
        finalCount.text = "- -"
        actualCount.text = "Actual Count: - -"
        actualCountVal = 0
        stepper.value = 0
    }
    
    func updateUI() {
        switch fetchCase {
        case .containerWeight:
            if let weight = viewModel.weightData {
                containerWeightVal = weight
                containerWeight.text = "\(weight) gms"
            } else {
                containerWeight.text = "- -"
            }
        case .singleItemWeight:
            if var weight = viewModel.weightData {
                weight = weight - containerWeightVal
                singleItemWeightVal = weight
                singleItemWeight.text = "\(weight) gms"
                let actualTotalWeight = weight*Double(actualCountVal)
                actualWeight.text = "Actual Weight: \(actualTotalWeight)"
            } else {
                singleItemWeight.text = "- -"
            }
        case .totalItemWeight:
            if var weight = viewModel.weightData {
                weight = weight - containerWeightVal
                totalWeightSensor.text = "\(weight) gms"
                let finalCountValue = Int(weight/(singleItemWeightVal ?? 0.0))
                finalCount.text = "\(finalCountValue) units"
            } else {
                totalWeightSensor.text = "- -"
            }
        case .none:
            break
            //do nothing
        }
    }
    
    func addTapGestures() {
        
        let tapClearFinalCount = UITapGestureRecognizer(target: self, action: #selector(self.clearFinalCountDataAction(_:)))
        clearFinalCountData.isUserInteractionEnabled = true
        clearFinalCountData.addGestureRecognizer(tapClearFinalCount)
        
        let tapClearTotalWeightData = UITapGestureRecognizer(target: self, action: #selector(self.clearTotalWeightDataAction(_:)))
        clearTotalWeightData.isUserInteractionEnabled = true
        clearTotalWeightData.addGestureRecognizer(tapClearTotalWeightData)
        
        let tapGetTotalWeightData = UITapGestureRecognizer(target: self, action: #selector(self.getTotalWeightDataAction(_:)))
        getTotalWeightData.isUserInteractionEnabled = true
        getTotalWeightData.addGestureRecognizer(tapGetTotalWeightData)
        
        let tapClearSingleWeightData = UITapGestureRecognizer(target: self, action: #selector(self.clearSingleWeightDataAction(_:)))
        clearSingleItemWeightData.isUserInteractionEnabled = true
        clearSingleItemWeightData.addGestureRecognizer(tapClearSingleWeightData)
        
        let tapGetSingleWeightData = UITapGestureRecognizer(target: self, action: #selector(self.getSingleWeightDataAction(_:)))
        getSingleItemWeightData.isUserInteractionEnabled = true
        getSingleItemWeightData.addGestureRecognizer(tapGetSingleWeightData)
        
        let tapClearContainerWeightData = UITapGestureRecognizer(target: self, action: #selector(self.clearContainerWeightDataAction(_:)))
        clearContainerWeightData.isUserInteractionEnabled = true
        clearContainerWeightData.addGestureRecognizer(tapClearContainerWeightData)
        
        let tapGetContainerWeightData = UITapGestureRecognizer(target: self, action: #selector(self.getContainerWeightDataAction(_:)))
        getContainerWeightData.isUserInteractionEnabled = true
        getContainerWeightData.addGestureRecognizer(tapGetContainerWeightData)
    }
    
    @objc func clearFinalCountDataAction(_ sender: UITapGestureRecognizer? = nil) {
        finalCount.text = "- -"
    }
    
    @objc func clearTotalWeightDataAction(_ sender: UITapGestureRecognizer? = nil) {
        totalWeightSensor.text = "- -"
    }
    
    @objc func clearSingleWeightDataAction(_ sender: UITapGestureRecognizer? = nil) {
        singleItemWeight.text = "- -"
    }
    
    @objc func clearContainerWeightDataAction(_ sender: UITapGestureRecognizer? = nil) {
        containerWeight.text = "- -"
    }
    
    @objc func getTotalWeightDataAction(_ sender: UITapGestureRecognizer? = nil) {
        fetchCase = .totalItemWeight
        ActivityIndicator.sharedInstance.showActivityIndicator(self)
        viewModel.fetchWeightData()
    }
    
    @objc func getSingleWeightDataAction(_ sender: UITapGestureRecognizer? = nil) {
        fetchCase = .singleItemWeight
        ActivityIndicator.sharedInstance.showActivityIndicator(self)
        viewModel.fetchWeightData()
    }
    
    @objc func getContainerWeightDataAction (_ sender: UITapGestureRecognizer? = nil) {
        fetchCase = .containerWeight
        ActivityIndicator.sharedInstance.showActivityIndicator(self)
        viewModel.fetchWeightData()
    }
}
