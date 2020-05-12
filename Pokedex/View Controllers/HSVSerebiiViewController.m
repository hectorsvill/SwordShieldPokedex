//
//  HSVSerebiiViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 5/11/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVSerebiiViewController.h"
#import <WebKit/WebKit.h>

@interface HSVSerebiiViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation HSVSerebiiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self activityIndicator] startAnimating];
    [[self activityIndicator] setHidesWhenStopped:true];

    [self.webView setNavigationDelegate:self];
    NSString *urlString = [NSString stringWithFormat:@"https://www.serebii.net/pokedex-swsh/%@", self.pokemonName];
    NSURL *url = [NSURL URLWithString:urlString];

    [[self webView] loadRequest:[NSURLRequest requestWithURL:url]];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [[self activityIndicator] stopAnimating];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *host = navigationAction.request.URL.host;
    [host isEqualToString:@"www.serebii.net"] ? decisionHandler(WKNavigationActionPolicyAllow) : decisionHandler(WKNavigationActionPolicyCancel);

    return;
}

@end
