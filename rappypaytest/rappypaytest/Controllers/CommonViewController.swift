//
//  CommonViewController.swift
//  rappypaytest
//
//  Created by Enar GoMez on 25/09/21.
//

import UIKit

class CommonViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var isSearchEnabled: Bool = false
    var programtype: ProgramTypeEnum!
        
    let arrProgramSearch: [Program] = [Program]()
    var arrProgramPopular: [Program] = [Program]()
    var arrProgramTopRated: [Program] = [Program]()
    var arrProgramUpcoming: [Program] = [Program]()
    var oSelectedProgram: Program!
    
    let programService: ProgramService = ProgramService()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.view.backgroundColor = .white
        self.loadData()
        if self.programtype == ProgramTypeEnum.Movie {
            title = "Peliculas"
        }else{
            title = "Series"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    func configUI(){
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    func loadData(){
        programService.getPopular(self.programtype) { (success, msg, arrProgram) in
           
            if (success){
                self.arrProgramPopular.append(contentsOf: arrProgram)
                self.tableView.reloadSections(IndexSet(integersIn: 0...2), with: .automatic)
            }
            
        }
        
        programService.getTopRated(self.programtype) { (success, msg, arrProgram) in
           
            if (success){
                self.arrProgramTopRated.append(contentsOf: arrProgram)
                self.tableView.reloadSections(IndexSet(integersIn: 0...2), with: .automatic)
            }
            
        }
        
        programService.getUpcoming(self.programtype) { (success, msg, arrProgram) in
           
            if (success){
                self.arrProgramUpcoming.append(contentsOf: arrProgram)
                self.tableView.reloadSections(IndexSet(integersIn: 0...2), with: .automatic)
               // let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! ContainerTableViewCell
               // cell.update()
                
                
            }
            
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToDetailVC"){
            let detailController = segue.destination as! DetailViewController
            detailController.oProgram = oSelectedProgram
            detailController.programType = programtype
        }
    }
    

}

extension CommonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // showDataPickerComponent(imageInfo: self.arrImages[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearchEnabled{
            return 60
        }
        return 210
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSearchEnabled {
            return 0.0
        }
        return 44.0
    }
    
    
}

extension CommonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchEnabled{
            return self.arrProgramSearch.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearchEnabled{
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if isSearchEnabled {
            cell = makeSearchCell(tableView, indexPath: indexPath)
        }else{
            let row = indexPath.section
            switch row {
            case 0://popular
                cell =  makeCollectionCell(tableView, indexPath: indexPath, arrPrograms: self.arrProgramPopular)
                break
            case 1://toprated
                cell =  makeCollectionCell(tableView, indexPath: indexPath, arrPrograms: self.arrProgramTopRated)
                break
            case 2://upcoming
                cell =  makeCollectionCell(tableView, indexPath: indexPath, arrPrograms: self.arrProgramUpcoming)
                break
            default:
                cell = ContainerTableViewCell()
                break
            }
            
        }
       
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isSearchEnabled {
            return ""
        }else{
            let sectionTitle: String
            switch section {
            case 0:
                sectionTitle = "Populares"
                break
            case 1:
                sectionTitle = "Mejor valorados"
                break
            case 2:
                if self.programtype == ProgramTypeEnum.Movie {
                    sectionTitle = "Próximos Estrenos"
                }else{
                    sectionTitle = "Al aire"
                }
                
                break
            default:
                sectionTitle = ""
                break
            }
            return sectionTitle
        }
    }
  
    
    func makeSearchCell(_ tableView: UITableView, indexPath: IndexPath) -> CardSearchTableViewCell {
        let cardSearchCell = tableView.dequeueReusableCell(withIdentifier: "CardSearchTVCell", for: indexPath) as! CardSearchTableViewCell
        return cardSearchCell
    }
    
    func makeCollectionCell(_ tableView: UITableView, indexPath: IndexPath, arrPrograms: [Program]) -> ContainerTableViewCell {
        let containerCell = tableView.dequeueReusableCell(withIdentifier: "ContainerTVCell", for: indexPath) as! ContainerTableViewCell
        containerCell.arrPrograms = arrPrograms
        containerCell.programType = self.programtype
        containerCell._delegate = self
        containerCell.update()
        return containerCell
    }
}

extension CommonViewController: ContainerTableViewCellDelegate {
    func showDetailProgram(oProgram: Program) {
        self.oSelectedProgram = oProgram
        self.performSegue(withIdentifier: "goToDetailVC", sender: self)
    }
    
    
}
