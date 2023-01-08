//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 05/12/22.
//

import SwiftUI

// MARK: LoginTextModifier
struct LoginLinkModifier: ViewModifier {
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
                    "loginWhite",
                    bundle: Bundle.module
                )
            )
            .background(
                Color(
                    "loginBlack",
                    bundle: Bundle.module
                )
            )
            .cornerRadius(
                10.0
            )
    }
}

extension Text {
    func loginLinkTitle() -> some View {
        modifier(
            LoginLinkModifier()
        )
    }
}

// MARK: LoginTextModifier
struct LoginTextModifier: ViewModifier {
    func body(
        content: Content
    ) -> some View {
        content
            .font(
                .title
            )
            .foregroundColor(
                Color(
                    "loginBlack",
                    bundle: Bundle.module
                )
            )
            .bold()
    }
}

extension Text {
    func loginTextTitle() -> some View {
        modifier(
            LoginTextModifier()
        )
    }
}

// MARK: LoginImage
extension Image {
    func loginImage() -> some View {
        self
            .resizable()
            .aspectRatio(
                contentMode: .fit
            )
            .frame(
                maxWidth: 100.0,
                maxHeight: 100.0
            )
    }
}

// MARK: LoginTextFieldModifier
struct LoginTextFieldModifier: ViewModifier {
    @FocusState var focusedField: LoginFieldType?
    let equalsValue: LoginFieldType?
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
    func loginTextfield(
        focusedField: FocusState<LoginFieldType?>,
        equalsValue: LoginFieldType?,
        textContent: UITextContentType,
        submitLabel: SubmitLabel
    ) -> some View {
        modifier(
            LoginTextFieldModifier(
                focusedField: focusedField,
                equalsValue: equalsValue,
                textContent: textContent,
                submitLabel: submitLabel
            )
        )
    }
}

extension SecureField {
    func loginTextfield(
        focusedField: FocusState<LoginFieldType?>,
        equalsValue: LoginFieldType?,
        textContent: UITextContentType,
        submitLabel: SubmitLabel
    ) -> some View {
        modifier(
            LoginTextFieldModifier(
                focusedField: focusedField,
                equalsValue: equalsValue,
                textContent: textContent,
                submitLabel: submitLabel
            )
        )
    }
}

// MARK: GroupLoginModifier
struct GroupLoginModifier: ViewModifier {
    func body(
        content: Content
    ) -> some View {
        content
            .frame(
                maxHeight: .infinity,
                alignment: .bottom
            )
            .padding(
                EdgeInsets(
                    top: 0.0,
                    leading: 20.0,
                    bottom: 20.0,
                    trailing: 20.0
                )
            )
    }
}

extension View {
    func loginGroup() -> some View {
        modifier(
            GroupLoginModifier()
        )
    }
}
