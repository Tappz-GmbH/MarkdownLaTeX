//
//  MarkdownLaTeX.swift
//
//
//  Created by Sergey Rezanov on 13.11.2023.
//

import SwiftUI
import MarkdownUI

public struct MarkdownLaTeX: View {
    private let components: [Component]
    
    public init(_ text: String) {
        self.components = Parser.parse(text)
    }
    
    public var body: some View {
        VStack {
            ForEach(components, id: \.self) { component in
                if component.type.isEquation {
                    LaTeX(component.originalText)
                        .padding(.bottom, 8)
                } else {
                    Markdown(component.originalText)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        MarkdownLaTeX("""
            | abc | defghi |
            :-: | -----------:
            bar | baz
            The equation you provided is the quadratic formula, which is used to solve quadratic equations of the form ax^2 + bx + c = 0. In this formula, x represents the variable we are solving for, and a, b, and c are constants.
            
            ## To use the quadratic formula, follow the steps below: ##
            
            > 1. Identify the values of a, b, and c in your quadratic equation.
            
            > 2. Substitute these values into the quadratic formula:
            
            \\[ x = \\frac { - b \\pm \\sqrt { b ^ { 2 } - 4 a c } } { 2 a } \\]
            
            > 3. Simplify the expression inside the square root:
            
            \\[ b ^ { 2 } - 4 a c \\]
            
            > 4. Calculate the square root of the simplified expression.
            
            > 5. Substitute the values of -b, the simplified expression, and 2a into the quadratic formula.
            
            > 6. Calculate the two possible values of x by performing the necessary operations.
            
            Remember that when using the quadratic formula, you will get two possible solutions for x, represented by the plus and minus signs in the numerator.
            
            If you have specific values for a, b, and c, please provide them so I can assist you further in solving the equation.
            
            ```json
            {
                \"firstName\": \"John\",
                \"lastName\": \"Smith\",
                \"age\": 25
            }
            ```
            """)
        .padding()
    }
}
