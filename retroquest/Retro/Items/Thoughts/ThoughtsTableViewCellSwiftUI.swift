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
import FASwiftUI

struct ThoughtsTableViewCellSwiftUI: View {
    let thought: Thought
    internal weak var thoughtEditDelegate: ThoughtEditDelegate!
    var opacity: CGFloat

    init(thought: Thought, delegate: ThoughtEditDelegate) {
        self.thought = thought
        self.thoughtEditDelegate = delegate

        opacity = CGFloat(thought.discussed ? 0.7 : 1.0)
    }

    var body: some View {
        VStack {
            MessageLabel(self.thought)
                .padding(.top, 20)
                .padding(.bottom, 10)
            ThoughtsTableCellDivider(.vertical)
            HStack {
                Spacer()
                Button(action: starsTapped) {
                    StarsLabel(thought.hearts)
                }
                ThoughtsTableCellDivider(.horizontal)
                Button(action: modifyMessageTapped) {
                    FAIcon("edit").padding(10)
                }
                ThoughtsTableCellDivider(.horizontal)
                Button(action: markDiscussedTapped) {
                    FAIcon(self.thought.discussed ? "envelope-open-text" : "envelope").padding(10)
                }
                Spacer()
            }.padding(.bottom, 20)
        }
        .background(Color(RetroColors.expandedCellBackgroundColor.withAlphaComponent(self.opacity)))
        .cornerRadius(15)
    }

    internal func starsTapped() {
        print("tapped on stars")
        thoughtEditDelegate.starred(thought)
    }

    internal func modifyMessageTapped() {
        print("tapped on message")
        thoughtEditDelegate.textChanged(thought)
    }

    internal func markDiscussedTapped() {
        print("tapped on discussed")
        thoughtEditDelegate.discussed(thought)
    }
}

enum DividerAxis: Int {
    case horizontal = 0

    case vertical = 1
}

struct FAIcon: View {
    let iconName: String

    init(_ iconName: String) {
        self.iconName = iconName
    }

    var body: some View {
        FAText(iconName: iconName, size: 20, style: .solid)
            .foregroundColor(Color(RetroColors.cellTextColor))
    }
}

private struct ThoughtsTableCellDivider: View {
    let axis: DividerAxis

    init(_ axis: DividerAxis) {
        self.axis = axis
    }

    var body: some View {
        Group {
            Spacer()
            if axis == .vertical {
                Rectangle()
                    .fill(Color(RetroColors.separatorColor))
                    .frame(height: 4)
            } else {
                Rectangle()
                    .fill(Color(RetroColors.separatorColor))
                    .frame(width: 4)
            }
            Spacer()
        }
    }
}

private struct MessageLabel: View {
    let thought: Thought

    init(_ thought: Thought) {
        self.thought = thought
    }

    var body: some View {
        Text(self.thought.message)
            .font(Font.retroquestRegular(size: 20))
            .strikethrough(self.thought.discussed)
            .foregroundColor(Color(RetroColors.cellTextColor))
            .padding(.horizontal, 25)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private struct StarsLabel: View {
    let numStars: Int

    init(_ numStars: Int) {
        self.numStars = numStars
    }

    var body: some View {
        HStack {
            FAText(iconName: "star", size: 20, style: .solid)
                .foregroundColor(Color(RetroColors.starColor))
            Text(String(numStars))
                .font(Font.retroquestRegular(size: 20))
                .foregroundColor(Color(RetroColors.cellTextColor))
        }
    }
}

struct ThoughtsTableViewCellSwiftUIPreview: PreviewProvider {

    static var previews: some View {
        ThoughtsTableViewCellSwiftUI(
            thought: Thought(
              id: 2,
              message: "fdsas",
              hearts: 70,
              topic: "happy",
              discussed: true,
              teamId: "testers"
            ),
            delegate: PreviewThoughtEditDelegate()
        )
    }
}

class PreviewThoughtEditDelegate: ThoughtEditDelegate {
    func starred(_ thought: Thought) { }
    func discussed(_ thought: Thought) { }
    func textChanged(_ thought: Thought) { }
}
