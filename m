Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD02188B87
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCQREg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 13:04:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54702 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:04:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id n8so73889wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ObAO8lewPX3AflqGqqsEgIOkagJMImeMxzpRcMylRvI=;
        b=iFlBHxIsRE10dkGC+K9sL69iB57t/esmERm5mei+203ZMMUaT0x21Tb1gP3p+TCaPo
         EHJht2XolZ1tgKPe42Nw4MVY+eXyWrrD2CjYd7x8Kp7ZzwN1uDhRny127AA96XozMu8l
         hRzgTitP+mBlas/H9SEq4t9G+7j8ELkFyoiYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ObAO8lewPX3AflqGqqsEgIOkagJMImeMxzpRcMylRvI=;
        b=GpL10Q2t0mbiaUJtB47Fs914g6gLnBumFy6znUV2TMSnAxtj6eGbNLkOvSp6giiecF
         d38AdWslGXXni/VQgbhRuKGj2YIdRT0qJ2UcvPlS0N2Iy4EoVwcxpdKJLy7NwqmG9nQz
         UexSyMQr29aljBscDY4lVgFCYAUXqEZL9tAIARSsRHT8saNqTCPUFSr4ixf+Ar2YLQJl
         5vEAh+q3XzvIGjpW3c16AEmXxAZUFivYQUATleT/XQFmagXqErJWRcUg9RyGC0+Zy1YB
         sT8IUPDQCzzibTcDktB+NeBPGWUF4mWgV3ez1XTHYMhDwTH0NqeCev9/RMIXC9ZHwn4p
         wK9A==
X-Gm-Message-State: ANhLgQ288HyO87gj3jEZwmQNIfnsQFCWi/bw55BLrUj3OoaH6n0rgTm2
        1nq398oe0IqnhXDr+bd5lt0GeNUdbfKWdrdu
X-Google-Smtp-Source: ADFU+vtf8dj2MkY7sbusKtJmdk4v9PDgTuJO25WhkTpjF7YXhCbnK1FtHZvjdup433Kfub3tQ9x/yA==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr231550wmh.121.1584464673859;
        Tue, 17 Mar 2020 10:04:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r9sm28323wma.47.2020.03.17.10.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:04:33 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:04:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Igor Torrente <igormtorrente@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] Staging: drm_gem: Fix a typo in a function comment
Message-ID: <20200317170431.GS2363188@phenom.ffwll.local>
Mail-Followup-To: Igor Torrente <igormtorrente@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200316210413.2321-1-igormtorrente@gmail.com>
 <CAOA8r4HieupER-gW4BU9U8YYC+6eLkSzoS2z-KRrbq4XZb40Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOA8r4HieupER-gW4BU9U8YYC+6eLkSzoS2z-KRrbq4XZb40Ww@mail.gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:08:30PM -0300, Igor Torrente wrote:
> Ccing dri-devel and linux-kernel.

git apply-mbox chokes on this, can you pls resubmit?

Thanks, Daniel

> 
> ---------- Forwarded message ---------
> From: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> Date: Mon, Mar 16, 2020 at 6:04 PM
> Subject: [PATCH] Staging: drm_gem: Fix a typo in a function comment
> To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
> <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>, <
> sumit.semwal@linaro.org>
> Cc: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>, <
> Rodrigo.Siqueira@amd.com>, <rodrigosiqueiramelo@gmail.com>, <
> andrealmeid@collabora.com>
> 
> 
> Replace "pionter" with "pointer" in the
> drm_gem_handle_create description.
> 
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6e960d57371e..c356379f5e97 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -432,7 +432,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
>   * drm_gem_handle_create - create a gem handle for an object
>   * @file_priv: drm file-private structure to register the handle for
>   * @obj: object to register
> - * @handlep: pionter to return the created handle to the caller
> + * @handlep: pointer to return the created handle to the caller
>   *
>   * Create a handle for this object. This adds a handle reference to the
> object,
>   * which includes a regular reference count. Callers will likely want to
> -- 
> 2.20.1

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
