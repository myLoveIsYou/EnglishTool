//
//  EnglishHomeViewController.m
//  EnglishTool
//
//  Created by MarkLiu on 2022/10/17.
//

#import "EnglishHomeViewController.h"

@interface EnglishHomeViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *ftB;
@property (weak, nonatomic) IBOutlet UITextView *textEnterTextView;

@end

@implementation EnglishHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
     
}


-(void)createUI{
    self.ftB.layer.cornerRadius=28;
    self.textEnterTextView.keyboardType = UIKeyboardTypeDefault;
    self.textEnterTextView.delegate = self;
    
}
// 翻译按钮
- (IBAction)ftbGoTranslate:(UIButton *)sender {
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.text =nil;
    return YES;
}


- (IBAction)soundEnterBtyClick:(UIButton *)sender {
}


- (IBAction)imageSBBtyClick:(UIButton *)sender {
}
@end
