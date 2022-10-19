//
//  EnglishHomeViewController.m
//  EnglishTool
//
//  Created by MarkLiu on 2022/10/17.
//

#import "EnglishHomeViewController.h"
#import "IFlyMSC/IFlyMSC.h"
//#import "IATConfig.h"
#define PUTONGHUA   @"mandarin"
#define YUEYU       @"cantonese"
#define ENGLISH     @"en_us"
#define CHINESE     @"zh_cn"
#define SICHUANESE  @"lmz"
@interface EnglishHomeViewController ()<UITextViewDelegate,IFlySpeechRecognizerDelegate,IFlyRecognizerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *soundBty;
@property (weak, nonatomic) IBOutlet UIButton *ftB;
@property (weak, nonatomic) IBOutlet UIButton *imgBty;
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//Recognition conrol without view
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;
@property (weak, nonatomic) IBOutlet UITextView *textEnterTextView;
//5cf4f864
@end

@implementation EnglishHomeViewController

- (void)viewDidLoad {
  // 首页
    [super viewDidLoad];
    [self createUI];
   
     
}


-(void)createUI{
    self.ftB.layer.cornerRadius=28;
    self.textEnterTextView.keyboardType = UIKeyboardTypeDefault;
    self.textEnterTextView.delegate = self;
    [self.imgBty setTitle:@"" forState:UIControlStateNormal];
    [self.soundBty setTitle:@"" forState:UIControlStateNormal];
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", @"90053474"];
    [IFlySpeechUtility createUtility:initString];
}

//讯飞SDK
-(void)initXunFei{


    [self.iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
    //set recognition domain
    [self.iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    self.iflyRecognizerView.delegate = self;
    [self.iflyRecognizerView setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
    [self.iflyRecognizerView setParameter:PUTONGHUA forKey:[IFlySpeechConstant ACCENT]];
    [self.iflyRecognizerView setParameter:@"16000"forKey:[IFlySpeechConstant SAMPLE_RATE]];
    [self.iflyRecognizerView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
    //set VAD timeout of beginning of speech(BOS)
    [self.iflyRecognizerView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
    //set network timeout
    [self.iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
    
    [self.iflyRecognizerView setParameter:CHINESE forKey:[IFlySpeechConstant LANGUAGE]];
    
    
    
}
// 翻译按钮
- (IBAction)ftbGoTranslate:(UIButton *)sender {
    
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.text =nil;
    return YES;
}


- (IBAction)soundEnterBtyClick:(UIButton *)sender {
    [self initXunFei];
    
    if ([self.iflyRecognizerView start]) {
        return;;
    }else{
        
    }
}


- (IBAction)imageSBBtyClick:(UIButton *)sender {
}

//IFlyRecognizerViewDelegate---------------------
-(void)onCompleted:(IFlySpeechError *)error
{
    
}
-(void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    
}

//IFlySpeechRecognizerDelegate--------------------
-(void)onVolumeChanged:(int)volume{
    
}


- (void) onBeginOfSpeech
{

}

/**
End Of Speech
**/
- (void) onEndOfSpeech
{
   NSLog(@"onEndOfSpeech");
   
}


/**
result callback of recognition without view
results：recognition results
isLast：whether or not this is the last result
**/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
  
}

// 懒加载---
-(IFlyRecognizerView *)iflyRecognizerView{
    if (_iflyRecognizerView ==nil) {
        _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center] ;
    }
    return _iflyRecognizerView;
    
}

-(IFlySpeechRecognizer *)iFlySpeechRecognizer{
    if (!_iFlySpeechRecognizer) {
        
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    
    }
    return _iFlySpeechRecognizer;
}
@end
