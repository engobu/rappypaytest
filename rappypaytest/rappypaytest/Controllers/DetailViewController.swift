//
//  DetailViewController.swift
//  rappypaytest
//
//  Created by Enar GoMez on 26/09/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var oProgram: Program!
    var programType:ProgramTypeEnum!
    
    let programService: ProgramService = ProgramService()
    let imageLoader: ImageService = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 180
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorStyle = .none
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func loadData() {
        programService.getProgramDetail(programType, self.oProgram.id) { (success, msg, arrVideo) in
            if success {
                self.oProgram.update(arrVideo: arrVideo)
                self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            }
        }
    }
    
    func presentPopover(oVideo: Video) -> Void {
       // let storyBoard = self.storyboard
        let playerViewController = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        
        playerViewController.modalPresentationStyle = .popover
        playerViewController.oVideo = oVideo
        let popover = playerViewController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .up
        
        popover.sourceView = self.view
        popover.sourceRect = CGRect(x: self.view.bounds.midX, y: 100, width: 0, height: 0)//CGRect(x: 0, y: 0, width: 100, height: 80)
        
        
        present(playerViewController, animated: false, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 2 else {
            return
        }
        let oVideo = self.oProgram.arrVideo[indexPath.row]
        guard oVideo.hasYouTuve else {
            return
        }
        
        self.presentPopover(oVideo: oVideo)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section < 2 else {
            return 50
        }
        return 200
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 40
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "TRAILERS"
        }
        return ""
    }
    
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 2 else {
            return 1
        }
        return oProgram.arrVideo.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
       
        let section = indexPath.section
        switch section {
        case 0://image
            cell =  makeImageCell(tableView, indexPath: indexPath)
            break
        case 1://detail
            cell =  makeDetailCell(tableView, indexPath: indexPath)
            break
        case 2://trailers
            cell =  makeTrailerCell(tableView, indexPath: indexPath)
            break
        default:
            cell = UITableViewCell()
            break
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    func makeImageCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        let imageView = imageCell.viewWithTag(1) as! UIImageView
        imageLoader.loadImage(with: oProgram.backdropURL) { (success, image) in
            DispatchQueue.main.async{
                if success {
                    imageView.image = image
                }else{
                    imageView.image = UIImage(named: "ic_default")
                }
            }
        }
        
        return imageCell
    }
    
    func makeDetailCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        let lblTitle = detailCell.viewWithTag(1) as! UILabel
        let lblReleaseDate = detailCell.viewWithTag(2) as! UILabel
        let lblOverview = detailCell.viewWithTag(3) as! UILabel
               
        
        lblTitle.text = oProgram.getProgramName(type: programType)
        lblReleaseDate.text = oProgram.getProgramReleaseDate(type: programType)
        lblOverview.text = oProgram.overview
        return detailCell
    }
    
    func makeTrailerCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let trailerCell = tableView.dequeueReusableCell(withIdentifier: "trailerCell", for: indexPath)
       
        let trailer = self.oProgram.arrVideo[indexPath.row]
        let lblTitle = trailerCell.viewWithTag(1) as! UILabel
        lblTitle.text = trailer.name
        
        return trailerCell
    }
}
