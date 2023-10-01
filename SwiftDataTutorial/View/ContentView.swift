//
//  ContentView.swift
//  SwiftDataTutorial
//
//  Created by Asif Syeed on 1/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @Query(sort: \Expense.date) var expenses: [Expense]

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                    }
                }
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet) {
                AddExpenseSheet()
            }
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus") {
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding expenses to your list")
                    }, actions: {
                        Button("Add expense") {
                            isShowingItemSheet = true
                        }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
