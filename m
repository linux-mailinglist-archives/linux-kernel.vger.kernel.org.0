Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBF89831
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfHLHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:47:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38152 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfHLHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:47:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so6823745wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IZQkmchfIioxGvxwfII0Mb+GhztO+bLNAcrpZHM+gHM=;
        b=OECdOmDA1lzjAt+UsvoP0TqVlUeO1ixOThWyjxtZuCd4oakR+9BQn/4G8j8ye0yyku
         oV0ece3Ii0I7yeVVZk0bMi+QmTcv5Kqb6Xya03Qu0d0AbuPdFwoirPWmWR3WJ4cTVy2a
         eBlZgoGSHyFJ7yKQg08nm834Ix1lGleGESZeJ911cCmVm1crG4deJvLOKietdzKU7jYG
         A+ZycIXNVZKFbgo666VKZdnHsezbk6YfplfEuzxvwi+mE0o7eeVBdDD3nZSeCL+9TwkH
         Ojef2nA6gIYY1FefCAjrIuP8K70IkAqTYxjVkl/dLelbu3PjAjE5+ybJuqF9uWdmzqyc
         9rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IZQkmchfIioxGvxwfII0Mb+GhztO+bLNAcrpZHM+gHM=;
        b=iaDmMZzzOseSdsJVSpDRKUNaSu6aYF42sI6kXM14k7FoEqXeEEyysErDW9VGAJB4ym
         KIFPr7cRULgwzLN81o1R7X1DVQTmPEYcgxCDuYZW6yV171fdlPvWeYYQYCtrGwIhi1pT
         xKWpVnsYso26Ow57VR/C2j3AVeaN87JxaOO8vlgnc0rQeF7VUlEKkQGaIeMko+nXKmzr
         uQ18c0XvMD7r0piotzgLeu7RQ95LcJ8gV4Gl2hEJi4Doz7oCGX6vtMWhKx1FndrhRD64
         a5uDJ1LRMUhWUvRNtK4gxX0aq/EvrIPte/aRWtLJAOdPUv+844x10I7yo7/Gd5AqI1Lv
         iMrw==
X-Gm-Message-State: APjAAAUd5ifW65RuKUxAEt1iDMdkLJU/+FObW/R+hgEF1ObRgYlGyUBy
        4IbRIcraIV5IKj6twyDEkTtlCMxlwP8=
X-Google-Smtp-Source: APXvYqy6nkLHkYwyL8VAeRFYM48i04+iJL/GyfS30yDTdMe7US9LguSGzQDHKCqRHLGsmsqset4kpg==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr26988551wmj.13.1565596071588;
        Mon, 12 Aug 2019 00:47:51 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id w13sm43977302wre.44.2019.08.12.00.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:47:51 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:47:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] mfd: max8925-i2c: convert to i2c_new_dummy_device
Message-ID: <20190812074749.GB4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-11-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-11-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/max8925-i2c.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
