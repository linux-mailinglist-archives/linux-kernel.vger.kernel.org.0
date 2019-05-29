Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4054C2D55A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 08:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfE2GIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 02:08:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45264 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfE2GIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:08:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id t1so1146627qtc.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 23:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9m6XmpcV32pBGRaKWaAZOu/nkbXf9RLY5czIdmVMIiE=;
        b=Vk/pDafXgg2bzDpfTFeKjsIp8WdKd3TNKbs23N/It+yi/CVfzyhiySQJ8J4jtLszAi
         LFiveV8PEpd6y+Dsh/gNPfB9fYQ5zv+RrOkISmmXalE+GzteLeypk6R36MTVSR1m/T6a
         wfTXpmePwdYxnvW4o3FzOIubaWyRpDgNwMyP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9m6XmpcV32pBGRaKWaAZOu/nkbXf9RLY5czIdmVMIiE=;
        b=jkSWu6KG7DPvYcjDsncj+k81Q/nAEvtNnFA63Nimfl41sJSNZmIcF7MGsKn5yhd7EC
         GRBRTsmOwVa5oHCLUqfWwVgYluICRp8wsfFCRRC62Cm/Gz3AZYx1WiCA+kVNoHLbu7hB
         U6QNzvJyRGydNpYibrXHzM/PB1ZvxNwv7VkhWG+vXq4Yccfe+Z62W6mIymmZbS+UY5Xa
         G8WG5fE2hEPC2sI+7wu3M1vb1X2dYipLS5ImDsI8qDHjK3v15aP/Ho4xV//MCLlfgvLZ
         +WtXBP8QAt8a9hUbXJ/SFw1+GTW85cdZc2C63wROBsl/124fZUUEWAyFZiKB1ihvpKQG
         e7fw==
X-Gm-Message-State: APjAAAWr40pA7Qv06EHnauCZRGjCjPrRyZla7ssYaD72gvCLjAckBRNh
        mjBEjHcDfsw5QH1Q5XZ2n7fKt1z74mjzYAxARUqwjg==
X-Google-Smtp-Source: APXvYqy1lIVHOTaLcihvMF7zGLF3pmNL3AVewtEF/CAwLER2Lc1MzHGPozPVQVC8HRo0kHV7SIzbmTEe6U0L3SD3dn4=
X-Received: by 2002:a0c:b621:: with SMTP id f33mr68502313qve.199.1559110123624;
 Tue, 28 May 2019 23:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190527045054.113259-1-hsinyi@chromium.org> <20190527045054.113259-3-hsinyi@chromium.org>
 <1559109490.15592.6.camel@mtksdaap41>
In-Reply-To: <1559109490.15592.6.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 29 May 2019 14:08:17 +0800
Message-ID: <CAJMQK-gQ_j4ma_EjGbFJOz6WGXy3UZA0F9JZYnFHPZ0F08rXog@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm: mediatek: remove clk_unprepare() in mtk_drm_crtc_destroy()
To:     CK Hu <ck.hu@mediatek.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 1:58 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Hsin-Yi:
>
> On Mon, 2019-05-27 at 12:50 +0800, Hsin-Yi Wang wrote:
> > There is no clk_prepare() called in mtk_drm_crtc_reset(), when unbinding
> > drm device, mtk_drm_crtc_destroy() will be triggered, and the clocks will
> > be disabled and unprepared in mtk_crtc_ddp_clk_disable. If clk_unprepare()
> > is called here, we'll get warnings[1], so remove clk_unprepare() here.
>
> In original code, clk_prepare() is called in mtk_drm_crtc_create() and
> clk_unprepare() is called in mtk_drm_crtc_destroy(). This looks correct.

clk_prepare() is removed in https://patchwork.kernel.org/patch/10872777/.

> I don't know why we should do any thing about clock in
> mtk_drm_crtc_reset(). To debug this, the first step is to print message
> when mediatek drm call clk_prepare() and clk_unprepare(). If these two
> interface is called in pair, I think we should not modify mediatek drm
> driver, the bug maybe in clock driver.
>
