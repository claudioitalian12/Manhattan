//
//  SwiftUIView.swift
//  
//
//  Created by Claudio Cavalli on 04/12/22.
//

import ManhattanCore
import SwiftUI

public struct LoginView: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var focusedField: LoginFieldType?
    private let spacingVStack = 20.0
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(
                    alignment: .center,
                    spacing: spacingVStack
                ) {
                    header()
                    fields()
                }
                .padding(
                    EdgeInsets(
                        top: 15.0,
                        leading: 0.0,
                        bottom: 0.0,
                        trailing: 0.0
                    )
                )
                Group{
                    buttons()
                }
                .loginGroup()
                .alert(
                    "loginView_alert_title".localized,
                    isPresented: $viewModel.isAlertHidden,
                    actions: {
                        Button(
                            "loginView_alert_button".localized,
                            role: .cancel
                        ) { }
                    },
                    message: {
                        Text(viewModel.errorMessage)
                    }
                )
            }
            .scrollIndicators(.hidden)
            .overlay {
                OverlayView()
                    .opacity(
                        viewModel.isOverlayHidden ? 1 : 0
                    )
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        Text(
            "loginView_label_title".localized
        )
        .loginTextTitle()
        Divider()
            .foregroundColor(
                Color(
                    "loginWhite",
                    bundle: Bundle.module
                )
            )
        Image(
            "manhattan",
            bundle: .module
        )
        .loginImage()
    }
    
    @ViewBuilder
    func fields() -> some View {
        VStack(
            alignment: .center,
            spacing: spacingVStack
        ) {
            Divider()
                .hidden()
            TextField(
                "loginView_button_login_placeholder".localized,
                text: $viewModel.username
            )
            .loginTextfield(
                focusedField: _focusedField,
                equalsValue: .username,
                textContent: .username,
                submitLabel: .next
            )
            SecureField(
                "loginView_button_signin_placeholder".localized,
                text: $viewModel.password
            )
            .loginTextfield(
                focusedField: _focusedField,
                equalsValue: .password,
                textContent: .password,
                submitLabel: .join
            )
            Divider()
                .hidden()
        }
        .padding(
            EdgeInsets(
                top: 0.0,
                leading: 20.0,
                bottom: 0.0,
                trailing: 20.0
            )
        )
        .onSubmit {
            Task {
                await didOnSubmit()
            }
        }
    }
    
    @ViewBuilder
    func buttons() -> some View {
        VStack(
            alignment: .center,
            spacing: spacingVStack
        ) {
            NavigationStack {
                Button {
                    Task {
                        await viewModel.loginOperation(
                            app: appEnvironment
                        )
                    }
                } label: {
                    Text(
                        LoginButtonType.home.rawValue
                    )
                    .loginLinkTitle()
                }
            }
            Button {
                viewModel.isOverlayHidden = false
                appEnvironment.gateway = .signUp
            } label: {
                Text(
                    LoginButtonType.signup.rawValue
                )
                .loginLinkTitle()
            }
        }
    }
    
    private func didOnSubmit() async {
        switch focusedField {
        case .username:
            focusedField = .password
        case .password:
            await viewModel.loginOperation(
                app: appEnvironment
            )
        default:
            break
        }
    }
}
