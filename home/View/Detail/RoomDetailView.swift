//
//  RoomDetailView.swift
//  home
//
//  Created by Scott Courtney on 12/13/22.
//

import SwiftUI
import ScalingHeaderScrollView

struct RoomDetailView: View {
    
    let room: Room
    
    @Environment(\.dismiss) var dismiss
    
    @State var progress: CGFloat = 0
    
    private let minHeight = 110.0
    private let maxHeight = 372.0
    
    var body: some View {
            ZStack {
                ScalingHeaderScrollView {
                    ZStack {
                        Color.white.edgesIgnoringSafeArea(.all)
                        largeHeader(progress: progress)
                    }
                } content: {
                    roomContentView
                }
                .height(min: minHeight, max: maxHeight)
                .collapseProgress($progress)
                .allowsHeaderGrowth()
                
                topButton
            }
            .ignoresSafeArea()

    }
    
    private var topButton: some View {
            VStack {
               
                HStack {
                    Button(action: { dismiss() }, label: {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 25))
                            
                    })
                    .foregroundColor(Color.black)
                    .padding(.leading, 17)
                    .padding(.top, 65)
                    
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()
        }

    
    private var smallHeader: some View {
        HStack {
            
            Spacer()
            
            Text((room.nickname ?? "N/A")
                .uppercased())
            .font(.title3)
            
            Spacer()
        }
    }
    
    
    private func largeHeader(progress: CGFloat) -> some View {
        ZStack {
            ImageView(houseId: "", roomId: "", folderName: "")
                .scaledToFill()
                .frame(height: maxHeight)
                .opacity(1 - progress)
                .padding(.bottom, 10)
            
            VStack {
                Spacer()
                
                HStack(spacing: 4.0) {
                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white)
                    
                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white.opacity(0.2))
                    
                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white.opacity(0.2))
                }
                
                ZStack(alignment: .leading) {
                    
                    VisualEffectView(effect: UIBlurEffect(style: .regular))
                        .mask(Rectangle())
                        .offset(y: 10.0)
                        .frame(height: 80.0)
                    
//                    RoundedRectangle(cornerRadius: 40.0, style: .circular)
//                        .foregroundColor(.clear)
//                        .background(
//                            LinearGradient(gradient: Gradient(colors: [.white.opacity(0.0), .white]), startPoint: .top, endPoint: .bottom)
//                        )
                    
                    nickname
                        .padding(.leading, 24.0)
                        .opacity(1 - max(0, min(1, (progress - 0.75) * 4.0)))
                    
                    smallHeader
                        .opacity(progress)
                        .opacity(max(0, min(1, (progress - 0.75) * 4.0)))
                        
                }
                .frame(height: 80.0)
            }
        }
    }
    
    private var roomContentView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    wallInfo
                    ceilingInfo
                    floorInfo
                    Color.clear.frame(height: 100)
                }
            }
        }
    }
    
    private var nickname: some View {
        HStack {
            VStack(alignment: .leading) {
                Text((room.nickname ?? "N/A")
                    .uppercased())
                    .font(.title)
                Text((room.roomType ?? "N/A")
                    .uppercased())
                .font(.footnote)
                
            }
            .padding(.vertical, 20)
            
            Spacer()
            
            Button(action: {
                print("open form view")
            }, label: {
                Text("Edit")
                    .font(.system(size: 20))
            })
            .padding(.trailing, 10)
        }
    }
    
    private var wallInfo: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Label {
                        Text(("Wall").uppercased())
                            .font(.title3)
                            .foregroundColor(.gray)
                    } icon: {}
                    Label {
                        Text(("Paint Brand:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.walls?.wallPaintBrand ?? "")
                    } icon: {}
                        .padding(.leading, 10)
                    Label {
                        Text(("Paint Color:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.walls?.wallPaintColor ?? "")
                    } icon: {}
                        .padding(.leading, 10)
                    Label {
                        Text(("Paint Finish:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.walls?.wallPaintFinish ?? "")
                    } icon: {}
                        .padding(.leading, 10)
                    if room.walls?.wallType == "Tile" {
                        Label {
                            Text("Grout Color")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.walls?.groutColor ?? "N/A")
                        } icon: {}
                            .padding(.leading, 10)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
    private var ceilingInfo: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Label {
                        Text(("Ceiling").uppercased())
                            .font(.title3)
                            .foregroundColor(.gray)
                    } icon: {}
                    Label {
                        Text(("Paint Brand:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.ceiling?.ceilingPaintBrand ?? "")
                    } icon: {}                        .padding(.leading, 10)
                    Label {
                        Text(("Paint Color:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.ceiling?.ceilingPaintColor ?? "")
                    } icon: {}                        .padding(.leading, 10)
                    Label {
                        Text(("Paint Finish:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.ceiling?.ceilingPaintFinish ?? "")
                    } icon: {}                        .padding(.leading, 10)
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
    private var floorInfo: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Label {
                        Text(("Floor").uppercased())
                            .font(.title3)
                            .foregroundColor(.gray)
                    } icon: {}
                    Label {
                        Text(("Type:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.flooring?.floorType ?? "")
                    } icon: {}                        .padding(.leading, 10)
                    Label {
                        Text(("Brand:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.flooring?.floorBrand ?? "")
                    } icon: {}
                        .padding(.leading, 10)
                    Label {
                        Text(("Collection Name:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.flooring?.floorCollectionName ?? "")
                    } icon: {}
                        .padding(.leading, 10)
                    Label {
                        Text(("Style Number:").uppercased())
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(room.flooring?.floorStyleNumber ?? "")
                    } icon: {}
                        .padding(.leading, 10)
                    if room.flooring?.floorType == "Tile" {
                        Label {
                            Text("Grout Color")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text(room.flooring?.groutColor ?? "N/A")
                        } icon: {}
                            .padding(.leading, 10)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

//struct RoomDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            RoomDetailView(room: Room(flooring: Flooring(floorType: "Wood", floorCollectionName: "Lowes", floorStyleNumber: "1234", floorBrand: "Brand", groutColor: ""), roomType: "Bathroom", ceiling: Ceiling(ceilingPaintBrand: "Sherwin Williams", ceilingPaintColor: "White", ceilingPaintFinish: "Satin"), nickname: "Scott's Room", id: "", walls: Walls(wallType: "Sheetrock", wallPaintBrand: "Sherwin Williams", wallPaintColor: "Blue", wallPaintFinish: "Gloss", groutColor: "")))
//        }
//    }
//}
