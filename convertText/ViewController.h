//
//  ViewController.h
//  convertText
//
//  Created by 楢木 悠士 on 2015/03/11.
//  Copyright (c) 2015年 yuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController
{
    UILabel *label;
    IBOutlet UITextView *textView;
    NSString *string;
    CGRect rect;
    IBOutlet UITextField *textField;
    IBOutlet UIButton *convertButton;
    IBOutlet UIButton *back;
    IBOutlet UIButton *copy;
}

-(IBAction)back;
-(IBAction)copy;
-(IBAction)convertButton;
-(void)convert;
@end

