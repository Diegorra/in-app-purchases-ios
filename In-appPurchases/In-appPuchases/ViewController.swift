//
//  ViewController.swift
//  In-appPuchases
//
//  Created by Diego Andrés Ramón Sanchís on 17/11/23.
//

import UIKit
import StoreKit

class ViewController: UITableViewController, SKProductsRequestDelegate {

    private var effects: [Effects] = [.poker, .cardOnNumber, .stopCard, .guessing, .numberOnWrittenCard, .doubleCardOnNumber]
    private var products = [SKProduct]()
    private var purchasedProducts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        fetchProducts()
        refreshPurchasedProducts()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return effects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EffectCell", for: indexPath)
        cell.textLabel?.text = effects[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if purchasedProducts.contains(effects[indexPath.row].id) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "EffectDetail") as? EffectDetail {
                vc.quicktitle = effects[indexPath.row].title
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            guard let index = products.firstIndex(where: { $0.productIdentifier == effects[indexPath.row].id }) else { return }
            let payment = SKPayment(product: products[index])
            SKPaymentQueue.default().add(payment)
            refreshPurchasedProducts()
        }

    }

    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Effects.allCases.compactMap( { $0.id })))
        request.delegate = self
        request.start()
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.products = response.products
            print(self.products.count)
        }
    }

    func refreshPurchasedProducts() {
        purchasedProducts = []
        // Iterate through the user's purchased products.
        Task {
            for await verificationResult in Transaction.currentEntitlements {
                switch verificationResult {
                case .verified(let transaction):
                    purchasedProducts.append(transaction.productID)
                case .unverified(_, _):
                    continue
                }
            }
        }
        tableView.reloadData()
    }

}

