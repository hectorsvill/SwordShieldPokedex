//
//  HSVSerebiiViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 5/11/20.
//  Copyright © 2020 s. All rights reserved.
//

@import GoogleMobileAds;
#import "HSVSerebiiViewController.h"
#import <WebKit/WebKit.h>

@interface HSVSerebiiViewController () <GADInterstitialDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) GADInterstitial *googleInterstitialAd;

@end

@implementation HSVSerebiiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureViews];
    [NSURLCache.sharedURLCache removeAllCachedResponses];
    [NSURLCache.sharedURLCache setMemoryCapacity:0];
}

- (void)configureInterstitialAd {
    self.googleInterstitialAd = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    self.googleInterstitialAd.delegate = self;
    self.googleInterstitialAd.accessibilityLabel = @"HSVPokemonDetailViewControllerGADInterstitial";
    
    GADRequest *request = [GADRequest request];
    [self.googleInterstitialAd loadRequest: request];
}

- (void)configureViews {
    [[self activityIndicator] startAnimating];
    [[self activityIndicator] setHidesWhenStopped:true];
    [self configureWebView];
}

- (void)configureWebView {
    self.webView.backgroundColor = UIColor.systemBackgroundColor;
    [self.webView setNavigationDelegate:self];

    NSURL *url = nil;

    if( self.urlString != nil) {
        url = [NSURL URLWithString:self.urlString];
    } else {
        NSString *urlString = [NSString stringWithFormat:@"https://www.serebii.net/pokedex-swsh/%@", self.pokemonName];
        url = [NSURL URLWithString:urlString];
    }

    [[self webView] loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [[self activityIndicator] stopAnimating];
    [self configureInterstitialAd];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *host = navigationAction.request.URL.host;
    [host isEqualToString:@"www.serebii.net"] ? decisionHandler(WKNavigationActionPolicyAllow) : decisionHandler(WKNavigationActionPolicyCancel);

    return;
}

#pragma mark - GADInterstitialDelegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    if (self.googleInterstitialAd.isReady) {
        [self.googleInterstitialAd presentFromRootViewController:self];
    }
}

@end
