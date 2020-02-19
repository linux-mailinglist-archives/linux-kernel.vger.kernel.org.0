Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB7164C06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 18:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBSRgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 12:36:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33062 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgBSRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:36:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so362843plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tAaLKrE1Z8JOnxwlw25YePbSDtyhE+ndxQTEfFT/04w=;
        b=TPtjy4D4jV0++Xhi8uiJg5/88ean8xsUdshEvLdOrkeXtlV2VE9/G/odj6VfRPcn+J
         Vh6+hIPRRX7k7zSPxFQsRQd8dZvtRt+FLIcLMiHphb6PYUrCafQbBWIL98oEsnWvQJ+a
         PAc5lBi3FJBX+eLsC5hyANL6xEZNStIaqcKQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tAaLKrE1Z8JOnxwlw25YePbSDtyhE+ndxQTEfFT/04w=;
        b=Ydp/TwpK1w3EH/ifuENZNo1Ofq2vekZbpcwdHpD2YKxwp0J2XWGDi2COANIMysus/Y
         dD2fw0L71iAbHpdNpKAXXGwDxUDN9P2YxiJwuVaEb+qMuoqzOPrkxrIHDY435DaZWvzY
         2nj9NMTqVNNTVUfQjDCWz0jVCzMxK/5cXH1ionoZcghx1oqNFuTrf3ss1MaFC6j5ihDk
         eiZie3wn0DKDRTdXIzc4Rr6UNHJKWTOQWm7UngC395zeZD7dUn6+Ste20hwkO1lo99Tt
         qGR4QReXRsTanzsgDm6ZxGXRgzbzdR4MssH4JUN5fn4QJWDIdNsWFjsyCIv7LaXDMUql
         4amA==
X-Gm-Message-State: APjAAAU/8g/T3jzdsOIFRnzQBiQNMG2V/67R2AWxgy2p4AuS2NdkzVWi
        /sGaaGEXQViN+T7pbfCsr3t0By24i4U=
X-Google-Smtp-Source: APXvYqyzsFSIApZMXJl3qcBWlNY6072ABLOXDIZ5B1dQ0ZAeOxK+EYzeCuVOV4iVSNlECIzL+ESvHw==
X-Received: by 2002:a17:90a:102:: with SMTP id b2mr10118008pjb.64.1582133766781;
        Wed, 19 Feb 2020 09:36:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z30sm215405pfq.154.2020.02.19.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:36:05 -0800 (PST)
Date:   Wed, 19 Feb 2020 09:36:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     glider@google.com
Cc:     jannh@google.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_stackinit: move a local outside the switch
 statement
Message-ID: <202002190916.EFA74B50C@keescook>
References: <20200218094815.233387-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200218094815.233387-1-glider@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:48:15AM +0100, glider@google.com wrote:
> Right now CONFIG_INIT_STACK_ALL is unable to initialize locals declared
> in switch statements, see http://llvm.org/PR44916.
> Move the variable declaration outside the switch in lib/test_stackinit.c
> to prevent potential test failures until this is sorted out.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Er, no. This test is specifically to catch that case. (i.e. the proposed
GCC version of this feature misses this case too.) We absolutely want
this test to continue to fail until it's fixed:

[   65.546670] test_stackinit: switch_1_none FAIL (uninit bytes: 8)
[   65.547478] test_stackinit: switch_2_none FAIL (uninit bytes: 8)

What would be nice is if Clang could at least _warn_ about these
conditions. GCC does this in the same situation:

fs/fcntl.c: In function ‘send_sigio_to_task’:
fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
   siginfo_t si;
             ^~

I have a patch to fix all the switch statement variables, though:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/gcc-plugin/stackinit&id=35ed32e16e13a86370e4b70991db8d5f771ba898

-Kees

> ---
>  lib/test_stackinit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
> index 2d7d257a430e..41e2a6e0cdaa 100644
> --- a/lib/test_stackinit.c
> +++ b/lib/test_stackinit.c
> @@ -282,9 +282,9 @@ DEFINE_TEST(user, struct test_user, STRUCT, none);
>   */
>  static int noinline __leaf_switch_none(int path, bool fill)
>  {
> -	switch (path) {
> -		uint64_t var;
> +	uint64_t var;
>  
> +	switch (path) {
>  	case 1:
>  		target_start = &var;
>  		target_size = sizeof(var);
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

-- 
Kees Cook
