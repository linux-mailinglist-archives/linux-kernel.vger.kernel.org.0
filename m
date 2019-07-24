Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A732725D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 06:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfGXEWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 00:22:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39277 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfGXEWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:22:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so45844647edv.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 21:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwge67L+3EQ2aFGxgAjJAjYtC8kh0cJgKbJ+VBbrRe4=;
        b=gKG79kqSGS6PE3wGKci7oDEWb0bB1oWWLWP3WcZ3h/yXwdEcjYTt2USKxZL7qtIF2b
         3yvROFrTrRnW/UtSz0F64CeWYyiN5EJVkayWZ8vb3JWPS+hkDGSh0ax2XxGfE8Elimpn
         Xy7Nc6wR7PzNyMrMzWW22EG102F/JzY5p9qUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwge67L+3EQ2aFGxgAjJAjYtC8kh0cJgKbJ+VBbrRe4=;
        b=AG6tiqvSmwGGM8l2rvF4f+0WIQa099fk8AnZXyLcTSZoyF5fP7y2epJY7SaMwHhIwX
         9aw4dyCxEFlWp/UZxX0JpBT/P+nA9XvMpC2quwlx/IhI8SO+hntkO+cj/MkV5h/3wcQb
         P8aKr2uckhO+BasmmspHY4Vt2gURaztrxRLFwMt10OLiW/5i0WZ3w8WScRIjeswAcpU3
         28MZOJeagNwQComVogQtM+qcCxUA/O2FmN7/dsxiojVVu1WDN/HEtG72wgC2kgAVz6in
         hPxuU8/njg+MtErkMNuhfmV4W44/lh6MW/AMnV8eUewbPLWyOWypiFKM2sb18Q3OCGGb
         4G9w==
X-Gm-Message-State: APjAAAVzN1cyTkEOs77Mm+tjkwx42oMdmKCFAm/MfqG5PPlFjcxmE9pK
        u5YSFeGlbvnCImCAMwiiqpf9liHkzp5tTw==
X-Google-Smtp-Source: APXvYqynOaj0r8CofwhjkuLJjID+KUpiLoI/5F6KOHPEdeXH0CIQNAN2fVpzsff7XBxaxX391cPvIw==
X-Received: by 2002:a17:906:1303:: with SMTP id w3mr47614627ejb.143.1563942137484;
        Tue, 23 Jul 2019 21:22:17 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id g22sm4507466eje.84.2019.07.23.21.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 21:22:15 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id a15so40403152wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 21:22:15 -0700 (PDT)
X-Received: by 2002:a05:600c:2111:: with SMTP id u17mr51303133wml.64.1563942134673;
 Tue, 23 Jul 2019 21:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190723053421.179679-1-acourbot@chromium.org>
In-Reply-To: <20190723053421.179679-1-acourbot@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 24 Jul 2019 13:22:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CfCrKLVb9obuXcMpFzBUxyZhK4NAuUOEUTviN-mZ9H6w@mail.gmail.com>
Message-ID: <CAAFQd5CfCrKLVb9obuXcMpFzBUxyZhK4NAuUOEUTviN-mZ9H6w@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: make imported PRIME buffers contiguous
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 2:34 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> This driver requires imported PRIME buffers to appear contiguously in
> its IO address space. Make sure this is the case by setting the maximum
> DMA segment size to a better value than the default 64K on the DMA
> device, and use said DMA device when importing PRIME buffers.
>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 47 ++++++++++++++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
>  2 files changed, 46 insertions(+), 3 deletions(-)
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
