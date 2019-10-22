Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74261E00DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 11:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfJVJg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 05:36:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32801 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbfJVJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:36:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so8477248wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YqXqHk50UmDNEMYXTSHPPhm4w8EIzR88JCsr5CRoHs=;
        b=aGVHsYgnTUvSzWqxkgDanmOAat4LYpbPxLmx2ADBlcbzp7QiYvVsQnpy8U4e9sdlqk
         r4T+Mtq7tgm0lj8K12o6lyV6AithxP6WkNF/WaL4ZRc7hWiQiKGVft9Y5ktPWjQD7bBm
         zP/z3wGQr4utEDtjRQmJ3PwIsly2omlqgMho4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/YqXqHk50UmDNEMYXTSHPPhm4w8EIzR88JCsr5CRoHs=;
        b=obeiwOUoUrfohM4McgXcoYyOUdbZQr/CxMwgNh3tsNFXSQXdngGznmR+TezVr6DMO8
         i4MTpV0vkTMOH/9RC3qe9FqYguumS6YW/WOMc/DpTA2ZHKKB6O3ZxJilrZWrTXf8z+zY
         72+E3VCnKCTTQyojSjZ76hN1h4MsPJTCh/51DWCoTbuN+/+RyWOUAg8p2W92gLCOa0lv
         WjimziHzrfKlLlil4fxSUkucAXb1O9m6bfM1PqiDwQVCprBwkliybQD50rPvx2zH8P6c
         nP2MKWW3IJGoA/Y1ajTaThmJl15tuTsPCscC1GbG3RhmT/Utgwv22npCFxxDEZ0g7s/1
         mj0g==
X-Gm-Message-State: APjAAAVgTs2TgJNf3gpBnm9fOIbu1DKEmUoLNkOV3KzES2dPHb5wuncc
        h0Bl/HZBsjAzH5LQ+cKrCBwCvw==
X-Google-Smtp-Source: APXvYqx+JFyqVszkw5BCqDalJWIVq/o7Yqx3WGohJsD0fVYT2Ap02/oIbKtgTtyZt/Vvwhfl85iaeA==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr2748992wrn.199.1571737016806;
        Tue, 22 Oct 2019 02:36:56 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id u26sm18652968wrd.87.2019.10.22.02.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:36:55 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:36:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Fix memory leak in v3d_submit_cl_ioctl
Message-ID: <20191022093654.GF11828@phenom.ffwll.local>
Mail-Followup-To: Navid Emamdoost <navid.emamdoost@gmail.com>,
        emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191021185250.26130-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021185250.26130-1-navid.emamdoost@gmail.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 01:52:49PM -0500, Navid Emamdoost wrote:
> In the impelementation of v3d_submit_cl_ioctl() there are two memory
> leaks. One is when allocation for bin fails, and the other is when bin
> initialization fails. If kcalloc fails to allocate memory for bin then
> render->base should be put. Also, if v3d_job_init() fails to initialize
> bin->base then allocated memory for bin should be released.
> 
> Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 5d80507b539b..19c092d75266 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -557,13 +557,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>  
>  	if (args->bcl_start != args->bcl_end) {
>  		bin = kcalloc(1, sizeof(*bin), GFP_KERNEL);
> -		if (!bin)
> +		if (!bin) {
> +			v3d_job_put(&render->base);

The job isn't initialized yet, this doesn't work.

>  			return -ENOMEM;
> +		}
>  
>  		ret = v3d_job_init(v3d, file_priv, &bin->base,
>  				   v3d_job_free, args->in_sync_bcl);
>  		if (ret) {
>  			v3d_job_put(&render->base);

v3d_job_put will call kfree, if you chase the callchain long enough (in
v3d_job_free). So no bug here, this would lead to a double kfree and
crash.
-Daniel

> +			kfree(bin);
>  			return ret;
>  		}
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
