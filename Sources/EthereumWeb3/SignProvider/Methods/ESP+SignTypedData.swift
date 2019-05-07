//
//  SignTypedData.swift
//  EthereumWeb3
//
//  Created by Yehor Popovych on 3/29/19.
//  Copyright © 2019 Tesseract Systems, Inc. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import Ethereum

// eth_signTypedData
extension EthereumSignProvider {
    func eth_signTypedData(
        request: RPCRequest<SignTypedDataCallParams>,
        cb: @escaping Completion<EthData>
    ) {
        networkId { res in
            res.asyncMap(cb) { networkId, response in
                self.sign.eth_signTypedData(
                    account: request.params.account,
                    data: request.params.data,
                    networkId: networkId
                ) {
                    response($0.map{EthData($0)}.mapError{.signProviderError($0)})
                }
            }
        }
    }
}
