//
//  InformationCell.m
//  Egive
//
//  Created by sino on 15/7/28.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "InformationCell.h"
#import "UIView+ZJQuickControl.h"
@implementation InformationCell

- (void)awakeFromNib {
    
    // Initialization code
}

-(NSMutableAttributedString *)setStrA:(NSString *)StrA andIndexA:(int)IndexA andColorA:(UIColor *)ColorA andStrB:(NSString *)StrB andIndexB:(int)IndexB andColorB:(UIColor *)ColorB andStrC:(NSString *)StrC
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:StrC];
    [str addAttribute:NSForegroundColorAttributeName value:ColorA range:NSMakeRange(0,StrA.length+IndexA)];
    [str addAttribute:NSForegroundColorAttributeName value:ColorB range:NSMakeRange(StrA.length+IndexA,StrB.length+IndexB)];
    return str;
}

-(void)setData:(InformationModel *)model andIDArray:(NSArray *)array
{
    if([model.Title rangeOfString:@"-"].location!=NSNotFound){
        NSString * strA=nil;
        NSString * strB=nil;
        for (int i=0; i<[model.Title length]; i++) {
            NSString *temp = [model.Title substringWithRange:NSMakeRange(i, 1)];
            if ([temp isEqualToString:@"-"]) {
                strA=[model.Title substringToIndex:i+1];
                strB=[model.Title substringFromIndex:i+1];
                break;
            }
        }
        NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc] init];
        titleStr=[self setStrA:strA andIndexA:0 andColorA:[UIColor blackColor] andStrB:strB andIndexB:0 andColorB:[UIColor purpleColor] andStrC:model.Title];
        self.Title.attributedText=titleStr;
    }
    else{
        self.Title.text=model.Title;
    }
    
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentJustified;//设置对齐方式
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;

    NSString * htmlString =[NSString stringWithFormat:@"<html><body>%@</body></html>",model.Msg];
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType ,NSParagraphStyleAttributeName:paragraph} documentAttributes:nil error:nil];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attrStr.length)];
   
    self.SubTitle.attributedText = attrStr;
    self.SubTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.Dtate.text=model.CreatedDate;

    if (array) {
        for(int i=0; i<array.count; i++)
        {
            if (![model.MsgID isEqualToString:array[i]]) {
                if (array.count-1==i) {
                    self.NewImage.hidden=NO;
                }
            }
            else
            {
                self.NewImage.hidden=YES;
                break;
            }
        }
    }
    else{
        self.NewImage.hidden=NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
