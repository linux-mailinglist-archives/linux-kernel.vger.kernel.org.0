Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9487173535
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 11:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgB1KXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 05:23:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46447 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1KXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:23:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id j7so2256304wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BWu8iueEzRzeq+ljMw3GO5DRJ7WpLyt4g4K03+Dz2U=;
        b=KTWA0MiyIymXK1ATe6uz1WTX+uZh1NFjhSn/HYL20oh5JOrl+xuw5wSOntPWjheDpX
         kGr7V+YNENnDtmAZmSBYWYXNd6tx9zjgzOSGVbzH1OIStw6HhgbolY1tuhAAUOwChI+x
         CxIpmiEZXhMn419GAw1JLw2n4CnMiqmhilpsrOvduDDzT8BGQT23vXZr8LVxi1VC08Vk
         np7JOcGNQwnxwRe2kxffJGMutUFJ51YmnTePtg30An5qzu0nhYBUgOVq3ceedls5Nqel
         g7uhLy9OzxwW75lYS5R7WwPDCgGDirl6nncK2xueTAhZUageI22Ms0ns5dvu+4RrP7gG
         34Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BWu8iueEzRzeq+ljMw3GO5DRJ7WpLyt4g4K03+Dz2U=;
        b=KU93MEiIiAZjjQSrgHiXX9f+61PPp17MZm0S053K+cNqBrBaUxtLEivDJ+g/h53t9G
         7e8AXuo8c8wSb37COdif9+MI75DGYRmMu7rjh+3aBYYwUoG1fVpBJfelJMutr6b32D8f
         fD7LJ+xJ2FR+P+tczX5hTAIDROp9YeVJiHPpHzb/JsRS1IhKXf860PJQNpMpgnCmEwZM
         S296cxU1Nl9AOkaHYB5d3aW8895k68dw59r5muK7cwj0NF+HSp613E6mbeQvwB//IVXm
         ZDwKNVOaUF+BptX613mPQpa2UTLUKbA15N9nrTIG80dlwAjtXDTpHA1+kp+7I2PoPGk4
         OrNQ==
X-Gm-Message-State: APjAAAVQIcs4exAB/ZIYgAKgtYWyma4ebCLb/DMOOhlDQbaRr2XKZqUi
        P6r/PMQFau/Vb6BWHPc/VEPV97kPH8VsRQ==
X-Google-Smtp-Source: APXvYqxH9owCTU7Ao+s51LMXcNiAO5qGpIEiVwOzyQhqkpDRULgg/35xMMXIZiEqRYYQVhOhgVu2Nw==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr4423764wrt.132.1582885429318;
        Fri, 28 Feb 2020 02:23:49 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id z14sm8597747wrg.76.2020.02.28.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:23:48 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:23:46 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: drbg: DRBG_CTR should select CTR
Message-ID: <20200228102346.GA1662@Red>
References: <1582127495-5871-1-git-send-email-clabbe@baylibre.com>
 <1582127495-5871-2-git-send-email-clabbe@baylibre.com>
 <20200228003052.GA9060@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228003052.GA9060@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:30:52AM +1100, Herbert Xu wrote:
> On Wed, Feb 19, 2020 at 03:51:35PM +0000, Corentin Labbe wrote:
> > if CRYPTO_DRBG_CTR is builtin and CTR is module, allocating such algo
> > will fail.
> > DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
> > alg: drbg: Failed to reset rng
> > alg: drbg: Test 0 failed for drbg_pr_ctr_aes128
> > DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
> > alg: drbg: Failed to reset rng
> > alg: drbg: Test 0 failed for drbg_nopr_ctr_aes128
> > DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
> > alg: drbg: Failed to reset rng
> > alg: drbg: Test 0 failed for drbg_nopr_ctr_aes192
> > DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
> > alg: drbg: Failed to reset rng
> > ialg: drbg: Test 0 failed for drbg_nopr_ctr_aes256
> > 
> > Since setting DRBG_CTR=CTR lead to a recursive dependency, let's depends
> > on CTR=y
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  crypto/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/crypto/Kconfig b/crypto/Kconfig
> > index 6d27fc6a7bf5..eddeb43fc01c 100644
> > --- a/crypto/Kconfig
> > +++ b/crypto/Kconfig
> > @@ -1822,7 +1822,7 @@ config CRYPTO_DRBG_HASH
> >  config CRYPTO_DRBG_CTR
> >  	bool "Enable CTR DRBG"
> >  	select CRYPTO_AES
> > -	depends on CRYPTO_CTR
> > +	depends on CRYPTO_CTR=y
> 
> This should be turned into a select.
> 

it fail also if I select it:
crypto/Kconfig:1800:error: recursive dependency detected!
crypto/Kconfig:1800:	symbol CRYPTO_DRBG_MENU is selected by CRYPTO_RNG_DEFAULT
crypto/Kconfig:83:	symbol CRYPTO_RNG_DEFAULT is selected by CRYPTO_SEQIV
crypto/Kconfig:330:	symbol CRYPTO_SEQIV is selected by CRYPTO_CTR
crypto/Kconfig:370:	symbol CRYPTO_CTR is selected by CRYPTO_DRBG_CTR
crypto/Kconfig:1822:	symbol CRYPTO_DRBG_CTR depends on CRYPTO_DRBG_MENU

I forgot to say it in the commit message.
I will send a v2 with an updated commit message.

Regards
