//
//  ViewController.m
//  MySafari
//
//  Created by Yeah Right on 5/14/14.
//  Copyright (c) 2014 Naomi Himley. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *forwardButtonOutlet;
@property (nonatomic) CGFloat originy;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self disableEnableButtonMethod];
    self.myWebView.scrollView.delegate = self;

}
- (IBAction)showNewFeatures:(UIButton *)sender
{
    UIAlertView *alertview = [[UIAlertView alloc] init];
    alertview.title = @"Get Hyped!";
    alertview.message = @"Coming soon!";
    [alertview addButtonWithTitle:@"Cancel"];
    alertview.delegate = self;
    [alertview show];


}

- (IBAction)onBackButtonPressed:(UIButton *)sender {
    if ([self.myWebView canGoBack]) {
        [self.myWebView goBack];
    }
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    if ([self.myWebView canGoForward]) {
        [self.myWebView goForward];
    }
}
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.myWebView reload];
}

-(void)webViewDidFinishLoad:(UIWebView *)myWebView
{
    [self disableEnableButtonMethod];
    NSString *labelURLstring = self.myWebView.request.URL.absoluteString;
    [self.myURLTextField setText:labelURLstring];
}

-(BOOL)textFieldShouldReturn:(UITextField *)myURLTextField
{
    [self createURL:myURLTextField.text];

    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.originy > self.myWebView.scrollView.contentOffset.y) {
        self.myURLTextField.alpha = 1;
    }
    else {
        self.myURLTextField.alpha = .2;
    }

    self.originy = self.myWebView.scrollView.contentOffset.y;


}

// helper method

-(void) disableEnableButtonMethod
{
    if ([self.myWebView canGoBack]) {
    self.backButtonOutlet.alpha = 1;
    self.backButtonOutlet.enabled = YES;
}
    else{
    self.backButtonOutlet.alpha = .5;
    self.backButtonOutlet.enabled = NO;
};
    if ([self.myWebView canGoForward]) {
        self.forwardButtonOutlet.alpha = 1;
        self.forwardButtonOutlet.enabled = YES;
}
    else{
        self.forwardButtonOutlet.alpha = .5;
        self.forwardButtonOutlet.enabled = NO;
    }

}

-(void)createURL: (NSString *) website
{
    NSRange range = NSMakeRange(0, 7);
    NSString *firstFive = [self.myURLTextField.text substringWithRange:range];
    if ([firstFive isEqualToString:@"http://"]) {
        NSString *urlString = self.myURLTextField.text;
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.myWebView loadRequest:request];
    }
    else {
        NSString *urlString = [NSString stringWithFormat:@"http://%@", self.myURLTextField.text];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.myWebView loadRequest:request];
    }

[self.myURLTextField resignFirstResponder];

}
@end
