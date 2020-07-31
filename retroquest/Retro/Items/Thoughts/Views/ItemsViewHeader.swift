///**
/**
Copyright © 2019 Ford Motor Company. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import SwiftUI

struct ItemsViewHeader<T: ItemsViewEnvironmentObject>: View {
    @EnvironmentObject var items: T
    let teamName: String

    var body: some View {
        ZStack {
            HStack {
                Text(self.teamName)
                    .font(.system(size: 30))
                    .frame(alignment: .center)
            }
            HStack {
                Spacer()
                Button(action: addItem) {
                    Text("+")
                        .font(.system(size: 32))
                        .foregroundColor(Color(RetroColors.buttonColor))
                        .frame(alignment: .trailing)
                        .padding(.trailing, 25)
                }
            }
        }
        .padding(.top, 50)
        .padding(.bottom)
        .background(Color(RetroColors.menuHeaderColor))
    }

    private func addItem() {
        self.items.activeItemsViewModal = .addItem
        self.items.showModal = true
    }
}

struct ThoughtsViewHeaderPreview: PreviewProvider {
    static var previews: some View {
        ItemsViewHeader<ThoughtsViewEnvironmentObject>(teamName: "Best Team")
            .environmentObject(ThoughtsViewEnvironmentObject())
    }
}