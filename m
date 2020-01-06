Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49B7131127
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 12:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAFLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 06:08:15 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43489 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAFLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:08:15 -0500
Received: by mail-vs1-f65.google.com with SMTP id s16so29819465vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmvJO09F5LptWX15W1OhA2q6USBr8Wc7nFJ/W9cZZHw=;
        b=FojhqejLBBf4FzD/fo8Nen8d6lR5fKNNbSgmVyxYY/nxqx7Ii3l1aUp6lnO/QqX2Pz
         w+aNWTUNarT2cSeO3gTxZ3qloDraoApx3WowgZzn5BL6DrXazw4aWE3R5S6N2o9dsEzk
         R8p/I3mmrgYXrARi8y8yfLdYKOQNZptGr0Db+7+pfO8A2eVeGloRoTp5utubqlVS1vC1
         aMBxdHRRa37K+vX8iaAJYXqVisCw0gpCwHcTSrWE5YkZJSneaf/vlIIQxbjB11sCwHns
         3u3ge8PL+/W/7ptPyjn5w7Y6rwkEVF/xogLScbAKh1ZzpvYUS120EzNl+0BFwXJkDVcx
         8iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmvJO09F5LptWX15W1OhA2q6USBr8Wc7nFJ/W9cZZHw=;
        b=iF/yCVu+HFWnXVZIYsDDwek+rGMbYU13x9DGMnLtL3BJD4f0k2g+Q9OZEgkY2NhraN
         Q//r1AqLCqUIrlXE3ksZGPn43nru//IbIA69EbQ/3bbpo1T+YCVLwz70DcB85QV2BGGC
         Ad4GsgQFRPYcPklyz+Kex+l3LtdW1RpcgghTyXUJViI+SJQOL73wZNYQtnFTnjp0H+Bc
         hAiiB2EvhVwGUKHNnEkBFBGYheiate/iqF38naHvQhxBGsyRGfH2pbwhREYNc09vrn9A
         qKXlly1nZMycfQQErkLFWQ7YplJtz2AlTKN6BJMe4KJ5PVqriwPbVVo+f6cg7arb7qiC
         XD2Q==
X-Gm-Message-State: APjAAAXmoonezHJkd19b6cyoP1hykiJ3qHolyTMPuB8YmT/4CyMrM44h
        Ilpgvi3kRKLVTLzOJ1CNoIAmfMpBOZC2CeU9q0k=
X-Google-Smtp-Source: APXvYqzCfUVATQvg/zXG1j+6zPEZgU57DcHIyiKn603xj48o6dgKrjMZvKdDl97D0pHfO2pv/C7JgQe+IiZk0tYoQJo=
X-Received: by 2002:a05:6102:227b:: with SMTP id v27mr40176369vsd.72.1578308894437;
 Mon, 06 Jan 2020 03:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
 <20200102100230.420009-4-christian.gmeiner@gmail.com> <15ed7b85a13e220a533a800b9c04f13b1c747c1c.camel@pengutronix.de>
In-Reply-To: <15ed7b85a13e220a533a800b9c04f13b1c747c1c.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 6 Jan 2020 12:08:03 +0100
Message-ID: <CAH9NwWdKVrp=oN9cVWq+aLqhUDsh8PpC+bkeihDfMTnsE60U0A@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/etnaviv: show identity information in debugfs
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

Am Mo., 6. Jan. 2020 um 11:08 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
>
> On Do, 2020-01-02 at 11:02 +0100, Christian Gmeiner wrote:
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > index 253301be9e95..cecef5034db1 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > @@ -868,6 +868,18 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu,
> > struct seq_file *m)
> >
> >       verify_dma(gpu, &debug);
> >
> > +     seq_puts(m, "\tidentity\n");
> > +     seq_printf(m, "\t model: 0x%x\n",
> > +                gpu->identity.model);
> > +     seq_printf(m, "\t revision: 0x%x\n",
> > +                gpu->identity.revision);
> > +     seq_printf(m, "\t product_id: 0x%x\n",
> > +                gpu->identity.product_id);
> > +     seq_printf(m, "\t customer_id: 0x%x\n",
> > +                gpu->identity.customer_id);
> > +     seq_printf(m, "\t eco_id: 0x%x\n",
> > +                gpu->identity.eco_id);
>
> I like having this info in debugfs. Most of those seq_printf don't need
> a line break though, as they fit well within the 80 char limit.

Ok..

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
