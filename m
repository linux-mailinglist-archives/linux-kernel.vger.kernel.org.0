Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9255B81FD5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfHEPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 11:11:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36595 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:11:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id x67so28296045ywd.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xpk6f+iULzta9MKqDdvJJrwYV01nAnI8/sskf5srO6w=;
        b=Yc8iF9Tg6K4ZUygMSzIbAg7TgFHqn+DDIs7uLPE5xrDqID2IWXqNk6LvPQ9rUJHn/y
         iwBv+kyYjwO2lD6X/Fbjg+YcSnkIRz0Leri50AKvtchFjaw+ayZguSVOSk2X/dILnpWv
         l05vTy1Q3eSFfnRT62uEMfRaxksSOQIg4guRvn5xGyPW/ul2eM9FFdAE7qOmM6HojDz0
         hxSRDLNwD1Y46nxRF8OvkBl4oPTboz1hP1ZPsSs4wUZj6mCajEVFQtOiN5fzjDm955Jb
         YEDhkh4JZe7a4k1yOwZ76mQBkUFzfK0sAxWkzheCnCCnGz6AvAqPROj/zx2UuM4Ya+HD
         ntyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xpk6f+iULzta9MKqDdvJJrwYV01nAnI8/sskf5srO6w=;
        b=oFPgvFw3CN3OjH5ZqS4lNmKUgExNNVdBpnegfVs+K9Txi4MOnqf2AbPkX7enIIn/vm
         4l1wX9cUCc/g3q6CkIqcPKfug2nQUujdd+8uzM69Gj6skONSbDKOw0Br9LYn/uKHndMF
         E0VwocUMEBWGNv3c9axuviLEEvC9LS1mdDnJ5HymaovS112iGH4wOdrSo98rCOQfwLmI
         6LJIR4ew3DeOZzlN/KyIBpRlbZPOU6TjqN4kg4Z1S5HrrcvgJw3RbRp/DxbXjlGES99C
         +zRc8LRwbSL2DskzMfhv6KvyghqzjF7GkroQ4TnptEfI5w5GNHaDPyb9eDcQ8psJRAWE
         zQ1Q==
X-Gm-Message-State: APjAAAWaHsj5b1arFqnFagKV5kkLOqOa0fHq4GYHVbTcA6Wt05puNfeY
        3JfK/sTtK/p22+4drP5jVnDl2g==
X-Google-Smtp-Source: APXvYqwucyKIizPhyNVHyc8xvnzNgJysm59poTBqYa8cImRwlOnzSuOS8zREscvyu0uqoevbAyXDUA==
X-Received: by 2002:a81:1d11:: with SMTP id d17mr96208542ywd.9.1565017865628;
        Mon, 05 Aug 2019 08:11:05 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id w188sm18900454ywc.93.2019.08.05.08.11.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 08:11:04 -0700 (PDT)
Date:   Mon, 5 Aug 2019 11:11:03 -0400
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
Message-ID: <20190805151103.GY104440@art_vandelay>
References: <20190802184616.44822-1-dianders@chromium.org>
 <20190802192629.GX104440@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802192629.GX104440@art_vandelay>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:26:29PM -0400, Sean Paul wrote:
> On Fri, Aug 02, 2019 at 11:46:16AM -0700, Douglas Anderson wrote:
> > In commit fe64ba5c6323 ("drm/rockchip: Resume DP early") we moved
> > resume to be early but left suspend at its normal time.  This seems
> > like it could be OK, but casues problems if a suspend gets interrupted
> > partway through.  The OS only balances matching suspend/resume levels.
> > ...so if suspend was called then resume will be called.  If suspend
> > late was called then resume early will be called.  ...but if suspend
> > was called resume early might not get called.  This leads to an
> > unbalance in the clock enables / disables.
> > 
> > Lets take the simple fix and just move suspend to be late to match.
> > This makes the PM core take proper care in keeping things balanced.
> > 
> > Fixes: fe64ba5c6323 ("drm/rockchip: Resume DP early")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Reviewed-by: Sean Paul <sean@poorly.run>
> 
> This should go in -misc-fixes and due to some... administrative reasons... I
> will leave it on the list until Maarten has a chance to ff to -rc4 on Monday.
> I'll apply it then so as to not require a backmerge.

We're no longer able to ff drm-misc-fixes since a commit came in on Saturday, so
I've piled this on as well.

Thanks,

Sean

> 
> Sean
> 
> > ---
> > 
> >  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > index 7d7cb57410fc..f38f5e113c6b 100644
> > --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > @@ -436,7 +436,7 @@ static int rockchip_dp_resume(struct device *dev)
> >  
> >  static const struct dev_pm_ops rockchip_dp_pm_ops = {
> >  #ifdef CONFIG_PM_SLEEP
> > -	.suspend = rockchip_dp_suspend,
> > +	.suspend_late = rockchip_dp_suspend,
> >  	.resume_early = rockchip_dp_resume,
> >  #endif
> >  };
> > -- 
> > 2.22.0.770.g0f2c4a37fd-goog
> > 
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS

-- 
Sean Paul, Software Engineer, Google / Chromium OS
