Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63AD12E033
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 19:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgAASsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 13:48:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53167 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAASsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:48:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so3996768wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=B/sd6xhXXpuwJBp+kaINuvIW2l7yFRLjwKn3IBy/+os=;
        b=GwN9qvf4LyBDGZZaZWrXzo6BOFPnDtlajbeoG1UTE/0he02g17nC+ZaXG/VeP3MqEz
         dSVkwPOfAYxs8uDYJHPuzA3nlQRybla75ewusneNntG9ESChtMM8YiHh4d8sJuDmOKr9
         //vRsoHz+djvkDj9oGpkaNBFNdGRVjmZNFC20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=B/sd6xhXXpuwJBp+kaINuvIW2l7yFRLjwKn3IBy/+os=;
        b=p+dkT/ik7b9LYnQFAlrAFZ1CJGcrocv9m+4y3JQvHlvfUIMBDY5FV9OtfPNB5PHAuM
         m4h7cv2bGl2EQDR/Ji3KDmYxUKEAPmxU51WMGgL8nkQM5ihqPqiHqIfvnD4s8L7NGo/9
         pC1eTIcaA5o8JqMgukI0RvG5k3AI+6mpTi8PcDbhZWucCt8A3PcFjNAGJRQbqixL7KAb
         iEJmo0zLvnX2daiw1E1+dqZFH8xNI/MbYD45nUq5YLjXsN3g67HpiEB0CPYjY8rJaC9g
         PJR5FzfpjA6+7D1t0oGzUjDTa+5uOETvDXRZIUNd8E5zFSl4VeSpWS3uKaKWKn/aIDc9
         EwXA==
X-Gm-Message-State: APjAAAWyM5H3Q2VofLj4hoYUxRCrHt1chiXC9D6eR9rIc/NFtzTIdFau
        gO9aoLG8jhUbqb9ri+ke9U8jDg==
X-Google-Smtp-Source: APXvYqyW3tBV/7q+H7o4VFXihIgDTuFVkq5L4vmpPa6c4No7kXIJpZyFMbaLSpsRpDkVeJBAjJmRqw==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr10380009wmc.82.1577904532065;
        Wed, 01 Jan 2020 10:48:52 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.125])
        by smtp.gmail.com with ESMTPSA id h17sm56232629wrs.18.2020.01.01.10.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 10:48:51 -0800 (PST)
Date:   Wed, 1 Jan 2020 19:48:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: remove set but unused variable.
Message-ID: <20200101184843.GA3856@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        bskeggs@redhat.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191231205607.1005-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231205607.1005-1-wambui.karugax@gmail.com>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 5.2.11-200.fc30.x86_64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 11:56:07PM +0300, Wambui Karuga wrote:
> The local variable `pclks` is defined and set but not used and can
> therefore be removed.
> Issue found by coccinelle.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> index 362495535e69..f607a04d262d 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> @@ -54,7 +54,7 @@ static void
>  nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
>  {
>  	int pagemiss, cas, width, bpp;
> -	int nvclks, mclks, pclks, crtpagemiss;
> +	int nvclks, mclks, crtpagemiss;

Hm, reading the code (just from how stuff is named) I wonder whether the
original idea was that the calculation for us_p should us pclks, not
nvclks, but given that this code is as old as the initial nouveau merge
probably not a good idea to touch it. Plus I guess not many with a vintage
nv04 in working condition around to even test stuff ...

Ben, what should we do here?
-Daniel

>  	int found, mclk_extra, mclk_loop, cbs, m1, p1;
>  	int mclk_freq, pclk_freq, nvclk_freq;
>  	int us_m, us_n, us_p, crtc_drain_rate;
> @@ -69,7 +69,6 @@ nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
>  	bpp = arb->bpp;
>  	cbs = 128;
>  
> -	pclks = 2;
>  	nvclks = 10;
>  	mclks = 13 + cas;
>  	mclk_extra = 3;
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
