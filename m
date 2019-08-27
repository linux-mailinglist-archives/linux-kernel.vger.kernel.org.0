Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198429EC0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfH0PJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 11:09:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38764 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfH0PJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:09:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so3433924wmm.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Qq0g1XL+PbeMFceNKBAmH7iRX3/JfNtU8Nq/VEW2ks=;
        b=PLln4fpd0YhSY8pSpNl44r1UmZv2vqlKnFyViLPoAd1mnWo4OIjHPPURJoj2rKCdBh
         fAWeNLWPIxIhMOiIMJA6yOibIUt8iBghTSzVn1Xefjz3tcRqiUd5CTSWEz/u9PL1xm5u
         7HDylFoozw9wrhl2n9guPuDxSp92vS3sMXAsnezNFd4nMGan3Bc5Yidb4F7FGDDEeSFB
         o0AUevQMHGDtP4gvfVqumaCHgjwoZfzHIC1N2/Hzuh64J7al1OCBZjvDhQcnUagqsB2l
         aWple+A7KtLS+xtjGCUs4yQL7oT+MnvB3fM3mgonL8xNwMUO/UsaPp34PTshPZ3P2F3O
         Taaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Qq0g1XL+PbeMFceNKBAmH7iRX3/JfNtU8Nq/VEW2ks=;
        b=sLnXIzRWiDb7SbLa25GIcjV0sH6CqgKsjwpBoIOIcXfQ2jG7dC3R71chlbuWbMhShe
         UOs8V4wzxwemL90k9FF1La1nEZXlDDd4eSAK7BEXN0kvKSLmgz/1hPbYgQDft9ssSxZM
         0ocMHe42w9KOErPgck/c7WDk7EcwENuxVsLhVhtWzvkbK8gusYdDHU23GMf+2JuEBull
         zO8Uo7U+OrF+S1XGBMSm1eMHI6yGrGO2uUS9igFWfYxzw75eXhdCtRsCn22npXslSTTY
         mDBN4QIEnC6yS469M3y/3yDkodySYMzM8DVTet/e6P5Qk9rl0efVeB6N9ywZn5SgCTyQ
         0QYA==
X-Gm-Message-State: APjAAAWsTJN+Bwd6bQ2v1scvwyRpbYFub8D0YHDkcdumFh+8LDby9/SX
        PBfSQ+0GiHYk4jI0q3e5yxfNwU2sHjpC+6XYoDc=
X-Google-Smtp-Source: APXvYqwXAxK4qE/kfjKMd/jlTPp+yDppDz4AMPQr+Hz42Vgnu4UxoeuKdCuXbSMp+hx7UWIC0reBZcWVTh99hk0ZtFo=
X-Received: by 2002:a05:600c:352:: with SMTP id u18mr29119665wmd.141.1566918591384;
 Tue, 27 Aug 2019 08:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190827064425.19627-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190827064425.19627-1-yamada.masahiro@socionext.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 27 Aug 2019 11:09:38 -0400
Message-ID: <CADnq5_OUC_Wtwe2+w-DRtEUoBEmNa6GkoQ10_qD8=28xF32jBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: remove meaningless descending into amd/amdkfd/
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?B?Q2hyaXN0aWFuIEvvv73vv73Dk25pZw==?= 
        <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 3:29 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since commit 04d5e2765802 ("drm/amdgpu: Merge amdkfd into amdgpu"),
> drivers/gpu/drm/amd/amdkfd/Makefile does not contain any syntax that
> is understood by the build system.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied.  thanks!

Alex

> ---
>
>  drivers/gpu/drm/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 9f0d2ee35794..3f9195b7ad13 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -62,7 +62,6 @@ obj-$(CONFIG_DRM_TTM) += ttm/
>  obj-$(CONFIG_DRM_SCHED)        += scheduler/
>  obj-$(CONFIG_DRM_TDFX) += tdfx/
>  obj-$(CONFIG_DRM_R128) += r128/
> -obj-$(CONFIG_HSA_AMD) += amd/amdkfd/
>  obj-$(CONFIG_DRM_RADEON)+= radeon/
>  obj-$(CONFIG_DRM_AMDGPU)+= amd/amdgpu/
>  obj-$(CONFIG_DRM_MGA)  += mga/
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
