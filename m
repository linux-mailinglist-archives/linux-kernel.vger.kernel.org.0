Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7859780367
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 02:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfHCAOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 20:14:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35439 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfHCAOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 20:14:47 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so155900476ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4x/c6aFCerGwW46+jAJx/0xkBWsbbCj8p2s7VTuzx8=;
        b=MLkWEGvkkIkdnTVe/Yq9GekUC+t7Ci3fj98xN5HfkXiOvm/MMg784R24yCjHSu8K0h
         AW6wNE43CTPQ3HnsY09vnm7ebuGXirzQWPSNRbN6TDV+yMRx6wt4mBurzmx7Lfu7xfWd
         wvOc91VHRIKLo1B9aqILfav2Bz8i3r18qHvWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4x/c6aFCerGwW46+jAJx/0xkBWsbbCj8p2s7VTuzx8=;
        b=X+hrCWpABGH7UdeRMssx+XDUVrPA+Tat+QHlBavsp8Iq9tSJqPNhtv6TjUH9YWk6GF
         MgDkSUVQtNKHxFcntBujkCN10/7cldwsXD1UF7N7I8dkfpqQWFpsHu8P91FM8+ByQr0k
         svazNOP9yA7etvm2hUinB2lVxavKkjnQwCJquW8L6DBJhSCzWDazwBXdsqgtD0w4X22p
         hEPcrN/nre7dpxCKJ3pJSDQxV5HuX5ggfB0qcigBE2nbQDVRdG0+X60KIzmy5Xtp04se
         /nZTSx6B8QnsTyx+Aalb75mvQW/qvP/EVkyuq3cFXnddVBPE+c2oXXlGSZkKDRDNWA9C
         CItQ==
X-Gm-Message-State: APjAAAWzAoQVPDR8VtutJBQZ9yjTziJDPgDiRNS3bPLxh4PDfPOun6an
        BU5EduPMN8Ch1IRTuItJ58GqU7NZKxJy70yIJN8Ohw==
X-Google-Smtp-Source: APXvYqzf+8HF1jNb9DEf6l4Ve9OqBkgZcoiA7Q7ZK26p9D3udPa2BQT1369JwNyXg+EZvobWAJFoHF0bH17R4/EaURY=
X-Received: by 2002:a02:c916:: with SMTP id t22mr3605894jao.24.1564791286556;
 Fri, 02 Aug 2019 17:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190802131951.11600-1-sashal@kernel.org> <20190802131951.11600-42-sashal@kernel.org>
In-Reply-To: <20190802131951.11600-42-sashal@kernel.org>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 2 Aug 2019 17:14:35 -0700
Message-ID: <CAJs_Fx4ddE-85uA3S+YLPat4uX8Mk9zRU2SFm2xmGgmAFWPEyg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.2 42/76] drm/msm: stop abusing dma_map/unmap for cache
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

It's probably best *not* to backport this patch.. drm/msm abuses the
DMA API in a way that it is not intended be used, to work around the
lack of cache sync API exported to kernel modules on arm/arm64.  I
couldn't really guarantee that this patch does the right thing on
older versions of DMA API, so best to leave things as they were.

BR,
-R

On Fri, Aug 2, 2019 at 6:21 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> [ Upstream commit 0036bc73ccbe7e600a3468bf8e8879b122252274 ]
>
> Recently splats like this started showing up:
>
>    WARNING: CPU: 4 PID: 251 at drivers/iommu/dma-iommu.c:451 __iommu_dma_unmap+0xb8/0xc0
>    Modules linked in: ath10k_snoc ath10k_core fuse msm ath mac80211 uvcvideo cfg80211 videobuf2_vmalloc videobuf2_memops vide
>    CPU: 4 PID: 251 Comm: kworker/u16:4 Tainted: G        W         5.2.0-rc5-next-20190619+ #2317
>    Hardware name: LENOVO 81JL/LNVNB161216, BIOS 9UCN23WW(V1.06) 10/25/2018
>    Workqueue: msm msm_gem_free_work [msm]
>    pstate: 80c00005 (Nzcv daif +PAN +UAO)
>    pc : __iommu_dma_unmap+0xb8/0xc0
>    lr : __iommu_dma_unmap+0x54/0xc0
>    sp : ffff0000119abce0
>    x29: ffff0000119abce0 x28: 0000000000000000
>    x27: ffff8001f9946648 x26: ffff8001ec271068
>    x25: 0000000000000000 x24: ffff8001ea3580a8
>    x23: ffff8001f95ba010 x22: ffff80018e83ba88
>    x21: ffff8001e548f000 x20: fffffffffffff000
>    x19: 0000000000001000 x18: 00000000c00001fe
>    x17: 0000000000000000 x16: 0000000000000000
>    x15: ffff000015b70068 x14: 0000000000000005
>    x13: 0003142cc1be1768 x12: 0000000000000001
>    x11: ffff8001f6de9100 x10: 0000000000000009
>    x9 : ffff000015b78000 x8 : 0000000000000000
>    x7 : 0000000000000001 x6 : fffffffffffff000
>    x5 : 0000000000000fff x4 : ffff00001065dbc8
>    x3 : 000000000000000d x2 : 0000000000001000
>    x1 : fffffffffffff000 x0 : 0000000000000000
>    Call trace:
>     __iommu_dma_unmap+0xb8/0xc0
>     iommu_dma_unmap_sg+0x98/0xb8
>     put_pages+0x5c/0xf0 [msm]
>     msm_gem_free_work+0x10c/0x150 [msm]
>     process_one_work+0x1e0/0x330
>     worker_thread+0x40/0x438
>     kthread+0x12c/0x130
>     ret_from_fork+0x10/0x18
>    ---[ end trace afc0dc5ab81a06bf ]---
>
> Not quite sure what triggered that, but we really shouldn't be abusing
> dma_{map,unmap}_sg() for cache maint.
>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20190630124735.27786-1-robdclark@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 49a019939ccdc..a3b5fe1a13944 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -97,7 +97,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
>                  * because display controller, GPU, etc. are not coherent:
>                  */
>                 if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> -                       dma_map_sg(dev->dev, msm_obj->sgt->sgl,
> +                       dma_sync_sg_for_device(dev->dev, msm_obj->sgt->sgl,
>                                         msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
>         }
>
> @@ -127,7 +127,7 @@ static void put_pages(struct drm_gem_object *obj)
>                          * GPU, etc. are not coherent:
>                          */
>                         if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> -                               dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
> +                               dma_sync_sg_for_cpu(obj->dev->dev, msm_obj->sgt->sgl,
>                                              msm_obj->sgt->nents,
>                                              DMA_BIDIRECTIONAL);
>
> --
> 2.20.1
>
