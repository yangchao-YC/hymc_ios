//
//  DynamicCell.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "DynamicCell.h"
#import "DynamicModel.h"
#import "RegexKitLite.h"
#import "RTLabel.h"

@implementation DynamicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    self.contentRTLabel = [[RTLabel alloc] initWithFrame:CGRectMake(20,40,300,0)];
    [self.contentRTLabel setParagraphReplacement:@""];
    [self.contentView addSubview:self.contentRTLabel];
    [self.contentRTLabel setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize optimumSize = [self.contentRTLabel optimumSize];
	CGRect frame = [self.contentRTLabel frame];
	frame.size.height = optimumSize.height; // +5 to fix height issue, this should be automatically fixed in iOS5
	[self.contentRTLabel setFrame:frame];
    
    CGFloat height = self.contentRTLabel.frame.size.height;
    self.btnForwarding.frame = CGRectMake(self.btnForwarding.frame.origin.x, 55 + height, self.btnForwarding.frame.size.width, self.btnForwarding.frame.size.height);
    self.btnPraise.frame = CGRectMake(self.btnPraise.frame.origin.x, 55 + height, self.btnPraise.frame.size.width, self.btnPraise.frame.size.height);
    self.btnReply.frame = CGRectMake(self.btnReply.frame.origin.x, 55 + height, self.btnReply.frame.size.width, self.btnReply.frame.size.height);
}

- (void)setDynamicData:(DynamicModel *)dynamicModel
{
    self.authornameLabel.text = dynamicModel.authorname;
    self.dateTimeLabel.text = [dynamicModel.dateTime stringValue];
    self.contentRTLabel.text = dynamicModel.content;//[self transformString:dynamicModel.content];
    
 
    [self layoutSubviews];
    [self layoutIfNeeded];
}

- (NSString *)transformString:(NSString *)originalStr
{
    NSMutableString *text = [NSMutableString string];
    int startIndex = -1;
    for (int i=0; i<originalStr.length; i++) {
        NSString *s = [originalStr substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"{"]) {
            startIndex = i;
        }
        
        if (startIndex < 0) {
            [text appendString:s];
        }
        
        if ([s isEqualToString:@"}"]) {
            if (startIndex > -1) {
                NSLog(@"%@",[originalStr substringWithRange:NSMakeRange(startIndex, i-startIndex)]);
                startIndex = -1;
            }
        }
        
        i++;
    }
    
    NSLog(@"%@",text);
    
    //NSString *text = originalStr;
    /*
    //解析http://短链接
    NSString *regex_http =@"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";//http://短链接正则表达式
    NSArray *array_http = [text componentsMatchedByRegex:regex_http];
    
    if ([array_http count]) {
        for (NSString *str in array_http) {
            NSRange range = [text rangeOfString:str];
            NSString *funUrlStr = [NSString stringWithFormat:@"<a href=%@>%@</a>",str, str];
            text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, str.length)withString:funUrlStr];
        }
    }
    */
    /*
    //解析@
    NSString *regex_at =@"@[\\u4e00-\\u9fa5\\w\\-]+";//@的正则表达式
    NSArray *array_at = [text componentsMatchedByRegex:regex_at];
    if ([array_at count]) {
        NSMutableArray *test_arr = [[NSMutableArray alloc]init];
        for (NSString *str in array_at) {
            NSRange range = [text rangeOfString:str];
            if (![test_arr containsObject:str]) {
                [test_arr addObject:str];
                NSString *funUrlStr = [NSString stringWithFormat:@"<a href=%@>%@</a>",str, str];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:funUrlStr];
            }
        }
    }
    */
    /*
    //解析&
    NSString *regex_dot =@"\\$\\*?[\u4e00-\u9fa5|a-zA-Z|\\d]{2,8}(\\((SH|SZ)?\\d+\\))?";//&的正则表达式
    NSArray *array_dot = [text componentsMatchedByRegex:regex_dot];
    if ([array_dot count]) {
        NSMutableArray *test_arr = [[NSMutableArray alloc]init];
        for (NSString *str in array_dot) {
            NSRange range = [text rangeOfString:str];
            if (![test_arr containsObject:str]) {
                [test_arr addObject:str];
                NSString *funUrlStr = [NSString stringWithFormat:@"<a href=%@>%@</a>",str, str];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:funUrlStr];
            }
        }
    }
    */
    /*
    //解析话题
    NSString *regex_pound = @"#([^\\#|.]+)#";//话题的正则表达式
    NSArray *array_pound = [text componentsMatchedByRegex:regex_pound];
    
    if ([array_pound count]) {
        for (NSString *str in array_pound) {
            NSRange range = [text rangeOfString:str];
            NSString *funUrlStr = [NSString stringWithFormat:@"<a href=%@>%@</a>",str, str];
            text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length])withString:funUrlStr];
        }
    }
     */
    /*
    //解析表情
    NSString *regex_emoji =@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\]";//表情的正则表达式
    NSArray *array_emoji = [text componentsMatchedByRegex:regex_emoji];
    NSString *filePath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"emotionImage.plist"];
    NSDictionary *m_EmojiDic = [[NSDictionary alloc]initWithContentsOfFile:filePath];
    // NSString *path = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] bundlePath]];
    
    if ([array_emoji count]) {
        for (NSString *strin array_emoji) {
            NSRange range = [text rangeOfString:str];
            NSString *i_transCharacter = [m_EmojiDicobjectForKey:str];
            if (i_transCharacter) {
                //NSString *imageHtml = [NSString stringWithFormat:@"<img src = 'file://%@/%@' width='12' height='12'>", path, i_transCharacter];
                NSString *imageHtml = [NSStringstringWithFormat:@"<img src =%@>",  i_transCharacter];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:[imageHtmlstringByAppendingString:@" "]];
            }
        }
    }
     */
    //返回转义后的字符串
    return text;
}


@end
