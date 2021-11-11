//
//  WatchQRCodeListView.swift
//  WatchGatherQR WatchKit Extension
//
//  Created by K.Hatano on 2021/10/31.
//

import SwiftUI

struct WatchQRCodeListView: View {
    
    @EnvironmentObject var qrcodeList: WatchQRInfoList
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        
        Group {
            if !qrcodeList.qrInfoList.isEmpty {
                List {
                    ForEach(qrcodeList.qrInfoList, id: \.uuid) { item in
                        NavigationLink(destination: WatchQRCodePreviewView(item: item)) {
                            Text(item.title)
                        }
                    }
                }
            } else {
                VStack {
                    ProgressView()
                        .padding(.all, 16)
                    Spacer()
                    Text(app.loadString("Data syncing...\nPlease hold your iPhone close."))
                        .font(.body)
                    Spacer()
                }
                .padding()
            }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                // Sync when this view become active.
                // (not call this method on the first time this application launch, because the view did not created.)
                app.syncWithPhone()
                break
            case .inactive:
                // The app has become inactive.
                break
            case .background:
                // The app has moved to the background.
                break
            @unknown default:
                fatalError("The app has entered an unknown state.")
            }

        }
        
    }
}

struct WatchQRCodeListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchQRCodeListView()
//            .preferredColorScheme(.light)
            .environmentObject(WatchQRInfoList())
//        WatchQRCodeListView()
//            .preferredColorScheme(.dark)
//            .environmentObject(WatchQRInfoList())
    }
}
