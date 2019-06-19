Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8F4B6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfFSLF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 07:05:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35167 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfFSLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:05:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so1374061wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xl41q9hNOc/g9EYGMDVv6e3kqykgA8u4AjfGsUyaRHQ=;
        b=JdBKTLDrjuc2YV4PWxdd20VcvL3iFMegCFa3Q6/uzxvqugEYTjmLnyj3TVyv5+lys4
         PVN+wGlTXU/nam3nxiTvzOWWzj9hPkoHQ+xbPGb+E3B8NyUvnBV/CfvX4yvCMHuiSmFt
         3AqbNmYSEqL1Es3/1h3AwunxKHbRwcaLzPU1yKE6dk5/1OO04B5XEPyBvkL2tpm1Flem
         EFAI8EhR6ft5+W4a1Rcw04rvaT/1+0dFW8gjs1eG/PoBy2xi+eySWVD8tVEPwTsoKRwn
         F9bSd1N5bhkLh+fdtRtGYuKSbiqJP1LG/v1NxcE+PbhV/JwyBeI09YxUpy7B5UiSy2q3
         Vipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xl41q9hNOc/g9EYGMDVv6e3kqykgA8u4AjfGsUyaRHQ=;
        b=OLJlwSBCYtOEhnJjgcGFX/1c21VGIHjsf4+QjORgPGiZXnydM6uzQ++j6pNFplsm++
         sJIiSCb0d7WEmdBxI3DoxUGNrX72MJxLHGxVyH/tJK52A3/TtMOBMP/qgsEHuDwMvaDc
         XxF2xMf3rz3oDM7ZqKrjvpRvKqGW5PyxZmmWI9uey0KSmU6WT5rFVME9Sa5q9JPjkesy
         F6rpi69N1wyrZazMSCEya0glTOROWTihqCqS1ZTwqdVPoNgYZ/0/hgovzq3i/fBr3Sza
         wumFXpL/htlDk1l1m9fIUDeeJmOq4Xj2XBl+0NkydpocRby21DDyWtHx0Ys2nEiL2ryI
         H8MQ==
X-Gm-Message-State: APjAAAWbfzmaJnSuTLRJGhF1W4+qnvOX/K2mVTSHmLMmnywbMjnrRf5c
        L20LnPcrx8R4YrhLH5e7trqgIw==
X-Google-Smtp-Source: APXvYqy0Vj4gusY17LcUMJkB9rXJuNIK1DSDRJXpXkTwo5jvGI4HfycfIswmjX9F29RGTZ3uyd8gDw==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr7615451wmj.2.1560942356321;
        Wed, 19 Jun 2019 04:05:56 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u6sm1599073wml.9.2019.06.19.04.05.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 04:05:55 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:05:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 1/4] MAINTAINERS: Add entry for stable backlight sysfs
 ABI documentation
Message-ID: <20190619110553.zyz3jqshscqxqtum@holly.lan>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613194326.180889-2-mka@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:43:23PM -0700, Matthias Kaehlcke wrote:
> Add an entry for the stable backlight sysfs ABI to the MAINTAINERS
> file.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Well spotted. Thanks!

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..d51e74340870 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2857,6 +2857,7 @@ F:	drivers/video/backlight/
>  F:	include/linux/backlight.h
>  F:	include/linux/pwm_backlight.h
>  F:	Documentation/devicetree/bindings/leds/backlight
> +F:	Documentation/ABI/stable/sysfs-class-backlight
>  
>  BATMAN ADVANCED
>  M:	Marek Lindner <mareklindner@neomailbox.ch>
> -- 
> 2.22.0.rc2.383.gf4fbbf30c2-goog
> 
