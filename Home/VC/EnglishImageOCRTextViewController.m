//
//  EnglishImageOCRTextViewController.m
//  EnglishTool
//
//  Created by MarkLiu on 2022/10/25.
//

#import "EnglishImageOCRTextViewController.h"
#import "EnglishHomeModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface EnglishImageOCRTextViewController ()<UIImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startShiBieBty;
@property (weak, nonatomic) IBOutlet UIButton *backBty;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *buttVIew;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *imageBty;
//@property (nonatomic,strong)UIAlertController *alertVC;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation EnglishImageOCRTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backView.layer.cornerRadius=10;
    self.buttVIew.layer.cornerRadius=50;
    self.photoImageView.layer.cornerRadius=10;
    self.textView.text =@"";
    [self.imageBty setTitle:@"" forState:UIControlStateNormal];
    self.textView.layer.cornerRadius=10;
    self.photoImageView.hidden = YES;
    UITapGestureRecognizer*tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clcikImage)];
    self.photoImageView.userInteractionEnabled = YES;
    [self.photoImageView addGestureRecognizer:tap];
    [self.startShiBieBty setTitle:@"开始识别" forState:UIControlStateNormal];
    self.startShiBieBty.layer.cornerRadius=5;
}
-(void)clcikImage{
    [self.imageBty sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)chooseImage:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * imageAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf takePhoto];
        
    }];
    UIAlertAction * imagePhotoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf LocalPhoto];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:imageAction];
    [alertVc addAction:imagePhotoAction];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
    
    
}
//开始拍照
-(void)takePhoto
{
    
//    __weak typeof(self) weakSelf = self;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];

        
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;

    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    __weak typeof(self) weakSelf = self;
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
     
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        weakSelf.photoImageView.hidden = NO;
        weakSelf.photoImageView.image = image;
        
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)startShiBieAc:(UIButton *)sender {
    self.startShiBieBty.userInteractionEnabled = NO;
    if (self.photoImageView.image !=nil) {
        UIImage *phothImage  = self.photoImageView.image;
        NSData *data =  [NSData dataWithData:UIImageJPEGRepresentation(phothImage, 1)];
        NSString *Str = [EnglishHomeModel ImageWithText:data];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请先传入图片"];
        self.startShiBieBty.userInteractionEnabled = YES;
    }
  
    
}
- (IBAction)backAC:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
