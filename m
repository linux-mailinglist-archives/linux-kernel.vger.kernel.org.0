Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9940E1282D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 20:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLTTki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 14:40:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51146 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLTTkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:40:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so10078549wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdYNVeVJ9zG7uGLj2brLM5VkYYRU60Z3UwUXj26j7Y4=;
        b=CQjMpL4hpX1WnvIacGuyzDar6rEtOQ1Hzw1EWSkC5XHG14fswPnJF+1QV21ZfGULQA
         mo9Kz7hvURKWJsuf04nj3n1t675ntsjJiu6YgdNBoPx+1I1VLVA5sNxdGONzPvsomlcy
         UR35nKhJ3NFWeMAlJz/Nm17pxvMqiK3/R8cLZjLuwX6skmzUW6/NBiL2F2E609zQBP6l
         EnMNIw+vKToWzJCrnqHUKuW0T16VZaqdkAwBDK6jOZHj/wAb62pB9QGbeOGw3vzCBrQS
         jvsjALrM4HfNat7B+63vHH17sL5/w5yEgaPTkOdOdi4e1Ph+JDDG6mRaza3jnjxOT1nt
         9TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdYNVeVJ9zG7uGLj2brLM5VkYYRU60Z3UwUXj26j7Y4=;
        b=bXWwet4XTukZ85YjRXGM7mSQ0N214nczAIFkAFQmiQ1m28KVk+pa36wsiaG+9Xt2pr
         +QwpNZTrIS4bqxssPS34BSgOpvYrKALoSz6NUf8XYzs3Yy+mykyL0gf1kKVKUFSEli5I
         MegFxlg/0xu4EDwYaLusGGLUCSV+syIowOe1SGtWhx34daF9ehXNJ7PWbhO02+YRoCat
         xXCHShZHNIlZu5bGUtzndCE1TFJI56zzr7hivuU8QVQ72QwdIhwMhSLHSNp75EHCFXH7
         9X3xVWcoWxUxMbQkq2UBSmRo9RsXBHUiHjxzriMlLOrri77v8vIHowqvf4Iw3S1QEMlo
         fzDQ==
X-Gm-Message-State: APjAAAV77Yc9XiLQwun/BNJOjoriu51j7rt0+snzd6vDkaeRskjbKqLC
        NQvwt+x5KAjzBOfljb7LR9ECbj4JqpQr9YXtq6h/kA==
X-Google-Smtp-Source: APXvYqym0wfGn4MUh0Q5DxHRfhzWymg3X0lx1rvhD/+srbD8Wct7zzVCcUi8kXTeECHde0dGL3nXAC88Ujygt72NEnw=
X-Received: by 2002:a1c:6404:: with SMTP id y4mr18312577wmb.143.1576870835379;
 Fri, 20 Dec 2019 11:40:35 -0800 (PST)
MIME-Version: 1.0
References: <1576834568-82874-1-git-send-email-mafeng.ma@huawei.com>
In-Reply-To: <1576834568-82874-1-git-send-email-mafeng.ma@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 20 Dec 2019 14:40:23 -0500
Message-ID: <CADnq5_MgHpY4NJg+QcneaEWjVUa0qtdN8WX4aBrsx=hv2ukVdw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove unneeded variable 'ret' in navi10_ih.c
To:     Ma Feng <mafeng.ma@huawei.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:10 AM Ma Feng <mafeng.ma@huawei.com> wrote:
>
> Fixes coccicheck warning:
>
> drivers/gpu/drm/amd/amdgpu/navi10_ih.c:113:5-8: Unneeded variable: "ret". Return "0" on line 182
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 9af7356..f737ce4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -110,7 +110,6 @@ static uint32_t navi10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl
>  static int navi10_ih_irq_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ih_ring *ih = &adev->irq.ih;
> -       int ret = 0;
>         u32 ih_rb_cntl, ih_doorbell_rtpr, ih_chicken;
>         u32 tmp;
>
> @@ -179,7 +178,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
>         /* enable interrupts */
>         navi10_ih_enable_interrupts(adev);
>
> -       return ret;
> +       return 0;
>  }
>
>  /**
> --
> 2.6.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
