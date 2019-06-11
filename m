Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A3D3CE26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbfFKOLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 10:11:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40353 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbfFKOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:11:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so3098303wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qc5EFkVTKGr6dYAxoaP7PbGa9RFFb0Yu3NvNTqCuC7g=;
        b=PG0OjEu1w3GysO55d1AWF1JxGrKq//m5h/+lqkdUO4kaTlmGHYQkTZfi5j2mYvLMxF
         voKWf4tqIhrTsY9L4GnOTVRdkcQTdMek5MfrPc3nxSNFAMB3Up8vAf2wnBjiv6jDA/f1
         PXrO1HfQn7++uNe2BSjhTwc05BzyqrvgZYUJZrcxBZ4teyFkmmgaBSL5H4Q69nG+PSxm
         z4Fi1g0EI5qm6iG+Yf7J1mEU0kEWIIWJ1YP4tBPqfVzEDWxR65a+AT9PBvZtJLCYK14b
         1bvjtCf/Nug5Zf8GiWEBE8FXdY5lS1vOSZv05gmHphpBN6t40O6TpdSG1ZF0jiWNOJh8
         7NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qc5EFkVTKGr6dYAxoaP7PbGa9RFFb0Yu3NvNTqCuC7g=;
        b=gw3CDHxLgvhcXjprYMRRnGS0pC1dv2MtJ8dBwba43uxS/beU6n5KaxiaX9V1CJb7s9
         z2jkjQISLU9qX9WzzUgaveLe51SkWztPB8HsPzr84IBKTFha5hQqxPEc0hEZfyNBrjx4
         Q3TgfhtAswhxDz3dtCF8ahYeBIWxigvIj6KcxKbH3AYWqyBdmppDQFTY3gcrsHYEBVmJ
         iC8pd0pnv9Y0oaJ1IWAfVhodAevF3KyJpNXl09aRZEg45e/DlPhE3Q2Hpqzb594docO9
         w2kixH5jzrBqFtlDX3GdSNYRUyZ4vHWFVdOowolrc7YM6JDCNmoMjijaYtuCsygHhsOS
         mP/w==
X-Gm-Message-State: APjAAAUN+zaGzU4KWCcwMDiuEadjItvEu+MY2hVMJzeO4rJdi8N/DwdP
        6BXYutxoqsx0lMoORi/wHFgSCQ==
X-Google-Smtp-Source: APXvYqxCrGFZDkB6E92/L2zQkhPrLCT80Z0/I9uddbexDlRQYg1pdUdK2tzvVwqbMxgtCW6DRYNgYQ==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr4133085wmh.76.1560262287645;
        Tue, 11 Jun 2019 07:11:27 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u23sm2501379wmj.33.2019.06.11.07.11.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 07:11:27 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:11:25 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 33/33] backlight: simplify lcd notifier
Message-ID: <20190611141125.w6vhytsue7toif3g@holly.lan>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
 <20190528090304.9388-34-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528090304.9388-34-daniel.vetter@ffwll.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:03:04AM +0200, Daniel Vetter wrote:
> With all the work I've done on replacing fb notifier calls with direct
> calls into fbcon the backlight/lcd notifier is the only user left.
> 
> It will only receive events now that it cares about, hence we can
> remove this check.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lcd.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
> index ecdda06989d0..d6b653aa4ee9 100644
> --- a/drivers/video/backlight/lcd.c
> +++ b/drivers/video/backlight/lcd.c
> @@ -30,17 +30,6 @@ static int fb_notifier_callback(struct notifier_block *self,
>  	struct lcd_device *ld;
>  	struct fb_event *evdata = data;
>  
> -	/* If we aren't interested in this event, skip it immediately ... */
> -	switch (event) {
> -	case FB_EVENT_BLANK:
> -	case FB_EVENT_MODE_CHANGE:
> -	case FB_EARLY_EVENT_BLANK:
> -	case FB_R_EARLY_EVENT_BLANK:
> -		break;
> -	default:
> -		return 0;
> -	}
> -
>  	ld = container_of(self, struct lcd_device, fb_notif);
>  	if (!ld->ops)
>  		return 0;
> -- 
> 2.20.1
> 
