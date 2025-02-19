//
//  AboutUsPageController.m
//  Egive
//
//  Created by sinogz on 15/9/10.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "AboutUsPageController.h"
#import "MenuViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@interface AboutUsPageController (){

    NSString * string;
    NSString * subject;
    UIImageView * imageView;
    NSURL *imageurl;

}

@end

@implementation AboutUsPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"AboutGird_label_title1", nil);
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(chairmanButton) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    currentY = 20;
    
    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.delegate = self;
    [self.view addSubview:mScrollView];
    
    //[mScrollView addImageViewWithFrame:CGRectMake(0, 0, kScreenW, 200) image:@"Icon-1024.png"];
    
//    UIPageControl  * pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 180, kScreenW, 20)];
//    pageControl.numberOfPages = 1;
//    [mScrollView addSubview:pageControl];
    
    //[self parseHTML:nil];
    [self getStaticPageContentWithFormID:@"AboutUs"];
    currentY = 220;
    [self addMySlider];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Maile) name:@"other" object:nil];

}
-(void)Maile{
    
    
    
}
- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)chairmanButton{
    
    [self shareSystem];
}


-(void)shareSystem{
    if ([EGUtility getAppLang]==1) {
        NSString *str = @"Egive 意贈慈善基金由一群熱心公益的社會賢達創辦，旨在團結個人力量，以生命影響生命的方法，透過互聯網募捐平台，宣揚關懷互愛的訊息，共建關懷互助的社群，以達致「網絡相連．善心相傳」之效。\n\n請瀏覽: http://www.egive4u.org\n\n意贈慈善基金\n電話: (852) 2210 2600\n電郵: info@egive4u.org";
            string = str;
            subject = @"Egive 意贈慈善基金";
        
    }else if ([EGUtility getAppLang]==2){
        NSString *str = @"Egive 意赠慈善基金由一群热心公益的社会贤达创办，旨在团结个人力量，以生命影响生命的方法，透过互联网募捐平台，宣扬关怀互爱的讯息，共建关怀互助的社群，以达致「网络相连．善心相传」之效。\n\n请浏览: http://www.egive4u.org\n\n意赠慈善基金\n电话:(852) 2210 2600\n电邮:info@egive4u.org";
            string = str;
            subject = @"Egive 意赠慈善基金";
    }else{
            
        NSString * str = [NSString stringWithFormat:@"Egive For You Charity Foundation  was founded by a group of public-spirited community leaders who aim to gather everyone to touch the lives of each other.\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org"];
            string = str;
            subject = @"Egive For You Charity Foundation";
    }

    [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];
   
//    UIActivityViewController *activityViewController =
//    [[UIActivityViewController alloc] initWithActivityItems:@[string]
//                                      applicationActivities:nil];
//    [self.navigationController presentViewController:activityViewController
//                                            animated:YES
//                                          completion:^{
//                                              // ...
//                                          }];
//    activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
//    [activityViewController setValue:subject forKey:@"subject"];
}
- (void)parseHTMLTest:(NSString*)htmlString{
    NSString *html = @"<ul id=\"ctl00_cnt_PageContent_ContentList\" class=\"ContentList2\"><li><h2>「意贈慈善基金」理念</h2><p>「意贈慈善基金」旨在團結個人力量，以生命影響生命的<br/>方法，通過互聯網募捐平台，將有需要人士、捐款者及<br/>公眾緊密地連繫起來，共建關懷互助的社群。</p><p>「意贈」不分地域、文化、族裔和語言，致力推動企業、<br/>團體和個人透過「意贈」網站幫助有需要人士，特別是<br/>政府或社會服務機構未能完全涵蓋的服務範疇。「意贈」<br/>期望通過這個互動的平台，集思廣益，共同促進「意贈」<br/>持續發展。</p><br/><br/><h2>「意贈慈善基金」工作方向</h2><table><tr><td>1.&nbsp;</td><td>成立「意贈」網站，建立互聯網募捐平台</td></tr><tr><td>2.&nbsp;</td><td>舉辦「意贈行動」，動員社會各界參與</td></tr><tr><td>3.&nbsp;</td><td>設立「意贈愛心企業計劃」，鼓勵企業參與</td></tr><tr><td>4.&nbsp;</td><td>成立「意贈愛心隊」，凝聚意贈之友</td></tr></table><br/><br/><h2>「意贈」網站簡介</h2><p>「意贈慈善基金」創立全球性的網上募捐平台，匯聚全球<br/>捐款者的關懷，即時幫助有需要人士。「意贈」涵蓋的<br/>服務範疇廣泛，包括：助學、安老、助醫、扶貧、緊急<br/>援助及其他項目。</p><p>「意贈」藉著互聯網讓更多人士可以參與慈善活動，特別<br/>是年青世代。透過「意贈」發放的資訊，引發他們的關懷<br/>和參與、幫助和支援有需要人士，關注他人的需要。</p><p>為了有效幫助受惠者，「意贈」以點對點的方式進行募捐<br/>，讓有需要人士能直接受惠。「意贈」鼓勵捐款者按照<br/>個人的能力捐輸，數目不論多寡，發揮聚沙成塔的效果。</p><p>「意贈」深切認同互助互勉的信念，受惠者、捐款者及<br/>公眾可以透過「意贈」溝通，表達關懷和謝意，同時可<br/>透過「意贈」了解受惠者的進度及捐款情況，為社會注入<br/>正能量。</p></li></ul>";
    
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    
    NSData *dataTitle=[html dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//ul"];
    
    [self parseElements:elements];
}


- (void)addSubImageView:(NSURL *)imageURL {
//    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
//    
//    CGFloat height = (self.view.frame.size.width-30)/img.size.width * img.size.height;
//    CGRect rect = CGRectMake(15, currentY, self.view.frame.size.width-30, height);
//    currentY += height + 10;
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
//    [imageView setImage:img];
//    
//    CALayer *layer=[imageView layer];
//    [layer setMasksToBounds:YES];
//    [layer setCornerRadius:10.0];
//    [layer setBorderWidth:1];
//    [layer setBorderColor:[[UIColor blackColor] CGColor]];
//    [mScrollView addSubview:imageView];
//    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];

    imageView = [mScrollView addImageViewWithFrame:CGRectMake(0, 0, kScreenW, 220) image:nil];
    //imageView.backgroundColor=[UIColor redColor];
    //NSString *urlString = [NSString stringWithFormat:@"%@",imageURL];
    //UIImage *ThumbnailImage = [self getThumbnailImage:urlString];
    //imageView.image=ThumbnailImage;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageurl=imageURL;
    __weak __typeof(self)weakself = self;
    
   
    UIButton * playButton = [imageView addImageButtonWithFrame:CGRectMake(20, 140, 50, 50) title:nil backgroud:nil action:^(UIButton *button){
        
        
        MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:imageURL];
        
        [weakself presentViewController:mpvc animated:YES completion:nil];
        
        
    }];
  [playButton setBackgroundImage:[UIImage imageNamed:@"comment_play.png"] forState:UIControlStateNormal];
    
  NSThread *thr = [[NSThread alloc]initWithTarget:self selector:@selector(task) object:nil];
        [thr start];

}

-(void)task{

    NSString *urlString = [NSString stringWithFormat:@"%@",imageurl];
    UIImage *ThumbnailImage = [self getThumbnailImage:urlString];
    imageView.image=ThumbnailImage;
    imageView.contentMode = UIViewContentModeScaleAspectFit;

}

-(UIImage *)getThumbnailImage:(NSString *)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(10, 50);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if (error) {
       // MyLog(@"截取视频图片失败:%@",error.localizedDescription);
    }
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}

@end
