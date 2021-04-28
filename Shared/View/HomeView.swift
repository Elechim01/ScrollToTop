//
//  HomeView.swift
//  ScrollToTop (iOS)
//
//  Created by Michele Manniello on 28/04/21.
//

import SwiftUI

struct HomeView: View {
    @State var scrollViewoffset : CGFloat = 0
//    Getting Start Offset and eliminating form current offset so that we will get exact offset...
    @State var startOffset : CGFloat = 0
    var body: some View {
//        Scroll to top function...
//        with the help of scrollview reader....
        
        
        ScrollViewReader { proxyReader in
            ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 25){
                ForEach(1...30,id: \.self){ index in
                    //                    simple Row View
                    HStack(spacing: 15){
                        Circle()
                            .fill(Color.gray.opacity(0.45))
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading, spacing: 8, content: {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 22)
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 22)
                                .padding(.trailing,100)
                        })
                    }
                }}
                .padding()
//                setting ID
//                so that it can scroll to that position...
                .id("SCROLL_TO_TOP")
                //  getting scrollView Offset...
                .overlay(
    //            using Geomtery rider to get scroll View Offset
                    GeometryReader{ proxy -> Color in
    //                    let offset = proxy.frame(in: .global).minY
    //                    print(offset)
                        DispatchQueue.main.async {
                            if startOffset == 0{
                                self.startOffset = proxy.frame(in: .global).minY
                            }
                            let offset = proxy.frame(in: .global).minY
                            self.scrollViewoffset = offset - startOffset
                            print(self.scrollViewoffset)
                        }
                        
                       return  Color.clear
                    }
                    .frame(width: 0, height: 0)
                    ,alignment: .top
                )
    //            if offset goes less than 450 then showing floating action button at bottom....
            })
            .overlay(
                Button(action: {
//                    scroll to top with animation...
                    withAnimation(.spring()) {
                        proxyReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                    }
                }, label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20,weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(Circle())
    //                shadow
                        .shadow(color: .black.opacity(0.09), radius: 5, x: 5, y: 5)
                })
                .padding(.trailing)
                .padding(.bottom,getSafeArea().bottom == 0 ? 12 : 0)
                .opacity(-scrollViewoffset > 450 ? 1 : 0)
                .animation(.easeInOut)
    //            fixing at the bottom left...
                ,alignment: .bottomTrailing
        )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//estendo la view per ottenre la safearea
extension View{
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
