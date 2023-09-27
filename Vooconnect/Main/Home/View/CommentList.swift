//
//  CommentList.swift
//  Vooconnect
//
//  Created by Vooconnect on 31/12/22.
//

import SwiftUI
import URLImage

struct CommentList: View {
    
    //    @Binding var commentSheet: Bool
    @Binding var commentReplySheet: Bool
    
    @State var comment: CommentsData
    @State var comments: [CommentsData] = []
    //        @State var users: [Users] = []
    @State var likeUnlike: Bool = false
    
    @Binding var commentId: Int
    @State var selectedReaction: Int = 0
    
    @StateObject private var likeVM: ReelsLikeViewModel = ReelsLikeViewModel()
    
    @State var username: String = ""
    @Binding var placeholder: String
    @Binding var isReply: Bool
    @State var isReplies: Bool = false
    //    @State var commentText: String = ""
    @State private var likeCount: Int = 0
    @State private var likeeeeCount: Int = 0
    @State var likeImage: String = "LikeWhiteC"
    @State var longPressPopUp: Bool = false
    
    var body: some View {
        
        //        if comment.reply_to_comment_id == 0 {
        ZStack{
            VStack(alignment: .leading) {
            
            HStack {
                Image(comment.userProfileImage ?? "ImageCP")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .cornerRadius(10)
                
                //                        ForEach(users, id: \.self){ user in
                //                            if user.uuid == comment.userUUID {
                Text("\(comment.userUsername ?? "")")
                    .font(.custom("Urbanist-Bold", size: 16))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                    .padding(.leading, 10)
                //                            }
                //                        }
                
                
                Spacer()
                
                Image("MoreOptionLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
            }
            
            Text(comment.comment ?? "")
                .font(.custom("Urbanist-Regular", size: 14))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
            
            HStack {
                
                
                Image(likeImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 28, height: 28)
                    .clipped()
                    .onTapGesture {
                        likeUnlike.toggle()
                        print("Success ====== 0")
                        likeVM.reelsLikeDataModel.userUUID = comment.userUUID ?? ""
                        //                            likeVM.reelsLikeDataModel.postID = comment.postID ?? 0
                        if likeUnlike == true {
                            likeCount = likeCount+1
                            likeeeeCount = likeeeeCount+1
                            likeImage = "LikeRedC"
                        } else{
                            likeCount = likeCount-1
                            likeeeeCount = likeeeeCount-1
                            likeImage = "LikeWhiteC"
                        }
                        
                        likeVM.commentLikeApi(reactionType: 1, comment_id: comment.id!)
                        
                        if longPressPopUp == true {
                            longPressPopUp = false
                        }
                    }
                    .onLongPressGesture(minimumDuration: -0.5) {
                        longPressPopUp.toggle()
                    }
                Text("\(likeCount)")
                    .font(.custom("Urbanist-Medium", size: 12))
                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                
                Text(formatTimeElapsed(from: comment.updatedAt ?? "2023-09-11T08:13:26.000Z"))
                    .font(.custom("Urbanist-Medium", size: 12))
                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                    .padding(.leading, 10)
                
                Button {
                    commentId = comment.id ?? 0
                    print("Comment Id ------------ \(commentId)")
                    placeholder = "Reply to \(comment.userUsername ?? "")"
                    isReply.toggle()
                    //                            commentReplySheet.toggle()
                    //                            commentSheet.toggle()
                    //                            isReply = true
                } label: {
                    Text("Reply")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                }
                .padding(.leading, 10)
                
            }
            .onAppear{
                if comment.isLiked == 1{
                    if likeeeeCount == 0{
                        likeUnlike = true
                        likeeeeCount = likeeeeCount + 1
                        likeImage = "HeartRedLV"
                        if let likesCount = comment.likeCount{
                            likeCount = likesCount
                        }
//                        if comment.reactionType == 1{
//                            likeImage = "HeartRedLV"
//                        }else if (comment.reactionType == 2){
//                            likeImage = "Love"
//                        }else if (comment.reactionType == 3){
//                            likeImage = "Haha"
//                        }else if (comment.reactionType == 4){
//                            likeImage = "Sad"
//                        }else if (comment.reactionType == 5){
//                            likeImage = "Angry"
//                        }else if (comment.reactionType == 6){
//                            likeImage = "Angry"
//                        }
                    }
                }
            }
            if isReplies{
                LazyVGrid(columns: gridLayoutLS, alignment: .center, spacing: columnSpacingLS, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<likeVM.commentReplies.count, id: \.self) { ind in
                            CommentReplyList(commentReplySheet: $commentReplySheet, isReply: $isReply, replyToComment: likeVM.commentReplies[ind], commentId: $commentId, placeholder: $placeholder)
                            
                            //                                }
                            
                        }
                    }
                }
                .padding(.leading, 40)
            }
            
            if let replyCount = comment.replyCount {
                if replyCount != 0 {
                    HStack{
                        Text("View Replies (\(replyCount))")
                            .font(.custom("Urbanist-Regular", size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                        Image("ArrowDownS")
                    }
                    .onTapGesture {
                        isReplies.toggle()
                        likeVM.fetchCommentRepliesApi(commentId: comment.id!)
                    }
                }
            }
            
            
        }
    }
//    HStack {
//        if longPressPopUp {
//            CommentLongPressPopUp(likeImage: $likeImage, longPressPopUp: $longPressPopUp, selectedReaction: selectedReaction, commentId: comment.id, likeCount: $likeCount, likeeCount: $likeeeeCount, isLiked: $likeUnlike)
//        }
//    }
//    .frame(maxHeight: .infinity, alignment: .bottom)
//    .padding(.bottom, 70)
}
    
    func formatTimeElapsed(from dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set locale to ensure correct date parsing
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Ensure the date is in GMT
            
            if let createdAtDate = dateFormatter.date(from: dateString) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day, .hour, .minute], from: createdAtDate, to: Date())
                
                if let days = components.day, days > 0 {
                    return "\(days) day\(days == 1 ? "" : "s") ago"
                } else if let hours = components.hour, hours > 0 {
                    return "\(hours) hour\(hours == 1 ? "" : "s") ago"
                } else if let minutes = components.minute, minutes > 0 {
                    return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
                } else {
                    return "Just now"
                }
            } else {
                return "Invalid Date"
            }
        }
}

//struct CommentList_Previews: PreviewProvider {
//    @State static var commentId: Int = 0
//    @State static var commentReplySheet: Bool = false
//    @State static var commentSheet: Bool = false
//    
//    static var previews: some View {
//        CommentList(commentSheet: $commentSheet, commentReplySheet: $commentReplySheet, commentId: $commentId)
//    }
//}
