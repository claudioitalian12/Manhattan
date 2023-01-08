//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import SwiftUI
import ManhattanCore

public struct SignUpView: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: SignUpViewModel
    @FocusState private var focusedField: SignUpFieldType?
    
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
        .scrollIndicators(.hidden)
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
    
    @ViewBuilder
    func headerTitle() -> some View {
        VStack(
            alignment: .leading,
            spacing: 10.0
        ) {
            Text("signinView_label_title".localized)
                .signUpTextTitle(font: .title)
        }
    }
    
    @ViewBuilder
    func nameField() -> some View {
        VStack(
            alignment: .leading,
            spacing: 10.0
        ) {
            Text("signinView_label_username".localized)
                .signUpTextTitle(font: .title3)
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

private extension SignUpView {
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
