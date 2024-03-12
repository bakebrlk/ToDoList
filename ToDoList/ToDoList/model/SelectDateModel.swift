//
//  SelectDateModel.swift
//  ToDoList
//
//  Created by bakebrlk on 13.03.2024.
//

import SwiftUI

struct SelectDateModel: View {
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    var currentDate: Int
    var title: String
    @State var showDatePicker: Bool
    
    var body: some View {
        HStack{
            Image(systemName: "calendar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding([.top, .bottom, .leading])
                .foregroundColor(Color("purple"))

            VStack(alignment: .leading){
                textView(text: title, size: 14)
                    .foregroundStyle(Color(.systemGray))
                
                textView(text: "\(CalendarModel.shared.forAddTaskPage(date: currentDate == 0 ? $startDate : $endDate))", size: 16)
            }
            
            Spacer()
            
            Image(systemName: showDatePicker ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/12)
        .background(Color.white)
        .cornerRadius(20)
        .padding([.leading, .trailing, .bottom])
        
        .onTapGesture {
            showDatePicker.toggle()
        }
        
        .sheet(isPresented: $showDatePicker, content: {
            VStack{
                DatePicker("",selection: currentDate == 0 ? $startDate : $endDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(Color("purple"))
               
                Button(action: {
                    if startDate > endDate {
                        endDate = startDate
                    }
                    showDatePicker.toggle()
                }, label: {
                    textView(text: "Ok", size: 18)
                })
                .frame(maxWidth: Size.size[0]/4, maxHeight: Size.size[1]/14)
                    .background(Color("purple"))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding()
                
                Spacer()
            }
            .presentationDetents([.height(Size.size[1]/1.5)])
        })
        
    }
}

//#Preview {
//    SelectDateModel()
//}
