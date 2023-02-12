//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import SwiftUI
import ManhattanCore

// MARK: SignUpView
public struct SignUpView: View {
    /// appEnvironment.
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    /// view model.
    @ObservedObject var viewModel: SignUpViewModel
    /// focused field.
    @FocusState private var focusedField: SignUpFieldType?
    /// body.
    public var body: some View {
        NavigationStack {
            contentScroll()
        }
        .onAppear() {
            focusedField = .username
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    /// content scroll.
    @ViewBuilder
    func contentScroll() -> some View {
        ScrollView {
            VStack(
                alignment: .center,
                spacing: 40.0
            ) {
                headerTitle()
                Divider()
                nameField()
                passwordField()
                signUpButton()
            }
            .frame(
                maxWidth: .infinity
            )
            .padding()
            .onSubmit {
                Task {
                    await didOnSubmit()
                }
            }
        }
        .scrollIndicators(
            .hidden
        )
        .alert(
            "signUpView_alert_title".localized,
            isPresented: $viewModel.isAlertHidden,
            actions: {
                Button(
                    "signUpView_alert_button".localized,
                    role: .cancel
                ) { }
            },
            message: {
                Text(viewModel.errorMessage)
            }
        )
        .overlay {
            OverlayView()
                .opacity(
                    viewModel.isOverlayHidden ? 1 : 0
                )
        }
    }
    /// header title.
    @ViewBuilder
    func headerTitle() -> some View {
        VStack(
            alignment: .leading,
            spacing: 10.0
        ) {
            Text(
                "signinView_label_title".localized
            )
            .signUpTextTitle(
                font: .title
            )
        }
    }
    /// name field.
    @ViewBuilder
    func nameField() -> some View {
        VStack(
            alignment: .leading,
            spacing: 10.0
        ) {
            Text(
                "signinView_label_username".localized
            )
            .signUpTextTitle(
                font: .title3
            )
            TextField(
                "signUpView_button_username_placeholder".localized,
                text: $viewModel.username
            )
            .signUpTextfield(
                focusedField: _focusedField,
                equalsValue: .username,
                textContent: .username,
                submitLabel: .next
            )
        }
    }
    /// password field.
    @ViewBuilder
    func passwordField() -> some View {
        VStack(
            alignment: .leading,
            spacing: 10.0
        ) {
            Text("signinView_label_password".localized)
                .signUpTextTitle(font: .title3)
            SecureField(
                "signUpView_button_password_placeholder".localized,
                text: $viewModel.password
            )
            .signUpTextfield(
                focusedField: _focusedField,
                equalsValue: .password,
                textContent: .password,
                submitLabel: .join
            )
        }
    }
    /// signup button.
    @ViewBuilder
    func signUpButton() -> some View {
        VStack(
            alignment: .leading,
            spacing: 20.0
        ) {
            Button {
                Task {
                    await viewModel.signUpOperation(
                        app: appEnvironment
                    )
                }
            } label: {
                Text(
                    SignUpButtonType.home.rawValue
                )
                .signUpLinkTitle()
            }
            
            Button {
                appEnvironment.gateway = .login
            } label: {
                Text(
                    SignUpButtonType.login.rawValue
                )
                .signUpLinkTitle()
            }
        }
    }
}
// MARK: SignUpView Extension
private extension SignUpView {
    /// did on submit.
    func didOnSubmit() async {
        switch focusedField {
        case .username:
            focusedField = .password
        case .password:
            await viewModel.signUpOperation(
                app: appEnvironment
            )
        default:
            break
        }
    }
}
