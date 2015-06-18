//
//  ViewController.m
//  convertText
//
//  Created by 楢木 悠士 on 2015/03/11.
//  Copyright (c) 2015年 yuji. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [textField addTarget:self    //textField
                  action:@selector(textField_EditingChanged:)
        forControlEvents:UIControlEventEditingChanged];
    
    back.alpha=0;
    copy.alpha=0;
    textView.alpha=0;
    
    string = @"";
    textField.text=@"Apple";
    
    rect = CGRectMake(10, 85, 200, 600);
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(-150, 260, 600, 200)];
    label.font = [UIFont fontWithName:@"AppleGothic" size:200];
    //label.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN W6" size:100];
    label.text = textField.text;
    
//    [[label layer] setBorderColor:[[UIColor blackColor] CGColor]];
//    [[label layer] setBorderWidth:1.0];
    
    [self.view addSubview:label];
    
    [label setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    
    label.frame = rect;
    
}

-(IBAction)convertButton{
    if(textField.text!=nil){
        [self convert];
    }
}

-(void)convert{
    if(label.alpha!=0){
        
        UIGraphicsBeginImageContext(rect.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *capture = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //    CGImageRef cgImageRef = CGImageRetain(capture.CGImage);
        ////    UIImage *image = [UIImage imageNamed:@"color.png"];
        ////    CGImageRef cgImageRef = CGImageRetain(image.CGImage);
        ////    CFDataRef *imageData = CGDataProviderCopyData(CGImageGetDataProvider(cgImageRef));
        //    NSData *data = (id)CFBridgingRelease(CGDataProviderCopyData(CGImageGetDataProvider(cgImageRef)));
        ////    NSLog(@"the data = %@", imageData);
        //    NSLog(@"the data = %@", data);
        
        // CGImageを取得する
        CGImageRef  imageRef = capture.CGImage;
        // データプロバイダを取得する
        CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
        
        // ビットマップデータを取得する
        CFDataRef dataRef = CGDataProviderCopyData(dataProvider);
        UInt8 *buffer = (UInt8*)CFDataGetBytePtr(dataRef);
        
        size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
        
        string = @"";
        
//        span style="color: rgb(0, 128, 128);"> // 画像全体を１ピクセルずつ走査する
//        for (int y=0; y<capture.size.height; y+=capture.size.height/30) {
//            for (int x=0; x<capture.size.width; x+=capture.size.width/10) {
        for (int y=rect.origin.y; y<capture.size.height+rect.origin.y; y+=(capture.size.height)/31) {
            for (int x=rect.origin.x; x<capture.size.width+rect.origin.x; x+=(capture.size.width)/10) {
                // ピクセルのポインタを取得する
                UInt8 *pixelPtr = buffer + (int)(y) * bytesPerRow + (int)(x) * 4;
//                NSLog(@"%s",pixelPtr);
                
                // 色情報を取得する
                UInt8 r = *(pixelPtr + 2);  // 赤
                UInt8 g = *(pixelPtr + 1);  // 緑
                UInt8 b = *(pixelPtr + 0);  // 青
//                NSLog(@"%d",r);
                
                if(r==255&&g==255&&b==255){
                    string = [string stringByAppendingString:@"　"];
                }else{
//                    string = [string stringByAppendingString:@"■"];
                    string = [string stringByAppendingString:@""];
                }
                
                
                //NSLog(@"x:%d y:%d R:%d G:%d B:%d", x, y, r, g, b);
            }
            string = [string stringByAppendingString:@"\n"];
            
        }
        
        CFRelease(dataRef);
        
        label.alpha=0;
        textView.alpha=1;
        
//        [[textView layer] setBorderColor:[[UIColor blackColor] CGColor]];
//        [[textView layer] setBorderWidth:1.0];
        
        textView.text=string;
        convertButton.alpha=0;
        back.alpha=1.0;
        copy.alpha=1.0;
    }
}

-(IBAction)copy{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setValue:string forPasteboardType:@"public.utf8-plain-text"];
}

-(void)textField_EditingChanged:(id)sender{
    label.alpha=1;
    textView.alpha=0;
    label.text = textField.text;
    convertButton.alpha=1.0;
    back.alpha=0;
    copy.alpha=0;
}

-(IBAction)back{
    label.alpha=1;
    textView.alpha=0;
    convertButton.alpha=1;
    back.alpha=0;
    copy.alpha=0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
