Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9AD7AEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfG3RHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 13:07:40 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45343 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfG3RHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:07:40 -0400
Received: by mail-yb1-f196.google.com with SMTP id s41so1270118ybe.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qks3K4GGrulb2C0Ck+/3WZ7Ox9e+XzeggPI4nq1FENI=;
        b=KTozmroQs2NoFwB/7cl52MZhpQHOqD8frHClUzchrD+1HxPb9jxsHarpK3lbMg14oL
         LvrYfMv1OxYxEk6jTm/oYLAA1RdIdt90n8LIv84ycM//5KWB2QKFMMRnNP2+q294Y/Ip
         cuQdCy/DmyXBXHobGkSOPgzMDflCjWKmxCI2Gna6sU4P6WSEDL8WKeRFuFWX5o7CyMIF
         wZyKmBnSXQ1KHVTuWNQi9UsCTyRX35TUPnXApNzYCjn7YYiHM9VhcNZSbK+PsB7WjA7t
         EN1DNM4JQq0J0XMWbU6stHC55kbJswvAXgKDVC3C0YC0OmgqC4JCqrQVFSC9oXShtX0M
         E4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qks3K4GGrulb2C0Ck+/3WZ7Ox9e+XzeggPI4nq1FENI=;
        b=RiNALAaj7EdN37MOkeij9AuzlBt+/YK94djimAMBca45yBVyH4VCYcz/RKef5pK47q
         Ya8HgFiQuPqcqcRgwto0W4C3qljrWDBC8AwAA4j1yWy9P5oYeu9Jcv4GJll0kuTFWnUh
         6AGhXTZtnjbzpIlu9EHBtsyPyIlqlzHwUdMdtlUk5ZD8fMHTz2v+JRuDRZlHpKzzbfQz
         ISh9rTuaKNJ16Tr8rMp58TL5doyDpFFREo1WdFshhqJSr3u78b4s74x8r+aTMdRReFaa
         ciz4tdyiy/KQgNv7qTIx7mL89Y1CuUUxUUB/OIG1i5xpdQz/3ikUy/GIcYuNqE19CqZW
         d99g==
X-Gm-Message-State: APjAAAXTJk2ioZsrXMHqs64QGYOVpaPPvk20XnFfPnkZq4/mF2Gwy9+w
        mUyxaxeSPjQD4oqCi1pnYxgpFA==
X-Google-Smtp-Source: APXvYqyyhk5DPM+8bWP0tf2V0lR52Kjy3fuZGEK6h5rkpUxWToTAGb8tO/aypQUexqS+TP4/SxRaKg==
X-Received: by 2002:a25:f202:: with SMTP id i2mr73141060ybe.462.1564506459592;
        Tue, 30 Jul 2019 10:07:39 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id v135sm15374362ywc.53.2019.07.30.10.07.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 10:07:39 -0700 (PDT)
Date:   Tue, 30 Jul 2019 13:07:38 -0400
From:   Sean Paul <sean@poorly.run>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        seanpaul@chromium.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/rockchip: Make analogix_dp_atomic_check static
Message-ID: <20190730170738.GR104440@art_vandelay>
References: <20190730150057.57388-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730150057.57388-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:00:57PM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1151:5: warning:
>  symbol 'analogix_dp_atomic_check' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for your patch, applied to drm-misc-next

Sean

> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index c82c7d5..f2f7f69 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1148,8 +1148,8 @@ analogix_dp_best_encoder(struct drm_connector *connector)
>  }
>  
>  
> -int analogix_dp_atomic_check(struct drm_connector *connector,
> -			     struct drm_atomic_state *state)
> +static int analogix_dp_atomic_check(struct drm_connector *connector,
> +				    struct drm_atomic_state *state)
>  {
>  	struct analogix_dp_device *dp = to_dp(connector);
>  	struct drm_connector_state *conn_state;
> -- 
> 2.7.4
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
