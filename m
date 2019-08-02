Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C1800DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 21:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404672AbfHBT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 15:26:32 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46853 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404439AbfHBT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:26:31 -0400
Received: by mail-yb1-f194.google.com with SMTP id a5so27240345ybo.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oolSjnNy8o69qEXumrcNervgTiZ+0C/a0z2WrugF1/U=;
        b=aobcd8eDORReviFPdWXwJ+owjz07tUDlmFTI8N2UVHjRvHreP3t+H60+aVprbNizpN
         DVp9kUtL4tHn9qZ1XKPX2XWMn2+X7vva5tuYoKXNJIvUQE8qgVSBtEEc+9BLd77TgAle
         9ugd4NRMK+0DTYvGMi8PGMKCXL62gEqNiCxYBbvWVGEvd85Bk1yR58GuU2AK+YI3/j4T
         Ya7uA2+jqRuqLBOtDwGQj/oXyvmwAIsWbYU++bAVC7r1PUqCnQzZ+//dqKBBp/aGjoRN
         R7AJmQDz+uVBx9kBwjBALruxa0mpEMTTGWoxf63Z/Czq9klDBcDv9sA+JKzqtWnKyicb
         nJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oolSjnNy8o69qEXumrcNervgTiZ+0C/a0z2WrugF1/U=;
        b=Nt/Dpe3nn+Zllxu8pZAUrJRPVEvYfjTW2kNewMdKvABJ5LuNiICu9FSB4qcG9LXnQR
         IRhC+PnmtPnA9B78XWpCP6v66HhaVb75m0DCe/dkxM9yc1H5rsFgrfdmPBc6lvIUYa9n
         GSJmYiM1XmQwxtSzTDdB2O3deoSSrnlTQVswIuCbvvSezFay5lwpW1FHwpimxMjJh5Mr
         fRWMzg6yS87jNSc16IMfynkHq4blQfanioaGd/eWCiiKKsn9Htq0NvOx46MOZ8GgMUMJ
         1nxTv2AB4CgTaPx/4IevgqczghQE72CU+HZaC6DNFuXjkHzg9FULNxxZSRZLK9M6wB9D
         Z1Lw==
X-Gm-Message-State: APjAAAXTwi9VrSm0w3+B5N8zZd/uKbnmOQhtOO4Rm5xv9SY20//N1f/O
        DNcmEfIQDK+CknrQHE8zDJrWqQ==
X-Google-Smtp-Source: APXvYqyzp76n9T+wWTNjzFV6D8CqVkpC4vTtN8rYlshUPMNLk6fs5ugiybl1QqkrOcbaUwfiGlN7aQ==
X-Received: by 2002:a25:9209:: with SMTP id b9mr74080808ybo.271.1564773990707;
        Fri, 02 Aug 2019 12:26:30 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id p141sm17544110ywg.78.2019.08.02.12.26.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 12:26:30 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:26:29 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        seanpaul@chromium.org, linux-rockchip@lists.infradead.org,
        mka@chromium.org, Sandy Huang <hjc@rock-chips.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/rockchip: Suspend DP late
Message-ID: <20190802192629.GX104440@art_vandelay>
References: <20190802184616.44822-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802184616.44822-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:46:16AM -0700, Douglas Anderson wrote:
> In commit fe64ba5c6323 ("drm/rockchip: Resume DP early") we moved
> resume to be early but left suspend at its normal time.  This seems
> like it could be OK, but casues problems if a suspend gets interrupted
> partway through.  The OS only balances matching suspend/resume levels.
> ...so if suspend was called then resume will be called.  If suspend
> late was called then resume early will be called.  ...but if suspend
> was called resume early might not get called.  This leads to an
> unbalance in the clock enables / disables.
> 
> Lets take the simple fix and just move suspend to be late to match.
> This makes the PM core take proper care in keeping things balanced.
> 
> Fixes: fe64ba5c6323 ("drm/rockchip: Resume DP early")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

This should go in -misc-fixes and due to some... administrative reasons... I
will leave it on the list until Maarten has a chance to ff to -rc4 on Monday.
I'll apply it then so as to not require a backmerge.

Sean

> ---
> 
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 7d7cb57410fc..f38f5e113c6b 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -436,7 +436,7 @@ static int rockchip_dp_resume(struct device *dev)
>  
>  static const struct dev_pm_ops rockchip_dp_pm_ops = {
>  #ifdef CONFIG_PM_SLEEP
> -	.suspend = rockchip_dp_suspend,
> +	.suspend_late = rockchip_dp_suspend,
>  	.resume_early = rockchip_dp_resume,
>  #endif
>  };
> -- 
> 2.22.0.770.g0f2c4a37fd-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
