//
//  CommentModel.h
//  Egive
//
//  Created by sino on 15/9/17.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic,copy) NSString *MemberName;
@property (nonatomic,copy) NSString *CaseCommentID;
@property (nonatomic,copy) NSString *Comment;
@property (nonatomic,copy) NSString *CommentDate;
@property (nonatomic,copy) NSString *ImgURL;
@property (nonatomic,copy) NSString *MemberID;
@end
