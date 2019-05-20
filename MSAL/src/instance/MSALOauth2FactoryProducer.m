//------------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import "MSALOauth2FactoryProducer.h"
#import "MSALB2CAuthority.h"
#import "MSALAADAuthority.h"
#import "MSALADFSAuthority.h"
#import "MSALB2COauth2Factory.h"
#import "MSALAADOauth2Factory.h"
#import "MSALADFSAuthority.h"

@implementation MSALOauth2FactoryProducer

+ (MSALOauth2Factory *)oauthFactoryForAuthority:(MSALAuthority *)authority
                                        context:(id<MSIDRequestContext>)context
                                          error:(NSError **)error
{
    if (!authority)
    {
        MSIDFillAndLogError(error, MSIDErrorInvalidDeveloperParameter, @"Provided authority url is nil.", nil);
        
        return nil;
    }
    
    if ([authority isKindOfClass:[MSALB2CAuthority class]])
    {
        return [MSALB2COauth2Factory new];
    }
    else if ([authority isKindOfClass:[MSALAADAuthority class]])
    {
        return [MSALAADOauth2Factory new];
    }
    else if ([authority isKindOfClass:[MSALADFSAuthority class]])
    {
        NSAssert(NO, @"ADFS not implemented in MSAL yet");
        return nil;
    }
    
    // Create base factory for everything else, but in future we might want to further separate this out
    // (e.g. ADFS, Google, Oauth2 etc...)
    return [MSALOauth2Factory new];
}

@end
