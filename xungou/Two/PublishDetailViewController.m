//
//  PublishDetailViewController.m
//  peigou
//
//  Created by Hehe on 2019/8/30.
//  Copyright © 2019 shuang. All rights reserved.
//

#import "PublishDetailViewController.h"
@interface PublishDetailViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UITextField *sexTF;
@property (weak, nonatomic) IBOutlet UIView *ageView;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UIView *classifyView;
@property (weak, nonatomic) IBOutlet UITextField *classifyTF;
@property (weak, nonatomic) IBOutlet UIView *adressView;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UITextField *descTF;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
/** 是否有图片 */
@property (nonatomic,assign) BOOL hasImage;
@end

@implementation PublishDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布";
    self.hasImage = NO;
    [self.nameView addBottomLineWithEdge:UIEdgeInsetsZero viewSize:self.nameView.bounds.size];
    [self.sexView addBottomLineWithEdge:UIEdgeInsetsZero viewSize:self.sexView.bounds.size];
    [self.ageView addBottomLineWithEdge:UIEdgeInsetsZero viewSize:self.ageView.bounds.size];
    [self.classifyView addBottomLineWithEdge:UIEdgeInsetsZero viewSize:self.classifyView.bounds.size];
    [self.adressView addBottomLineWithEdge:UIEdgeInsetsZero viewSize:self.adressView.bounds.size];
    [self.descView addBottomLineWithEdge:UIEdgeInsetsZero viewSize:self.descView.bounds.size];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"姓名:";
    label1.font = [UIFont systemFontOfSize:13];
    label1.frame = CGRectMake(0, 0, 45, 44);
    self.nameTF.placeholder = @"请输入姓名";
    self.nameTF.leftView = label1;
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"性别:";
    label2.font = [UIFont systemFontOfSize:13];
    label2.frame = CGRectMake(0, 0, 45, 44);
    self.sexTF.placeholder = @"请输入性别";
    self.sexTF.leftView = label2;
    self.sexTF.leftViewMode = UITextFieldViewModeAlways;
    self.sexTF.enabled = NO;
    if (self.gender == 0) {
        self.sexTF.text = @"雄性";
    }else{
        self.sexTF.text = @"雌性";
    }
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"年龄:";
    label3.font = [UIFont systemFontOfSize:13];
    label3.frame = CGRectMake(0, 0, 45, 44);
    self.ageTF.placeholder = @"请输入年龄";
    self.ageTF.leftView = label3;
    self.ageTF.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.text = @"电话:";
    label4.font = [UIFont systemFontOfSize:13];
    label4.frame = CGRectMake(0, 0, 45, 44);
    self.classifyTF.placeholder = @"请输入电话";
    self.classifyTF.leftView = label4;
    self.classifyTF.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *label5 = [[UILabel alloc]init];
    label5.text = @"地址:";
    label5.font = [UIFont systemFontOfSize:13];
    label5.frame = CGRectMake(0, 0, 45, 44);
    self.addressTF.placeholder = @"请输入地址";
    self.addressTF.leftView = label5;
    self.addressTF.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *label6 = [[UILabel alloc]init];
    label6.text = @"介绍:";
    label6.font = [UIFont systemFontOfSize:13];
    label6.frame = CGRectMake(0, 0, 45, 44);
    self.descTF.placeholder = @"请输入介绍";
    self.descTF.leftView = label6;
    self.descTF.leftViewMode = UITextFieldViewModeAlways;
    
}
- (IBAction)imageAction:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"请选择操作" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        //设置相册呈现的样式
        pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
        //照片的选取样式还有以下两种
        //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
        //UIImagePickerControllerSourceTypeCamera//调取摄像头
        // UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
        
        pickerController.delegate = self;
        [self.navigationController presentViewController:pickerController animated:YES completion:nil];
        
    }];
    UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        //设置相册呈现的样式
        pickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        pickerController.delegate = self;
        [self.navigationController presentViewController:pickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:albumAction];
    [alertVC addAction:photographAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (IBAction)submitAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.nameTF.text.length == 0) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写姓名";
        [hud hide:YES afterDelay:2];
        return;
    }else if (self.sexTF.text.length == 0){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写性别";
        [hud hide:YES afterDelay:2];
        return;
    }else if (self.ageTF.text.length == 0){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写年龄";
        [hud hide:YES afterDelay:2];
        return;
    }
    else if (self.descTF.text.length == 0){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写介绍";
        [hud hide:YES afterDelay:2];
        return;
    }
    else if (self.classifyTF.text.length == 0){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写电话";
        [hud hide:YES afterDelay:2];
        return;
    }
    else if (self.addressTF.text.length == 0){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写地址";
        [hud hide:YES afterDelay:2];
        return;
    }
    else if (self.hasImage == NO){
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请上传图像";
        [hud hide:YES afterDelay:2];
        return;
    }
    hud.labelText = @"正在提交...请稍后";
    [hud hide:YES afterDelay:2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self alertWithTitile:@"提示" message:@"提交成功,等待审核..." handle:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    });
}

//通用alertController
- (void)alertWithTitile:(NSString *)title message:(NSString *)message handle:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertController *sameAlertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];

    [sameAlertC addAction:sureAction];
    [self presentViewController:sameAlertC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.hasImage = YES;
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.imageButton setImage:image forState:UIControlStateNormal];
}


@end
