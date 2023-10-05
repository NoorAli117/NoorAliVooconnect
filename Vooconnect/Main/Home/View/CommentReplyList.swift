//
//  CommentReplyList.swift
//  Vooconnect
//
//  Created by door on 16/05/2023.
//

import SwiftUI

struct CommentReplyList: View {
//    @Binding var isReply: Bool
    @Binding var commentReplySheet: Bool
    @Binding var isReply: Bool
    
//    @State var comment: CommentResponse
//    @State var comments: CommentsData
    @State var replyToComment: CommentsData
//    @State var users: [Users] = []
    @State var likeUnlike: Bool = false
    
    @Binding var commentId: Int
//    @Binding var reply_to_reply: String
    
    @StateObject private var likeVM: ReelsLikeViewModel = ReelsLikeViewModel()
    
    @State var username: String = ""
    //    @State var commentText: String = ""
    @Binding var placeholder: String
    
    @State private var likeCount: Int = 0
    @State private var likeeeeCount: Int = 0
    @State var likeImage: String = "LikeWhiteC"
    @State var longPressPopUp: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                
                
                if let userImage = replyToComment.userProfileImage {
                    CreatorProfileImageView(creatorProfileImage: userImage)
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .cornerRadius(10)
                }else{
                    Image("ImageCP")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .cornerRadius(10)
                }
                
//                ForEach(users, id: \.self){ user in
                    
//                    if user.uuid == comment.user_uuid && comment.reply_to_reply.isEmpty {
                Text("\(replyToComment.userUsername ?? "")")
                            .font(.custom("Urbanist-Bold", size: 16))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                            .padding(.leading, 10)
                        
//                    }
                    
//                    if !comment.reply_to_reply.isEmpty && user.uuid! == comment.reply_to_reply.split(separator: "/").first! {
//                        Text("\(user.username ?? "")-")
//                            .font(.custom("Urbanist-Bold", size: 16))
//                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
//                            .padding(.leading, 10)
//                    }
//
//                    if !comment.reply_to_reply.isEmpty && user.uuid! == comment.reply_to_reply.split(separator: "/").last! {
//                        Text("\(user.username ?? "")")
//                            .font(.custom("Urbanist-Bold", size: 16))
//                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
//                            .padding(.leading, 5)
//                    }
//
////                }
                
                
                Spacer()
                
                Image("MoreOptionLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
            }
            
            Text(replyToComment.comment ?? "")
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
                        likeVM.reelsLikeDataModel.userUUID = replyToComment.userUUID ?? ""
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
                        
                        likeVM.commentLikeApi(reactionType: 1, comment_id: replyToComment.id!)
                        
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
                
                Text(formatTimeElapsed(from: replyToComment.createdAt ?? "2023-09-11T08:13:26.000Z"))
                    .font(.custom("Urbanist-Medium", size: 12))
                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                    .padding(.leading, 10)
                
                Button {
                    commentId = replyToComment.replyToCommentID ?? 0
                    print("Comment Id ------------ \(commentId)")
                    placeholder = "Reply to \(replyToComment.userUsername ?? "")"
                    isReply.toggle()
//                    let uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
//                    if comment.reply_to_comment_id != 0 {
//                        commentId = comment.reply_to_comment_id
//                        reply_to_reply = "\(uuid)/\(comment.user_uuid)"
//                        print(commentId)
//                        print(reply_to_reply)
//                    }else{
//                        commentId = comment.id
//                    }
//
//
//                    commentReplySheet.toggle()
//                    commentSheet.toggle()
                } label: {
                    Text("Reply")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7020126242)))
                }
                .padding(.leading, 10)
                
                
                
            }
            
        }
        
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
//
//struct CommentReplyList_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentReplyList()
//    }
//}


