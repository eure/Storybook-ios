//
//  StorybookDefinition.swift
//  MyUIKit
//
//  Created by muukii on 2019/02/27.
//  Copyright © 2019 eureka, Inc. All rights reserved.
//

import Foundation

import StorybookKit

public let __storybookMenuDescriptor: StorybookMenuDescriptor = StorybookMenuDescriptor(
    sections: [
        StorybookSectionDescriptor(
            title: "Sample",
            items: [
                StorybookItemDescriptor(
                    title: "Sample",
                    detail: "Sample Detail Text",
                    components: { () -> [StorybookComponent] in
                        [
                            Elements.MyLabel.makeStorybookComponent(title: "Hello"),
                            Elements.MyLabel.makeStorybookComponent(title: "HelloHelloHelloHello")
                        ]
                })
            ])
])
