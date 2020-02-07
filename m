Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D411551A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 05:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBGEwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 23:52:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39433 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGEwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:52:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id z2so836230oih.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 20:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8urWy+QgrC/YMF1CIIkby5XffaDuEx4UNskBOy8RUs=;
        b=fL8dDpBSRVSlM8FGOuZfEp6zopgEtvglqThCVlfAdJyXUd1xw/bl5PyyXPjVJMmE6O
         xhruU/YngLkt6YE9gdDXeL0++a8tYHMimWtQCT1caaDsqrcfcL2TXNgDO46Tg6IwfPBc
         N68ToIQHl33MkLSupJmZeDaLwA89c5qw5fqL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8urWy+QgrC/YMF1CIIkby5XffaDuEx4UNskBOy8RUs=;
        b=buW50sCiWmOq6HR3CDFne9wkLkPpewINierjBAmY+9SjxJuUrae5vZGAIg87Pz8X0n
         bz2a5ml2tZtFLzuutHd6ykJ9eBY0szmY+rrOWMPRXQNlQKB5mRhBCzN0eXHLgM+PTY0V
         B+gspUNhvmLLn+szfZfgbCks+ZFYZA5tccJairiNzHuigSa0PacYHFOpltOa2dp2ZCxL
         QJeFF3tvwgaA9Yjn4SKJAxH1JlLwQ7SGUFkbN7VKJVrmveqJnwTx9Uh5nmYvdE8bQ3JT
         ALd81h4mASJzr1A7fdNwMDRs/H1Q/atGEK96r6QEliT2KgXZk3VfqEJ5aJcafYpSaMeq
         MN7Q==
X-Gm-Message-State: APjAAAXNbdAFFDZ36YvBjdjog9W/WLH9GZ/h1FUnKHlTJWAgdD0bBaAP
        lBrmW8rlZ3LtVlZIbwZnvYZB01jB88HpUT1tC5KaK3d/j4bKOg==
X-Google-Smtp-Source: APXvYqxiVoCiey9ViAoCoUEG25fwaEz1f1ghn+enzI8QQgzUweirJ8Q8HY0XByHEr76nc8HhKhRjfHYPpevMD5tHvRo=
X-Received: by 2002:aca:ebc3:: with SMTP id j186mr871922oih.15.1581051154041;
 Thu, 06 Feb 2020 20:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20200206140140.GA18465@art_vandelay> <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
In-Reply-To: <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Fri, 7 Feb 2020 15:52:23 +1100
Message-ID: <CAEJYR+nhwfqOK3Ogy=w_D9uS8uV-YsPckactgTX0nAe-_MKsQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Find the cursor plane instead of hard
 coding it
To:     dri-devel@lists.freedesktop.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the confusing thread. Please apply the above patch:
'drm/mediatek: Find the cursor plane instead of hard coding it'
before Sean Paul's original patch:
'drm/mediatek: Ensure the cursor plane is on top of other overlays'

This way authorship is correctly preserved, but we do not introduce the bug.

Thanks


On Fri, Feb 7, 2020 at 3:23 PM Evan Benn <evanbenn@chromium.org> wrote:
>
> The cursor and primary planes were hard coded.
> Now search for them for passing to drm_crtc_init_with_planes
>
> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> ---
>
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 7b392d6c71cc..935652990afa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -658,10 +658,18 @@ static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
>
>  static int mtk_drm_crtc_init(struct drm_device *drm,
>                              struct mtk_drm_crtc *mtk_crtc,
> -                            struct drm_plane *primary,
> -                            struct drm_plane *cursor, unsigned int pipe)
> +                            unsigned int pipe)
>  {
> -       int ret;
> +       struct drm_plane *primary = NULL;
> +       struct drm_plane *cursor = NULL;
> +       int i, ret;
> +
> +       for (i = 0; i < mtk_crtc->layer_nr; i++) {
> +               if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_PRIMARY)
> +                       primary = &mtk_crtc->planes[i];
> +               else if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_CURSOR)
> +                       cursor = &mtk_crtc->planes[i];
> +       }
>
>         ret = drm_crtc_init_with_planes(drm, &mtk_crtc->base, primary, cursor,
>                                         &mtk_crtc_funcs, NULL);
> @@ -830,9 +838,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>                         return ret;
>         }
>
> -       ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
> -                               mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
> -                               NULL, pipe);
> +       ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, pipe);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.25.0.341.g760bfbb309-goog
>
