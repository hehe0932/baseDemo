//
//  PersonCenterController.m
//  wode
//
//  Created by chenlishuang on 16/12/1.
//  Copyright © 2016年 chenlishuang. All rights reserved.
//

#import "PersonCenterController.h"
#import "HeaderView.h"
#import "MessageViewController.h"
#import "ChangePasswordViewController.h"
#import "AboutViewController.h"
#import "HelpCenterViewController.h"
#import "FeedbackViewController.h"
#import "LoginViewController.h"
@interface PersonCenterController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *imagesArray;
@property(nonatomic,weak)HeaderView *headerView;
@end

@implementation PersonCenterController
- (NSArray *)titleArray{
    if (!_titleArray) {

        _titleArray = [NSArray array];
        _titleArray = @[@[@"我的消息",@"修改密码"],@[@"帮助中心",@"关于我们",@"联系我们"]];
    }
    return _titleArray;
}
- (NSArray *)imagesArray{
    if (!_imagesArray) {
        
        _imagesArray = [NSArray array];
        _imagesArray = @[@[@"icon_@2x_11",@"icon_@2x_20"],@[@"icon_@2x_16",@"icon_@2x_18",@"icon_@2x_20"]];
    }
    return _imagesArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBar];
    [self setupTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登出" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    // Do any additional setup after loading the view.
}
- (void)logout{
    [self alertWithTitile:@"提示" message:@"您是否要退出登录" handle:^(UIAlertAction *action) {
        
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:kUserName];
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:kPassword];
        [UIApplication sharedApplication].keyWindow.rootViewController = [LoginViewController new];
    }];
}
//通用alertController
- (void)alertWithTitile:(NSString *)title message:(NSString *)message handle:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertController *sameAlertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [sameAlertC addAction:sureAction];
    [sameAlertC addAction:cancleAction];
    [self presentViewController:sameAlertC animated:YES completion:nil];
}
- (void)setNavigationBar{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}
- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    HeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil][0];
    headerView.view1.layer.cornerRadius = 80;
    headerView.view1.layer.borderWidth = 3;
    headerView.view1.layer.borderColor = [UIColor whiteColor].CGColor;
    headerView.view1.alpha = 0.2;
    headerView.view2.layer.cornerRadius = 57;
    headerView.view2.layer.borderWidth = 3;
    headerView.view2.layer.borderColor = [UIColor whiteColor].CGColor;
//    headerView.view2.alpha = 0.2;
    headerView.iconImageBtn.layer.cornerRadius = 32.5;
    headerView.iconImageBtn.layer.borderWidth = 3;
    headerView.iconImageBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    headerView.iconImageBtn.layer.masksToBounds = YES;
    [headerView.iconImageBtn addTarget:self action:@selector(chooseIconImageAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}
- (void)chooseIconImageAction{
    //创建图片控制器
    UIImagePickerController * pc = [[UIImagePickerController alloc]init];
//    pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;//相册的另一种视图形式
    //    pc.sourceType = UIImagePickerControllerSourceTypeCamera这时候是照相使用的，使用的时候先判断能不能使用相机，模拟机不能拍照，调用相册不会用到
    //是否允许被编辑
    pc.allowsEditing = YES;
    //代理，这时候遵循一下代理
    pc.delegate = self;//因为delegete遵守了两个协议，这里只需要一个协议，只遵守了一个
    //animated是否要动画
    [self presentViewController:pc animated:YES completion:^{
        
    }];

}

#pragma mark-tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titleArray[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    NSString *imageName = self.imagesArray[indexPath.section][indexPath.row];
    UIImage *icon = [UIImage imageNamed:imageName];
    CGSize itemSize = CGSizeMake(32, 32);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MessageViewController *messageVC = [[MessageViewController alloc]init];
            [self.navigationController pushViewController:messageVC animated:YES];
        }else if (indexPath.row == 1){
            ChangePasswordViewController *vc = [ChangePasswordViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            HelpCenterViewController *vc = [HelpCenterViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            AboutViewController *vc = [AboutViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            FeedbackViewController *vc = [FeedbackViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
    }
}
#pragma mark-UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    self.headerView.iconImageBtn.imageView.image= info[UIImagePickerControllerEditedImage];
//    NSLog(@"%@",info);
    [self.headerView.iconImageBtn setBackgroundImage:info[UIImagePickerControllerEditedImage] forState:(UIControlStateNormal)];
    //退出
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
