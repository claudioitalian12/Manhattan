//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct EventList: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @StateObject var viewModel: EventListViewModel = EventListViewModel()
    @Binding var date: Date
    @State private var isPresentedNew: Bool = false
    @State private var isPresentedEdit: Bool = false
    
    var body: some View {
        VStack (
            alignment: .center,
            spacing: 10.0
        ) {
            listHeader()
            listSections()
        }
        .customEventListVStack(
            eventData: $viewModel.eventData,
            newEvent: $viewModel.newEvent,
            isPresented: $isPresentedNew
        )
        .task(
            id: appEnvironment.realm
        ) {
            viewModel.eventData.setEventsList(
                realm: appEnvironment.realm
            )
        }
    }
    
    @ViewBuilder
    private func listHeader() -> some View {
        HStack() {
            Text("eventListView_profile_title_text".localized)
                .font(.title2)
            Button {
                viewModel.newEvent = Event(
                    _id: ObjectId.generate(),
                    date: date,
                    owner_id: appEnvironment.getUserID(),
                    tasks: RealmSwift.List<EventTask>(),
                    todo_id: ObjectId.generate(),
                    realm: nil
                )
                isPresentedNew.toggle()
            } label: {
                Image(
                    systemName: "plus.circle"
                )
            }
        }
    }
    
    @ViewBuilder
    private func listSections() -> some View {
        VStack(
            alignment: .leading
        ) {
            ForEach(Period.allCases) { period in
                if !viewModel.eventData.sortedEvents(
                    period: period
                ).isEmpty {
                    listRows(
                        period: period
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    private func listRows(
        period: Period
    ) -> some View {
        VStack(
            alignment: .leading,
            spacing: 20.0
        ) {
            Spacer()
            Text(period.name)
                .customEventSectionTitleDate()
            
            ForEach(viewModel.eventData.sortedEvents(
                period: period
            )) { event in
                EventRow(event: event)
                    .customEventListRow(
                        eventData: $viewModel.eventData,
                        selectedEvent: $viewModel.selectedEvent,
                        isPresented: $isPresentedEdit,
                        event: event
                    )
            }
        }
    }
}
