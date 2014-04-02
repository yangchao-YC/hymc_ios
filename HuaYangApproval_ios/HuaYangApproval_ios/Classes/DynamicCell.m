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

#import "TSPopoverController.h"
#import "DynamicCellPopoverContentView.h"

@interface DynamicCell()<RTLabelDelegate>

@end

@implementation DynamicCell

- (CGFloat)height
{
    return 90.0f + self.contentRTLabel.optimumSize.height + 5;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    self.contentRTLabel = [[RTLabel alloc] initWithFrame:CGRectMake(20,40,280,0)];
    self.contentRTLabel.delegate = self;
    [self.contentRTLabel setParagraphReplacement:@""];
    [self.contentView addSubview:self.contentRTLabel];
    [self.contentRTLabel setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSString *)urlString
{
    NSLog(@"%@",urlString);
}

- (IBAction)showPop:(id)sender forEvent:(UIEvent *)event
{
    DynamicCellPopoverContentView *popoverContentView = [[[NSBundle mainBundle] loadNibNamed:@"DynamicCellPopoverContentView" owner:self options:nil] lastObject];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithView:popoverContentView];
    
    popoverController.cornerRadius = 1;
    popoverController.popoverBaseColor = [UIColor greenColor];
    popoverController.popoverGradient= NO;
    [popoverController showPopoverWithTouch:event];
}

- (void)setDynamicData:(DynamicModel *)dynamicModel
{
    self.authornameLabel.text = dynamicModel.authorname;
    self.dateTimeLabel.text = [dynamicModel.dateTime stringValue];
    self.contentRTLabel.text = [self transformString:dynamicModel.content];
    
    CGSize optimumSize = [self.contentRTLabel optimumSize];
	CGRect frame = [self.contentRTLabel frame];
	frame.size.height = optimumSize.height;
	[self.contentRTLabel setFrame:frame];
    
    CGFloat height = self.contentRTLabel.frame.size.height;
    self.btnForwarding.frame = CGRectMake(self.btnForwarding.frame.origin.x, 60 + height, self.btnForwarding.frame.size.width, self.btnForwarding.frame.size.height);
    self.btnPraise.frame = CGRectMake(self.btnPraise.frame.origin.x, 60 + height, self.btnPraise.frame.size.width, self.btnPraise.frame.size.height);
    self.btnReply.frame = CGRectMake(self.btnReply.frame.origin.x, 60 + height, self.btnReply.frame.size.width, self.btnReply.frame.size.height);
}

- (NSString *)transformString:(NSString *)originalStr
{
    //解析@
    NSString *regex_at = @"\\{[^}]*\\}";//@的正则表达式
    NSArray *array_at = [originalStr componentsMatchedByRegex:regex_at];
    if ([array_at count]) {
        for (NSString *str in array_at) {
            NSRange range = [originalStr rangeOfString:str];
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            NSString *funUrlStr = [NSString stringWithFormat:@"<a href=%@><font face='HelveticaNeue-CondensedBold' size=16 color='#0000ff'>%@</font></a>",[info objectForKey:@"uid"], [NSString stringWithFormat:@"@%@",[info objectForKey:@"uname"]]];
            originalStr = [originalStr stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:funUrlStr];
        }
    }
    
    return originalStr;
    
}

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


@end
