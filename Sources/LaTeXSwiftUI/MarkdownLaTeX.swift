//
//  MarkdownLaTeX.swift
//
//
//  Created by Sergey Rezanov on 13.11.2023.
//

import SwiftUI
import MarkdownUI

public struct MarkdownLaTeX: View {
    private let components: [TappzParser.Block]
    private let fontSize: CGFloat
    
    @State var label: String = ""
    
    public init(_ text: String, fontSize: CGFloat = 15) {
        self.components = TappzParser.parse(text)
        self.fontSize = fontSize
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(components, id: \.self) { component in
                switch component.type {
                case .latex:
                    LaTeX(component.text)
                        .font(.system(size: fontSize))
                        .padding(.bottom, 8)
                case .markdown:
                    Markdown(component.text)
                        .markdownTextStyle {
                            FontSize(fontSize)
                        }
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        MarkdownLaTeX("To solve the system of equations:\n\n\\[\n\\begin{align*}\nx + 2y + z &= 8 \\quad \\text{(Equation 1)} \\\\\n2x + y + 2z &= 10 \\quad \\text{(Equation 2)} \\\\\n3x + 3y + z &= 12 \\quad \\text{(Equation 3)}\n\\end{align*}\n\\]\n\nWe can solve this system using the method of elimination or substitution. Let\'s use the method of elimination.\n\nFirst, let\'s eliminate the variable $x$. Multiply Equation 1 by $2$ and subtract Equation 2 multiplied by $1$:\n\n\\[\n\\begin{align*}\n2(x + 2y + z) - (2x + y + 2z) &= 2(8) - 10 \\\\\n2x + 4y + 2z - 2x - y - 2z &= 16 - 10 \\\\\n3y &= 6 \\\\\ny &= 2\n\\end{align*}\n\\]\n\nNow that we have the value of $y$, we can substitute it back into Equation 1:\n\n\\[\n\\begin{align*}\nx + 2(2) + z &= 8 \\\\\nx + 4 + z &= 8 \\\\\nx + z &= 4 \\quad \\text{(Equation 4)}\n\\end{align*}\n\\]\n\nNext, substitute the value of $y$ into Equation 3:\n\n\\[\n\\begin{align*}\n3x + 3(2) + z &= 12 \\\\\n3x + 6 + z &= 12 \\\\\n3x + z &= 6 \\quad \\text{(Equation 5)}\n\\end{align*}\n\\]\n\nNow, we have two equations left:\n\n\\[\n\\begin{align*}\nx + z &= 4 \\quad \\text{(Equation 4)} \\\\\n3x + z &= 6 \\quad \\text{(Equation 5)}\n\\end{align*}\n\\]\n\nTo eliminate the variable $z$, multiply Equation 4 by $-1$ and add it to Equation 5:\n\n\\[\n\\begin{align*}\n-(x + z) + (3x + z) &= -4 + 6 \\\\\n2x &= 2 \\\\\nx &= 1\n\\end{align*}\n\\]\n\nSubstitute the value of $x$ back into Equation 4:\n\n\\[\n\\begin{align*}\n1 + z &= 4 \\\\\nz &= 3\n\\end{align*}\n\\]\n\nSo the solution to the system of equations is $x = 1$, $y = 2$, and $z = 3$.")
        MarkdownLaTeX("""
            Hello world
            $$
            \\begin{cases}
            3x - y = 2 \\
            x^2 - 4x + 8 = y
            \\end{cases}
            $$
            
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
