//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import SwiftUI

// MARK: SingUpTextFieldModifier
struct SingUpTextFieldModifier: ViewModifier {
    @FocusState var focusedField: SignUpFieldType?
    let equalsValue: SignUpFieldType?
    let textContent: UITextContentType
    let submitLabel: SubmitLabel
    
    func body(
        content: Content
    ) -> some View {
        content
            .focused(
                $focusedField,
                equals: equalsValue
            )
            .textContentType(
                textContent
            )
            .submitLabel(
                submitLabel
            )
            .textFieldStyle(
                .roundedBorder
            )
            .frame(
                maxWidth: 500.0
            )
    }
}

extension TextField {
    func signUpTextfield(
        focusedField: FocusState<SignUpFieldType?>,
        equalsValue: SignUpFieldType?,
        textContent: UITextContentType,
        submitLabel: SubmitLabel
    ) -> some View {
        modifier(
            SingUpTextFieldModifier(
                focusedField: focusedField,
                equalsValue: equalsValue,
                textContent: textContent,
                submitLabel: submitLabel
            )
        )
    }
}

extension SecureField {
    func signUpTextfield(
        focusedField: FocusState<SignUpFieldType?>,
        equalsValue: SignUpFieldType?,
        textContent: UITextContentType,
        submitLabel: SubmitLabel
    ) -> some View {
        modifier(
            SingUpTextFieldModifier(
                focusedField: focusedField,
                equalsValue: equalsValue,
                textContent: textContent,
                submitLabel: submitLabel
            )
        )
    }
}


// MARK: SignUpTextModifier
struct SignUpTextModifier: ViewModifier {
    let font: Font
    
    func body(
        content: Content
    ) -> some View {
        content
            .font(
                font
            )
            .foregroundColor(
                Color(
                    "signUpBlack",
                    bundle: Bundle.module
                )
            )
            .bold()
    }
}

extension Text {
    func signUpTextTitle(
        font: Font
    ) -> some View {
        modifier(
            SignUpTextModifier(font: font)
        )
    }
}

// MARK: SignUpLinkModifier
struct SignUpLinkModifier: ViewModifier {
    func body(
        content: Content
    ) -> some View {
        content
            .frame(
                maxWidth: 500.0,
                maxHeight: 60.0
            )
            .padding()
            .font(
                .headline
            )
            .foregroundColor(
                Color(
                    "signUpWhite",
                    bundle: Bundle.module
                )
            )
            .background(
                Color(
                    "signUpBlack",
                    bundle: Bundle.module
                )
            )
            .cornerRadius(
                10.0
            )
    }
}

extension Text {
    func signUpLinkTitle() -> some View {
        modifier(
            SignUpLinkModifier()
        )
    }
}
