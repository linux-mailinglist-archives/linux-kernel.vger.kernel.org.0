Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807B81809D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 22:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgCJVEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 17:04:11 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44380 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJVEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:04:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id u24so9388478vso.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdbG+NqozjHb3DuLnEyD+xmAePEHTJeITgREUaZPMNg=;
        b=CngUwdr3bxoD5iC/5lI0WCL6Mqn6nSmpoMEK83K3xN0v08ISyBSVyXb/zcm5ZDQeCb
         PgmUesXLiCxl6wmzOs5WtQIdvBMj/VSdElpEMXjRzX85yI28VD7T7jVb0ccczckgBQ34
         Lm/tL7AYk/ec8oVUMbXgOswT0jyxukaC0XZqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdbG+NqozjHb3DuLnEyD+xmAePEHTJeITgREUaZPMNg=;
        b=fftSwv9ZNecvDUZuijWjsrwcD2eH5nuBFsTmnIhBbsAj3jUi1Pw/Iz49AVeqlkyQx1
         Nlc1aOIH0jMOR88iTosJ/Gh2rgYiEPijv2/yVqf2vUBXfQxLT9qjMmXBKaG7OoVi2o8j
         zjLy2dJ195ZFv1qjkfvD/rkN8BgX92qqkpHF+AFId778UaK+0SCQzGXr/fIo4SLoq/UE
         jdcmUSd+HkzXq8ig4iSp061CWoHuKZ/JOqs05HD1MqEb9rc6hsYy8iNKyaGAVtyux+Ee
         ILWXW0ULJtUpxokFkb8Zi4EUuqs9Af+0a40QQSeaKXu9jofKETBpolHnIqZ+hC14s4ko
         wwRQ==
X-Gm-Message-State: ANhLgQ3uTlymr4cyl3E09b6XNlUXFHkJQ17iE1juY6qA7S2De3u17mBN
        Wbydo9Q4hcuoOu25Bm3B/ic2sjg1RB0=
X-Google-Smtp-Source: ADFU+vukKZkg1TzUcseJwe5+ocYbKzxAhZpM/7iKPacx5+akReKNSViL76PGDmCAIYW8iG2Xm47JsQ==
X-Received: by 2002:a67:fb12:: with SMTP id d18mr2171724vsr.149.1583874249514;
        Tue, 10 Mar 2020 14:04:09 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id y23sm8497627uay.0.2020.03.10.14.04.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 14:04:08 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id b2so2774578uas.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:04:08 -0700 (PDT)
X-Received: by 2002:ab0:a90:: with SMTP id d16mr8706162uak.22.1583874247823;
 Tue, 10 Mar 2020 14:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200303174349.075101355@linuxfoundation.org> <20200303174349.401386271@linuxfoundation.org>
 <20200304151316.GA2367@duo.ucw.cz> <20200304171817.GC1852712@kroah.com> <20200309101410.GA18031@duo.ucw.cz>
In-Reply-To: <20200309101410.GA18031@duo.ucw.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Mar 2020 14:03:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4u90Q3-QLHqUSGQkNZOXO4HZ_euVXCSUncQj0bhH3dw@mail.gmail.com>
Message-ID: <CAD=FV=X4u90Q3-QLHqUSGQkNZOXO4HZ_euVXCSUncQj0bhH3dw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix leaks if initialization fails
To:     Pavel Machek <pavel@denx.de>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 9, 2020 at 3:14 AM Pavel Machek <pavel@denx.de> wrote:
>
> We should free resources in unlikely case of allocation failure.
>
> Signed-off-by: Pavel Machek <pavel@denx.de>
>
> ---
>
> > Can you submit a patch to fix it?
>
> Here it is.
>
> Best regards,
>                                                                 Pavel
>
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 83a0000eecb3..f5c1495cc4b9 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -444,8 +444,10 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>         if (!dev->dma_parms) {
>                 dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
>                                               GFP_KERNEL);
> -               if (!dev->dma_parms)
> -                       return -ENOMEM;
> +               if (!dev->dma_parms) {
> +                       ret = -ENOMEM;
> +                       goto err_msm_uninit;
> +               }
>         }
>         dma_set_max_seg_size(dev, DMA_BIT_MASK(32));

Looks good.  Error cases both above and below your "goto" both already
go to err_msm_uninit(), so it makes sense it would also be the
appropriate place for you to go to.  ...and no extra cleanup was
needed for dma_parms allocation since it was devm.  Thus:

Fixes: db735fc4036b ("drm/msm: Set dma maximum segment size for mdss")
Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks for noticing and fixing!

-Doug
