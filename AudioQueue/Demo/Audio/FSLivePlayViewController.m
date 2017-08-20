////
////  FSLiveViewController.m
////  Foscam
////
////  Created by song.wang on 14-7-23.
////  Copyright (c) 2014年 Foscam. All rights reserved.
////
//#import "FSLivePlayViewController.h"
//#import <MediaPlayer/MediaPlayer.h>
//#import "TYMActivityIndicatorView.h"
//#import "SettingsViewController.h"
//#import "FSCGIResultParser.h"
//#import "NSString+FS.h"
//#import "UIImage+Color.h"
//#import "UIViewController+FS.h"
//#import "UILabel+FS.h"
//#import "UIButton+FS.h"
//#import "JSONKit.h"
//#import "FSNetService.h"
//#import "FCOutputAudio.h"
//#import "FCInputAudio.h"
//#import "FSDatabaseHelper.h"
//#import "FSTypedef.h"
//#import <VideoToolbox/VideoToolbox.h>
//#import <AVFoundation/AVSampleBufferDisplayLayer.h>
//#import "FSInitInfoModel.h"
//
//#import "FSAppDelegate.h"
//
//#import "LiveHD.h"
//#import "FosDef.h"
//
//#import "OpenAl_aec.h"
//
//#import "ProductAllInfoHelper.h"
//#import "DevInfoModel.h"
//#import "CommonMode.h"
//#import "CGIManager.h"
//#import "DetectModel.h"
//
//#import "FSShareManager.h"
//
//#import "DesEncryptor.h"
//
//#import "ForceViewController.h"
//
//#import "VideoView.h"
//#import "WebClient.h"
//#import "VideoPortalManager.h"
//#import "SignModelManager.h"
//#import "VideoHelper.h"
//#import "VideoViewController.h"
//#import "VideoAnimatedTransitioning.h"
//#import "PortalUpgradeManager.h"
//#import "CloudServiceViewController.h"
//#import "AlbumViewController.h"
//#import "SecuritySettingsViewController.h"
//
//#import "ADNoteView.h"
//#import "OrderComfirmViewController.h"
//
//#import "DirectionHelper.h"
//#import "DirectionViewController.h"
//#import "PTZView.h"
//#import "PTZListView.h"
//#import "Masonry.h"
//#import "TroubleshootingViewController.h"
//#import "g726.h"
//#import "FileFrame.h"
//#import "g711.h"
//
//#define MAXAUDIOBUF     245670 //9600/*245760*/
//#define kSecondOf3Days  259200 //3天的秒数
////#define kSecondOf3Days 300 //3天的秒数
//#define kPromotion @"Promotion"
//
//static size_t       const kSizeOfVideoBuffer = 2 * 1024 * 1024;//视频Buffer默认大小2M
//
//@interface FSLivePlayViewController () <WebClientDelegate, VideoViewDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, ADNoteViewDelegate, PresetViewDelegate, PTZListViewDelegate, PTZControlViewDelegate, FrameDelegate>
//
//@property (nonatomic, strong) MScrollView *videoScrollView;
//@property (nonatomic, strong) TYMActivityIndicatorView *activityIndicatorView;
//
//@property (nonatomic, strong) FCOutputAudio *outputAudio;
//@property (nonatomic, strong) FCInputAudio  *inputAudio;
//@property (nonatomic, retain) OpenAl_aec    *openAlAec;
//
//@property (nonatomic, strong) FSInitInfoModel *mInfoModel;
//
//@property (nonatomic, strong) ProductAllInfoModel *productAllInfoModel;
//
//@property (nonatomic, strong) DevInfoModel *devInfoModel;
//
//@property (nonatomic, strong) AlertManager *alertManager;
//@property (nonatomic, assign) bool alertfetch;
//@property (nonatomic, strong) AlertManager *soundManager;
//@property (nonatomic, assign) bool soundfetch;
//@property (nonatomic, strong) AlertManager *temperatureManager;
//@property (nonatomic, assign) bool temperaturefetch;
//@property (nonatomic, strong) AlertManager *humidityManager;
//@property (nonatomic, assign) bool humidityfetch;
//@property (nonatomic, strong) AlertManager *ioManager;
//@property (nonatomic, assign) bool iofetch;
//@property (nonatomic, strong) HumanDetectModel *humanModel;
//@property (nonatomic, assign) bool humanfetch;
//
//@property (nonatomic, strong) LiveHD *liveHD;       //HD相关
//
//@property (nonatomic, strong) VideoView *videoView; // 云录像View
//
//@property (nonatomic, strong) WebClient *webClient;
//
//@property (nonatomic, strong) NSSet *dateSet;       // 存在云录像的日期
//
//@property (nonatomic, strong) ADNoteView *adNoteView;
//
//@property (nonatomic, strong) NSString  *recurring;//是否循环付款
//@property (nonatomic, strong) NSString  *serialNo; //订单编号
//@property (nonatomic, assign) NSInteger promotionTimes;
//@property (nonatomic, assign) BOOL      bAdNoteViewShow;
//
//@property (nonatomic, strong) PTZView *ptzCView;
//@property (nonatomic, strong) PTZListView *ptzListView;
//@property (nonatomic, strong) PTZPanView *panView;
//@property (nonatomic, assign) FOSPRESETPOINT presetPoint;
//@property (nonatomic, assign) FOSCRUISEMAP cruiseMap;
//@property (nonatomic, assign) int selectPresetRow;
//
//@property (nonatomic, assign) int connectTime;//连接次数
//
//@end
//
//@implementation FSLivePlayViewController
//
//- (void)setHandle :(FOSHANDLE)handle{
//    playerHandle = handle;
//}
//
//- (void)setPlayerCameraInfo:(CameraModel *)cameraModel
//{
//    if (playerModel != cameraModel) {
//        playerModel = cameraModel;
//    }
//}
//
//-(void)initAudioFmt{
//    //----------------------音频相关----------------//
//    if(isDoubSound){
//    }else{
//        _outputAudio = [[FCOutputAudio alloc] init];
//        bzero(&_audio_fmt, sizeof(AudioStreamBasicDescription));
//        _audio_fmt.mSampleRate = 8000;
//        _audio_fmt.mFormatID = kAudioFormatLinearPCM;
//        _audio_fmt.mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
//        //_audio_fmt.mFormatFlags = kAudioFormatFlagsAudioUnitCanonical;
//        _audio_fmt.mBytesPerPacket = 2;
//        _audio_fmt.mBytesPerFrame = 2;
//        _audio_fmt.mFramesPerPacket = 1;
//        _audio_fmt.mChannelsPerFrame = 1;
//        _audio_fmt.mBitsPerChannel = 16;
//    }
//}
//
//#pragma mark - Application LifeCycle
//- (instancetype)init
//{
//    
//    if (self = [super init]) {
//        _devicesArray = [NSMutableArray array];
//        _mInfoModel = [[FSInitInfoModel alloc] init];
//        playerHandle = FOSHANDLE_INVALID;
//        
//        hdMode = 0;
//        curMode = 0;
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self setupViews];      //设置界面元素
//    [self setData];         //设置数据
//}
//
//- (void)setupViews
//{
//    [self setTopNavView];
//    self.view.backgroundColor =RGB_35_35_45;
//    floSize =(SCREEN_HEIGHT >IS_IPHONE_4)?1.f:4.f/5;
//    videoViewFrame = CGRectMake(0.f, 0, self.view.bounds.size.width, self.view.bounds.size.width * (SCREEN_HEIGHT >IS_IPHONE_5?10.f:9.0f) / 16.f);
//    _videoScrollView = [[MScrollView alloc] initWithFrame:videoViewFrame delegate:self pageNum:1];
//    _videoScrollView.backgroundColor =RGB_19_19_25;
//    [self.view addSubview:_videoScrollView];
//    
//    //添加操作
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOperationView)];
//    [_videoScrollView.imageView addGestureRecognizer:tapGesture];
//    //滚动
//    _videoScrollView.zoomScrollView.minimumZoomScale = 1.0;
//    _videoScrollView.zoomScrollView.maximumZoomScale = 5.0;
//    _videoScrollView.zoomScrollView.contentSize = videoViewFrame.size;
//    _videoScrollView.zoomScrollView.bouncesZoom =NO;
//    _videoScrollView.zoomScrollView.bounces = NO;
//    
//    // LoadingView
//    _activityIndicatorView = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleNormal];
//    _activityIndicatorView.userInteractionEnabled =YES;
//    _activityIndicatorView.hidesWhenStopped = YES;
//    _activityIndicatorView.errorImage = [UIImage imageNamed:@"live_Refresh_nor.png"];
//    
//    //LoadingView 再次连接
//    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadVideo)];
//    [_activityIndicatorView addGestureRecognizer:labelTapGestureRecognizer];
//    _activityIndicatorView.center = _videoScrollView.center;
//    [self.view addSubview:_activityIndicatorView];
//    [_activityIndicatorView startAnimating:YES];
//    
//    //声音大小显示效果
//    soundView =[[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH -75)/2, CGRectGetMaxY(_videoScrollView.frame) -64.f -10.f, 75, 64)];
//    soundFrame =soundView.frame;
//    [_videoScrollView addSubview:soundView];
//    soundView.hidden =YES;
//    soundView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_opacity_80.png"]];
//    soundView.layer.cornerRadius=5.0f;
//    soundView.layer.masksToBounds = YES;
//    
//    UIImage *imageVoice =[UIImage imageNamed:@"Speak_voice_1.png"];
//    soundImageView =[[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(soundView.frame) -imageVoice.size.width)/2, (CGRectGetHeight(soundView.frame) -imageVoice.size.height) /2, imageVoice.size.width, imageVoice.size.height)];
//    [soundView addSubview:soundImageView];
//    
//    //footView 大小
//    footView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_videoScrollView.frame), SCREEN_WIDTH, SCREEN_HEIGHT -CGRectGetMaxY(_videoScrollView.frame) -FSTableContentInsetBottom)];
//    [self.view addSubview:footView];
//    footView.backgroundColor =RGB_35_35_45;
//    
//    //声音,清晰度横条,全屏
//    float view1Heiht =30.f;
//    UIView *view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, view1Heiht)];
//    [footView addSubview:view1];
//    view1.backgroundColor =RGB_57_57_66;
//    //监听声音按钮
//    soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [view1 addSubview:soundBtn];
//    soundBtn.tag =IPCAudioButtonTag;
//    UIImage *imageSound =[UIImage imageNamed:@"sound_close_nor.png"];
//    [soundBtn setImage:imageSound forState:UIControlStateNormal];
//    [soundBtn setImage:GetImageByName(@"sound_open_press.png") forState:UIControlStateSelected];
//    [soundBtn setImage:GetImageByName(@"sound_open_press.png") forState:UIControlStateHighlighted];
//    [soundBtn setFrame:CGRectMake(OriginX_15,(view1Heiht-imageSound.size.height)/2,imageSound.size.width,imageSound.size.height)];
//    [soundBtn addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *imageL1 =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(soundBtn.frame)+15.f, 2.5f, 1.f, 25.f)];
//    imageL1.backgroundColor =RGB_77_77_85;
//    [view1 addSubview:imageL1];
//    //清晰度按钮
//    hdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [view1 addSubview:hdBtn];
//    hdBtn.tag =IPCHDButtonTag;
//    [hdBtn setFrame:CGRectMake(CGRectGetMaxX(imageL1.frame),0.f,60.f,view1Heiht)];
//    [hdBtn setTitle:FSLocalizedString(@"FS_Pic_FHD") forState:UIControlStateNormal];
//    hdBtn.titleLabel.font =SysFontOfSize_15;
//    [hdBtn setTitleColor:RGB_187_190_199 forState:UIControlStateNormal];
//    [hdBtn addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *imageL2 =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hdBtn.frame), 2.5f, 1.f, 25.f)];
//    imageL2.backgroundColor =RGB_77_77_85;
//    [view1 addSubview:imageL2];
//    //全屏按钮
//    fullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [view1 addSubview:fullBtn];
//    fullBtn.tag =IPCFullButtonTag;
//    UIImage *imageFull =[UIImage imageNamed:@"full_screen_nor.png"];
//    [fullBtn setImage:imageFull forState:UIControlStateNormal];
//    [fullBtn setImage:[UIImage imageNamed:@"full_screen_press.png"] forState:UIControlStateHighlighted];
//    [fullBtn setFrame:CGRectMake(SCREEN_WIDTH - OriginX_15 - imageFull.size.width,(view1Heiht-imageFull.size.height)/2,imageFull.size.width,imageFull.size.height)];
//    [fullBtn addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//    //流量显示
//    trafficBtn =[[UIButton alloc]init];
//    [_videoScrollView addSubview:trafficBtn];
//    [trafficBtn setImage:[UIImage imageNamed:@"network_speed_icon.png"] forState:UIControlStateNormal];
//    trafficBtn.userInteractionEnabled =NO;
//    NSString *traffic =@" 0.0KB";
//    float widTraffic =[CommonMode getWidthSize:traffic andFontOfSize:SysFontOfSize_12 andFontName:0];
//    trafficBtn.frame =CGRectMake(SCREEN_WIDTH -(widTraffic +20)-10, 10, widTraffic +20, 19.f);
//    [trafficBtn setBackgroundImage:[UIImage imageNamed:@"bg_opacity_80.png"] forState:UIControlStateNormal];
//    [trafficBtn.layer setMasksToBounds:YES];
//    [trafficBtn.layer setCornerRadius:9.0f];//设置矩形圆角半径
//    [trafficBtn setTitle:traffic forState:UIControlStateNormal];
//    [trafficBtn setTitleColor:RGB_White forState:UIControlStateNormal];
//    trafficBtn.titleLabel.font =SysFontOfSize_12;
//    trafficBtn.hidden =YES;
//    
//    redImageView = [[UIImageView alloc]init];//红点
//    [redImageView setFrame:CGRectMake(20, 0, 7, 7)];
//    redImageView.image = [UIImage imageNamed:@"red_dot.png"];
//    [settingButton addSubview:redImageView];
//    redImageView.hidden = YES;
//    //云台，抓拍，对讲，录像，more
//    float xSpace =0.f; float yHeight =0.f;
//    if (SCREEN_HEIGHT > IS_IPHONE_6) {
//        xSpace =25.f; yHeight =80.f;
//    }else if ( SCREEN_HEIGHT >IS_IPHONE_5){
//        xSpace =20.f; yHeight =75.f;
//    }else if ( SCREEN_HEIGHT >IS_IPHONE_4){
//        xSpace =15.f; yHeight =70.f;
//    }else{
//        xSpace =15.f; yHeight =55.f;
//    }
//    float view2Height =yHeight;
//    view2Fun =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), SCREEN_WIDTH, view2Height)];
//    [footView addSubview:view2Fun];
//    view2Fun.backgroundColor =RGB_35_35_45;
//    //分割线
//    UIImageView *imageLine =[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view2Fun.frame), SCREEN_WIDTH, 0.5f)];
//    [footView addSubview:imageLine];
//    imageLine.backgroundColor =RGB_46_46_56;
//    //对讲按钮
//    talkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [view2Fun addSubview:talkBtn];
//    talkBtn.tag =IPCTalkButtonTag;
//    UIImage *imageTalk =[UIImage imageNamed:@"livemenu_talk_nor.png"];
//    float imageTalkWid = imageTalk.size.width *floSize;
//    float imageTalkHeight = imageTalk.size.height *floSize;
//    [talkBtn setImage:imageTalk forState:UIControlStateNormal];
//    [talkBtn setImage:GetImageByName(@"livemenu_talk_press.png") forState:UIControlStateHighlighted];
//    [talkBtn setFrame:CGRectMake((SCREEN_WIDTH -imageTalkWid)/2,(view2Height-imageTalkHeight)/2,imageTalkWid,imageTalkHeight)];
//    [talkBtn addTarget:self action:@selector(openTalk:) forControlEvents:UIControlEventTouchDown];
//    [talkBtn addTarget:self action:@selector(closeTalk:) forControlEvents:UIControlEventTouchUpOutside];
//    [talkBtn addTarget:self action:@selector(closeTalk:) forControlEvents:UIControlEventTouchUpInside];
//    [talkBtn addTarget:self action:@selector(closeTalk:) forControlEvents:UIControlEventTouchCancel];
//    //云台按钮
//    ptzBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [view2Fun addSubview:ptzBtn];
//    ptzBtn.tag =IPCPTZButtonTag;
//    UIImage *imagePtz =[UIImage imageNamed:@"livemenu_ptz_nor.png"];
//    float imagePtzWid = imagePtz.size.width *floSize;
//    float imagePtzHeight = imagePtz.size.height *floSize;
//    [ptzBtn setImage:imagePtz forState:UIControlStateNormal];
//    [ptzBtn setImage:[UIImage imageNamed:@"livemenu_ptz_press.png"] forState:UIControlStateHighlighted];
//    [ptzBtn setImage:[UIImage imageNamed:@"livemenu_ptz_press.png"] forState:UIControlStateSelected];
//    [ptzBtn setFrame:CGRectMake(xSpace,(view2Height-imagePtzHeight)/2,imagePtzWid,imagePtzHeight)];
//    [ptzBtn addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//    //抓拍按钮
//    float widSpace =(CGRectGetMinX(talkBtn.frame)-CGRectGetMaxX(ptzBtn.frame) -imagePtzWid)/2;
//    
//    picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [view2Fun addSubview:picBtn];
//    picBtn.tag =IPCPicButtonTag;
//    UIImage *imagePic =[UIImage imageNamed:@"livemenu_capture_nor.png"];
//    float imagePicWid = imagePic.size.width *floSize;
//    float imagePicHeight = imagePic.size.height *floSize;
//    [picBtn setImage:imagePic forState:UIControlStateNormal];
//    [picBtn setImage:[UIImage imageNamed:@"livemenu_capture_press.png"] forState:UIControlStateHighlighted];
//    [picBtn setFrame:CGRectMake(widSpace+CGRectGetMaxX(ptzBtn.frame),(view2Height-imagePicHeight)/2,imagePicWid,imagePicHeight)];
//    [picBtn addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //录像按钮
//    recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [view2Fun addSubview:recordBtn];
//    recordBtn.tag =IPCRecordButtonTag;
//    UIImage *imageRecord =[UIImage imageNamed:@"livemenu_record_nor.png"];
//    float imageRecordWid = imageRecord.size.width *floSize;
//    float imageRecordHeight = imageRecord.size.height *floSize;
//    [recordBtn setImage:imageRecord forState:UIControlStateNormal];
//    [recordBtn setImage:[UIImage imageNamed:@"livemenu_record_press.png"] forState:UIControlStateHighlighted];
//    [recordBtn setImage:[UIImage imageNamed:@"livemenu_record_press.png"] forState:UIControlStateSelected];
//    [recordBtn setFrame:CGRectMake(widSpace +CGRectGetMaxX(talkBtn.frame),(view2Height-imageRecordHeight)/2,imageRecordWid,imageRecordHeight)];
//    [recordBtn addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //更多按钮
//    moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [view2Fun addSubview:moreBtn];
//    moreBtn.tag =IPCMoreButtonTag;
//    UIImage *imageMore =[UIImage imageNamed:@"livemenu_more_nor.png"];
//    float imageMoreWid = imageMore.size.width *floSize;
//    float imageMoreHeight = imageMore.size.height *floSize;
//    [moreBtn setImage:imageMore forState:UIControlStateNormal];
//    [moreBtn setImage:[UIImage imageNamed:@"livemenu_more_press.png"] forState:UIControlStateSelected];
//    [moreBtn setImage:[UIImage imageNamed:@"livemenu_more_press.png"] forState:UIControlStateHighlighted];
//    [moreBtn setFrame:CGRectMake(widSpace +CGRectGetMaxX(recordBtn.frame),(view2Height-imageMoreHeight)/2,imageMoreWid,imageMoreHeight)];
//    [moreBtn addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//    //历史云录像view
//    self.videoView.frame = CGRectMake(0, CGRectGetMaxY(view2Fun.frame), SCREEN_WIDTH, CGRectGetHeight(footView.frame) -CGRectGetMaxY(view2Fun.frame));
//    [footView addSubview:self.videoView];
//    self.videoView.hidden = SharedAppDelegate.bIsChina;
//    
//    NSLog(@"setupViews");
//
//}
//
//- (void) toggleOperationView{
//    if (listTableView && listTableView.hidden ==NO) {
//        listTableView.hidden =YES;
//    }
//    if (hdTableView && hdTableView.hidden ==NO) {
//        hdTableView.hidden =YES;
//    }
//    if (iOrientation != 0) {
//        _videoScrollView.exitFullScreenButton.hidden =NO;
//        if (btnViewFull.hidden ==YES) {
//            ptzFullView.hidden =YES;
//            ptzBtnFull.selected =NO;
//            btnViewFull.hidden =NO;
//            [self setBtnFullViewTimer];
//        }
//        
//        if (self.panView.superview) {
//            ((UIButton *)[btnViewFull viewWithTag:IPCPTZFullButtonTag]).selected = NO;
//            [self.panView removeFromSuperview];
//        }
//    }
//}
//-(void)setData{
//    
//    spdArray =[NSMutableArray array];    
//    //录音设置
//    recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
//                           [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
//                           [NSNumber numberWithInt:1000.0],AVSampleRateKey,
//                           [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
//                           [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
//                           [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
//                           [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
//                           nil];
//    //音量图片数组
//    volumImages = [[NSMutableArray alloc]initWithObjects:@"Speak_voice_1.png",@"Speak_voice_2.png",@"Speak_voice_3.png",
//                   @"Speak_voice_4.png", @"Speak_voice_5.png",nil];
//
//    // Add Observer
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishUpgrade) name:@"DidFinishDownloadPortal" object:nil];
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//   
//    if (shareBo) {
//        return;
//    }
//    
//    [self registerForNSNotification];
//    [self fetchStorageInformation];
//    //显示AdNoteView
//    if (_bAdNoteViewShow) {
//        [_adNoteView show];
//    }
//    self.navigationController.delegate = self;
//    [UIApplication sharedApplication].idleTimerDisabled = YES;//防止屏幕睡眠
//    DDLogInfo(@"viewWillAppear liveVc");
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    if (shareBo) {
//        return;
//    }
//    [self showStatusAndNavBar];
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//    //隐藏AdNoteView
//    if (_bAdNoteViewShow) {
//        [_adNoteView dismiss];
//    }
//    
//    self.connectTime = 0;
//    if (![self checkWiFiOnly]) {
//        _activityIndicatorView.hidden = YES;
//        if (!onlywifiPlayView) {
//            onlywifiPlayView = [[UIView alloc]initWithFrame:videoViewFrame];
//            [_videoScrollView addSubview:onlywifiPlayView];
//            [onlywifiPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.center.equalTo(_videoScrollView);
//                make.size.equalTo(_videoScrollView);
//            }];
//            
//            onlywifiPlayView.backgroundColor = [UIColor clearColor];
//            float nub = [CommonMode getLineNumber:FSLocalizedString(@"FS_Live_Using_Data") andFontOfSize:SysFontOfSize_13 andWidth:SCREEN_WIDTH andFontName:0];
//            
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(OriginX_15, 60, SCREEN_WIDTH - 2*OriginX_15, (nub +1)* 17)];
//            [onlywifiPlayView addSubview:label];
//            
//            [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.offset((CGRectGetHeight(_videoScrollView.frame) - label.frame.size.height )/2);
//                make.left.equalTo(onlywifiPlayView).offset(0);
//                make.right.equalTo(onlywifiPlayView).offset(0);
//            }];
//            label.text = [NSString stringWithFormat:@"%@\n%@",FSLocalizedString(@"FS_Live_No_Wifi"),FSLocalizedString(@"FS_Live_Using_Data")];
//            label.textColor = RGB_187_190_199;
//            label.font = SysFontOfSize_13;
//            label.numberOfLines = 0;
//            label.textAlignment = NSTextAlignmentCenter;
//            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [onlywifiPlayView addSubview:button];
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(label.mas_bottom).offset(30);
//                make.centerX.equalTo(onlywifiPlayView);
//                make.height.mas_equalTo(30);
//                make.width.mas_equalTo(80);
//            }];
//            [button setTitle:FSLocalizedString(@"FS_Live_Play") forState:UIControlStateNormal];
//            button.titleLabel.font = SysFontOfSize_17;
//            [button setBackgroundColor:RGBCOLOR(57, 57, 66)];
//            [button setTitleColor:RGBCOLOR(140, 140, 160) forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(onlywifiPlayAction:) forControlEvents:UIControlEventTouchUpInside];
//            [button.layer setMasksToBounds:YES];
//            [button.layer setCornerRadius:3.0f];//设置矩形圆角半径
//
//        }else{
//            onlywifiPlayView.hidden = NO;
//        }
//    }else{
//        [self loadVideo];
//    }
//    DDLogInfo(@"viewDidAppear liveVc");
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//
//    if (shareBo) {
//        return;
//    }
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//    
//    noBackgroundFree = NO;
//    [self stopVideoStream:YES];
//    
//    [UIApplication sharedApplication].idleTimerDisabled = NO;
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    DDLogInfo(@"viewWillDisappear liveVc");
//}
//
//-(void)viewDidDisappear:(BOOL)animated{
//    
//    [super viewDidDisappear:animated];
//
//    if (shareBo) {
//        return;
//    }
//    DDLogInfo(@"viewDidDisappear liveVc");
//}
//
//- (void)onlywifiPlayAction:(UIButton *)sender{
//    onlywifiPlayView.hidden = YES;
//    _activityIndicatorView.hidden = NO;
//
//    SharedAppDelegate.bAppSettingWiFiOnly = NO;//设置到内存
//    [[NSUserDefaults standardUserDefaults] setObject:@{kWiFiOnly : @(NO)} forKey:kWiFiOnly];//设置到本地
//    [[NSUserDefaults standardUserDefaults] synchronize];//同步
//    
//    [self loadVideo];
//}
//
//- (void)showDirectionViews:(NSArray *)directionViews {
//    DirectionViewController *vc = [[DirectionViewController alloc] initWithDirectionViews:directionViews];
//    vc.definesPresentationContext = YES;
//    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self.navigationController presentViewController:vc animated:NO completion:nil];
//}
//
//- (void)setTopNavView
//{
//    // Setting
//    settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingButton setImage:[UIImage imageNamed:@"topnav_setting_nor.png"] forState:UIControlStateNormal];
//    [settingButton setImage:[UIImage imageNamed:@"topnav_setting_press.png"] forState:UIControlStateHighlighted];
//    [settingButton addTarget:self action:@selector(gotoSetting:) forControlEvents:UIControlEventTouchUpInside];
//    [settingButton sizeToFit];
//    
//    // List
//    listButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [listButton setImage:[UIImage imageNamed:@"topnav_dropdownarrow_nor.png"] forState:UIControlStateNormal];
//    [listButton setImage:[UIImage imageNamed:@"topnav_dropdownarrow_press.png"] forState:UIControlStateHighlighted];
//    [listButton addTarget:self action:@selector(listMoreDevice:) forControlEvents:UIControlEventTouchUpInside];
//    [listButton sizeToFit];
//    
//    // Title
//    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    navigationButton = titleButton;
//    [titleButton addTarget:self action:@selector(listMoreDevice:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self setNavigationTitle:titleButton];
//}
//
//- (void)setNavigationTitle:(UIButton *)titleButton{
//    settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
//    listItem = [[UIBarButtonItem alloc] initWithCustomView:listButton];
//    flexibaleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    if (playerModel)
//    {
//        if (!playerModel.cloudModel.deviceName)
//        {
//            [titleButton setTitle:kDefaultDeviceName forState:UIControlStateNormal];
//        }
//        else
//        {
//            [titleButton setTitle:playerModel.cloudModel.deviceName.length > 0 ? playerModel.cloudModel.deviceName : kDefaultDeviceName forState:UIControlStateNormal];
//        }
//    }
//    [self.navigationItem setRightBarButtonItems:@[settingItem, flexibaleItem, listItem]];
//    
//    if (_devicesArray.count == 1)
//    {
//        [self.navigationItem setRightBarButtonItems:@[settingItem, flexibaleItem]];
//        titleButton.userInteractionEnabled = NO;
//    }
//    else
//    {
//        [self.navigationItem setRightBarButtonItems:@[settingItem, flexibaleItem, listItem]];
//    }
//    self.navigationItem.titleView = titleButton;
//}
//
//- (void)setupRecordLabel{
//    recordTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_videoScrollView addSubview:recordTimeBtn];
//    recordTimeBtn.userInteractionEnabled = YES;
//    recordTimeBtn.titleLabel.font = SysFontOfSize_12;
//    [recordTimeBtn setTitleColor:RGB_White forState:UIControlStateNormal];
//    UIImage *imagebg =[UIImage imageNamed:@"record_bg.png"];
//    [recordTimeBtn setBackgroundImage:imagebg forState:UIControlStateNormal];
//    [recordTimeBtn setBackgroundImage:[UIImage imageNamed:@"record_reddot_bg.png"] forState:UIControlStateHighlighted];
//    recordTimeBtn.frame = CGRectMake((SCREEN_WIDTH - imagebg.size.width) / 2.f, 10.f, imagebg.size.width, imagebg.size.height);
//    recordTimeBtn.hidden = YES;
//}
//
//- (void)setActionButtons:(UIButton *)sender
//{
//    if (!hdTableView.hidden && sender.tag !=IPCHDButtonTag) {
//        hdTableView.hidden =YES;
//    }
//    if (!listTableView.hidden) {
//        listTableView.hidden =YES;
//    }
//    if (!connectSuc) {
//        [self showMessage:FSLocalizedString(@"FS_Live_NotConnect") wihtStyle:ALAlertBannerStyleFailure];
//        return;
//    }
//    
//    if (!_productAllInfoModel) {
//        [self getProductAllInfo];
//        return;
//    }
//    
//    if (!_devInfoModel){
//        [self getDeviceInfo];
//    }
//    // 需求修改，观察者没有任何权限只能观看
////    if (_mInfoModel.iUserRight == UserRightTypeWatcher) {
////        [self showMessage:FSLocalizedString(@"FS_Live_NoPermission") wihtStyle:ALAlertBannerStyleNotify];
////        return;
////    }
//    switch (sender.tag) {
//        case IPCAudioButtonTag:     //监听
//        {
//            [self soundAction:sender];
//        }
//            break;
//        case  IPCHDButtonTag:       //HD清晰度调节
//        {
//            [self hdAction:sender];
//        }
//            break;
//        case  IPCFullButtonTag:     //全屏按钮
//        {
//            [self fullScreenAction:sender];
//        }
//            break;
//        case  IPCPTZButtonTag:      //PTZ云台
//        {
//            [self ptzAction:sender];
//        }
//            break;
//        case  IPCPTZFullButtonTag:  //PTZ横屏云台
//        {
//            [self ptzAction:sender];
//        }
//            break;
//        case  IPCPicButtonTag:      //抓拍
//        {
//            [self picAction:sender];
//        }
//            break;
//        case  IPCPicFullButtonTag:  //横屏抓拍
//        {
//            [self picAction:sender];
//        }
//            break;
//        case  IPCTalkButtonTag:     //对讲
//        {
//        }
//            break;
//        case  IPCRecordButtonTag:   //录像
//        {
//            [self recordAction:sender];
//        }
//            break;
//        case  IPCMoreButtonTag:     //更多
//        {
//            [self moreAction:sender];
//        }
//            break;
//        default:
//            break;
//    }
//}
//
////监听
//-(void)soundAction:(UIButton *)sender
//{
//    if (_productAllInfoModel.audioFlag == 0 )//不支持音频播放
//    {
//        return;
//    }
//    NSLog(@"soundAction------------%d",sender.selected);
//    sender.selected =!sender.selected;
//    if (isDoubSound) {
//        if (!audioOpened) {
//            
//            //[self showMessage:FSLocalizedString(@"FS_Live_OpenAudio") wihtStyle:ALAlertBannerStyleNotify];
//            
//            [[FSNetService sharedNetService] openAudio_async:playerHandle block:^(FOSCMD_RESULT ret) {
//                if (FOSCMDRET_OK == ret) {
//                    audioOpened = YES;
//                    sender.selected =YES;
//                    [_openAlAec OpenAudio];
//                    DDLogInfo(@"打开监听成功 handle = %d, ret = %d",playerHandle,ret);
//
//                }else{
//                    audioOpened = NO;
//                    sender.selected =NO;
//                    [_openAlAec CloseAudio];
//                    DDLogInfo(@"打开监听失败 handle = %d, ret = %d",playerHandle,ret);
//                    [self showMessage:FSLocalizedString(@"FS_Live_OpenListen_Fail") wihtStyle:ALAlertBannerStyleNotify];
//                }
//            } timeout:1000];
//            
//        }else {
//            
//            FOSCMD_RESULT ret = [[FSNetService sharedNetService] closeAudio_sync:playerHandle timeout:1000];
//            if(ret == FOSCMDRET_OK){
//                audioOpened = NO;
//                sender.selected =NO;
//                DDLogInfo(@"关闭监听成功 handle = %d, ret = %d",playerHandle,ret);
//
//            }else{
//                audioOpened = YES;
//                sender.selected =YES;
//                DDLogInfo(@"关闭监听失败 handle = %d, ret = %d",playerHandle,ret);
//                [self showMessage:FSLocalizedString(@"FS_Live_CloseListen_Fail") wihtStyle:ALAlertBannerStyleNotify];
//            }
//        }
//        
//    }else{
//        
//        if (sender.selected) {
//            assert([_outputAudio InitAudio:&_audio_fmt : MAXAUDIOBUF]);
//        }
//        
//        if (!audioOpened) {
//
//            [_outputAudio AudioStart];
//            [[FSNetService sharedNetService] openAudio_async:playerHandle block:^(FOSCMD_RESULT ret) {
//                if (FOSCMDRET_OK == ret) {
//                    audioOpened = YES;
//                    sender.selected =YES;
//                }else{
//                   FOSCMD_RESULT ret = [[FSNetService sharedNetService] closeAudio_sync:playerHandle timeout:1000];
//                    if(ret == FOSCMDRET_OK){
//                        audioOpened = NO;
//                        sender.selected =NO;
//                        DDLogInfo(@"打开监听成功 handle = %d, ret = %d",playerHandle,ret);
//
//                    }else{
//                        audioOpened = YES;
//                        sender.selected =YES;
//                        DDLogInfo(@"打开监听失败 handle = %d, ret = %d",playerHandle, ret);
//                        [self showMessage:FSLocalizedString(@"FS_Live_OpenListen_Fail") wihtStyle:ALAlertBannerStyleNotify];
//                    }
//                }
//            } timeout:1000];
//            
//        }else {
//            
//            [_outputAudio AudioStop];
//            FOSCMD_RESULT ret = [[FSNetService sharedNetService] closeAudio_sync:playerHandle timeout:1000];
//            if(ret == FOSCMDRET_OK){
//                audioOpened = NO;
//                sender.selected =NO;
//                DDLogInfo(@"关闭监听成功 handle = %d, ret = %d",playerHandle,ret);
//                
//            }else{
//                audioOpened = YES;
//                sender.selected =YES;
//                DDLogInfo(@"关闭监听失败 handle = %d, ret = %d",playerHandle, ret);
//                [self showMessage:FSLocalizedString(@"FS_Live_CloseListen_Fail") wihtStyle:ALAlertBannerStyleNotify];
//            }
//        }
//    }
//}
//
////切换清晰度/切换分辨率
//-(void)hdAction:(UIButton *)sender{
//    NSLog(@"sdAction------------");
//    if (hdTableView) {
//        if (hdTableView.hidden ==YES) {
//            hdTableView.hidden =NO;
//        }else{
//            hdTableView.hidden =YES;
//        }
//    }else{
//        //设备列表list
//        hdTableView =[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(hdBtn.frame), CGRectGetMaxY(_videoScrollView.frame)-120.f, CGRectGetWidth(hdBtn.frame), 120.f)];
//        [_videoScrollView addSubview:hdTableView];
//        hdDataSource =[[NSMutableArray alloc]initWithObjects:FSLocalizedString(@"FS_Pic_FHD"),FSLocalizedString(@"FS_Pic_HD"),FSLocalizedString(@"FS_Pic_SD"), nil];
//        hdTableView.delegate =self;
//        hdTableView.dataSource =self;
//        hdTableView.backgroundColor =RGB_35_35_45;
//        hdTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
//        hdTableView.showsVerticalScrollIndicator =NO;
//        NSIndexPath * selIndex = [NSIndexPath indexPathForRow:hdMode inSection:0];
//        [hdTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionNone];
//    }
//}
//- (void) setHD:(int)row withTitle:(NSString *)title{
//    NSLog(@"HD row = %d",row);
//    int recording = NO;
//    if (isRecording) {
//        recording = YES;
//        isRecording = NO;
//        [recordBtn setSelected:NO];
//        [self stopRecordShow];      //停止录像
//        [[FSNetService sharedNetService] stopRecord_sync:playerHandle];
//    }
//    //FosSdk_StopReconnect(playerHandle);
//    [spdArray removeAllObjects];//删除流量数组
//    __weak __typeof(self) weakSelf = self;
//    [self.liveHD setStreamParamWithHandle:playerHandle
//                               sensorType:_productAllInfoModel.sensorType
//                                  hdValue:row
//                             currentValue:playerModel.streamType
//                             onCompletion:^(FOSCMD_RESULT result,BOOL mainStreamType) {
//                                 if (FOSCMDRET_OK != result){
//                                     [weakSelf showMessage:FSLocalizedString(@"FS_Live_ChangeHD_Fail") wihtStyle:ALAlertBannerStyleNotify];
//                                     [weakSelf setButtonTitle:title];
//                                 }else{
//                                     [weakSelf setStreamType:mainStreamType];
//                                 }
//                                 if (recording) {
//                                     isPreRecording = YES;
//                                 }
//                             }];
//    
//}
//
//-(void)setButtonTitle:(NSString *)title{
//    [hdBtn setTitle:title forState:UIControlStateNormal];
//}
//-(void)setStreamType:(BOOL)type{
//    int mainType =(type?0:1);
//    NSLog(@"type1 =%d,type2 =%d",playerModel.streamType,mainType);
//    if (playerModel.streamType !=mainType) {
//        playerModel.streamType =mainType;       //更改内存
//        [self updateDB:playerModel.streamType]; //更改DB数据
//        [self stopVideoStream:YES];
//        sleep(0.5);
//        [self connectCamera];
//    }
//}
//
//- (void)updateDB:(int)streamType{
//
//    CloudModel *cloudModel =[[CloudModel alloc]init];
//    cloudModel =playerModel.cloudModel;
//    
//    NSMutableDictionary *dbDict =[NSMutableDictionary new];
//    [dbDict setValue:[NSString stringWithFormat:@"%ld",(long)cloudModel.ipcSettingId] forKey:kCameraID];
//    NSString *openid =[DesEncryptor desEncryption:[FSUserAccountManager user]];
//    [dbDict setValue:openid forKey:kCameraUserID];//所属云账号
//    NSString *ipcUid = [DesEncryptor desEncryption:SAFTYSTRING(cloudModel.deviceUID)];//ipc uid
//    [dbDict setValue:ipcUid forKey:kUID];
//    NSString *macAddr = [DesEncryptor desEncryption:SAFTYSTRING(cloudModel.deviceMac)];//ipc mac
//    [dbDict setValue:macAddr forKey:kMAC];
//    [dbDict setValue:SAFTYSTRING(cloudModel.ip) forKey:kIP];
//    [dbDict setValue:[NSString stringWithFormat:@"%ld",(long)cloudModel.ipPort] forKey:kIPPort];
//    [dbDict setValue:SAFTYSTRING(cloudModel.ddns) forKey:kDDNS];
//    [dbDict setValue:[NSString stringWithFormat:@"%ld",(long)cloudModel.ddnsPort] forKey:kDDNSPort];
//    NSString *username = [DesEncryptor desEncryption:SAFTYSTRING(cloudModel.username)];//ipc 用户名
//    [dbDict setValue:username forKey:kLoginName];
//    NSString *password = [DesEncryptor desEncryption:SAFTYSTRING(cloudModel.password)];//ipc 密码
//    [dbDict setValue:password forKey:kLoginPassword];
//    [dbDict setValue:SAFTYSTRING(cloudModel.productName) forKey:kProductName];
//    [dbDict setValue:SAFTYSTRING(cloudModel.deviceName) forKey:kDeviceName];
//    [dbDict setValue:[NSString stringWithFormat:@"%d",cloudModel.productType] forKey:kProductType];
//    [dbDict setValue:[NSString stringWithFormat:@"%d",cloudModel.deviceType] forKey:kDeviceType];
//    [dbDict setValue:[NSString stringWithFormat:@"%d",cloudModel.hasusertag] forKey:kHasUserTag];
//    [dbDict setValue:[NSString stringWithFormat:@"%d",cloudModel.supportP2p] forKey:kP2PType];
//    [dbDict setValue:[NSString stringWithFormat:@"%d",streamType] forKey:kStreamType];
//    [dbDict setValue:[NSString stringWithFormat:@"%d",cloudModel.supportStore] forKey:kSupportStore];
//    [dbDict setValue:[NSString stringWithFormat:@"%d",cloudModel.supportRichMedia] forKey:kSupportRichMedia];
//    [dbDict setValue:SAFTYSTRING(cloudModel.appVersion) forKey:kAppVersion];
//    [dbDict setValue:SAFTYSTRING(cloudModel.sysVersion) forKey:kSysVersion];
//    [dbDict setValue:SAFTYSTRING(cloudModel.additionInfo) forKey:kAdditionInfo];
//    
//    Camera *thisCamera = [[Camera alloc] instanceWithDictionary:dbDict];
//    thisCamera.primaryKey =thisCamera.cameraID;
//    [[DBManager sharedInstance] updateToDB:thisCamera modelTag:DBModelTagCamera];
//}
//
////全屏
//-(void)fullScreenAction:(UIButton *)sender{
//    NSLog(@"fullScreenAction-----------");
//
//    // Rotate Screen To LandscapeRight
//    [self hiddenStatusAndNavBar];
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
//    _videoScrollView.exitFullScreenButton.hidden = NO;
//    [_videoScrollView.exitFullScreenButton addTarget:self action:@selector(exitFullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)exitFullScreenAction:(UIButton *)sender
//{
//    [self showStatusAndNavBar];
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//    _videoScrollView.exitFullScreenButton.hidden = YES;
//}
//
//#pragma mark - 横竖屏状态栏和导航栏的显示与隐藏
//- (void)hiddenStatusAndNavBar{
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//- (void)showStatusAndNavBar{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [self.navigationController setNavigationBarHidden:NO];
//    [self setNavigationTitle:navigationButton];
//}
//
////云台按钮
//-(void)ptzAction:(UIButton *)sender{
//    NSLog(@"ptzAction________");
//    if (!moreView.hidden) {
//        moreView.hidden =YES;
//        moreBtn.selected =NO;
//    }
//    
//    ProductAllInfoModel *productModel = playerModel.productModel;
//    
//    BOOL selected = sender.selected = !sender.selected;
//    if (IPCPTZButtonTag == sender.tag) {
//        if (selected) {
//            [footView addSubview:self.ptzCView];
//            
//            self.ptzCView.enablePreset = productModel.isEnablePreset;
//            self.ptzCView.ptzControlView.isSupportZoom = productModel.zoomFlag;
//            self.ptzCView.ptzControlView.isSupportFocus = productModel.isEnableFocus;
//            if (productModel.ptFlag) {
//                self.ptzCView.ptzControlView.isSupportPTZ = YES;
//            } else {
//                self.ptzCView.ptzControlView.isSupportEPT = (isSupportEPT || productModel.isEnableEPT);
//            }
//            
//            [self.ptzCView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(self.videoView);
//            }];
//        } else {
//            [self.ptzCView removeFromSuperview];
//        }
//    } else if (IPCPTZFullButtonTag == sender.tag) {
//        if (selected) {
//            btnViewFull.hidden = YES;
//            [self.videoScrollView addSubview:self.panView];
//            if (productModel.ptFlag) {
//                self.panView.isSupportPTZ = YES;
//            } else {
//                self.panView.isSupportEPT = (isSupportEPT || productModel.isEnableEPT);
//            }
//            
//            [self.panView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.bottom.equalTo(self.view).offset(-15);
//                make.size.equalTo(self.panView);
//            }];
//        }
//    }
//    
//    /*
//    BOOL ptzBo =YES;//默认Yes为竖屏，NO为横屏
//    if (sender.tag ==IPCPTZButtonTag){
//        if (sender.selected) {
//            ptzView.hidden =YES;
//            sender.selected =NO;
//            [self setPTZData:ptzBo];
//            return;
//        }else{
//            sender.selected =YES;
//            if (ptzView) {
//                ptzView.hidden =NO;
//                [self setPTZData:ptzBo];
//                return;
//            }
//        }
//        ptzView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view2Fun.frame), SCREEN_WIDTH, CGRectGetHeight(footView.frame) -CGRectGetMaxY(view2Fun.frame))];
//        [footView addSubview:ptzView];
//        ptzView.backgroundColor = RGB_48_48_64;
//    }else if (sender.tag ==IPCPTZFullButtonTag){
//        ptzBo =NO;
//        if (sender.selected) {
//            ptzFullView.hidden =YES;
//            sender.selected =NO;
//            [self setPTZData:ptzBo];
//            return;
//        }else{
//            sender.selected =YES;
//            if (ptzFullView) {
//                ptzFullView.hidden =NO;
//                btnViewFull.hidden =YES;
//                [self setPTZData:ptzBo];
//                return;
//            }
//        }
//        UIImage *ptzImage =GetImageByName(@"fullscreen_ptz_big_nor.png");
//        CGSize sizeImage =ptzImage.size;
//        ptzFullView =[[UIView alloc]initWithFrame:CGRectMake(_videoScrollView.frame.size.width -sizeImage.width -10.f, _videoScrollView.frame.size.height -sizeImage.height -10.f, sizeImage.width, sizeImage.height)];
//        [_videoScrollView addSubview:ptzFullView];
//        ptzFullView.backgroundColor =RGB_Clear;
//        btnViewFull.hidden =YES;
//    }
//    
//    UIButton *btnBigCircle = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *ptzImage =GetImageByName(ptzBo?@"ptz_big_nor.png":@"fullscreen_ptz_big_nor.png");
//    [btnBigCircle setImage:ptzImage forState:UIControlStateNormal];
//    [btnBigCircle setImage:GetImageByName(ptzBo?@"ptz_center_press.png":@"fullscreen_ptz_center_press.png") forState:UIControlStateHighlighted];
//    [btnBigCircle setImage:GetImageByName(ptzBo?@"ptz_center_press.png":@"fullscreen_ptz_center_press.png") forState:UIControlStateSelected];
//    [btnBigCircle setFrame:CGRectMake(ptzBo?((SCREEN_WIDTH -ptzImage.size.width) /2):0.f, ptzBo?((CGRectGetHeight(ptzView.frame) - ptzImage.size.height) / 2):0.f, ptzImage.size.width, ptzImage.size.height)];
//    [btnBigCircle addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//    [btnBigCircle addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *imgUp =GetImageByName(ptzBo?@"ptz_up_press.png":@"fullscreen_ptz_up_press.png");
//    [btnUp setImage:imgUp forState:UIControlStateHighlighted];
//    [btnUp setImage:imgUp forState:UIControlStateSelected];
//    [btnUp setImage:nil forState:UIControlStateNormal];
//    [btnUp setFrame:CGRectMake(0, CGRectGetMinY(btnBigCircle.frame), imgUp.size.width, imgUp.size.height)];
//    [btnUp setCenter:CGPointMake(btnBigCircle.center.x, btnUp.center.y)];
//    [btnUp setBackgroundColor:RGB_Clear];
//    [btnUp addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//    [btnUp addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *btnDown = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *imgDown = GetImageByName(ptzBo?@"ptz_down_press.png":@"fullscreen_ptz_down_press.png");
//    [btnDown setImage:imgDown forState:UIControlStateHighlighted];
//    [btnDown setImage:imgDown forState:UIControlStateSelected];
//    [btnDown setImage:nil forState:UIControlStateNormal];
//    [btnDown setFrame:CGRectMake(CGRectGetMinX(btnUp.frame), CGRectGetMaxY(btnBigCircle.frame) - imgDown.size.height, imgDown.size.width, imgDown.size.height)];
//    [btnDown setBackgroundColor:RGB_Clear];
//    [btnDown addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//    [btnDown addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *imgLeft = GetImageByName(ptzBo?@"ptz_left_press.png":@"fullscreen_ptz_left_press.png");
//    [btnLeft setImage:imgLeft forState:UIControlStateHighlighted];
//    [btnLeft setImage:imgLeft forState:UIControlStateSelected];
//    [btnLeft setImage:nil forState:UIControlStateNormal];
//    [btnLeft setFrame:CGRectMake(CGRectGetMinX(btnBigCircle.frame), 0, imgLeft.size.width, imgLeft.size.height)];
//    [btnLeft setCenter:CGPointMake(btnLeft.center.x, btnBigCircle.center.y)];
//    [btnLeft setBackgroundColor:RGB_Clear];
//    [btnLeft addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//    [btnLeft addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *imgRight  = GetImageByName(ptzBo?@"ptz_right_press.png":@"fullscreen_ptz_right_press.png");
//    [btnRight setImage:imgRight forState:UIControlStateHighlighted];
//    [btnRight setImage:imgRight forState:UIControlStateSelected];
//    [btnRight setImage:nil forState:UIControlStateNormal];
//    [btnRight setFrame:CGRectMake(CGRectGetMaxX(btnBigCircle.frame) - imgRight.size.width, 0, imgRight.size.width, imgRight.size.height)];
//    [btnRight setCenter:CGPointMake(btnRight.center.x, btnBigCircle.center.y)];
//    [btnRight setBackgroundColor:RGB_Clear];
//    [btnRight addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//    [btnRight addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//    
//    if (ptzBo) {
//        [ptzView addSubview:btnBigCircle];
//        [ptzView addSubview:btnUp];
//        [ptzView addSubview:btnDown];
//        [ptzView addSubview:btnLeft];
//        [ptzView addSubview:btnRight];
//    }else{
//        [ptzFullView addSubview:btnBigCircle];
//        [ptzFullView addSubview:btnUp];
//        [ptzFullView addSubview:btnDown];
//        [ptzFullView addSubview:btnLeft];
//        [ptzFullView addSubview:btnRight];
//    }
//    if (ptzBo) {
//        UIButton *btnFocusBig = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *imgFocusBig  = GetImageByName(@"ptz_focusadd_nor.png");
//        [btnFocusBig setImage:imgFocusBig forState:UIControlStateNormal];
//        [btnFocusBig setImage:GetImageByName(@"ptz_focusadd_press.png") forState:UIControlStateHighlighted];
//        [btnFocusBig setImage:GetImageByName(@"ptz_focusadd_disable.png") forState:UIControlStateDisabled];
//        
//        UIButton *btnFocusSmall = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *imgFocusSmall  = GetImageByName(@"ptz_focusreduce_nor.png");
//        [btnFocusSmall setImage:imgFocusSmall forState:UIControlStateNormal];
//        [btnFocusSmall setImage:GetImageByName(@"ptz_focusreduce_press.png") forState:UIControlStateHighlighted];
//        [btnFocusSmall setImage:GetImageByName(@"ptz_focusreduce_disable.png") forState:UIControlStateDisabled];
//        
//        [btnFocusBig setFrame:CGRectMake((CGRectGetMinX(btnBigCircle.frame) -imgFocusBig.size.width)/2, CGRectGetMinY(btnBigCircle.frame), imgFocusBig.size.width, imgFocusBig.size.height)];
//        [btnFocusSmall setFrame:CGRectMake(CGRectGetMinX(btnFocusBig.frame), CGRectGetMaxY(btnBigCircle.frame) - imgFocusSmall.size.height, imgFocusSmall.size.width, imgFocusSmall.size.height)];
//        
//        [btnFocusSmall addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//        [btnFocusSmall addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [btnFocusSmall addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//        [btnFocusSmall addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UILabel *focusLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMidY(btnBigCircle.frame)-10.f, CGRectGetMinX(btnBigCircle.frame), 20.f)];
//        focusLabel.textColor =RGB_187_190_199;
//        focusLabel.text =FSLocalizedString(@"FS_Live_Focus");
//        focusLabel.font =SysFontOfSize_12;
//        focusLabel.textAlignment =NSTextAlignmentCenter;
//        focusLabel.tag =PTZFocusLabel;
//
//        [ptzView addSubview:btnFocusBig];
//        [ptzView addSubview:btnFocusSmall];
//        [ptzView addSubview:focusLabel];
//        
//        UIButton *btnZoomAdd = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *imgZoomAdd  = GetImageByName(@"ptz_zoomadd_nor.png");
//        [btnZoomAdd setImage:imgZoomAdd forState:UIControlStateNormal];
//        [btnZoomAdd setImage:GetImageByName(@"ptz_zoomadd_press.png") forState:UIControlStateHighlighted];
//        [btnZoomAdd setImage:GetImageByName(@"ptz_zoomadd_disable.png") forState:UIControlStateDisabled];
//        
//        UIButton *btnZoomRed = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *imgZoomRed  = GetImageByName(@"ptz_zoomreduce_nor.png");
//        [btnZoomRed setImage:imgZoomRed forState:UIControlStateNormal];
//        [btnZoomRed setImage:GetImageByName(@"ptz_zoomreduce_press.png") forState:UIControlStateHighlighted];
//        [btnZoomRed setImage:GetImageByName(@"ptz_zoomreduce_disable.png") forState:UIControlStateDisabled];
//        
//        float bigCircleMaxX =CGRectGetMaxX(btnBigCircle.frame);
//        [btnZoomAdd setFrame:CGRectMake(bigCircleMaxX +(SCREEN_WIDTH -bigCircleMaxX - imgZoomAdd.size.width)/2, CGRectGetMinY(btnBigCircle.frame), imgZoomAdd.size.width, imgZoomAdd.size.height)];
//        [btnZoomRed setFrame:CGRectMake(CGRectGetMinX(btnZoomAdd.frame), CGRectGetMaxY(btnBigCircle.frame) - imgZoomRed.size.height, imgZoomRed.size.width, imgZoomRed.size.height)];
//        
//        [btnZoomRed addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//        [btnZoomRed addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [btnZoomAdd addTarget:self action:@selector(ptzClicked:) forControlEvents:UIControlEventTouchDown];
//        [btnZoomAdd addTarget:self action:@selector(ptzClickedStop:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UILabel *zoomLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnBigCircle.frame), CGRectGetMidY(btnBigCircle.frame)-10.f, SCREEN_WIDTH -bigCircleMaxX, 20.f)];
//        zoomLabel.textColor =RGB_187_190_199;
//        zoomLabel.text =FSLocalizedString(@"FS_Live_Zoom");
//        zoomLabel.font =SysFontOfSize_12;
//        zoomLabel.textAlignment =NSTextAlignmentCenter;
//        zoomLabel.tag =PTZZoomLabel;
//        
//        [ptzView addSubview:btnZoomAdd];
//        [ptzView addSubview:btnZoomRed];
//        [ptzView addSubview:zoomLabel];
//        
//        btnZoomAdd.tag      = PTZControlAmplification;
//        btnZoomRed.tag      = PTZControlNarrow;
//        btnFocusBig.tag     = PTZControlFocusAdd;
//        btnFocusSmall.tag   = PTZControlFocusRed;
//    }
//    
//    btnBigCircle.tag    = PTZControlRestore;
//    btnUp.tag           = PTZControlUp;
//    btnDown.tag         = PTZControlDown;
//    btnLeft.tag         = PTZControlLeft;
//    btnRight.tag        = PTZControlRight;
//    
//    [self setPTZData:ptzBo];*/
//}
///*
//- (void)setPTZData:(BOOL)ptzBo{
//
//    if (ptzBo) {
//        
//        UIButton *btnZoomAdd = (UIButton *)[ptzView viewWithTag:PTZControlAmplification];
//        UIButton *btnZoomRed = (UIButton *)[ptzView viewWithTag:PTZControlNarrow];
//        UIButton *btnFocusBig = (UIButton *)[ptzView viewWithTag:PTZControlFocusAdd];
//        UIButton *btnFocusSmall = (UIButton *)[ptzView viewWithTag:PTZControlFocusRed];
//
//        btnZoomAdd.enabled = btnZoomRed.enabled = _productAllInfoModel.zoomFlag;
//        btnFocusBig.enabled = btnFocusSmall.enabled = [[ProductAllInfoHelper sharedInstance] isEnableFocusWithProductAllInfoModel:_productAllInfoModel];
//        
//        UILabel *focusLabel = (UILabel *)[ptzView viewWithTag:PTZFocusLabel];
//        UILabel *zoomLabel = (UILabel *)[ptzView viewWithTag:PTZZoomLabel];
//
//        
//        if(!btnZoomAdd.enabled){
//            zoomLabel.alpha =0.2f;
//        }
//        if (!btnFocusBig.enabled) {
//            focusLabel.alpha =0.2f;
//        }
//    }
//    
//    UIButton *btnBigCircle;
//    UIButton *btnUp;
//    UIButton *btnDown;
//    UIButton *btnLeft;
//    UIButton *btnRight;
//    if (ptzBo) {
//        btnBigCircle = (UIButton *)[ptzView viewWithTag:PTZControlRestore];
//        btnUp = (UIButton *)[ptzView viewWithTag:PTZControlUp];
//        btnDown = (UIButton *)[ptzView viewWithTag:PTZControlDown];
//        btnLeft = (UIButton *)[ptzView viewWithTag:PTZControlLeft];
//        btnRight = (UIButton *)[ptzView viewWithTag:PTZControlRight];
//    }else{
//        btnBigCircle = (UIButton *)[ptzFullView viewWithTag:PTZControlRestore];
//        btnUp = (UIButton *)[ptzFullView viewWithTag:PTZControlUp];
//        btnDown = (UIButton *)[ptzFullView viewWithTag:PTZControlDown];
//        btnLeft = (UIButton *)[ptzFullView viewWithTag:PTZControlLeft];
//        btnRight = (UIButton *)[ptzFullView viewWithTag:PTZControlRight];
//    }
//    
//    if (1 == _productAllInfoModel.ptFlag){//支持PTZ
//        btnBigCircle.enabled = btnUp.enabled = btnDown.enabled = btnLeft.enabled = btnRight.enabled = YES;
//    }else{
//        if (isSupportEPT || 5008 == _productAllInfoModel.model || 5011 == _productAllInfoModel.model){//是否支持电子缩放
//            btnUp.enabled = btnDown.enabled = btnLeft.enabled = btnRight.enabled = YES;
//            btnBigCircle.userInteractionEnabled = NO;//不支持归位操作
//        }else{
//            btnBigCircle.enabled = btnUp.enabled = btnDown.enabled = btnLeft.enabled = btnRight.enabled = NO;
//        }
//    }
//}
//*/
//#pragma mark - ptz控制盘
//- (void)ptzClicked:(UIButton *)sender
//{
//    FOSPTZ_CMD cmd = FOSPTZ_STOP;
//    switch (sender.tag) {
//        case PTZControlRestore:
//            FSLog(@"回");
//            cmd = FOSPTZ_CENTER;
//            break;
//        case PTZControlUp:
//            FSLog(@"上");
//            cmd = FOSPTZ_UP;
//            break;
//        case PTZControlDown:
//            FSLog(@"下");
//            cmd = FOSPTZ_DOWN;
//            break;
//        case PTZControlLeft:
//            FSLog(@"左");
//            cmd = FOSPTZ_LEFT;
//            break;
//        case PTZControlRight:
//            FSLog(@"右");
//            cmd = FOSPTZ_RIGHT;
//            break;
//        case PTZControlAmplification:
//        {
//            FSLog(@"大");
//            FOSHANDLE *pHandle = &playerHandle;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[FSNetService sharedNetService] zoomIn_sync:*pHandle timeout:300];
//            });
//            return;
//        }
//            break;
//        case PTZControlNarrow:
//        {
//            FSLog(@"小");
//            FOSHANDLE *pHandle = &playerHandle;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[FSNetService sharedNetService] zoomOut_sync:*pHandle timeout:300];
//            });
//            return;
//        }
//            break;
//        case PTZControlFocusAdd:
//        {
//            FOSHANDLE *pHandle = &playerHandle;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[FSNetService sharedNetService] Focus_sync:*pHandle type:FOSPTZ_FOCUSFAR timeout:300];
//            });
//        }
//            break;
//        case PTZControlFocusRed:
//        {
//            FOSHANDLE *pHandle = &playerHandle;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[FSNetService sharedNetService] Focus_sync:*pHandle type:FOSPTZ_FOCUSNEAR timeout:300];
//            });
//        }
//            break;
//        default:
//            break;
//    }
//    
//    FOSHANDLE *pHandle = &playerHandle;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[FSNetService sharedNetService] ptz_sync:*pHandle cmd:cmd timeout:300];
//    });
//}
//
//- (void)ptzClickedStop:(UIButton *)sender
//{
//    switch (sender.tag) {
//        //case PTZControlRestore:
//        case PTZControlUp:
//        case PTZControlDown:
//        case PTZControlLeft:
//        case PTZControlRight:
//        {
//            FOSPTZ_CMD cmd = FOSPTZ_STOP;
//            FOSHANDLE *pHandle = &playerHandle;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[FSNetService sharedNetService] ptz_sync:*pHandle cmd:cmd timeout:300];
//            });
//        }
//            break;
//        case PTZControlAmplification:
//        case PTZControlNarrow:
//        {
//            FOSHANDLE *pHandle = &playerHandle;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[FSNetService sharedNetService] zoomStop_sync:*pHandle timeout:300];
//            });
//        }
//            break;
//        case PTZControlFocusAdd:
//        case PTZControlFocusRed:
//        {
//            FOSHANDLE *pHandle = &playerHandle;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[FSNetService sharedNetService] Focus_sync:*pHandle type:FOSPTZ_FOCUSSTOP timeout:300];
//            });
//        }
//            break;
//    }
//}
//
////抓拍按钮
//-(void)picAction:(UIButton *)sender{
//    NSLog(@"picAction________");
//    //  .5f秒内只有一次抓拍点击有效
//    sender.userInteractionEnabled = sender.enabled = NO;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        sender.userInteractionEnabled = sender.enabled = YES;
//    });
//    UIImage *image =_videoScrollView.imageView.image;
//    sharePicPath = [self savePictureImage:image withDeviceInfo:playerModel];
//    if (![sharePicPath isEqualToString:@"NO"]) {
//        picShowTime =0;
//        if (sender.tag ==IPCPicButtonTag) {
//            if (!picView) {
//                [self setPicView:image];
//            }else{
//                picView.hidden =NO;
//                shareImageView.image =image;
//            }
//        }else if (sender.tag ==IPCPicFullButtonTag){
//            if (!imageFullView) {
//                [self setPicFullView:image];
//            }else{
//                imageFullView.hidden =NO;
//                imageFullView.image =image;
//            }
//        }
//
//        if (!picShowTimer) {
//            picShowTimer =[NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(hideShareView) userInfo:nil repeats:YES];
//        }
//        [self picWithAnimation];//播放动画
//        [self picWithSound];    //播放声音
//    }
//}
//
//-(void)hideShareView{
//    ++picShowTime;
//    if (picShowTime >=5) {
//        [picShowTimer invalidate]; picShowTimer =nil;
//        picView.hidden =YES;
//        imageFullView.hidden =YES;
//    }
//}
//
////抓拍分享view
//-(void)setPicView:(UIImage *)image{
//    picView =[[UIView alloc]initWithFrame:CGRectMake(0, _videoScrollView.frame.size.height -50.f, SCREEN_WIDTH, 50.f)];
//    [_videoScrollView addSubview:picView];
//    picView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_opacity_80.png"]];
//    
//    shareImageView =[[UIImageView alloc]initWithFrame:CGRectMake(6.f, 5, 71.f, 40.f)];
//    [picView addSubview:shareImageView];
//    //设置边框及边框颜色
//    shareImageView.layer.borderWidth =1.5f;
//    shareImageView.layer.borderColor =[RGB_White CGColor];
//    shareImageView.image =image;
//    shareImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoAlbum)];
//    [shareImageView addGestureRecognizer:singleTap1];
//    
//    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [picView addSubview:shareBtn];
//    float shareWid =68.f;
//    [shareBtn setFrame:CGRectMake(SCREEN_WIDTH -shareWid-15.f,(CGRectGetHeight(picView.frame) -25.f)/2,shareWid,25.f)];
//    [shareBtn setTitle:FSLocalizedString(@"FS_Live_Share") forState:UIControlStateNormal];
//    shareBtn.titleLabel.font =SysFontOfSize_14;
//    shareBtn.layer.borderWidth =1.f;
//    shareBtn.layer.borderColor =[RGB_255_120_0 CGColor];
//    shareBtn.layer.cornerRadius = Corner_Radius;
//    shareBtn.layer.masksToBounds = YES;
//    [shareBtn setTitleColor:RGB_White forState:UIControlStateHighlighted];
//    [shareBtn setTitleColor:RGB_187_190_199 forState:UIControlStateNormal];
//    [shareBtn setBackgroundImage:[UIImage imageWithColor:RGB_255_120_0] forState:UIControlStateHighlighted];
//    [shareBtn addTarget:self action:@selector(shareActionButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel *labelTip =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shareImageView.frame) +8, CGRectGetMinY(shareImageView.frame), SCREEN_WIDTH -CGRectGetMaxX(shareImageView.frame) -8 -CGRectGetWidth(shareBtn.frame)-30.f, CGRectGetHeight(shareImageView.frame))];
//    [picView addSubview:labelTip];
//    labelTip.textColor =RGB_187_190_199;
//    labelTip.font =SysFontOfSize_12;
//    labelTip.backgroundColor =RGB_Clear;
//    labelTip.text =FSLocalizedString(@"FS_Live_SnapTips");
//    labelTip.numberOfLines =0;
//    
//}
//
//- (void)gotoAlbum{
//    NSLog(@"进入相册");
//    [self exitFullScreenAction:nil];
//    AlbumViewController *vc = [AlbumViewController new];
//    vc.deviceMac = playerModel.cloudModel.deviceMac;
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//-(void)shareActionButton:(UIButton *)sender{
//    NSLog(@"进入分享界面");
//    shareBo =YES;
//    //拍照截图立即分享
//    [FSShareManager initActivityWithTitle:nil imageArr:[NSMutableArray arrayWithArray:@[sharePicPath]] urlArr:nil sccuess:^(NSString *resultStr) {
//        DDLogInfo(@"shareComplect!");
//        shareBo = NO;
//    } failure:^(NSString *error) {
//        shareBo = NO;
//        //[self showMessage:error wihtStyle:ALAlertBannerStyleNotify];
//    }];
//}
//
////播放动画
//- (void)picWithAnimation{
//    __block UIView *view = [[UIView alloc] initWithFrame:_videoScrollView.frame];
//    view.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:view];
//    [UIView animateWithDuration:0.1f animations:^{
//        view.alpha = 0.2f;
//    } completion:^(BOOL finished) {
//        [view removeFromSuperview];
//        view = nil;
//    }];
//}
////拍照声音
//- (void)picWithSound{
//    AudioServicesPlaySystemSound(1108);  //拍照提示音
//}
////录像按钮
//-(void)recordAction:(UIButton *)sender{
//    NSLog(@"recordAction________");
//    if (!recordTimeBtn) {
//        [self setupRecordLabel];
//    }
//    if (isRecording) {
//        isRecording = NO;
//        sender.selected =NO;
//        [self stopRecordShow];
//        [[FSNetService sharedNetService] stopRecord_sync:playerHandle];
//    }else {
//        NSString *vedioDirPath =[self getDirectoryPath:playerModel medioType:MediaTypeVedio];
//        NSString *timeFileName =[self getFileName];
//        NSString *fileName = [NSString stringWithFormat:@"%@.mp4",timeFileName];
//        NSString *filePath = [vedioDirPath stringByAppendingPathComponent:fileName];
//        FOSCMD_RESULT ret = [[FSNetService sharedNetService] startRecord_sync:playerHandle filename:(char *)[filePath UTF8String]];
//        if (FOSCMDRET_OK == ret) {
//            isRecording = YES;
//            sender.selected =YES;
//            [sender setUserInteractionEnabled:NO];
//            [self performSelector:@selector(setButtonUserInteraction:) withObject:sender afterDelay:3.0f];
//            [self startRecordShow];
//            //保存截图,用于显示缩略图
//            NSString *videoSnapDirPath = [self getDirectoryPath:playerModel medioType:MediaTypeThumb];
//            NSString *snapFileName = [NSString stringWithFormat:@"%@.jpg",timeFileName];
//            NSString *snapFilePath = [videoSnapDirPath stringByAppendingPathComponent:snapFileName];
//            NSData *dataimg = UIImageJPEGRepresentation(_videoScrollView.imageView.image, 1);
//            [[NSFileManager defaultManager] createFileAtPath:snapFilePath contents:dataimg attributes:nil];
//        }else{
//            sender.selected =NO;
//        }
//    }
//}
////开始录像计时显示
//- (void)startRecordShow{
//    recordTimeBtn.hidden = NO;
//    if (!recordTimer){
//        recordCount = 0;
//        [self recordCount];
//        recordTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(recordCount) userInfo:nil repeats:YES];
//    }
//}
////停止录像计时显示
//- (void)stopRecordShow{
//    recordTimeBtn.hidden = YES;
//    if (recordTimer){
//        recordCount = 0;
//        [recordTimer invalidate];
//        recordTimer = nil;
//    }
//}
////定时器函数
//- (void)recordCount{
//    
//    NSInteger hour = recordCount / 3600;
//    NSInteger min = (recordCount - (hour * 3600)) / 60;
//    NSInteger sec = recordCount % 60;
//    
//    NSString *recordTime = [NSString stringWithFormat:@"   %02ld:%02ld:%02ld", (long)hour, (long)min, (long)sec];
//    
//    if ((recordTimeBtn.highlighted = (0 == (sec % 2)))){
//        [recordTimeBtn setTitle:recordTime forState:UIControlStateHighlighted];
//    }else{
//        [recordTimeBtn setTitle:recordTime forState:UIControlStateNormal];
//    }
//    ++ recordCount;
//}
////更多按钮
//-(void)moreAction:(UIButton *)sender{
//    NSLog(@"moreAction________");
//    
//    if (self.ptzCView.superview) {
//        ptzBtn.selected = NO;
//        [self.ptzCView removeFromSuperview];
//    }
//    
//    if (sender.selected) {
//        moreView.hidden =YES;
//        sender.selected =NO;
//        return;
//    }else{
//        sender.selected =YES;
//        if (moreView) {
//            moreView.hidden =NO;
//            if (DetectionBool)
//            {
//                DetectionBool = NO;
//                [self setDetectionData];
//            }
//            return;
//        }
//    }
//    float moreViewHeight =CGRectGetHeight(footView.frame)-CGRectGetMaxY(view2Fun.frame);
//    float tabWid =SCREEN_WIDTH /3 ;  float tabHeigt =49.f;
//    float subViewHeight =moreViewHeight -tabHeigt;
//    moreView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view2Fun.frame), SCREEN_WIDTH, moreViewHeight)];
//    [footView addSubview:moreView];
//    moreView.backgroundColor =RGB_48_48_64;
//    for (int index =0; index <3; ++index) {
//        UIButton *moreButton =[[UIButton alloc]initWithFrame:CGRectMake(0 + tabWid *index, moreViewHeight -tabHeigt, tabWid, tabHeigt)];
//        [moreView addSubview:moreButton];
//        [moreButton addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
//        moreButton.tag =Detection +index;
//        if (index ==0) {
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_alert_nor.png"] forState:UIControlStateNormal];
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_alert_select.png"] forState:UIControlStateSelected];
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_alert_select.png"] forState:UIControlStateHighlighted];
//            moreButton.selected =NO;
//        }else if (index ==1){
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_nightvision_nor.png"] forState:UIControlStateNormal];
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_nightvision_select.png"] forState:UIControlStateSelected];
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_nightvision_select.png"] forState:UIControlStateHighlighted];
//            moreButton.selected =YES;
//        }else if (index ==2){
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_flip_nor.png"] forState:UIControlStateNormal];
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_flip_select.png"] forState:UIControlStateSelected];
//            [moreButton setImage:[UIImage imageNamed:@"tabmenu_flip_select.png"] forState:UIControlStateHighlighted];
//            moreButton.selected =NO;
//        }
//        [moreButton setBackgroundImage:[UIImage imageWithColor:RGB_30_30_43] forState:UIControlStateSelected];
//        [moreButton setBackgroundImage:[UIImage imageWithColor:RGB_30_30_43] forState:UIControlStateHighlighted];
//        [moreButton setBackgroundImage:[UIImage imageWithColor:RGB_39_39_53] forState:UIControlStateNormal];
//        
//        UIView *view =nil;
//        
//        if (index ==1 && SCREEN_HEIGHT ==IS_IPHONE_4) {
//            UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, subViewHeight)];
//            [self.view addSubview:scrollView];
//            scrollView.userInteractionEnabled =YES;
//            scrollView.scrollEnabled =YES;
//            scrollView.multipleTouchEnabled =YES;
//            scrollView.contentSize =CGSizeMake(SCREEN_WIDTH *3/1.95, subViewHeight);
//            scrollView.showsVerticalScrollIndicator = NO;
//            scrollView.showsHorizontalScrollIndicator = NO;
//            [moreView addSubview:scrollView];
//            scrollView.tag =DetectionView +index;
//            view =scrollView;
//        }else{
//            view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, subViewHeight)];
//            [moreView addSubview:view];
//            view.tag =DetectionView +index;
//            view.backgroundColor =RGB_Clear;
//        }
//        
//        if (index ==0) {
//            view.hidden =YES;
//            [self setDectionView:view andHeight:subViewHeight];
//        }else if (index ==1){
//            view.hidden =NO;
//            [self setNightView:view andHeight:subViewHeight];
//        }else if (index ==2){
//            view.hidden =YES;
//            [self setMirrorView:view andHeight:subViewHeight];
//        }
//        if (index ==2) {
//            for (int iLine =0; iLine <2; ++iLine) {
//                UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(tabWid *(1 +iLine), moreViewHeight -tabHeigt, .5f, tabHeigt)];
//                line.backgroundColor =RGB_30_30_43;
//                [moreView addSubview:line];
//            }
//        }
//    }
//    
//    // 新手指引
//    DirectionModel *directionModel = [DirectionHelper sharedInstance].directionModel;
//    if (directionModel.moreButtonDirection) {
//        NSArray *directionViews = @[[LiveMoreDirectionView new]];
//        [self showDirectionViews:directionViews];
//        directionModel.moreButtonDirection = NO;
//    }
//}
////tab 事件
//-(void)tabBarAction:(UIButton *)sender{
//    sender.selected =YES;
//    for (int index =Detection; index <= Mirror; ++index) {
//        if (sender.tag == index) {
//            UIView *view =[moreView viewWithTag:((DetectionView -Detection) + index)];
//            view.hidden =NO;
//        }else{
//            UIView *view =[moreView viewWithTag:((DetectionView -Detection) + index)];
//            view.hidden =YES;
//            UIButton *button =[moreView viewWithTag:index];
//            button.selected =NO;
//        }
//    }
//}
////侦测内容
//- (void) setDectionView:(UIView *)view andHeight:(float)height{
//    if (detectionTableView) {
//        detectionTableView.hidden =NO;
//        [self setDetectionData];//设置侦测数据
//    }else{
//        detectionTableView =[[UITableView alloc]initWithFrame:view.frame];
//        [view addSubview:detectionTableView];
//        [self setDetectionData];//设置侦测数据
//        detectionTableView.delegate =self;
//        detectionTableView.dataSource =self;
//        detectionTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
//        detectionTableView.backgroundColor =RGB_Clear;
//        detectionTableView.showsVerticalScrollIndicator =NO;
//    }
//}
////设置侦测数据
//- (void) setDetectionData{
//    if (!detectionDataSource) {
//        detectionDataSource =[[NSMutableArray alloc]init];
//    }else{
//        [detectionDataSource removeAllObjects];
//    }
//    NSString *motionString = (_productAllInfoModel.isEnablePIRDetect) ? FSLocalizedString(@"FS_Settings_ActivityDetection") : FSLocalizedString(@"FS_Settings_MotionDetection");
//    [self addDetectionDataSource:motionString withType:FSAlertMotion];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        _alertManager = [[AlertManager alloc] init];
//        _alertfetch = NO;
//        [self fetchAlertConfig:_alertManager DetectType:FSAlertMotion];
//    });
//    if (_productAllInfoModel.isEnableAudioDetect){//声音侦测
//        NSString *title =FSLocalizedString(@"FS_Settings_SoundDetection");
//        [self addDetectionDataSource:title withType:FSSoundMotion];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            _soundManager =[[AlertManager alloc] init];
//            _soundfetch = NO;
//            [self fetchAlertConfig:_soundManager DetectType:FSSoundMotion];
//        });
//    }
//    if (_productAllInfoModel.isEnableTemperatureDetect) {//温度侦测
//        NSString *title =FSLocalizedString(@"FS_Settings_TemperatureDetection");
//        [self addDetectionDataSource:title withType:FSTemperatureMotion];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            _temperatureManager =[[AlertManager alloc] init];
//            _temperaturefetch = NO;
//            [self fetchAlertConfig:_temperatureManager DetectType:FSTemperatureMotion];
//        });
//    }
//    if (_productAllInfoModel.isEnableHumidityDetect){//湿度侦测
//        NSString *title =FSLocalizedString(@"FS_Settings_HumidityDetection");
//        [self addDetectionDataSource:title withType:FSHumidityMotion];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            _humidityManager =[[AlertManager alloc] init];
//            _humidityfetch = NO;
//            [self fetchAlertConfig:_humidityManager DetectType:FSHumidityMotion];
//        });
//    }
//    BOOL isEnableHumanDetect = [[ProductAllInfoHelper sharedInstance] isEnableHumanDetectionWithProductAllInfoModel:_productAllInfoModel];
//    if (isEnableHumanDetect) {//人体侦测
//        NSString *title =FSLocalizedString(@"FS_Settings_HumanDetection");
//        [self addDetectionDataSource:title withType:FSHumanMotion];
//        _humanfetch = NO;
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self fetchHumanConfig];
//        });
//    }
//    if (_productAllInfoModel.ioAlarmFlag){//IO侦测
//        NSString *title =FSLocalizedString(@"FS_Settings_IODetection");
//        [self addDetectionDataSource:title withType:FSIOMotion];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            _ioManager =[[AlertManager alloc] init];
//            _iofetch = NO;
//            [self fetchAlertConfig:_ioManager DetectType:FSIOMotion];
//        });
//    }
//}
//-(void)addDetectionDataSource:(NSString *)title withType:(FSAlertType)type{
//    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
//    [dict setObject:title forKey:@"title"];
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type"];
//    [dict setObject:@"0" forKey:@"enable"];
//    [detectionDataSource addObject:dict];
//}
//-(void) setSwitchButton:(int)enable withType:(FSAlertType)type{
//    for (int index =0; index <[detectionDataSource count]; ++index) {
//        NSMutableDictionary *dict =detectionDataSource[index];
//        if ([[dict objectForKey:@"type"] isEqualToString:[NSString stringWithFormat:@"%ld",(long)type]]) {
//            [dict setValue:[NSString stringWithFormat:@"%d",enable] forKey:@"enable"];
//            break;
//        }
//    }
//    NSLog(@"detectionDataSource =%@",detectionDataSource);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [detectionTableView reloadData];
//    });
//}
//-(void) fetchAlertConfig:(AlertManager *)manger DetectType:(FSAlertType)alertType{
//    [manger fetchAlertConfig:playerModel withType:alertType onCompletion:^(FOSCMD_RESULT cmdResult) {
//        if (FOSCMDRET_OK == cmdResult){
//            NSLog(@"alertType =%ld",(long)alertType);
//            int bEnable = manger.mdModel.isEnable;
//            switch (alertType) {
//                case FSAlertMotion:
//                    _alertfetch = YES;
//                    break;
//                case FSSoundMotion:
//                    _soundfetch = YES;
//                    break;
//                case FSTemperatureMotion:
//                    _temperaturefetch = YES;
//                    break;
//                case FSHumidityMotion:
//                    _humidityfetch = YES;
//                    break;
//                case FSHumanMotion:
//                    _humanfetch = YES;
//                    break;
//                case FSIOMotion:
//                    _iofetch = YES;
//                    break;
//                default:
//                    break;
//            }
//            [self setSwitchButton:bEnable withType:alertType];
//        }else{
//            [self showMessage:FSLocalizedString(@"FS_Settings_GetFail") wihtStyle:ALAlertBannerStyleFailure];
//        }
//    }];
//}
//-(void) switchButton:(UIButton *)sender{
//    NSLog(@"侦测开关sender tag =%ld,selected =%d",(long)sender.tag ,sender.selected);
//    sender.selected =!sender.selected;
//    NSDictionary *dict =detectionDataSource[sender.tag];
//    FSAlertType alertType =[[dict objectForKey:@"type"] intValue];
//    if (alertType ==FSAlertMotion) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (_alertfetch) {
//                [self saveAlertConfig:_alertManager DetectType:FSAlertMotion];
//            }else{
//                [self fetchAlertConfig:_alertManager DetectType:FSAlertMotion];
//            }
//        });
//    }else if (alertType ==FSSoundMotion){
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (_soundfetch) {
//                [self saveAlertConfig:_soundManager DetectType:FSSoundMotion];
//            }else{
//                [self fetchAlertConfig:_alertManager DetectType:FSSoundMotion];
//            }
//        });
//    }else if (alertType ==FSTemperatureMotion){
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (_temperaturefetch) {
//                [self saveAlertConfig:_temperatureManager DetectType:FSTemperatureMotion];
//            }else{
//                [self fetchAlertConfig:_alertManager DetectType:FSTemperatureMotion];
//            }
//        });
//    }else if (alertType ==FSHumidityMotion){
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (_humidityfetch) {
//                [self saveAlertConfig:_humidityManager DetectType:FSHumidityMotion];
//            }else{
//                [self fetchAlertConfig:_alertManager DetectType:FSHumidityMotion];
//            }
//        });
//    }else if (alertType ==FSIOMotion){
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (_iofetch) {
//                [self saveAlertConfig:_ioManager DetectType:FSIOMotion];
//            }else{
//                [self fetchAlertConfig:_alertManager DetectType:FSIOMotion];
//            }
//        });
//    }else if (alertType ==FSHumanMotion){
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (_humanfetch) {
//                [self saveDataWithFailure];
//            }else{
//                [self fetchHumanConfig];
//            }
//        });
//    }
//}
//-(void) saveAlertConfig:(AlertManager *)manger DetectType:(FSAlertType)alertType{
//    manger.mdModel.isEnable =!manger.mdModel.isEnable;
//    [manger saveAlertConfigWithType:alertType onCompletion:^(FOSCMD_RESULT cmdResult) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (FOSCMDRET_OK == cmdResult){
//                [self setSwitchButton:manger.mdModel.isEnable withType:alertType];
//            }else{
//                [self setSwitchButton:!manger.mdModel.isEnable withType:alertType];
//                [self showMessage:FSLocalizedString(@"FS_Settings_GetFail") wihtStyle:ALAlertBannerStyleFailure];
//            }
//        });
//    }];
//}
//- (void) fetchHumanConfig{
//    [FSCGIManager getCGICommandWithHandle:playerHandle cgiCommand:kCGIGetHumanDetectConfig onCompletion:^(NSDictionary *response, CGIResultType cgiResult) {
//        if (CGIResultSuccess == cgiResult) {
//            NSLog(@"... response = %@", response);
//            _humanModel = [[HumanDetectModel alloc]instanceWithDict:response];
//            int bEnable = _humanModel.isEnable;
//            _humanfetch = YES;
//            [self setSwitchButton:bEnable withType:FSHumanMotion];
//        } else {
//            NSLog(@"... cgiResult = %d", cgiResult);
//        }
//    }];
//}
//- (void) saveDataWithFailure {
//    _humanModel.isEnable =!_humanModel.isEnable;
//    [FSCGIManager setCGICommandWithHandle:playerHandle cgiCommand:kCGISetHumanDetectConfig parameters:_humanModel.dict onCompletion:^(NSDictionary *response, CGIResultType cgiResult) {
//        if (CGIResultSuccess == cgiResult) {
//            int bEnable = _humanModel.isEnable;
//            [self setSwitchButton:bEnable withType:FSHumanMotion];
//        }else if (CGIResultSuccess != cgiResult) {
//            [self setSwitchButton:!_humanModel.isEnable withType:FSHumanMotion];
//            [self showMessage:FSLocalizedString(@"FS_Settings_GetFail") wihtStyle:ALAlertBannerStyleFailure];
//        }
//    }];
//}
////夜视计划view
//- (void) setNightView:(UIView *)view andHeight:(float)height{
//    if (nightView) {
//        nightView.hidden = NO;
//        [self irModeSelectedStateWithSuperView:view];
//        return;
//    }
//    nightView =view;
//    UIImage *image =[UIImage imageNamed:@"nightvision_auto_nor.png"];
//    float imageWid = image.size.width *((SCREEN_HEIGHT > IS_IPHONE_5)?1.f:3.f/4);
//    float imageHeight = image.size.height *((SCREEN_HEIGHT > IS_IPHONE_5)?1.f:3.f/4);
//    float labHeight =16.f; float labSpace =5.f;
//    float aHeight =imageHeight + labSpace + labHeight;
//    float spaceHeight =(height -aHeight *2)/4;
//    if (SCREEN_HEIGHT ==IS_IPHONE_4) {
//        spaceHeight =(height -aHeight)/2;
//    }
//    float spaceWid = (SCREEN_WIDTH -imageWid *2)/4;
//    if (SCREEN_HEIGHT ==IS_IPHONE_4) {
//        UIScrollView *tempView =(UIScrollView *)nightView;
//        spaceWid = ((tempView.contentSize.width) -imageWid *4)/4;
//    }
//    float labWid =SCREEN_WIDTH/2;
//    if (SCREEN_HEIGHT ==IS_IPHONE_4) {
//        UIScrollView *tempView =(UIScrollView *)nightView;
//        labWid = (tempView.contentSize.width)/4;
//    }
//    for (int index =0; index < 4; ++index) {
//        UIButton *button =[[UIButton alloc]init];
//        [view addSubview:button];
//        UILabel *labelText =[[UILabel alloc]init];
//        [view addSubview:labelText];
//        if (SCREEN_HEIGHT ==IS_IPHONE_4) {
//            button.frame =CGRectMake(spaceWid *(index +.5f) + imageWid *index, spaceHeight, imageWid, imageHeight);
//            labelText.frame =CGRectMake(labWid *index, CGRectGetMaxY(button.frame) +labSpace, labWid, labHeight);
//        }
//        if (index ==0) {
//            [button setImage:[UIImage imageNamed:@"nightvision_auto_nor.png"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"nightvision_auto_select.png"] forState:UIControlStateSelected];
//            [button setImage:[UIImage imageNamed:@"nightvision_auto_select.png"] forState:UIControlStateHighlighted];
//            button.selected =YES;
//            labelText.text =FSLocalizedString(@"FS_Live_Auto");
//            if (SCREEN_HEIGHT >IS_IPHONE_4) {
//                button.frame =CGRectMake(spaceWid, spaceHeight, imageWid, imageHeight);
//                labelText.frame =CGRectMake(0, CGRectGetMaxY(button.frame) +labSpace, labWid, labHeight);
//            }
//        }else if(index ==1){
//            [button setImage:[UIImage imageNamed:@"nightvision_off_nor.png"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"nightvision_off_select.png"] forState:UIControlStateSelected];
//            [button setImage:[UIImage imageNamed:@"nightvision_off_select.png"] forState:UIControlStateHighlighted];
//            labelText.text =FSLocalizedString(@"FS_Live_Day");
//            if (SCREEN_HEIGHT >IS_IPHONE_4) {
//                button.frame =CGRectMake(spaceWid *3 + imageWid, spaceHeight, imageWid, imageHeight);
//                labelText.frame =CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(button.frame) +labSpace, labWid, labHeight);
//            }
//        }else if (index ==2){
//            [button setImage:[UIImage imageNamed:@"nightvision_open_nor.png"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"nightvision_open_select.png"] forState:UIControlStateSelected];
//            [button setImage:[UIImage imageNamed:@"nightvision_open_select.png"] forState:UIControlStateHighlighted];
//            labelText.text =FSLocalizedString(@"FS_Live_Night");
//            if (SCREEN_HEIGHT >IS_IPHONE_4) {
//                button.frame =CGRectMake(spaceWid, spaceHeight*3+aHeight, imageWid, imageHeight);
//                labelText.frame =CGRectMake(0, CGRectGetMaxY(button.frame) +labSpace, labWid, labHeight);
//            }
//        }else if (index ==3){
//            [button setImage:[UIImage imageNamed:@"nightvision_scheduled_nor.png"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"nightvision_scheduled_select.png"] forState:UIControlStateSelected];
//            [button setImage:[UIImage imageNamed:@"nightvision_scheduled_select.png"] forState:UIControlStateHighlighted];
//            labelText.text =FSLocalizedString(@"FS_Live_Schedule");
//            if (SCREEN_HEIGHT >IS_IPHONE_4) {
//                button.frame =CGRectMake(spaceWid *3 +imageWid, spaceHeight*3+aHeight, imageWid, imageHeight);
//                labelText.frame =CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(button.frame) +labSpace, labWid, labHeight);
//            }
//            [self irModeSelectedStateWithSuperView:button.superview];
//
//        }
//        button.tag =AutoMode +index;
//        [button addTarget:self action:@selector(nightAction:) forControlEvents:UIControlEventTouchUpInside];
//        labelText.textColor =RGB_187_190_199;
//        labelText.font =SysFontOfSize_14;
//        labelText.textAlignment =NSTextAlignmentCenter;
//    }
//
//}
////夜视计划按钮事件
//-(void)nightAction:(UIButton *)sender{
//    NSLog(@"nightAction___________");
//    //记录当前状态
//    FSInfraLedMode mode = _mInfoModel.infraLedMode;
//    FSInfraLedState state = _mInfoModel.infraLedState;
//    
//    if (AutoMode == sender.tag || ScheduledMode == sender.tag){//只修改IR模式
//        _mInfoModel.infraLedMode = (AutoMode == sender.tag) ? 0 : 2;//自动为0、计划为2
//        NSLog(@"infraLedMode = %lu infraLedState = %u", (unsigned long)_mInfoModel.infraLedMode, _mInfoModel.infraLedState);
//        [self irModeSelectedStateWithSuperView:sender.superview];//修改button状态
//        
//        [[FSNetService sharedNetService] setIRModeWithHandle:playerHandle mode:_mInfoModel.infraLedMode onCompletion:^(FOSCMD_RESULT result) {
//            if (FOSCMDRET_OK != result){//失败
//                _mInfoModel.infraLedMode = mode;
//                [self irModeSelectedStateWithSuperView:sender.superview];//修改button状态
//            }
//        }];
//    }else if (DayMode == sender.tag || NightMode == sender.tag){//修改IR开启状态
//        if (1 == _mInfoModel.infraLedMode){//当前是手动状态
//            _mInfoModel.infraLedState = !(NightMode == sender.tag);//YES打开 NO关闭
//            NSLog(@"infraLedMode = %lu infraLedState = %u", (unsigned long)_mInfoModel.infraLedMode, _mInfoModel.infraLedState);
//            [self irModeSelectedStateWithSuperView:sender.superview];//修改button状态
//            
//            [[FSNetService sharedNetService] setIRStateWithHandle:playerHandle state:_mInfoModel.infraLedState onCompletion:^(FOSCMD_RESULT result) {
//                if (FOSCMDRET_OK != result){//失败
//                    _mInfoModel.infraLedState = state;
//                    [self irModeSelectedStateWithSuperView:sender.superview];//修改button状态
//                }
//            }];
//            
//        }else{//当前非手动状态
//            _mInfoModel.infraLedMode = 1;
//            [[FSNetService sharedNetService] setIRModeWithHandle:playerHandle mode:_mInfoModel.infraLedMode onCompletion:^(FOSCMD_RESULT result) {
//                if (FOSCMDRET_OK == result){//成功修改为手动模式
//                    _mInfoModel.infraLedState = !(NightMode == sender.tag);//YES打开 NO关闭
//                    NSLog(@"______________________infraLedMode = %lu infraLedState = %u", (unsigned long)_mInfoModel.infraLedMode, _mInfoModel.infraLedState);
//                    [self irModeSelectedStateWithSuperView:sender.superview];//修改button状态
//                    
//                    [[FSNetService sharedNetService] setIRStateWithHandle:playerHandle state:_mInfoModel.infraLedState onCompletion:^(FOSCMD_RESULT result) {
//                        if (FOSCMDRET_OK != result){//失败
//                            _mInfoModel.infraLedMode = mode;
//                            _mInfoModel.infraLedState = state;
//                            [self irModeSelectedStateWithSuperView:sender.superview];//修改button状态
//                        }
//                    }];
//                }else{
//                    _mInfoModel.infraLedMode = mode;
//                    [self irModeSelectedStateWithSuperView:sender.superview];//修改button状态
//                }
//            }];
//        }
//    }
//    
//}
//- (void)irModeSelectedStateWithSuperView:(UIView *)superView{
//    NSInteger temp = -1;
//    if (0 == _mInfoModel.infraLedMode){
//        temp = AutoMode;//自动状态
//    }else if (1 == _mInfoModel.infraLedMode){//注意:state 0为off 1为on
//        if (1 == _mInfoModel.infraLedState){
//            temp = DayMode;//关闭状态
//        }else if (0 == _mInfoModel.infraLedState){
//            temp = NightMode;//开启状态
//        }
//    }else if (2 == _mInfoModel.infraLedMode){
//        temp = ScheduledMode;//计划
//    }
//    if (-1 != temp){//设置状态
//        for (NSInteger tag = AutoMode; tag <= ScheduledMode; ++ tag) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                ((UIButton *)[superView viewWithTag:tag]).selected = (tag == temp);
//            });
//        }
//    }
//}
////镜像翻转view
//- (void) setMirrorView:(UIView *)view andHeight:(float)height{
//    if (mirrorView) {
//        mirrorView.hidden = NO;
//        return;
//    }
//    mirrorView =view;
//    UIImage *image =[UIImage imageNamed:@"horizontal_flip_nor.png"];
//    float imageWid = image.size.width *((SCREEN_HEIGHT > IS_IPHONE_5)?1.f:3.f/4);
//    float imageHeight = image.size.height *((SCREEN_HEIGHT > IS_IPHONE_5)?1.f:3.f/4);
//    float labHeight =16.f; float labSpace =5.f;  float aHeight =imageHeight + labSpace + labHeight;
//    float spaceHeight =(height -aHeight )/2;
//    float spaceWid = (SCREEN_WIDTH -imageWid *2)/4;
//    for (int index =0; index < 2; ++index) {
//        UIButton *button =[[UIButton alloc]init];
//        [view addSubview:button];
//        UILabel *labelText =[[UILabel alloc]init];
//        [view addSubview:labelText];
//        if (index ==0) {
//            button.frame =CGRectMake(spaceWid, spaceHeight, imageWid, imageHeight);
//            [button setImage:[UIImage imageNamed:@"horizontal_flip_nor.png"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"horizontal_flip_select.png"] forState:UIControlStateSelected];
//            [button setImage:[UIImage imageNamed:@"horizontal_flip_select.png"] forState:UIControlStateHighlighted];
//            button.selected =isFlip;
//            
//            labelText.frame =CGRectMake(0, CGRectGetMaxY(button.frame) +labSpace, SCREEN_WIDTH/2, labHeight);
//            labelText.text =FSLocalizedString(@"FS_Live_Flip");
//            
//        }else if(index ==1){
//            button.frame =CGRectMake(spaceWid *3 + imageWid, spaceHeight, imageWid, imageHeight);
//            [button setImage:[UIImage imageNamed:@"vertical_flip_nor.png"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"vertical_flip_select.png"] forState:UIControlStateSelected];
//            [button setImage:[UIImage imageNamed:@"vertical_flip_select.png"] forState:UIControlStateHighlighted];
//            button.selected =isMirror;
//
//            labelText.frame =CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(button.frame) +labSpace, SCREEN_WIDTH/2, labHeight);
//            labelText.text =FSLocalizedString(@"FS_Live_Mirror");
//            
//            
//        }
//        
//        button.tag =FlipMode +index;
//        [button addTarget:self action:@selector(mirrorAction:) forControlEvents:UIControlEventTouchUpInside];
//        labelText.textColor =RGB_187_190_199;
//        labelText.font =SysFontOfSize_14;
//        labelText.textAlignment =NSTextAlignmentCenter;
//    }
//
//}
////镜像翻转按钮事件
//-(void)mirrorAction:(UIButton *)sender{
//    NSLog(@"mirrorAction_selceted =%d isFlip =%d isMirror =%d",sender.selected,isFlip,isMirror);
//    sender.userInteractionEnabled =NO;
//    [self performSelector:@selector(setButtonUserInteraction:) withObject:sender afterDelay:1.f];
//    switch (sender.tag) {
//        case FlipMode:
//        {
//            [self setMirrorState:FlipMode andState:!isFlip];
//            [[FSNetService sharedNetService] flip_async:playerHandle :!sender.selected block:^(FOSCMD_RESULT ret) {
//                if (FOSCMDRET_OK == ret) {
//                    sender.selected =!sender.selected;
//                    [self setMirrorState:FlipMode andState:!isFlip];
//                }else {
//                    [self setMirrorState:FlipMode andState:isFlip];
//                    if (FOSCMDRET_TIMEOUT == ret) {
//                        [self showMessage:FSLocalizedString(@"FS_LiveSetting_TimeOut") wihtStyle:ALAlertBannerStyleFailure];
//                    }else if (FOSCMDRET_OK != ret) {
//                        [self showMessage:FSLocalizedString(@"FS_LiveSetting_Mirror_Fial") wihtStyle:ALAlertBannerStyleFailure];
//                    }
//                }
//            } :1000];
//        }
//            break;
//        case MirrorMode:
//        {
//            [self setMirrorState:MirrorMode andState:!isMirror];
//            [[FSNetService sharedNetService] mirror_async:playerHandle :!sender.selected block:^(FOSCMD_RESULT ret) {
//                if (FOSCMDRET_OK == ret) {
//                    [self setMirrorState:MirrorMode andState:!isMirror];
//                    sender.selected =!sender.selected;
//                }else {
//                    [self setMirrorState:MirrorMode andState:isMirror];
//                    if (FOSCMDRET_TIMEOUT == ret) {
//                        [self showMessage:FSLocalizedString(@"FS_LiveSetting_TimeOut") wihtStyle:ALAlertBannerStyleFailure];
//                    }else if (FOSCMDRET_OK != ret) {
//                        [self showMessage:FSLocalizedString(@"FS_LiveSetting_Mirror_Fial") wihtStyle:ALAlertBannerStyleFailure];
//                    }
//                }
//            } :1000];
//        }
//            break;
//            
//        default:
//            break;
//    }
//}
//-(void) setMirrorState:(MirrorButtonType)tempMode andState:(BOOL)state{
//    dispatch_async(dispatch_get_main_queue(), ^(){
//        ((UIButton *)[mirrorView viewWithTag:tempMode]).selected =state;
//    });
//}
////对讲
//- (void)openTalk:(UIButton *)sender
//{
//    if (_productAllInfoModel.talkFlag == 0 )//不支持对讲
//    {
//        return;
//    }
//    
//    [self performSelector:@selector(setButtonUserInteraction:) withObject:sender afterDelay:1.0f];
//    if (iOrientation !=0) {
//        [fullTimer invalidate]; fullTimer =nil;
//        btnViewFull.hidden =NO;
//    }
//    if (!hdTableView.hidden) {
//        hdTableView.hidden =YES;
//    }
//    if (!listTableView.hidden) {
//        listTableView.hidden =YES;
//    }
//    if (!connectSuc) {
//        [self showMessage:FSLocalizedString(@"FS_Live_NotConnect") wihtStyle:ALAlertBannerStyleFailure];
//        return;
//    }
//
//    if (![self AudioAuthorization]) {
//        return ;
//    }
//    
//    [sender setUserInteractionEnabled:NO];
//    
////    [self performSelector:@selector(setButtonUserInteraction:) withObject:sender afterDelay:1.5f];
//    
//    // 需求修改，观察者没有任何权限只能观看
////    if (_mInfoModel.iUserRight == UserRightTypeWatcher) {
////        [self showMessage:FSLocalizedString(@"FS_Live_NoPermission") wihtStyle:ALAlertBannerStyleNotify];
////        return;
////    }
//    
//    //[self showMessage:FSLocalizedString(@"FS_Live_OpenTalk") wihtStyle:ALAlertBannerStyleNotify];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        FOSCMD_RESULT ret = [[FSNetService sharedNetService] openTalk_sync:playerHandle timeout:1000];
//        FSLog(@"\ntalkOpenRet-------------- : %d\n", (int)ret);
//
//        if (ret == FOSCMDRET_OK) {
//            talkOpened = YES;
//            
//            if (sender.state ==UIControlStateNormal ) {
//                [self closeTalk:sender];
//                return ;
//            }
//            
//            if (isDoubSound) {
//                //打开音频
//                [_openAlAec OpenTalk];
//            }else{
//                if (soundBtn.state ==UIControlStateSelected){
//                    //关闭监听
//                    [_outputAudio AudioStop];
//                    if (soundBtn) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [soundBtn setSelected:NO];
//                        });
//                    }
//                }
//                //打开音频
//                if (!_inputAudio) {
//                    _inputAudio =[[FCInputAudio alloc] init];
//                }
//                NSString *path = [NSString documentPath];
//                NSFileManager *fileManager = [NSFileManager defaultManager];
//                NSString * pathFile = [path stringByAppendingPathComponent:@"file.a711"];
//                if(![fileManager fileExistsAtPath:pathFile])
//                {
//                    [fileManager createFileAtPath:pathFile contents:nil attributes:nil];
//                }
//                __block NSString *fPath = pathFile;
//                
//                FILE *fpp = fopen([fPath UTF8String], "w+");
//                if (!fpp){
//                    printf("fopen file error\n");
//                }
//                __block FILE *fp = fpp;
//                fseek(fp, 0L, SEEK_END);
//                
//                [_inputAudio InitAudio:&_audio_fmt :120*8 :^(const void *frame, int size, int index, const AudioTimeStamp *time, void *userdata){
//                    if (talkOpened) {
//                        
//                        //todo test begin
//                        unsigned char encodeBuf[1024];
//                        char *buf = encodeBuf;
//                        memset(buf, 0x00, sizeof(buf));
//                        g711a_encode(encodeBuf, frame, 480);
//                        
//                        long readLen = fwrite(buf, 480, 1, fp);
//                        
//                        [[FSNetService sharedNetService] sendTalkData_sync:playerHandle :(char*)frame dataLen:size];
//                    }
//                } :NULL];
//                
////g726
////                NSString *path = [NSString documentPath];
////                NSFileManager *fileManager = [NSFileManager defaultManager];
////                NSString * pathFile = [path stringByAppendingPathComponent:@"file.726"];
////                if(![fileManager fileExistsAtPath:pathFile])
////                {
////                    [fileManager createFileAtPath:pathFile contents:nil attributes:nil];
////                }
////                __block NSString *fPath = pathFile;
////                
////                FILE *fpp = fopen([fPath UTF8String], "w+");
////                if (!fpp){
////                    printf("fopen file error\n");
////                }
////                __block FILE *fp = fpp;
////                fseek(fp, 0L, SEEK_END);
////
////                [_inputAudio InitAudio:&_audio_fmt :120*8 :^(const void *frame, int size, int index, const AudioTimeStamp *time, void *userdata){
////                    if (talkOpened) {
////                        
////                        //todo test begin
////                        unsigned char encodeBuf[512 * 1024];
////                        char *buf = encodeBuf;
////                        memset(buf, 0x00, sizeof(buf));
////                        g726_Encode((unsigned char*)frame, buf);
////                        
////                        /*
////                        unsigned char decodeBuf[512 * 1024];
////                        char *buf2 = decodeBuf;
////                        memset(buf2, 0x00, sizeof(buf2));
////                        g726_Decode(buf, buf2);
////                        [self callBackFrame:buf2 Len:960];
////                         */
////                        //NSLog(@"fopen file ok");
////                        //fseek(fp, 0L, SEEK_END);
////                        //NSLog(@"fseek file ok");
////                        long readLen = fwrite(buf, 120, 1, fp);
////
////                        //long fileSize = ftell(fp);
////                        //printf("ftell file ok, fileSize:%ld\n", fileSize);
////                        
////                        
////                        //readLen = fread(data, fileSize,1, fp);
////                        //size_t	 fread(void * __restrict __ptr, size_t __size, size_t __nitems, FILE * __restrict __stream);
////                        
////                        //NSLog(@"readLen  = %ld",readLen);
////                        
////                        //end
////                        
////                        [[FSNetService sharedNetService] sendTalkData_sync:playerHandle :(char*)frame dataLen:size];
////                    }
////                } :NULL];
//            }
//
//            NSString * docDir = [NSString documentPath];
//            NSString * playName = [NSString stringWithFormat:@"%@/play.xx",docDir];
//            NSError * error = nil;
//            //必须真机上测试,模拟器上可能会崩溃
//            recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:playName] settings:recorderSettingsDict error:&error];
//            
//            if (recorder) {
//                recorder.meteringEnabled = YES;
//                [recorder prepareToRecord];
//                [recorder record];
//            }
//            //启动定时器
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (sender.state ==UIControlStateNormal ) {
//                    return ;
//                }
//                soundView.hidden = NO;
//                timerTalk = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(soundLevelTimer:) userInfo:nil repeats:YES];
//            });
//
//        }else{
//            talkOpened = NO;
//            [self showMessage:FSLocalizedString(@"FS_Live_Talk_Open_Fial") wihtStyle:ALAlertBannerStyleNotify];
//        }
//    });
//    
//}
//
////test begin
//- (void)callBackFrame:(unsigned char *)buf Len:(int)len{
//    
//    if ([_outputAudio IsInit]) {
//        [_outputAudio WriteData:buf : len];
//    }else{
//        if (![_outputAudio IsInit]) {
//            assert([_outputAudio InitAudio:&_audio_fmt : MAXAUDIOBUF]);
//        }
//        [_outputAudio AudioStart];
//    }
//}
////test end
//
//- (void)closeTalk:(UIButton *)sender
//{
//    if (_productAllInfoModel.talkFlag == 0 )//不支持对讲
//    {
//        return;
//    }
//    [timerTalk invalidate]; timerTalk =nil;
//    recorder =nil;
//    soundView.hidden =YES;
//    
//    if (iOrientation !=0) {
//        [self setBtnFullViewTimer];
//    }
//    
//    if (!hdTableView.hidden) {
//        hdTableView.hidden =YES;
//    }
//    if (!listTableView.hidden) {
//        listTableView.hidden =YES;
//    }
//    
//    if (!connectSuc) {
//        [self showMessage:FSLocalizedString(@"FS_Live_NotConnect") wihtStyle:ALAlertBannerStyleFailure];
//        return;
//    }
//    
//    if (!talkOpened) {
//        return;
//    }
//    
//    if (isDoubSound) {
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            FOSCMD_RESULT ret = [[FSNetService sharedNetService] closeTalk_sync:playerHandle timeout:1000];
//            FSLog(@"\ntalkCloseRet------------ : %d\n", ret);
//            if (ret == FOSCMDRET_OK) {
//                [_openAlAec CloseTalk];
//                talkOpened =NO;
//                if (!audioOpened) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self soundAction:soundBtn];
//                        
//                    });
//                }
//                
//            }else{
//                talkOpened =YES;
//                [self showMessage:FSLocalizedString(@"FS_Live_Talk_Close_Fial") wihtStyle:ALAlertBannerStyleNotify];
//            }
//        });
//        
//    }else{
//        
////        if (_inputAudio) {
////            [_inputAudio ReleaseAudio];
////        }
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            FOSCMD_RESULT ret =[[FSNetService sharedNetService] closeTalk_sync:playerHandle timeout:1000];
//            FSLog(@"\ntalkCloseRet------------ : %d\n", ret);
//            if (ret == FOSCMDRET_OK) {
//                //松开对讲后听筒回到之前的状态
//                talkOpened =NO;
//                if (!audioOpened) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self soundAction:soundBtn];
//                    });
//                    
//                }else if (audioOpened) {
//                    if (![_outputAudio IsInit]) {
//                        assert([_outputAudio InitAudio:&_audio_fmt : MAXAUDIOBUF]);
//                    }
//                    [_outputAudio AudioStart];
//                    if (soundBtn) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [soundBtn setSelected:YES];
//                        });
//                    }
//                }
//
//            }else{
//                talkOpened =YES;
//                [self showMessage:FSLocalizedString(@"FS_Live_Talk_Close_Fial") wihtStyle:ALAlertBannerStyleNotify];
//            }
//        });
//    }
//}
//
//-(void)soundLevelTimer:(NSTimer*)timer
//{
//    //call to refresh meter values刷新平均和峰值功率,此计数是以对数刻度计量的,-160表示完全安静，0表示最大输入值
//    [recorder updateMeters];
//    const double ALPHA = 0.05;
//    double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
//    lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
//
//    if(lowPassResults>=0.8){
//        soundImageView.image = [UIImage imageNamed:[volumImages objectAtIndex:4]];
//    }else if(lowPassResults>=0.6){
//        soundImageView.image = [UIImage imageNamed:[volumImages objectAtIndex:3]];
//    }else if(lowPassResults>=0.4){
//        soundImageView.image = [UIImage imageNamed:[volumImages objectAtIndex:2]];
//    }else if(lowPassResults>=0.2){
//        soundImageView.image = [UIImage imageNamed:[volumImages objectAtIndex:1]];
//    }else{
//        soundImageView.image = [UIImage imageNamed:[volumImages objectAtIndex:0]];
//    }
//}
//
//- (void)loadVideo
//{
//    playerHandle = playerModel.mHandle;
//    if (self.connectTime > 2) {
//        if (iOrientation ==1 || iOrientation ==2) {
//            [self showStatusAndNavBar];
//            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//            sleep(1.5f);
//        }
//        TroubleshootingViewController *vc = [[TroubleshootingViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else {
//        _activityIndicatorView.userInteractionEnabled =NO;
//        [_activityIndicatorView startAnimating:YES];
//        [self connectCamera];
//        DDLogInfo(@"\nopenConnect end\n");
//    }
//}
//
//// 连接失败后的系列操作
//- (void)connectFaild
//{
//    self.connectTime ++;
//    connectSuc = NO;
//    if (!_activityIndicatorView.isAnimating) {
//        [_activityIndicatorView startAnimating:YES];
//    }
//    _videoScrollView.imageView.image = nil;//连接失败清屏操作
//    _activityIndicatorView.userInteractionEnabled = YES;
//    if (self.connectTime > 2) {
//        _activityIndicatorView.errorImage = [UIImage imageNamed:@"live_FAQ.png"];
//        [_activityIndicatorView stopAnimatingWithError:FSLocalizedString(@"FS_Live_Play_Fail_FAQ")];
//    }else{
//        _activityIndicatorView.errorImage = [UIImage imageNamed:@"live_Refresh_nor.png"];
//        [_activityIndicatorView stopAnimatingWithError:FSLocalizedString(@"FS_Live_Play_Fail")];
//    }
//    [[FSNetService sharedNetService] releaseIpcDevice:playerModel];
//}
//
//#pragma mark - 固件升级相关
//- (void)didFinishUpgrade
//{
//    [redImageView removeFromSuperview];
//}
//
//- (void)checkPortalUpgradeWithFirmwareVersion:(NSString *)firmwareVersion
//                              hardWareVersion:(NSString *)hardWareVersion
//                                  productName:(NSString *)productName{
//    
//    if (playerModel.productModel.hasPortalUpgrade == CameraSupportUnkown) {
//        
//        [PortalUpgradeManager checkPortalUpgradeWithFirmwareVersion:firmwareVersion
//                                                    hardWareVersion:hardWareVersion
//                                                        productName:productName
//                                                       onCompletion:^(NSString *errorCode, NSArray *portals)
//        {
//                                                           
//            NSLog(@"...Finished Check!");
//            // Error
//            if (errorCode.length > 0)
//            {
//               NSLog(@"___Check Error...");
//               // 记录是否需要固件升级
//               playerModel.productModel.hasPortalUpgrade = CameraSupportFalse;
//            }
//            else
//            {
//               // No Update
//               if (portals == nil || portals.count == 0)
//               {
//                   NSLog(@"No Update start...");
//                   // 记录是否需要固件升级
//                   playerModel.productModel.hasPortalUpgrade = CameraSupportFalse;
//               }
//               // Have Update
//               if (portals.count > 0)
//               {
//                   // 记录是否需要固件升级
//                   playerModel.productModel.hasPortalUpgrade = CameraSupportTrue;
//               }else{
//                   // 记录是否需要固件升级
//                   playerModel.productModel.hasPortalUpgrade = CameraSupportFalse;
//               }
//               
//            }
//
//            [self checkIPCWIFI];
//    
//        }];
//        
//    }
//    else{
//        
//        [self checkIPCWIFI];
//    }
//}
//
//-(void)checkIPCWIFI {
//    
//    BOOL hasWiFiConfig = NO;
//    
//    ProductAllInfoModel *productModel = playerModel.productModel;
//    if (productModel && productModel.isEnableWiFi) {
//        NSString *deviceMac = playerModel.cloudModel.deviceMac;
//        NSString *key = [NSString stringWithFormat:@"%@_WiFi_NotSet", deviceMac];
//        id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//        if (value) {
//            hasWiFiConfig = [value boolValue];
//        }
//    }
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (hasWiFiConfig || (CameraSupportTrue == productModel.hasPortalUpgrade)) {
//            redImageView.hidden = NO;
//        } else {
//            redImageView.hidden = YES;
//        }
//    });
//}
//
//- (void)fetchStorageInformation {
//    
//    if (SharedAppDelegate.bIsChina) return;
//    
//    if (!playerModel.permissionModel) {
//        playerModel.permissionModel = [PermissionModel new];
//    }
//    
//    // 授权状态未知，获取授权记录
//    if (PermissionUnknown == playerModel.permissionModel.status) {
//        [self fetchPermissionGroup];
//    }
//    
//    // 存在有效授权记录或有有效录像，并且dateSet为0时，获取存在录像的日期
//    if ((PermissionValid == playerModel.permissionModel.status || PermissionVideo == playerModel.permissionModel.status) &&
//        (0 == [self.dateSet count])) {
//        [self fetchVideoDates];
//    }
//    
//    [self.videoView reload];
//}
//
//- (void)fetchPermissionGroup {
//    
//    NSString *deviceMac = playerModel.cloudModel.deviceMac;
//    if (deviceMac.length != 0 && [FSUserAccountManager isLogin]) {
//        [self.webClient queryGroupWithType:WebClientQueryGroup baseURLString:SharedAppDelegate.serviceAddress deviceMac:deviceMac grantGroup:kWebClientSTOREVIDEO];
//    }
//}
//
//- (void)fetchVideoDates {
//    
//    // 获取存在录像的天数
//    NSString *deviceMac = playerModel.cloudModel.deviceMac;
//    NSString *baseURLString = [VideoPortalManager storeUrl];
//    NSString *sessionToken = [SignModelManager sign];
//    NSString *timestamp = [SignModelManager expire];
//    
//    [self.webClient queryVideoDatesWithType:WebClientQueryVideoDates baseURLString:baseURLString deviceMac:deviceMac sessionToken:sessionToken timestamp:timestamp];
//}
//
//#pragma mark - Dealloc
//- (void)dealloc
//{
//    if (isDoubSound) {
//        if (_openAlAec) {
//            [_openAlAec Quit];
//            _openAlAec = nil;
//        }
//    }else{
//        if (_inputAudio) {
//            [_inputAudio ReleaseAudio];
//        }
//        
//        if (_outputAudio) {
//            [_outputAudio ReleaseAudio];
//        }
//    }
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:_videoScrollView.imageView];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//    [_webClient invalidateSessionCancelingTasks:YES];
//    
//}
////注册监听消息
//- (void)registerForNSNotification
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(applicationDidEnterBackground:)
//                                                 name:UIApplicationDidEnterBackgroundNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(applicationWillEnterForeground:)
//                                                 name:UIApplicationWillEnterForegroundNotification
//                                               object:nil];
//}
//#pragma mark - 音视频流开启关闭
//// 关闭视频流
//- (void)stopVideoStream:(BOOL)bReleaseAPI
//{
//    threadQuit = YES;
//    connectSuc = NO;
//    [self removeLiveTimer];
//    
//    usleep(50*1000);//等待线程退出
//
//    if (self.ptzCView.superview) {
//        ptzBtn.selected = NO;
//        [self.ptzCView removeFromSuperview];
//        self.ptzCView = nil;
//    }
//    
//    if (ptzFullView) {
//        ptzFullView.hidden = YES;
//    }
//    if (moreView) {
//        DetectionBool = YES;
//        moreView.hidden = YES;
//        [moreBtn setSelected:NO];
//    }
//    
//    //移除Login通知
//    [self removeLoginNotificationWithDeviceMac:playerModel.cloudModel.deviceMac];
//    /*
//     *取消解码器
//    if (_decoder) {
//        NSLog(@"stopvideo deinitVideoDecode========");
//        [_decoder deinitVideoDecode];
//        _decoder = nil;
//    }*/
//    //流量显示隐藏
//    [self stopTrafficTimer];
//    [trafficBtn setTitle:@" 0.0KB" forState:UIControlStateNormal];
//    trafficBtn.hidden =YES;
//    //停止录像
//    if (isRecording) {
//        isRecording = NO;
//        [recordBtn setSelected:NO];
//        [self stopRecordShow];
//        [[FSNetService sharedNetService] stopRecord_sync:playerHandle];
//    }
//    //停止视频
//    FOSCMD_RESULT ret = [[FSNetService sharedNetService] closeVideo_sync:playerHandle timeout:1000];
//    NSLog(@"RETCloseVideo ret = %d,playerHandle = %d",ret,playerHandle);
//    DDLogInfo(@"RETCloseVideo ret = %d,playerHandle = %d",ret,playerHandle);
//    //停止音频
//    if (audioOpened)
//    {
//        audioOpened = NO;
//        [soundBtn setSelected:NO];
//        [_outputAudio AudioStop];        
//        FOSCMD_RESULT retAudio = [[FSNetService sharedNetService] closeAudio_sync:playerHandle timeout:1000];
//        DDLogInfo(@"stopvideo retAudio = %d",retAudio);
//        DDLogInfo(@"stopvideo retAudio = %d",retAudio);
//    }
//    //停止回音消除
//    if (isDoubSound ==1) {
//        if (_openAlAec) {
//            [_openAlAec Quit];
//        }
//        while (playAudioThreadState == THREAD_CREATE || talkThreadState == THREAD_CREATE)
//        {
//            usleep(10*1000);
//        }
//        if (_openAlAec) {
//            _openAlAec = nil;
//        }
//    }
//
//    if (bReleaseAPI == YES) {
//        [self performSelector:@selector(freeDecoder:) withObject:@"list" afterDelay:0.5f];
//    }else{
//        [self performSelector:@selector(freeDecoder:) withObject:@"moreList" afterDelay:0.5f];
//    }
//
//}
//
//- (void)freeDecoder:(NSString *)string{
//    
//    //释放内存
//    if (videoBuf != NULL && !noBackgroundFree) {
//        NSLog(@"videoBuf free");
//        free(videoBuf);
//        videoBuf = NULL;
//    }
//    
//    //取消解码器
//    if (_decoder && !noBackgroundFree) {
//        NSLog(@"freeDecoder deinitVideoDecode========");
//        [_decoder deinitVideoDecode];
//        _decoder = nil;
//    }
//    
//    if ([string isEqualToString:@"moreList"]) {
//        
//        [self changeDevice];
//    }
//}
//
////切换设备
//-(void)changeDevice{
//    listTableView.hidden =YES;
//    [self.videoScrollView.imageView setImage:nil];
//    playerModel =listDataSource[_currentIndex];
//    playerHandle =playerModel.mHandle;
//    [self setTopNavView];
//    [self loadVideo];
//    
//    // 更换设备，重新获取云存储相关信息
//    self.dateSet = nil;
//    [self fetchStorageInformation];
//}
//
//- (void)Runblock :(FunBlock)fun{
//    fun(nil);
//}
//
////解码器初始化
//- (void)initDecoder
//{
//    NSLog(@"initDecoder===============");
//    if (_decoder) {
//        [_decoder deinitVideoDecode];
//        _decoder = nil;
//    }
//    __block FSLivePlayViewController* weakSelf = self;
//    
//    _decoder = [[FSHWDecoder alloc] init];
//    [_decoder initDecoder:^(CVImageBufferRef imageBuffer) {
//        [weakSelf displayImage:imageBuffer];
//    }];
//    //硬解码创建失败回调,切换到软解码
//    [_decoder decoderFaile:^(BOOL decoderFal){
//        decoFaile =decoderFal;
//    }];
//}
//
//- (void)DecodePlay:(FOSDEC_DATA*)pFrameDe withData:(uint8_t *)frame withSize:(uint32_t)frameSize isIFrame:(int)isIFrame
//{
//    if (!_decoder) {
//        [self initDecoder];
//    }else{
//        [_decoder receivedRawVideoFrame:pFrameDe withData:(unsigned char*)pFrameDe->data withSize:pFrameDe->len isIFrame:pFrameDe->isKey];
//    }
//}
////流量控制
//#pragma mark - web traffic
//- (void)startWebTraffic{
//
//    if (trafficBtn.hidden == YES) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            trafficBtn.hidden =NO;
//            trafficTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countWebTraffic) userInfo:nil repeats:YES];
//        });
//    }
//    
//}
//- (void)stopTrafficTimer{
//    if (trafficTimer){
//        [trafficTimer invalidate];
//        trafficTimer = nil;
//    }
//}
//- (void)countWebTraffic{
//    trafficTimerEnd = [[NSDate date] timeIntervalSince1970];
//    double mediaSpd =0;
//    if (trafficTimerEnd -trafficTimerStart >=3) {
//        //清理数组
//        [spdArray removeAllObjects];
//    }else{
//        //取数组平均值
//        if ([spdArray count] >=10) {
//            [spdArray removeObjectAtIndex:0];
//            [spdArray addObject:[NSString stringWithFormat:@"%f",trafficCount]];
//            for (int index =0; index <[spdArray count]; ++index) {
//                mediaSpd +=[spdArray[index] doubleValue];
//            }
//        }else{
//            [spdArray addObject:[NSString stringWithFormat:@"%f",trafficCount]];
//            for (int index =0; index <[spdArray count]; ++index) {
//                mediaSpd +=[spdArray[index] doubleValue];
//            }
//        }
//        mediaSpd =mediaSpd/[spdArray count];
//    }
//    
//    NSString *traffic =[self textForNetworkTitle:mediaSpd];
//    float widTraffic =[CommonMode getWidthSize:traffic andFontOfSize:SysFontOfSize_12 andFontName:0];
//    trafficBtn.frame =CGRectMake(SCREEN_WIDTH -(widTraffic +20)-10, 10, widTraffic +20, 19.f);
//    [trafficBtn setTitle:traffic forState:UIControlStateNormal];
//}
//
//-(NSString *)textForNetworkTitle:(int)trafficPerSecond{
//    
//    CGFloat fKb =trafficPerSecond / 1024.f;
//    NSString *text =nil;
//    if (fKb > 1024.f) {
//        CGFloat fMb = fKb /1024.f;
//        if (fMb <10.f) {
//            text =[NSString stringWithFormat:@" %4.2fMB",fMb];
//        }else{
//            text =[NSString stringWithFormat:@" %4.1fMB",fMb];
//        }
//    }else{
//        if (fKb <100.f) {
//            text =[NSString stringWithFormat:@" %4.1fKB",fKb];
//        }else{
//            text =[NSString stringWithFormat:@" %4.0fKB",fKb];
//        }
//    }
//    return text;
//}
//
//#pragma mark - 处理登录结果
////处理FosSdk_Login的结果
//- (void)handleFosSDKLoginCommandResult:(FOSCMD_RESULT)cmdResult usrPrivilege:(NSInteger)usrPrivilege{
//    
//    playerHandle = playerModel.mHandle;
//    //处理结果
//    if (FOSCMDRET_OK == cmdResult){//登录成功
//        NSString * user =playerModel.cloudModel.username;
//        NSString * password =playerModel.cloudModel.password;
//        DDLogInfo(@"admin user =%@,password =%@",user,password);
//        if ([user isEqualToString:@"admin"] && [password length] ==0) {
//            //进入强制修改密码界面
//            ForceViewController *vc = [[ForceViewController alloc] initWithCameraModel:playerModel];
//            [self.navigationController pushViewController:vc animated:YES];
//            
//        }else if (!threadQuit) {
//            //openVideo getVideodata 同步进行
//            liveTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(getVideoDataFail) userInfo:nil repeats:YES];
//            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                
//                [self openVideo];   //openvideo结果
//
//            });
//            
//            //打开视频流
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                
//                [self livePlay];//getVideodata数据流
//                
//            });
//            
//        }
//    }else{//登录失败
//        DDLogInfo(@"设备登录失败 Error cmdResult = %ld", (long)cmdResult);
//        [self loginFailed:cmdResult];//处理登录失败
//    }
//}
//
//- (void)getVideoDataFail{
//    
//    liveInt++;
//    if (liveInt >= 30) {
//        NSLog(@"get data...liveInt = %d",liveInt);
//        [self removeLiveTimer];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            int usrPrivilege = 0;
//            FOS_HANDLE_STATE ret = FosSdk_CheckHandle(playerHandle, &usrPrivilege);
//            
//            if (ret != FOS_HANDLE_ONLINE) {
//                
//                [self connectFaild];//连接失败
//            }
//        });
//    }
//}
//
//- (void)removeLiveTimer{
//    if (liveTimer) {
//        NSLog(@"removeLiveTimer liveTimer");
//        [liveTimer invalidate];
//        liveTimer = nil;
//        liveInt = 0;
//    }
//}
//
//#pragma mark - Open Video
//- (void)openVideo{
//
//    DDLogInfo(@"openVideo start handle =%d,streamType = %d",playerHandle,((playerModel.streamType==0)?FOSSTREAM_MAIN:FOSSTREAM_SUB));
//    NSLog(@"openVideo start handle =%d,streamType = %d",playerHandle,((playerModel.streamType==0)?FOSSTREAM_MAIN:FOSSTREAM_SUB));
//    FOSCMD_RESULT openVideoRet = FosSdk_OpenVideo(playerHandle, ((playerModel.streamType==0)?FOSSTREAM_MAIN:FOSSTREAM_SUB), 3000);
//
//    if (FOSCMDRET_OK == openVideoRet && !threadQuit) {
//        
//        DDLogInfo(@"openVideo Success handle = %d",playerHandle);
//        NSLog(@"openVideo Success handle = %d",playerHandle);
//
//        [self removeLiveTimer];
//        [self startWebTraffic];
//
//    }
//    else if (FOSCMDRET_UNKNOW == openVideoRet){
//        DDLogInfo(@"openVideo result FOSCMDRET_UNKNOW error 8 handle = %d",playerHandle);
//        [self connectFaild];//连接失败
//    }else{
//        DDLogInfo(@"openVideo threadQuit ret = %d handle = %d",openVideoRet,playerHandle);
//    }
//}
//
//#pragma mark - Live Play
////播放视频流
//- (void)livePlay{
//    
//    int outLen = 0;
//    int mediaSpeed =0;
//    FosSdk_ResetMediaSpeed(playerHandle);
//
//    decoFaile = NO;
//    FSNetService *netService = [FSNetService sharedNetService];
//    float iosVersion = IOS_VERSION;
//    float screenH = SCREEN_HEIGHT;
//
//    while (!threadQuit)
//    {
//        if (videoBuf == NULL && iosVersion >= 8.0 && screenH > 480.f) {
//            DDLogInfo(@"malloc videoBuf");
//            videoBuf =  malloc(kSizeOfVideoBuffer);//开辟内存
//            memset(videoBuf, 0x00, kSizeOfVideoBuffer);
//            pFrame = (FOSDEC_DATA*)videoBuf;
//        }
//        outLen =0;
//        if (iosVersion >= 8.0 && screenH > 480.f && !decoFaile) {
//            FOSCMD_RESULT rawVideoResult = [netService getRawVideo_sync:playerHandle :videoBuf :kSizeOfVideoBuffer :&outLen :&mediaSpeed];
//            if ((FOSCMDRET_OK == rawVideoResult) && (outLen > 0))
//            {
//                DDLogInfo(@"get raw video data success handle = %d, outLen = %d, mediaSpeed = %d, isKey = %d",playerHandle,outLen,mediaSpeed,pFrame->isKey);
//                if (0 == oneTime) {
//                    NSLog(@"get data....");
//                    [self removeLiveTimer];
//                    oneTime =1;
//                    [self initDecoder];
//                    [self startWebTraffic];//流量显示
//                    [self getProductAllInfo];
//                    [self getDeviceInfo];
//                }
//                if (isPreRecording) {
//                    isPreRecording = NO;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self recordAction:recordBtn];
//                    });
//                }
//                connectSuc =YES;
//                trafficTimerStart = [[NSDate date] timeIntervalSince1970];
//                trafficCount =mediaSpeed;
//                if (videoBuf != NULL && pFrame != NULL) {
//                    
//                    if (!decodeBool) {
//                        widthImage = pFrame->media.video.picWidth;
//                        hightImage = pFrame->media.video.picHeight;
//                        decodeBool = YES;
//                    }
//                    
//                    if (widthImage != pFrame->media.video.picWidth || hightImage != pFrame->media.video.picHeight) {
//                        widthImage = pFrame->media.video.picWidth;
//                        hightImage = pFrame->media.video.picHeight;
//                     
//                        [self initDecoder];
//                        continue;
//                    }
//
//                    [self DecodePlay:pFrame withData:(unsigned char*)pFrame->data withSize:pFrame->len isIFrame:pFrame->isKey];
//                }
//            
//            }else{
//                usleep(20*1000);
//            }
//        }else{
//            FOSCMD_RESULT ret = [netService getVideoData_sync:playerHandle :(char**)&pFrame :&outLen :FOSDECTYPE_RGB24 :&mediaSpeed];
//            if (FOSCMDRET_OK == ret && pFrame !=NULL && pFrame->len > 0 && FOSMEDIATYPE_VIDEO == pFrame->type)
//            {
//                if (0 == oneTime) {
//                    DDLogInfo(@"get video data success handle = %d",playerHandle);
//                    NSLog(@"get data....");
//                    [self removeLiveTimer];
//                    oneTime =1;
//                    [self getProductAllInfo];
//                    [self getDeviceInfo];
//                    [self startWebTraffic];//流量显示
//                    
//                }
//                if (isPreRecording) {
//                    isPreRecording = NO;
//                    [self recordAction:recordBtn];
//                }
//                trafficTimerStart = [[NSDate date] timeIntervalSince1970];
//                trafficCount =mediaSpeed;
//                [self imageFromAVPicture:pFrame->data width:pFrame->media.video.picWidth height:pFrame->media.video.picHeight];
//            }else{
//                usleep(20*1000);
//            }
//        }
//    }
//}
//
//#pragma mark - 获取 设备相关信息(ProductAllInfo && DevInfo)
//-(void)getProductAllInfo{
//    if (playerModel.productModel) {
//        _productAllInfoModel =playerModel.productModel;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self showLiveTips];
//        });
//        
//        [self runAudioAndEvent:playerModel];
//        return;
//    }
//    //获取设备配置信息
//    [self fetchProductAllInfoWithResultBlock:^(BOOL bOperation) {
//        if (bOperation){//获取成功
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self showLiveTips];
//            });
//            [self runAudioAndEvent:playerModel];
//        }else{//获取失败
//            FSLog(@"###获取设备信息失败");
//        }
//    }];
//}
//
//- (void)showLiveTips {
//    // 新手指引
//    DirectionModel *directionModel = [DirectionHelper sharedInstance].directionModel;
//    if (directionModel.deviceLoginDirection && !threadQuit) {
//        // 国内无云存储点击按钮
//        NSArray *directionViews = (SharedAppDelegate.bIsChina) ? (@[[LivePlayZoomInView new], [LivePlayZoomOutView new], [LiveSettingsDirectionView new]]) : (@[[LivePlayZoomInView new], [LivePlayZoomOutView new], [LiveHistoryDirectionView new], [LiveSettingsDirectionView new]]);
//        [self showDirectionViews:directionViews];
//        directionModel.deviceLoginDirection = NO;
//    } else {
//        [self getAdProductsConfig];
//    }
//}
//
////广告弹窗提示购买产品
//- (void)getAdProductsConfig{
//    if (_adNoteView == nil || _adNoteView.hidden == YES) {
//        [self queryAdProductsService];
//    }
//}
//
///**
// * 获取设备ProductAllInfo 信息
// * resultBlock:YES:成功 NO:失败
// */
//- (void)fetchProductAllInfoWithResultBlock:(void (^)(BOOL bOperation))resultBlock{
//    [[ProductAllInfoHelper sharedInstance] fetchProductAllInfoModelWithDeviceHandle:playerHandle onCompletion:^(FOSCMD_RESULT cmdResult, id result) {
//        if (FOSCMDRET_OK == cmdResult){
//            _productAllInfoModel = (ProductAllInfoModel *)result;
//            playerModel.productModel = _productAllInfoModel;//获取并保存ProductAllInfoModel信息
//            NSDictionary *modelDict = [_productAllInfoModel dict];
//            DDLogInfo(@"播放界面获取FosSdk_GetProductAllInfo成功，productAllInfo = %@",modelDict);
//            if (resultBlock){
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    resultBlock(YES);
//                });
//            }
//        }else{
//            DDLogInfo(@"播放界面获取FosSdk_GetProductAllInfo失败，cmdResult = %u",cmdResult);
//            if (resultBlock){
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    resultBlock(NO);//获取失败，结果回掉
//                });
//            }
//        }
//    }];
//}
////获取设备DevInfo 信息
//- (void)getDeviceInfo{
//    if (playerModel.deviceModel) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            DDLogInfo(@"播放界面存在deviceModel");
//            _devInfoModel =playerModel.deviceModel;
//            [self checkPortalUpgradeWithFirmwareVersion:_devInfoModel.firmwareVer hardWareVersion:_devInfoModel.hardwareVer productName:_devInfoModel.productName];//检测是否存在固件升级(设置red dot)
//        });
//    }else{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            FOS_DEVINFO devInfo;
//            FOSCMD_RESULT cmdResult = FosSdk_GetDevInfo(playerHandle, 1000, &devInfo);
//            if (FOSCMDRET_OK == cmdResult && ![@"-1" isEqualToString:[NSString stringWithFormat:@"%s",devInfo.mac]]){
//                _devInfoModel = [[DevInfoModel alloc] instanceWithFOS_DEVINFO:&devInfo];
//                playerModel.deviceModel =_devInfoModel;
//                NSDictionary *modelDict = [_devInfoModel dict];
//                DDLogInfo(@"播放界面获取FosSdk_GetDevInfo成功 cmdResult = %d，devInfo = %@",cmdResult,modelDict);
//                //FSLog(@"...获取到_devInfoModel = %@", _devInfoModel);
//                [self checkPortalUpgradeWithFirmwareVersion:_devInfoModel.firmwareVer hardWareVersion:_devInfoModel.hardwareVer productName:_devInfoModel.productName];//检测是否存在固件升级(设置red dot)
//                NSLog(@"livePlay checkPortalUpgradeWithFirmwareVersion");
//            }else{
//                DDLogInfo(@"播放界面获取FosSdk_GetDevInfo失败 cmdResult = %d",cmdResult);
//            }
//        });
//    }
//}
//
//#pragma mark - Login Notification
///**
// * 注册Login通知消息
// */
//- (void)registerLoginNotificationWithDeviceMac:(NSString *)deviceMac{
//    NSString *key = deviceMac;//通知名称
//    FSLog(@"...register LoginNotification DeviceMac:%@", deviceMac);
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoginNotification:) name:key object:nil];
//}
//
///**
// * 移除Login通知消息
// */
//- (void)removeLoginNotificationWithDeviceMac:(NSString *)deviceMac{
//    NSString *key = deviceMac;//通知名称
//    FSLog(@"...remove LoginNotification DeviceMac:%@", deviceMac);
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:key object:nil];
//}
//
///**
// * 处理通知消息
// */
//- (void)handleLoginNotification:(NSNotification *)not{
//    
//    FSLog(@"...Login Notification:%@", not.userInfo);
//    [self removeLoginNotificationWithDeviceMac:playerModel.cloudModel.deviceMac];
//
//    FOSCMD_RESULT cmdResult = (FOSCMD_RESULT)[not.userInfo[@"loginStatus"] integerValue];
//    NSInteger usrPrivilege = [not.userInfo[@"usrPrivilege"] integerValue];
//    
//    [self handleFosSDKLoginCommandResult:cmdResult usrPrivilege:usrPrivilege];
//}
////连接摄像机开始
//- (void)connectCamera
//{    
//    threadQuit =NO;
//    oneTime =0;
//    int usrPrivilege = 0;
//    FOS_HANDLE_STATE ret = FosSdk_CheckHandle(playerHandle, &usrPrivilege);
//    if (FOS_HANDLE_ONLINE == ret){//设备在线，直接播放
//        DDLogInfo(@"设备在线，进入视频播放流程 handle = %d, ret = %d",playerHandle, ret);
//        [self handleFosSDKLoginCommandResult:FOSCMDRET_OK usrPrivilege:usrPrivilege];
//    }else{//设备不在线
//        
//        if (FOS_HANDLE_INIT != ret && FOS_HANDLE_CONNECTTING != ret){
//            DDLogInfo(@"设备未连接，断开重新连接,添加通知事件，handle = %d, ret = %d",playerHandle, ret);
//            [self registerLoginNotificationWithDeviceMac:playerModel.cloudModel.deviceMac];//注册通知
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [[FSNetService sharedNetService] loginToIpcNew:playerModel timeout:3000];
//            });
//        }else{
//            DDLogInfo(@"设备未连接,等待CheckHandle消息 handle = %d, ret = %d",playerHandle, ret);
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                while (!threadQuit) {
//                    int usrPrivilege2 = 0;
//                    FOS_HANDLE_STATE ret2 = FosSdk_CheckHandle(playerHandle, &usrPrivilege2);
//                    if (FOS_HANDLE_ONLINE == ret2) {
//                        DDLogInfo(@"ret2 FOS_HANDLE_ONLINE");
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self handleFosSDKLoginCommandResult:FOSCMDRET_OK usrPrivilege:usrPrivilege2];
//                        });
//                        break;
//                        
//                    }else if (FOS_HANDLE_INIT != ret2 && FOS_HANDLE_CONNECTTING != ret2 && FOS_HANDLE_ONLINE != ret2) {
//                        DDLogInfo(@"ret2 connectFaild = %d", ret2);
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            if (ret2 == FOS_HANDLE_ONLINE_USRORPWDERR) {
//                                
//                                [self connectFaild];
//                                [self gotoSecuritySettingsViewController];
//
//                            }else{
//                                [self connectFaild];
//                            }
//                        });
//                        break;
//                    }
//                    usleep(1000 *1000);
//                    
//                }
//            });
//        }
//    }
//}
////音频服务
//- (void)runAudioAndEvent:(CameraModel *)devInfo{
//    if (_productAllInfoModel.talkFlag != 0 )
//    {
//        //FOSCMD_RESULT retDuplexVoice =FosSdk_CheckDuplexVoice(_deviceinfo.mhandel, 1000, &isDoubSound);
//        BOOL retDuplexVoice = [[ProductAllInfoHelper sharedInstance] isEnableDuplexVoiceWithProductAllInfoModel:_productAllInfoModel];
//        isDoubSound =retDuplexVoice?1:0;
//        if (isDoubSound ==1 && !threadQuit) {
//            isDoubSound =1;
//            if (!_openAlAec) {
//                _openAlAec = [[OpenAl_aec alloc] init];
//            }
//            [_openAlAec setCall:^BOOL(void *userdata, char **data, int *len) {
//                if (threadQuit == YES) {
//                    return NO;
//                }
//                FOSDEC_DATA* pFrame = NULL;
//                int outLen = 0;
//                if ( FOSCMDRET_OK == FosSdk_GetAudioData(playerHandle, (char **)&pFrame, &outLen) ){
//                    *len = pFrame->len;
//                    *data = pFrame->data;
//                    return YES;
//                }
//                return NO;
//            } talk:^(const void *frame, int size, int index, void *userdata) {
//                FosSdk_SendTalkData(playerHandle, (char*)frame, size);
//            } usrdata:nil];
//            
//            playAudioThreadState = THREAD_CREATE;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [_openAlAec RunAlTalk];
//                playAudioThreadState = THREAD_QUIT;
//            });
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                talkThreadState = THREAD_CREATE;
//                [_openAlAec SendTalkData];
//                talkThreadState = THREAD_QUIT;
//            });
//        }else{
//            isDoubSound =0;
//            [self initAudioFmt];
//            FOSDEC_DATA* pFrame = NULL;
//            int len = 0;
//            int mediaSpeed =0;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                while (!threadQuit) {
//                    FOSCMD_RESULT ret = [[FSNetService sharedNetService] getAudioData_sync:playerHandle :(char**)&pFrame :&len :&mediaSpeed];
//                    if (FOSCMDRET_OK == ret && len > 0 && pFrame && !threadQuit) {
//                        if ([_outputAudio IsInit]) {
//                            NSLog(@"pFrame->len = %d",pFrame->len);
//                            [_outputAudio WriteData:pFrame->data : pFrame->len];
//                        }
//                    }else{
//                        usleep(20*1000);
//                    }
//                }
//            });
//        }
//    }
//    //EventRun事件循环操作
//    [self EventRun:playerHandle];
//}
//
////登录失败处理
//-(void)loginFailed:(int)iRet{
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_activityIndicatorView stopAnimating];
//    });
//    switch (iRet)
//    {
//        case FOSCMDRET_TIMEOUT:
//        {
//            [self showMessage:FSLocalizedString(@"FS_Foscam_Timeout") wihtStyle:ALAlertBannerStyleFailure];
//            FSLog(@"...SDK Timeout...");
//            [self performSelectorOnMainThread:@selector(connectFaild) withObject:nil waitUntilDone:NO];
//        }
//            break;
//            
//        case FOSCMDRET_EXCEEDMAXUSR:
//        {
//            [self showMessage:FSLocalizedString(@"FS_Foscam_EXCEED_MAX_USER") wihtStyle:ALAlertBannerStyleFailure];
//            [self performSelectorOnMainThread:@selector(connectFaild) withObject:nil waitUntilDone:NO];
//        }
//            break;
//            
//        case FOSCMDRET_USRNOTEXIST:
//        case FOSUSRRET_USRNAMEORPWD_ERR:
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [self connectFaild];
//                [self gotoSecuritySettingsViewController];
//        
//            });
//        }
//            break;
//            
//        case FOSCMDRET_ACCESSDENY:
//        {
//            [self showMessage:FSLocalizedString(@"FS_Foscam_LOGIN_ACCESS_DENY") wihtStyle:ALAlertBannerStyleFailure];
//            [self performSelectorOnMainThread:@selector(connectFaild) withObject:nil waitUntilDone:NO];
//        }
//            break;
//        case FOSCMDRET_FAILD:
//        {
//            [self showMessage:FSLocalizedString(@"FS_Foscam_CONNECT_FAIL") wihtStyle:ALAlertBannerStyleFailure];
//            [self performSelectorOnMainThread:@selector(connectFaild) withObject:nil waitUntilDone:NO];
//        }
//            break;
//        default:
//        {
//            [self performSelectorOnMainThread:@selector(connectFaild) withObject:nil waitUntilDone:NO];
//        }
//            break;
//    }
//
//}
//
//- (void)gotoSecuritySettingsViewController{
//
//    if (iOrientation ==1 || iOrientation ==2) {
//        [self showStatusAndNavBar];
//        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//        sleep(1.5f);
//    }
//    
//    NSString *deviceUID = playerModel.cloudModel.deviceMac;
//    SecuritySettingsViewController *vc = [[SecuritySettingsViewController alloc] initWithDeviceUID:deviceUID type:SecuritySettingsLive];
//    vc.didConfirmBlock = ^(NSString *username, NSString *password) {
//        // 更新内存数据
//        playerModel.cloudModel.username = SAFTYSTRING(username);
//        playerModel.cloudModel.password = SAFTYSTRING(password);
//        
//        // 更新云端数据
//        [self.webClient updateDeviceWithType:WebClientChange
//                               baseURLString:[SharedAppDelegate serviceAddress]
//                                ipcsettingId:playerModel.cloudModel.ipcSettingId
//                                   deviceUID:SAFTYSTRING(playerModel.cloudModel.deviceUID)
//                                ddnsWithPort:SAFTYSTRING(playerModel.cloudModel.ddns)
//                                  ipWithPort:SAFTYSTRING(playerModel.cloudModel.ip)
//                                    username:SAFTYSTRING(playerModel.cloudModel.username)
//                                    password:SAFTYSTRING(playerModel.cloudModel.password)
//                              additionalInfo:@""];
//    };
//    
//    vc.didCancelBlock = ^() {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    };
//    
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//
////EventRun事件操作
//-(void)EventRun:(int)handle{
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//   
//        FOSCMD_RESULT ret = FOSCMDRET_FAILD;
//        FOSEVET_DATA event;
//        while (!threadQuit) {
//            ret = [[FSNetService sharedNetService] getEvent_sync:playerHandle :&event];
//            //获取事件成功
//            if (FOSCMDRET_OK == ret && !threadQuit) {
//                switch (event.id) {
//                    case RECORD_EVENT_CHG:
//                    {
//                        NSLog(@"录像事件");
//                    }
//                        break;
//                    case VOLUME_EVENT_CHG:
//                    {
//                    }
//                        break;
//                    case WIFI_EVENT_CHG:{
//                        NSLog(@"WIFI变化事件");
//                    }
//                        break;
//                    case IRCUT_EVENT_CHG:
//                    {
//                        //红外state 0开，1是关
//                        FOSIRCUTSTATE *ir = (FOSIRCUTSTATE*)event.data;
//                        _mInfoModel.infraLedMode = ir->mode;
//                        _mInfoModel.infraLedState = ir->state;
//                        if (nightView) {
//                            [self irModeSelectedStateWithSuperView:nightView];
//                        }
//                        NSLog(@"IRmode = %d state = %d", ir->mode, ir->state);
//                    }
//                        break;
//                    case PROTOCOL_VER:
//                        break;
//                    case PRESET_EVENT_CHG:
//                    {
//                        FOSPRESETPOINT *pt = (FOSPRESETPOINT *)event.data;
//                        char *s = pt->curPoint;
//                        char *s0 = pt->pointList[0];
//                        NSLog(@"PRESET_EVENT_CHG s = %s, s0 = %s",s, s0);
//                        memcpy(&_presetPoint, pt, sizeof(_presetPoint));
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//                            NSString *title = [[NSString alloc] initWithCString:self.presetPoint.curPoint encoding:encoding];
//                            if ([title isEqualToString:@""] || [title isEqualToString:@"None"]) {
//                                title = [[NSString alloc] initWithCString:self.presetPoint.pointList[0] encoding:encoding];
//                            }
//                            self.ptzCView.presetView.presetTitle = title;
//                            [self.ptzListView reload];
//                        });
//                    }
//                        break;
//                    case CRUISE_EVENT_CHG:
//                    {
//                        FOSCRUISEMAP *pt = (FOSCRUISEMAP *)event.data;
//                        memcpy(&_cruiseMap, pt, sizeof(_cruiseMap));
//                        
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//                            NSString *title = [[NSString alloc] initWithCString:self.cruiseMap.curMap encoding:encoding];
//                            if ([title isEqualToString:@""]) {
//                                title = [[NSString alloc] initWithCString:self.cruiseMap.mapList[0] encoding:encoding];
//                            }
//                            self.ptzCView.presetView.cruiseTitle = title;
//                        });
//                        /*
//                        巡航
//                        FOSCRUISEMAP *cruise = (FOSCRUISEMAP*)event.data;
//                        memcpy(&mCruiseMap, cruise, sizeof(mCruiseMap));
//                         */
//                    }
//                        break;
//                    case MIRRORFLIP_EVENT_CHG:
//                    {
//                        FOSMIRRORFLIP* flip = (FOSMIRRORFLIP*)event.data;
//                        isFlip = flip->isFlip;
//                        isMirror = flip->isMirror;
//                        NSLog(@"Event isFlip =%d isMirror =%d",isFlip,isMirror);
//                        if (mirrorView) {
//                            [self setMirrorState:FlipMode andState:isFlip];
//                            [self setMirrorState:MirrorMode andState:isMirror];
//                        }
//                    }
//                        break;
//                    case STREAMTYPE_EVENT_CHG:
//                    {
//                        NSLog(@"________main type");
//                        [self getStreamTypeEvent:event withStreamType:0];
//                    }
//                        break;
//                    case STREAMPARAM_EVENT_CHG:
//                    {
//                        NSLog(@"________main param");
//                        [self getStreamEvent:event withStreamType:0];
//                    }
//                        break;
//                    case SUBSTREAMTYPE_EVENT_CHG:
//                    {
//                        NSLog(@"________sub type");
//                        [self getStreamTypeEvent:event withStreamType:1];
//                    }
//                        break;
//                    case SUBSTREAMPARAM_EVENT_CHG:
//                    {
//                        NSLog(@"________sub param");
//                        [self getStreamEvent:event withStreamType:1];
//                    }
//                        break;
//                    case IMAGE_EVENT_CHG:
//                        break;
//                    case ALARM_EVENT_CHG:
//                        break;
//                    case PWRFREQ_EVENT_CHG:
//                        break;
//                    case NETSTATE_CONNECTERROR_EVENT_CHG://重连消息
//                        break;
//                    case NETSTATE_RECONNECTRESULT:
//                    {
//                        FOSRECONNECTPARAM *conect = (FOSRECONNECTPARAM*)event.data;
//                        switch (conect->result) {
//                            case 0://OK
//                                break;
//                            case 1://faild
//                                break;
//                            case 2://密码错误
//                                break;
//                            case 3://max user
//                                break;
//                            default:
//                                break;
//                        }
//                        if (handle == playerHandle) {
//                            [[FSNetService sharedNetService] SelectFun:playerHandle :conect->result :conect->usrPrivilege];
//                        }
//                        _mInfoModel.iUserRight = conect->usrPrivilege;
//                    }
//                        break;
//                    case RECORD_ACHIEVE_FILE_MAXSIZE:{
//                        NSLog(@"录像结束");
//                    }
//                        break;
//                    case RECORD_NO_ENOUGE_SPACE:
//                        break;
//                    case RECORD_RESOLUTION_CHANGE:
//                        break;
//                    case RECORD_FILE_PATH_NOEXIST:
//                        break;
//                    case RECORD_UNKNOW:
//                        break;
//                    case ALL_EVENT_QUIT:
//                        break;
//                    case MUSIC_STATE_CHG:
//                        break;
//                    case MUSIC_FORMAT_ERR:
//                        break;
//                    case MUSIC_PLAY_MODE_CHG:
//                        break;
//                    case MUSIC_DORMANT_TIME_CHG:
//                        break;
//                    case MUSIC_PATH_CHG:
//                        break;
//                    case MUSIC_LISTS_CHG:
//                        break;
//                    case AUDIO_VOLUME_CHG:  //音量消息
//                    {
//                        //FOSVOLUME *param = (FOSVOLUME *)event.data;
//                        //int ivloume = param->volume;
//                    }
//                        break;
//                    case GET_ALL_PRODUCT_INFO:{//目前用于获取是否支持HDR功能
//                        FOS_AllProductInfoMSG *param = (FOS_AllProductInfoMSG *)event.data;
//                        FSLog(@"________________ambarellaFlag = %d", param->ambarellaFlag);
//                        if (1 & param->ambarellaFlag) {
//                            isSupportHDR =YES;
//                        }
//                        if (4 & param->ambarellaFlag) {
//                            isSupportEPT =YES;
//                        }
//                    }
//                        break;
//                    case CGI_ONLINE_UPGRADE_STATE:
//                        break;
//                    default:
//                        break;
//                }
//            }else//获取事件失败
//            {
//                usleep(20*1000);
//            }
//        }
//        usleep(20*1000);
//    });
//}
////清晰度HD数据回调
//-(void)getStreamEvent:(FOSEVET_DATA)event withStreamType:(int)streamType
//{
//    FOSSTREAMPARAM* streamPara = (FOSSTREAMPARAM*)event.data;
//    memcpy((char*)&streamParaBack, streamPara, sizeof(streamParaBack));
//    
//    if (playerModel.streamType ==0) {
//        curMode = streamPara->mainStreamType;
//        
//    }else{
//        curMode = streamPara->subStreamType;
//    }
//    if (curMode<0 || curMode >= 4) {
//        return ;
//    }
//
//    //mainStreamType的值,取param中的第几位,当resolution>7表示码流大于1080p，hdr禁用
//    FOSSTREAMPARAMINFO typeStream =streamPara->param[curMode];
//    _mInfoModel.infraHdrState =typeStream.resolution;
//    
//    FOSSTREAMPARAMINFO *param = &(streamPara->param[curMode]);
//
//    [self valueHD:param];
//    
//}
//
//-(void)getStreamTypeEvent:(FOSEVET_DATA)event withStreamType:(int)streamType
//{
//    FOSSTREAMTYPE* modeType = (FOSSTREAMTYPE*)event.data;
//    int  typeIndex = modeType->streamType;
//    
//    FOSSTREAMPARAMINFO *param = &streamParaBack.param[typeIndex];
//    
//    [self valueHD:param];
//
//}
//
//- (void)valueHD:(FOSSTREAMPARAMINFO *)param{
//    
//    //计算当前HD值
//    NSInteger sensorType = _productAllInfoModel.sensorType;
//    NSInteger modeNub = _productAllInfoModel.model;
//    hdMode = (int)[self.liveHD currentModeValueWithSensorType:sensorType
//                                              streamParamInfo:param
//                                                   StreamType:playerModel.streamType
//                                                      ModeNub:modeNub];
//    NSLog(@"HD Mode = %d",hdMode);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (hdMode ==0) {
//            [hdBtn setTitle:FSLocalizedString(@"FS_Pic_FHD") forState:UIControlStateNormal];
//        }else if (hdMode ==1){
//            [hdBtn setTitle:FSLocalizedString(@"FS_Pic_HD") forState:UIControlStateNormal];
//        }else{
//            [hdBtn setTitle:FSLocalizedString(@"FS_Pic_SD") forState:UIControlStateNormal];
//        }
//        if (hdTableView) {
//            NSIndexPath * selIndex = [NSIndexPath indexPathForRow:hdMode inSection:0];
//            [hdTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionNone];
//        }
//    });
//
//}
//
//- (void)setButtonUserInteraction:(UIButton *)sender
//{
//    [sender setUserInteractionEnabled:YES];
//}
//
//- (BOOL)AudioAuthorization
//{
//    __block BOOL bCanRecord = YES;
//
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
//        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
//            if (granted) {
//                bCanRecord = YES;
//            }
//            else {
//                bCanRecord = NO;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:FSLocalizedString(@"FS_Alert_Title") message:FSLocalizedString(@"FS_AudioAuthorization") delegate:self cancelButtonTitle:FSLocalizedString(@"Confirm") otherButtonTitles: nil];
//                    [alertV show];
//                });
//            }
//        }];
//    }
//    return bCanRecord;
//}
//
//#pragma mark - 音频相关
//
//void input_audio_callback(const void *frame, int size, int index, const AudioTimeStamp *time, void *userdata)
//{
//    FSLivePlayViewController *play = (FSLivePlayViewController *)CFBridgingRelease(userdata);
//    
//    [play InputAudioCallback:frame :size :index :time];
//}
//
//- (void)InputAudioCallback:(const void *)frame :(int)size :(int)index :(const AudioTimeStamp *)t
//{
//    [[FSNetService sharedNetService] sendTalkData_sync:playerHandle :(char *)frame dataLen:size];
//}
//
////选择更多设备
//- (void)listMoreDevice:(id)sender
//{
//    if (listTableView) {
//        if (listTableView.hidden ==YES) {
//            listTableView.hidden =NO;
//        }else{
//            listTableView.hidden =YES;
//        }
//    }else{
//        //设备列表list
//        listTableView =[[UITableView alloc]init];
//        [_videoScrollView addSubview:listTableView];
//        listDataSource =_devicesArray;
//        float listWid =160.f;
//        if ([listDataSource count] >3) {
//            listTableView.frame =CGRectMake((SCREEN_WIDTH-listWid)/2, 0, listWid, 119.5f);
//        }else{
//            listTableView.frame =CGRectMake((SCREEN_WIDTH-listWid)/2, 0.f, listWid, 40.f *[listDataSource count]);
//        }
//        listTableView.delegate =self;
//        listTableView.dataSource =self;
//        listTableView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_opacity_80.png"]];
//        listTableView.separatorInset =UIEdgeInsetsMake(0, 15, 0, 15);
//        listTableView.separatorColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2];
//        listTableView.showsVerticalScrollIndicator =NO;
//        listTableView.hidden =NO;
//        NSIndexPath * selIndex = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
//        [listTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionNone];
//    }
//}
//
////进入设置界面
//- (void)gotoSetting:(UIButton *)sender{
//    SettingsViewController *vc = [[SettingsViewController alloc] initWithCameraModel:playerModel];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)startLoadingAnimatingOnMainThread
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_activityIndicatorView startAnimating:YES];
//    });
//}
//
//- (void)stopLoadingAnimatingOnMainThread
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_activityIndicatorView stopAnimating];
//    });
//}
//
//#pragma mark - 屏幕旋转事件
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    if (UIInterfaceOrientationLandscapeLeft == toInterfaceOrientation || UIInterfaceOrientationLandscapeRight == toInterfaceOrientation ) {
//        //隐藏AdNoteView
//        if (_bAdNoteViewShow) {
//            [_adNoteView dismiss];
//        }
//        if (UIInterfaceOrientationLandscapeLeft == toInterfaceOrientation) {
//            iOrientation =1;
//        }else{
//            iOrientation =2;
//        }
//        // 横屏
//        [self hiddenStatusAndNavBar];
//        footView.hidden =YES;
//        if (hdTableView && hdTableView.hidden == NO){
//            hdTableView.hidden = YES;
//        }
//        if (listTableView && listTableView.hidden == NO) {
//            listTableView.hidden = YES;
//        }
//        //旋转时隐藏footerView
//        if (IOS_VERSION >=8.0) {
//            [_videoScrollView setFrame:CGRectMake(0, 0, SCREEN_Max, SCREEN_Min)];
//        }else{
//            [_videoScrollView setFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
//        }
//        soundView.frame =CGRectMake((_videoScrollView.frame.size.width -soundFrame.size.width)/2, _videoScrollView.frame.size.height -soundFrame.size.height -20.f, soundFrame.size.width, soundFrame.size.height);
//        _videoScrollView.exitFullScreenButton.hidden = YES;
//        _activityIndicatorView.center = _videoScrollView.center;
//        [_videoScrollView.exitFullScreenButton addTarget:self action:@selector(exitFullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
//
//        trafficBtn.frame =CGRectMake(_videoScrollView.frame.size.width -70, 10, 60, 18);
//        recordTimeBtn.frame = CGRectMake((_videoScrollView.frame.size.width - 85.f) / 2.f, 10.f, 85.f, 25.f);
//        if (btnViewFull) {
//            
//        }else{
//            [self setbtnViewFull];
//            btnViewFull.hidden = YES;
//        }
//        if(picView.hidden ==NO){
//            picView.hidden =YES;
//        }
//        if (recordBtn.selected ==YES) {
//            recordBtnFull.selected =YES;
//        }else{
//            recordBtnFull.selected =NO;
//        }
//        [self setBtnFullViewTimer];
//    }else
//    {
//        //显示AdNoteView
//        if (_bAdNoteViewShow) {
//            [_adNoteView show];
//        }
//        iOrientation =0;
//        [self showStatusAndNavBar];
//        _videoScrollView.frame = videoViewFrame;
//        _videoScrollView.exitFullScreenButton.hidden =YES;
//        soundView.frame =soundFrame;
//        _activityIndicatorView.center = _videoScrollView.center;
//        _videoScrollView.exitFullScreenButton.hidden = YES;
//        trafficBtn.frame =CGRectMake(_videoScrollView.frame.size.width -65, _videoScrollView.frame.origin.y -40, 60, 18);
//        recordTimeBtn.frame = CGRectMake((CGRectGetWidth(videoViewFrame) - 85.f) / 2.f, videoViewFrame.origin.y + 10.f, 85.f, 25.f);
//        footView.hidden =NO;
//        btnViewFull.hidden =YES;
//        if(imageFullView.hidden ==NO){
//            imageFullView.hidden =YES;
//        }
//        if (recordBtnFull.selected==YES) {
//            recordBtn.selected =YES;
//        }else{
//            recordBtn.selected =NO;
//        }
//
//        if (ptzFullView.hidden ==NO){
//            ptzFullView.hidden =YES;
//        }
//        
//        if (self.panView.superview) {
//            ((UIButton *)[btnViewFull viewWithTag:IPCPTZFullButtonTag]).selected = NO;
//            [self.panView removeFromSuperview];
//        }
//    }
//    _videoScrollView.zoomScrollView.zoomScale =1.;//重置为1
//}
////横屏UI
//- (void)setBtnFullViewTimer{
//    if (!fullTimer) {
//        fullTimer =[NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(hideBtnFullView) userInfo:nil repeats:NO];
//    }
//}
//- (void)hideBtnFullView{
//    [fullTimer invalidate]; fullTimer =nil;
//    btnViewFull.hidden =YES;
//    _videoScrollView.exitFullScreenButton.hidden =YES;
//}
//
//- (void) setbtnViewFull{
//    UIImage *image =[UIImage imageNamed:@"fullscreen_talk_nor.png"];
//    CGSize imageSize =image.size;
//    float space =(SCREEN_HEIGHT >IS_IPHONE_5 ?25.f:20.f);
//    float viewHeight =imageSize.height *4 + space *3;
//    float ySpace =(_videoScrollView.frame.size.height - viewHeight)/2;
//    btnViewFull =[[UIView alloc]initWithFrame:CGRectMake(_videoScrollView.frame.size.width -imageSize.width -20, ySpace, imageSize.width, viewHeight)];
//    [_videoScrollView addSubview:btnViewFull];
//    btnViewFull.backgroundColor =RGB_Clear;
//    
//    talkBtnFull =[UIButton buttonWithType:UIButtonTypeCustom];
//    [btnViewFull addSubview:talkBtnFull];
//    talkBtnFull.tag =IPCTalkButtonTag;
//    UIImage *imageTalkFull =[UIImage imageNamed:@"fullscreen_talk_nor.png"];
//    [talkBtnFull setImage:imageTalkFull forState:UIControlStateNormal];
//    [talkBtnFull setImage:GetImageByName(@"fullscreen_talk_press.png") forState:UIControlStateHighlighted];
//    [talkBtnFull setFrame:CGRectMake(0.f,0.f,imageSize.width,imageSize.height)];
//    [talkBtnFull addTarget:self action:@selector(openTalk:) forControlEvents:UIControlEventTouchDown];
//    [talkBtnFull addTarget:self action:@selector(closeTalk:) forControlEvents:UIControlEventTouchUpOutside];
//    [talkBtnFull addTarget:self action:@selector(closeTalk:) forControlEvents:UIControlEventTouchUpInside];
//    [talkBtnFull addTarget:self action:@selector(closeTalk:) forControlEvents:UIControlEventTouchCancel];
//    
//    picBtnFull =[UIButton buttonWithType:UIButtonTypeCustom];
//    [btnViewFull addSubview:picBtnFull];
//    UIImage *imagePicFull =[UIImage imageNamed:@"fullscreen_capture_nor.png"];
//    [picBtnFull setImage:imagePicFull forState:UIControlStateNormal];
//    [picBtnFull setImage:GetImageByName(@"fullscreen_capture_press.png") forState:UIControlStateHighlighted];
//    [picBtnFull setFrame:CGRectMake(0.f,CGRectGetMaxY(talkBtnFull.frame) +space,imageSize.width,imageSize.height)];
//    picBtnFull.tag =IPCPicFullButtonTag;
//    [picBtnFull addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//
//    recordBtnFull =[UIButton buttonWithType:UIButtonTypeCustom];
//    [btnViewFull addSubview:recordBtnFull];
//    UIImage *imageRecordFull =[UIImage imageNamed:@"fullscreen_record_nor.png"];
//    [recordBtnFull setImage:imageRecordFull forState:UIControlStateNormal];
//    [recordBtnFull setImage:GetImageByName(@"fullscreen_record_press.png") forState:UIControlStateHighlighted];
//    [recordBtnFull setImage:GetImageByName(@"fullscreen_record_press.png") forState:UIControlStateSelected];
//    [recordBtnFull setFrame:CGRectMake(0.f,CGRectGetMaxY(picBtnFull.frame) +space,imageSize.width,imageSize.height)];
//    recordBtnFull.tag =IPCRecordButtonTag;
//    [recordBtnFull addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//
//    ptzBtnFull =[UIButton buttonWithType:UIButtonTypeCustom];
//    [btnViewFull addSubview:ptzBtnFull];
//    UIImage *imagePtzFull =[UIImage imageNamed:@"fullscreen_ptz_nor.png"];
//    [ptzBtnFull setImage:imagePtzFull forState:UIControlStateNormal];
//    [ptzBtnFull setImage:GetImageByName(@"fullscreen_ptz_press.png") forState:UIControlStateHighlighted];
//    [ptzBtnFull setImage:GetImageByName(@"fullscreen_ptz_press.png") forState:UIControlStateSelected];
//    [ptzBtnFull setFrame:CGRectMake(0.f,CGRectGetMaxY(recordBtnFull.frame) +space,imageSize.width,imageSize.height)];
//    ptzBtnFull.tag =IPCPTZFullButtonTag;
//    [ptzBtnFull addTarget:self action:@selector(setActionButtons:) forControlEvents:UIControlEventTouchUpInside];
//}
////横屏抓拍
//-(void)setPicFullView:(UIImage *)image{
//    imageFullView =[[UIImageView alloc]initWithFrame:CGRectMake(15.f, _videoScrollView.frame.size.height -50.f -20.f, 89.f, 50.f)];
//    [_videoScrollView addSubview:imageFullView];
//    //设置边框及边框颜色
//    imageFullView.layer.borderWidth =1.5f;
//    imageFullView.layer.borderColor =[RGB_White CGColor];
//    imageFullView.image =image;
//    imageFullView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoAlbum)];
//    [imageFullView addGestureRecognizer:singleTap1];
//}
//
////后台操作
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    sleep(2.0f);
//    [self loadVideo];
//}
//
//- (void)applicationDidEnterBackground:(NSNotification*)aNotification
//{
//    noBackgroundFree = YES;
//    [self stopVideoStream:YES];
//}
//
//#pragma - mark TableView Datasouce delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 40.f;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if ([tableView isEqual:listTableView]) {
//        return [listDataSource count];
//    }else if ([tableView isEqual:hdTableView]){
//        return [hdDataSource count];
//    }else if ([tableView isEqual:detectionTableView]){
//        return [detectionDataSource count];
//    }
//    return 0;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([tableView isEqual:listTableView]) {
//        static NSString *identifier = @"listCell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            cell.backgroundColor =RGB_Clear;
//            cell.textLabel.textAlignment =NSTextAlignmentCenter;
//            cell.textLabel.font =SysFontOfSize_16;
//            cell.textLabel.textColor =RGB_220_220_220;
//            //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//            cell.selectedBackgroundView.backgroundColor = RGB_57_57_66;
//            cell.textLabel.highlightedTextColor = RGB_9_235_255;
//        }
//        CameraModel *thisDevice = _devicesArray[indexPath.row];
//        cell.textLabel.text = thisDevice.cloudModel.deviceName;
//        return cell;
//        
//    }else if ([tableView isEqual:hdTableView])
//    {
//        static NSString *identifier = @"sdcell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            cell.textLabel.text =hdDataSource[indexPath.row];
//            cell.backgroundColor =RGB_Clear;
//            cell.textLabel.textAlignment =NSTextAlignmentCenter;
//            cell.textLabel.font =SysFontOfSize_13;
//            cell.textLabel.textColor =RGB_187_190_199;
//            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//            cell.selectedBackgroundView.backgroundColor = RGB_57_57_66;
//            cell.textLabel.highlightedTextColor = RGB_9_235_255;
//        }
//        return cell;
//    
//    }else if ([tableView isEqual:detectionTableView]){
//        static NSString *identifier = @"detectionCell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            cell.backgroundColor =RGB_Clear;
//            cell.textLabel.textAlignment =NSTextAlignmentLeft;
//            cell.textLabel.font =SysFontOfSize_15;
//            cell.textLabel.textColor =RGB_187_190_199;
//            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            cell.textLabel.text = [detectionDataSource[indexPath.row] objectForKey:@"title"];
//            
//            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
//            button.tag =indexPath.row;
//            [button setSelected:[[detectionDataSource[indexPath.row] objectForKey:@"enable"] isEqual:@"1"]?YES:NO];
//            UIImage *image =[UIImage imageNamed:@"live_switch_off.png"];
//            button.frame =CGRectMake(0, 0, image.size.width, image.size.height);
//            [button setImage:image forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"live_switch_on.png"] forState:UIControlStateSelected];
//            [button addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
//            cell.accessoryView =button;
//        }
//
//        ((UIButton *)(cell.accessoryView)).selected =[[detectionDataSource[indexPath.row] objectForKey:@"enable"] isEqual:@"1"]?YES:NO;
//        
//        return cell;
//    }
//    
//    return nil;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if ([tableView isEqual:listTableView]) {
//        _currentIndex =indexPath.row;
//        [self stopVideoStream:NO];
//    }
//    else if ([tableView isEqual:hdTableView]){
//        hdTableView.hidden =YES;
//        NSString *title =hdBtn.currentTitle;
//        [hdBtn setTitle:hdDataSource[indexPath.row] forState:UIControlStateNormal];
//        [self setHD:(int)indexPath.row withTitle:title];
//    }
//}
//
//#pragma mark VCBackDelegate
//- (void)viewControllerDidPopBack:(UIViewController *)viewController withObject:(id)object
//{
//    playerModel = object;
//    if (playerModel) {
//        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
//        NSString *title = playerModel.cloudModel.deviceName.length > 0 ? playerModel.cloudModel.deviceName : kDefaultDeviceName;
//        [titleBtn setTitle:title forState:UIControlStateNormal];
//    }
//}
//
//- (void)saveOneImageForDeviceList:(UIImage *)img
//{
//    // 保存第一帧图片  用于设备播放列表的背景图片
//    [self saveCameraLiseImage:playerModel andImage:img];
//}
//
//extern char*  gRGBBuffer;
//extern int    gRGBBufferLen;
//-(UIImage*) imageFromAVPicture:(char*)data width:(int)width height:(int)height
//{
//    
//    if(_activityIndicatorView.hidden ==NO)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_activityIndicatorView stopAnimating];
//            _activityIndicatorView.hidden =YES;
//        });
//    }
//
////    CFDataRef dataRef = CFDataCreateWithBytesNoCopy(kCFAllocatorDefault, (const UInt8 *)data, width*height*3,kCFAllocatorNull);
//    CFDataRef dataRef = CFDataCreate(kCFAllocatorDefault, (const UInt8 *)data, width*height*3);
//    CGDataProviderRef provider = CGDataProviderCreateWithCFData(dataRef);
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGImageRef cgImage = CGImageCreate(width,
//                                       height,
//                                       8,
//                                       24,
//                                       width*3,
//                                       colorSpace,
//                                       kCGBitmapByteOrderDefault,
//                                       provider,
//                                       NULL,
//                                       NO,
//                                       kCGRenderingIntentDefault);
//    
//    CGColorSpaceRelease(colorSpace);
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    
//    if (image != nil && connectSuc == NO) {
//        connectSuc = YES;
//        [self saveOneImageForDeviceList:image];
//
//        if (_activityIndicatorView.isAnimating || !_activityIndicatorView.hidden) {
//            [_activityIndicatorView performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
//        }
//    }
//    
//    if (image != nil) {
//        connectSuc = YES;
//        if (_activityIndicatorView.isAnimating || !_activityIndicatorView.hidden) {
//            [_activityIndicatorView performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
//        }
//    }
//    if (_videoScrollView.imageView.hidden ==YES) {
//        NSLog(@"hidden...");
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_videoScrollView.imageView setImage:image];
//    });
//    
//    CGImageRelease(cgImage);
//    CGDataProviderRelease(provider);
//    CFRelease(dataRef);
//
//    return nil;
//
//}
//
//#pragma mark - h264decode
//- (void) displayImage:(CVImageBufferRef)imageBuffer
//{
//    CVImageBufferRef buffer = imageBuffer;
//    
//    CVPixelBufferLockBaseAddress(buffer, 0);
//    
//    //從 CVImageBufferRef 取得影像的細部資訊
//    uint8_t *base;
//    size_t width, height, bytesPerRow;
//    base = CVPixelBufferGetBaseAddress(buffer);
//    width = CVPixelBufferGetWidth(buffer);
//    height = CVPixelBufferGetHeight(buffer);
//    
//    bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);
//    
//    //利用取得影像細部資訊格式化 CGContextRef
//    CGColorSpaceRef colorSpace;
//    CGContextRef cgContext;
//    colorSpace = CGColorSpaceCreateDeviceRGB();
//    cgContext = CGBitmapContextCreate (base, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
//    
//    CGColorSpaceRelease(colorSpace);
//    
//    //透過 CGImageRef 將 CGContextRef 轉換成 UIImage
//    CGImageRef cgImage;
//    UIImage *image;
//    cgImage = CGBitmapContextCreateImage(cgContext);
//    image = [UIImage imageWithCGImage:cgImage];
//    
//    if (_activityIndicatorView.hidden == NO || _activityIndicatorView.isAnimating == YES) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_activityIndicatorView stopAnimating];
//            _activityIndicatorView.hidden =YES;
//            connectSuc = YES;
//            [self saveOneImageForDeviceList:image];
//        });
//    }
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        DDLogInfo(@"show video image width = %f,height =%f\n",image.size.width,image.size.height);
//        [_videoScrollView.imageView setImage:image];
//    });
//    
//    CGImageRelease(cgImage);
//    CGContextRelease(cgContext);
//    
//    CVPixelBufferUnlockBaseAddress(buffer, 0);
//    
//}
//
//#pragma mark - Private Methods
//- (void)addPresetPoint:(NSString *)newPreset {
//    DDLogInfo(@"... newPreset:%@", newPreset);
//    
//    // 设备限制最多16个点
//    if (self.presetPoint.cnt >= 16) {
//        [self showMessage:FSLocalizedString(@"FS_Live_Preset_Add_MaxWarning") wihtStyle:ALAlertBannerStyleFailure];
//        return ;
//    }
//    
//    if (![newPreset isValidYuzhidianName]) {
//        [self showMessage:FSLocalizedString(@"FS_Live_CuriseName_Invalid") wihtStyle:ALAlertBannerStyleFailure];
//        return ;
//    }
//    
//    // 判断重名
//    for (int i = 0; i < self.presetPoint.cnt; ++ i) {
//        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//        NSString *temp = [[NSString alloc] initWithCString:self.presetPoint.pointList[i] encoding:encoding];
//        if ([temp isEqualToString:newPreset]) {
//            [self showMessage:FSLocalizedString(@"FS_Live_Preset_Add_DidExist") wihtStyle:ALAlertBannerStyleFailure];
//            return ;
//        }
//    }
//    
//    // 添加到设备
//    FOSHANDLE handle = playerModel.mHandle;
//    NSString *pointName = [[newPreset urlEncode2147] copy];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        FOS_RESETPOINTLIST presetPointList;
//        FOSCMD_RESULT cmd = FosSdk_PTZAddPresetPoint(handle, (char *)([pointName UTF8String]), 1000, &presetPointList);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (FOSCMDRET_OK == cmd && 0 == presetPointList.result) {
//                DDLogInfo(@"... 预置点pointName:%@添加成功", pointName);
//            } else {
//                DDLogWarn(@"### 预置点pointName:%@添加失败", pointName);
//            }
//        });
//    });
//}
//
//#pragma mark - PTZControlViewDelegate
//- (void)ptzControlView:(PTZControlView *)controlView touchDownWithPTZControl:(PTZControl)tag {
//    FOSHANDLE handle = playerModel.mHandle;
//    
//    switch (tag) {
//        case PTZControlFocusAdd: {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                FosSdk_PTZFocus(handle, FOSPTZ_FOCUSNEAR, 1000);
//            });
//        }
//            break;
//        case PTZControlFocusRed: {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                FosSdk_PTZFocus(handle, FOSPTZ_FOCUSFAR, 1000);
//            });
//        }
//            break;
//        case PTZControlAmplification: {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                FosSdk_PTZZoom(handle, FOSPTZ_ZOOMIN, 1000);
//            });
//        }
//            break;
//        case PTZControlNarrow: {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                FosSdk_PTZZoom(handle, FOSPTZ_ZOOMOUT, 1000);
//            });
//        }
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)ptzControlView:(PTZControlView *)controlView touchUpWithPTZControl:(PTZControl)tag {
//    FOSHANDLE handle = playerModel.mHandle;
//    
//    switch (tag) {
//        case PTZControlFocusAdd:
//        case PTZControlFocusRed: {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                FosSdk_PTZFocus(handle, FOSPTZ_FOCUSSTOP, 1000);
//            });
//        }
//            break;
//        case PTZControlAmplification:
//        case PTZControlNarrow: {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                FosSdk_PTZZoom(handle, FOSPTZ_ZOOMSTOP, 1000);
//            });
//        }
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)ptzPanView:(PTZPanView *)panView touchDownWithPTZControl:(PTZControl)tag {
//    
//    FOSPTZ_CMD cmd = FOSPTZ_STOP;
//    switch (tag) {
//        case PTZControlUp:
//            cmd = FOSPTZ_UP;
//            break;
//        case PTZControlDown:
//            cmd = FOSPTZ_DOWN;
//            break;
//        case PTZControlLeft:
//            cmd = FOSPTZ_LEFT;
//            break;
//        case PTZControlRight:
//            cmd = FOSPTZ_RIGHT;
//            break;
//        case PTZControlRestore:
//            cmd = FOSPTZ_CENTER;
//            break;
//        default:
//            break;
//    }
//    
//    FOSHANDLE handle = playerModel.mHandle;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        FosSdk_PtzCmd(handle, cmd, 1000);
//    });
//}
//
//- (void)ptzPanView:(PTZPanView *)panView touchUpWithPTZControl:(PTZControl)tag {
//    FOSHANDLE handle = playerModel.mHandle;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        FosSdk_PtzCmd(handle, FOSPTZ_STOP, 1000);
//    });
//}
//
//#pragma mark - PresetViewDelegate
//- (void)presetView:(PresetView *)presetView didTrigger:(PresetViewActions)action inViewType:(PresetViewType)type {
//    NSLog(@"... type:%@, action:%@", @(type), @(action));
//    
//    if (PresetViewPreset == type) {
//        switch (action) {
//            case PresetViewSelect: {
//                self.ptzListView.title = FSLocalizedString(@"FS_Live_Preset");
//                self.ptzListView.tag = type;
//                [self.ptzListView show];
//            }
//                break;
//            case PresetViewStart: {
//                NSString *name = [[presetView.presetTitle urlEncode2147] copy];
//                
//                FOSHANDLE handle = playerModel.mHandle;
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    FosSdk_PTZGoToPresetPoint(handle, (char *)[name UTF8String], 1000);
//                });
//            }
//                break;
//            case PresetViewAdd: {
//                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:FSLocalizedString(@"FS_Live_Preset_Add") message:nil preferredStyle:UIAlertControllerStyleAlert];
//                [alertVC addAction:[UIAlertAction actionWithTitle:FSLocalizedString(@"Cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    
//                }]];
//                [alertVC addAction:[UIAlertAction actionWithTitle:FSLocalizedString(@"Confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    NSString *text = alertVC.textFields.firstObject.text;
//                    [self addPresetPoint:text];
//                }]];
//                [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//                    textField.placeholder = FSLocalizedString(@"FS_Live_Preset_Name");
//                    textField.returnKeyType = UIReturnKeyDone;
//                    textField.keyboardType = UIKeyboardTypeASCIICapable;
//                }];
//                [self presentViewController:alertVC animated:YES completion:nil];
//            }
//                break;
//                
//            default:
//                break;
//        }
//    } else if (PresetViewCruise == type) {
//        switch (action) {
//            case PresetViewSelect: {
//                self.ptzListView.title = FSLocalizedString(@"FS_Live_Cruise");
//                self.ptzListView.tag = type;
//                [self.ptzListView show];
//            }
//                break;
//            case PresetViewStart: {
//                NSString *name = [[presetView.cruiseTitle urlEncode2147] copy];
//                
//                FOSHANDLE handle = playerModel.mHandle;
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    FosSdk_PTZStartCruise(handle, (char *)[name UTF8String], 1000);
//                });
//            }
//                break;
//            case PresetViewStop: {
//                FOSHANDLE handle = playerModel.mHandle;
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    FosSdk_PTZStopCruise(handle, 1000);
//                });
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
//}
//
//#pragma mark - PTZListViewDelegate
//- (NSInteger)numberOfRowsInPTZListView:(PTZListView *)view {
//    PresetViewType type = view.tag;
//    if (PresetViewPreset == type) {
//        return self.presetPoint.cnt;
//    } else if (PresetViewCruise == type) {
//        return self.cruiseMap.cnt;
//    } else {
//        return 0;
//    }
//}
//
//- (NSString *)ptzListView:(PTZListView *)view forRowAtIndexPath:(NSIndexPath *)indexPath {
//    PresetViewType type = view.tag;
//    
//    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    if (PresetViewPreset == type) {
//        NSString *title = [[NSString alloc] initWithCString:self.presetPoint.pointList[indexPath.row] encoding:encoding];
//        return title;
//    } else if (PresetViewCruise == type) {
//        NSString *title = [[NSString alloc] initWithCString:self.cruiseMap.mapList[indexPath.row] encoding:encoding];
//        return title;
//    } else {
//        return @"";
//    }
//}
//
//- (BOOL)ptzListView:(PTZListView *)view showDeleteAtIndexPath:(NSIndexPath *)indexPath {
//    PresetViewType type = view.tag;
//    
//    if (PresetViewPreset == type) {
//        return !(indexPath.row < 4); // 不能删除默认预置点
//    } else if (PresetViewCruise == type) {
//        return !(indexPath.row < 2); // 不能删除默认巡航路径
//    }
//    
//    return NO;
//}
//
//- (void)ptzListView:(PTZListView *)view didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    PresetViewType type = view.tag;
//    
//    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    if (PresetViewPreset == type) {
//        NSString *title = [[NSString alloc] initWithCString:self.presetPoint.pointList[indexPath.row] encoding:encoding];
//        self.ptzCView.presetView.presetTitle = title;
//    } else if (PresetViewCruise == type) {
//        NSString *title = [[NSString alloc] initWithCString:self.cruiseMap.mapList[indexPath.row] encoding:encoding];
//        self.ptzCView.presetView.cruiseTitle = title;
//    }
//}
//
//- (void)ptzListView:(PTZListView *)view didDeleteItemAtIndexPath:(NSIndexPath *)indexPath {
//    PresetViewType type = view.tag;
//    
//    if (PresetViewPreset == type) {
//        self.selectPresetRow = (int)indexPath.row;
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:FSLocalizedString(@"FS_Live_Preset") message:FSLocalizedString(@"FS_Live_Del_Preset") delegate:self cancelButtonTitle:FSLocalizedString(@"FS_Alerts_Cancel") otherButtonTitles:FSLocalizedString(@"FS_Alerts_Delete"), nil];
//        alert.tag = 101;
//        [alert show];
//    }
//}
//
//- (void)deletePreset{
//    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *title = [[NSString alloc] initWithCString:self.presetPoint.pointList[_selectPresetRow] encoding:encoding];
//    NSString *pointName = [[title urlEncode2147] copy];
//    
//    FOSHANDLE handle = playerModel.mHandle;
//    [_ptzListView showLoading];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        FOS_RESETPOINTLIST presetPointList;
//        FOSCMD_RESULT cmd = FosSdk_PTZDelPresetPoint(handle, (char *)[pointName UTF8String], 3000, &presetPointList);
//        NSLog(@"... FosSdk_PTZDelPresetPoint cmd:%@ indexPath row:%@, pointName:%@, presetPointList.result = %@", @(cmd), @(_selectPresetRow), pointName, @(presetPointList.result));
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_ptzListView hideLoading];
//            if (FOSCMDRET_OK == cmd) {
//                if (0 == presetPointList.result || 1 == presetPointList.result) {
//                    memcpy(self.presetPoint.pointList, presetPointList.pointName, sizeof(self.presetPoint.pointList));
//                    [_ptzListView reload];
//                } else if (3 == presetPointList.result) {
//                    [_ptzListView dismiss];
//                    [self showMessage:FSLocalizedString(@"FS_Live_CannotDelete_1") wihtStyle:ALAlertBannerStyleFailure];
//                } else if (4 == presetPointList.result) {
//                    [_ptzListView dismiss];
//                    [self showMessage:FSLocalizedString(@"FS_Live_CannotDelete_2") wihtStyle:ALAlertBannerStyleFailure];
//                } else {
//                    [_ptzListView dismiss];
//                }
//            } else {
//                DDLogWarn(@"... FosSdk_PTZDelPresetPoint cmd:%@, presetPointList.result:%@", @(cmd), @(presetPointList.result));
//                if (FOSCMDRET_TIMEOUT == cmd) {
//                    DDLogWarn(@"... 操作超时，不提示"); //注: 可能SDK发送的CGI已执行成功，不提示错误
//                } else {
//                    [self showMessage:FSLocalizedString(@"FS_Live_Delete_Curise_Failed") wihtStyle:ALAlertBannerStyleFailure];
//                }
//            }
//        });
//    });
//
//}
//
//#pragma mark - WebClientDelegate
//- (void)webClient:(WebClient *)webClient didReceiveResponse:(id)response withInterfaceType:(WebClientInterfaceTypes)type {
//    
//    if (WebClientQueryGroup == type) {
//        NSArray *data = ((NSDictionary *)response)[@"data"];
//        if (data.count > 0) { // 存在有效授权记录
//            NSMutableArray *mutableArray = [NSMutableArray new];
//            for (id obj in data) {
//                GrantModel *model = [[GrantModel alloc] instanceWithDict:(NSDictionary *)obj];
//                model.sysDate = ((NSDictionary *)response)[@"sysDate"];
//                [mutableArray addObject:model];
//            }
//            playerModel.permissionModel.status = PermissionValid;
//            playerModel.permissionModel.grantGroup = [mutableArray copy];
//        } else { // 无有效授权记录
//        }
//
//        [self fetchVideoDates]; // 获取存在云录像的日期
//        
//    } else if (WebClientQueryVideoDates == type) {
//        self.dateSet = [VideoHelper dateListFromResponse:(NSDictionary *)(response)];
//        NSLog(@"... 获取到存在录像的日期:%@", self.dateSet);
//        if ([self.dateSet count] != 0) {
//            playerModel.permissionModel.status = PermissionVideo;
//        }else if (playerModel.permissionModel.status != PermissionValid){
//            playerModel.permissionModel.status = PermissionNone;
//        }
//        [self.videoView reload];
//    } else if (WebClientChange == type) {
//        NSLog(@"... 更新云平台账号信息成功");
//    }else if (WebClientGetAdProductsName == type){
//    
//        // Parse Server Data
//        NSDictionary *dict = (NSDictionary *)response;
//        NSLog(@"____live product beta dict %@",dict);
//        NSString *errorCode =[dict objectForKey:@"errorCode"];
//        int activityFlag =[[dict objectForKey:@"activityFlag"] intValue];
//        int popupFlag =[[dict objectForKey:@"popupFlag"] intValue];
//        _recurring =[dict objectForKey:@"recurring"];
//        _serialNo =[dict objectForKey:@"serialNo"];
//        NSString *activityCode =[dict objectForKey:@"activityCode"];//活动编码
//        if(_serialNo ==nil || _recurring ==nil){
//            NSLog(@"serialNo null or recurring null");
//            return ;
//        }
//        ADNoteViewType poptype = ADNoteViewCloud001Type;
//        if ([activityCode isEqualToString:@"0002"]) {
//            poptype = ADNoteViewCloud499Type;
//        }
//        
//        if(errorCode.length == 0 && activityFlag == 1 && popupFlag == 1 && threadQuit == NO){
//            
//            if(_adNoteView == nil){
//                [self initADNoteViewWithType:poptype];
//            }else{
//                [_adNoteView show];
//                _bAdNoteViewShow =YES;
//            }
//        }else{
//            [_adNoteView dismiss];
//        }
//
//    }
//}
//
//- (void)webClient:(WebClient *)webClient didFailWithError:(WBError *)error withInterfaceType:(WebClientInterfaceTypes)type {
//    NSLog(@"WebClientFailError livePlayVc type = %ld error = %@",(long)type,error);
//    if (WebClientGetAdProductsName == type){
//    
//        [_adNoteView dismiss];
//    }else if (WebClientQueryGroup == type || WebClientQueryVideoDates == type){
//        if ([error.errorCode isEqualToString:FC_DATABASE_ACCESS_ERROR] ||
//            [error.errorCode isEqualToString:FC_DATABASE_RECORD_NOT_EXIST] ||
//            [error.errorCode isEqualToString:FC_DATABASE_ACCESS_ERROR] ||
//            [error.errorCode isEqualToString:FC_CACHE_ACCESS_ERROR] ||
//            [error.errorCode isEqualToString:FC_ACCESS_DEV_ALREADY_ADD] ||
//            [error.errorCode isEqualToString:FC_ACCESS_DEV_NOT_EXIST] ||
//            [error.errorCode isEqualToString:FC_ACCESS_DEV_OFFLINE] ||
//            [error.errorCode isEqualToString:FC_ACCESS_DEV_TOKEN_INVALID] ||
//            [error.errorCode isEqualToString:FC_ACCESS_USER_TOKEN_INVALID] ||
//            [error.errorCode isEqualToString:FC_ACCESS_TOKEN_EXPIRED2] ||
//            [error.errorCode isEqualToString:FC_ACCESS_URI_SIGN_INVALID] ||
//            [error.errorCode isEqualToString:FC_ACCESS_URI_EXPIRED] ||
//            [error.errorCode isEqualToString:FC_ACCESS_CMS_INVALID_USER] ||
//            [error.errorCode isEqualToString:FC_ACCESS_SERVICE_EXPIRED] ||
//            [error.errorCode isEqualToString:FC_ACCESS_SERVICE_UNAUTHORIZED] ||
//            [error.errorCode isEqualToString:FC_STREAM_SERVER_NOT_EXIST] ||
//            [error.errorCode isEqualToString:FC_NO_ONLINE_STREAM_SERVER] ||
//            [error.errorCode isEqualToString:FC_PLAYBACK_SERVER_NOT_EXIST] ||
//            [error.errorCode isEqualToString:FC_NO_ONLINE_PLAYBACK_SERVER] ||
//            [error.errorCode isEqualToString:FC_THUMB_SERVER_NOT_EXIST] ||
//            [error.errorCode isEqualToString:FC_NO_ONLINE_THUMB_SERVER] ||
//            [error.errorCode isEqualToString:FC_LIVE_NUMBER_REACH_MAX] ||
//            [error.errorCode isEqualToString:FC_SERVICE_HAS_MIGRATED] ||
//            [error.errorCode isEqualToString:FC_SERVICE_HAS_ROLLBACK]) {
//            
//            if (playerModel.permissionModel.status != PermissionValid) {
//                playerModel.permissionModel.status = PermissionNone;
//            }
//            [self.videoView reload];
//        }else{
//            playerModel.permissionModel.status = PermissionError;
//        }
//    }
//}
//
//#pragma mark - 广告弹窗初始化 && ADNoteViewDelegate
//-(void)initADNoteViewWithType:(ADNoteViewType)adNoteType{
//    
//    _adNoteView =[[ADNoteView alloc] initADNoteViewType:adNoteType];
//    _adNoteView.adNoteDelegate = self;
//    _adNoteView.frame =self.parentViewController.view.bounds;
//    [[FSAppDelegate fsAppDelegate].window addSubview:_adNoteView];
//    _bAdNoteViewShow =YES;
//}
//
//- (void)ADNoteViewAction:(ADNoteAction)actionindex withADNoteView:(ADNoteViewType)viewtype{
//    
//    NSLog(@"%ld------%ld", (long)actionindex, (long)viewtype);
//    if(actionindex == ADNotePayAction){
//        
//        NSLog(@"---------------- pay ---------------");
//        _bAdNoteViewShow =NO;
//        [_adNoteView dismiss];
//        
//        NSString *desc = [NSString string];
//        NSString *price = [NSString string];
//        NSString *time = [NSString string];
//        NSString *recurringPrice = [NSString string];
//        if (viewtype == ADNoteViewCloud001Type) {
//            
//            desc = @"7-day of video history";
//            price = @"0.01";
//            time = @"1 month";
//            recurringPrice = @"4.99";
//            
//        }else if (viewtype == ADNoteViewCloud499Type) {
//            
//            desc = @"7-day of video history";
//            price = @"49.99";
//            time = @"1 year";
//            recurringPrice = @"59.88";
//            
//        }
//        OrderComfirmViewController *orderComfirmVC =[[OrderComfirmViewController alloc]initDeviceInfo:playerModel andDesc:desc andPrice:price andTime:time andSerialNo:_serialNo andCurrencyMark:0 andRecurring:_recurring andRecurringPrice:recurringPrice];
//        orderComfirmVC.liveActive =YES;
//        orderComfirmVC.finishBlockActive = ^(BOOL resultSuccess){
//            if (resultSuccess) {
//                _bAdNoteViewShow =NO;
//                [self showPromotion:viewtype];
//            }
//        };
//        
//        FSNavigationController *navigaionController = [[FSNavigationController alloc] initWithRootViewController:orderComfirmVC];
//        orderComfirmVC.navigationItem.leftBarButtonItem = [navigaionController backBarButtonItem];
//        [self presentViewController:navigaionController animated:YES completion:NULL];
//        
//    }else if(actionindex == ADNoteCloseAction){
//        NSLog(@"------- back");
//        [_adNoteView dismiss];
//        _bAdNoteViewShow =NO;
//    }
//}
//
//#pragma mark - 向服务器发送请求，是否需要广告弹窗
//- (void)queryAdProductsService{
//    // 国内无广告弹窗
//    if (SharedAppDelegate.bIsChina) {
//        DDLogWarn(@"... 国内无广告弹窗");
//        return ;
//    }
//    
//    // 获取国家信息
//    NSString *countryCode = [NSString stringWithFormat:@"%@", [FSUserAccountManager countryCode]];
//    if (0 == [countryCode length]) {
//        countryCode = @"US";
//    }
//    
//    // 获取产品名称
//    NSString *modelName = [NSString stringWithFormat:@"%@", _productAllInfoModel.modelName];
//    if (0 == [modelName length]) {
//        DDLogWarn(@"... 获取广告信息参数错误 modelName:%@", modelName);
//        return ;
//    }
//    
//    NSString *deviceMac = playerModel.cloudModel.deviceMac;
//    
//    [self.webClient getAdProductsName:WebClientGetAdProductsName
//                        baseURLString:[SharedAppDelegate serviceAddress]
//                            modelName:modelName
//                              country:countryCode
//                            deviceMac:deviceMac];
//}
//
//- (void)showPromotion:(ADNoteViewType)noteViewType{
//    
//    if(threadQuit)return;
//    [self queryAdProductsService];
//}
//
//#pragma mark AlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (alertView.tag == 101) {
//        if (buttonIndex != alertView.cancelButtonIndex) {
//            [self deletePreset];
//        }
//    }
//}
//
//#pragma mark - VideoViewDelegate
//- (int)isPermissionValidInVideoView:(VideoView *)videoView {
//    PermissionModel *permissionModel = playerModel.permissionModel;
//    return (permissionModel) ? (permissionModel.status) : (PermissionUnknown);
//}
//
//- (BOOL)videoView:(VideoView *)videoView hasDataInDate:(NSInteger)iDate {
//    return [self.dateSet containsObject:@(iDate)];
//}
//
//- (void)didTapTimeLineInVideoView:(VideoView *)videoView {
//    
//    // 存在云录像授权记录 或 存在云录像，跳转至播放界面
//    PermissionModel *permissionModel = playerModel.permissionModel;
//    if (permissionModel && ((PermissionValid == permissionModel.status) || (PermissionVideo == permissionModel.status)))
//    {
//        NSString *deviceMac = playerModel.cloudModel.deviceMac;
//        VideoViewController *vc = [[VideoViewController alloc] initWithDeviceMac:deviceMac];
//        [vc setCurrentDate:videoView.currentDate];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (permissionModel && (PermissionNone == permissionModel.status)) {
//        [self.videoView showCloudButton]; // 刷新
//        /*
//        CloudServiceViewController *cloudServiceVc = [CloudServiceViewController new];
//        cloudServiceVc.cloudType = 3;
//        cloudServiceVc.serviceModel = playerModel;
//        [self.navigationController pushViewController:cloudServiceVc animated:YES];
//         */
//    }else if (playerModel.permissionModel.status == PermissionError){
//        playerModel.permissionModel.status = PermissionUnknown;
//        [self fetchStorageInformation];
//    }
//}
//
//- (void)didTapCloudInVideoView:(VideoView *)videoView{
//    CloudServiceViewController *cloudServiceVc = [CloudServiceViewController new];
//    cloudServiceVc.cloudType = 3;
//    cloudServiceVc.serviceModel = playerModel;
//    [self.navigationController pushViewController:cloudServiceVc animated:YES];
//
//}
//
//
//#pragma mark - UINavigationControllerDelegate
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//    
//    if ([toVC isMemberOfClass:[VideoViewController class]]) {
//        return nil;
//        VideoAnimatedTransitioning *animation = [[VideoAnimatedTransitioning alloc] initWithOperation:operation];
//        return animation;
//    } else {
//        return nil;
//    }
//}
//
//#pragma mark - Getter && Setter
//- (LiveHD *)liveHD{
//    if (!_liveHD){
//        _liveHD = [[LiveHD alloc] init];
//        _liveHD.isChina = SharedAppDelegate.bIsChina;
//    }
//    return _liveHD;
//}
//
//- (VideoView *)videoView {
//    if (!_videoView) {
//        _videoView = [VideoView new];
//        _videoView.delegate = self;
//    }
//    return _videoView;
//}
//
//- (WebClient *)webClient {
//    if (!_webClient) {
//        _webClient = [[WebClient alloc] init];
//        _webClient.delegate = self;
//    }
//    return _webClient;
//}
//
//- (NSSet *)dateSet {
//    if (!_dateSet) {
//        _dateSet = [NSSet set];
//    }
//    return _dateSet;
//}
//
//- (PTZView *)ptzCView {
//    if (!_ptzCView) {
//        _ptzCView = [PTZView new];
//        _ptzCView.presetView.delegate = self;
//        _ptzCView.ptzControlView.delegate = self;
//        _ptzCView.backgroundColor = RGBCOLOR(48, 48, 64);
//    }
//    return _ptzCView;
//}
//
//- (PTZListView *)ptzListView {
//    if (!_ptzListView) {
//        _ptzListView = [PTZListView new];
//        _ptzListView.delegate = self;
//    }
//    return _ptzListView;
//}
//
//- (PTZPanView *)panView {
//    if (!_panView) {
//        _panView = [[PTZPanView alloc] initWithType:PTZPanLanLandscape];
//        _panView.delegate = self;
//    }
//    return _panView;
//}
//
//@end
