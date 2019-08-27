Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD29DB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 04:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfH0CDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 22:03:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35428 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfH0CDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:03:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id t50so29158589edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 19:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQLbAAP3qgGrIGu9Kjkqj69oOSg5ZXDZiLprSGvKM/s=;
        b=CVPT1uFzX7DyM112VsijlZFSKkt4lz1D/L7K1hvR1dvufgvrCCqwiLD4PeAmoqFCPd
         Bi910hsb55rpYce5TV7Wz+mUkBLbP+0JNxiyz3sBb5xEb2kXUf0IM/hR+3ih7ZHV+Y7j
         r5GBrQfwptyyAkZH/L5e/jALcV8kxJhSTzr+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQLbAAP3qgGrIGu9Kjkqj69oOSg5ZXDZiLprSGvKM/s=;
        b=K1fDjOyOnlrHGpe/FTuKF54itlHDsO8JXa/jBDM41bSFk+U6Snw97FJhLO+1PRZUm1
         FtW/8bqLwlNDR+mPIXBX1DS7YljcDUEJwAgeKEPtuoMwxuE0aGym59RcQ26Mhd0lldt1
         C8ZBvCpTOiTxhUMtxaefoWhrhgJNE2M59UjlflpjbaEKbuI0yV/FnSzBxLi7a4jBFvUY
         OTCsL4CSoiBlLIKLxts9QtQBmRGlTxfySonrSphZGWLStBtv2pYY8Hm81n1/9LDaFlyz
         OfQOSsimzo6KVKFc7SHjp5slf7Hq6PJwjSYc24YihUv/oBMIdngUVkJnN0anE1xIHocm
         EYrQ==
X-Gm-Message-State: APjAAAUpuGDLmR7TQO8A/4TwNFCtYhS5wtlMpVR9/vFdzF0Sjd+lQyXM
        ewB+qAIZw8l1+dDGFytZMphw8F7yDCSvww==
X-Google-Smtp-Source: APXvYqxHELHGSNlLBztToBvO60YqghpbZLFb6TFJVI1cMNQI8JNXzpLK6UnoXojdB9nxIa7AQviPGQ==
X-Received: by 2002:a17:906:fc06:: with SMTP id ov6mr19104522ejb.226.1566871413688;
        Mon, 26 Aug 2019 19:03:33 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id l6sm1641203edw.27.2019.08.26.19.03.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 19:03:32 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id r3so17110928wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 19:03:32 -0700 (PDT)
X-Received: by 2002:adf:f851:: with SMTP id d17mr25979076wrq.77.1566871411604;
 Mon, 26 Aug 2019 19:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190802131226.123800-1-shik@chromium.org>
In-Reply-To: <20190802131226.123800-1-shik@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 27 Aug 2019 11:03:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bu514efrHeL=eqjh_62RO0PU=FqpE2b9nC9mbpGYbOtw@mail.gmail.com>
Message-ID: <CAAFQd5Bu514efrHeL=eqjh_62RO0PU=FqpE2b9nC9mbpGYbOtw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Use streaming DMA APIs to transfer buffers
To:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     notify@kernel.org, Shik Chen <shik@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 10:12 PM Shik Chen <shik@chromium.org> wrote:
>
> Similar to the commit 1161db6776bd ("media: usb: pwc: Don't use coherent
> DMA buffers for ISO transfer") [1] for the pwc driver. Use streaming DMA
> APIs to transfer buffers and sync them explicitly, because accessing
> buffers allocated by usb_alloc_coherent() is slow on platforms without
> hardware coherent DMA.
>
> Tested on x86-64 (Intel Celeron 4305U) and armv7l (Rockchip RK3288) with
> Logitech Brio 4K camera at 1920x1080 using the WebRTC sample site [3].
>
> |                  |  URB (us)  | Decode (Gbps) | CPU (%) |
> |------------------|------------|---------------|---------|
> | x86-64 coherent  |  53 +-  20 |          50.6 |    0.24 |
> | x86-64 streaming |  55 +-  19 |          50.1 |    0.25 |
> | armv7l coherent  | 342 +- 379 |           1.8 |    2.16 |
> | armv7l streaming |  99 +-  98 |          11.0 |    0.36 |
>
> The performance characteristics are improved a lot on armv7l, and
> remained (almost) unchanged on x86-64. The code used for measurement can
> be found at [2].
>
> [1] https://git.kernel.org/torvalds/c/1161db6776bd
> [2] https://crrev.com/c/1729133
> [3] https://webrtc.github.io/samples/src/content/getusermedia/resolution/
>
> Signed-off-by: Shik Chen <shik@chromium.org>
> ---
> The allocated buffer could be as large as 768K when streaming 4K video.
> Ideally we should use some generic helper to allocate non-coherent
> memory in a more efficient way, such as https://lwn.net/Articles/774429/
> ("make the non-consistent DMA allocator more userful").
>
> But I cannot find any existing helper so a simple kzalloc() is used in
> this patch. The logic to figure out the DMA addressable GFP flags is
> similar to __dma_direct_alloc_pages() without the optimistic retries:
> https://elixir.bootlin.com/linux/v5.2.5/source/kernel/dma/direct.c#L96
>
>  drivers/media/usb/uvc/uvc_video.c | 65 +++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 8fa77a81dd7f2c..962c35478896c4 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1539,6 +1539,8 @@ static void uvc_video_complete(struct urb *urb)
>          * Process the URB headers, and optionally queue expensive memcpy tasks
>          * to be deferred to a work queue.
>          */
> +       dma_sync_single_for_cpu(&urb->dev->dev, urb->transfer_dma,
> +                               urb->transfer_buffer_length, DMA_FROM_DEVICE);
>         stream->decode(uvc_urb, buf, buf_meta);
>
>         /* If no async work is needed, resubmit the URB immediately. */
> @@ -1565,18 +1567,51 @@ static void uvc_free_urb_buffers(struct uvc_streaming *stream)
>                 if (!uvc_urb->buffer)
>                         continue;
>
> -#ifndef CONFIG_DMA_NONCOHERENT
> -               usb_free_coherent(stream->dev->udev, stream->urb_size,
> -                                 uvc_urb->buffer, uvc_urb->dma);
> -#else
> +               dma_unmap_single(&stream->dev->udev->dev, uvc_urb->dma,
> +                                stream->urb_size, DMA_FROM_DEVICE);
>                 kfree(uvc_urb->buffer);
> -#endif
> -               uvc_urb->buffer = NULL;
>         }
>
>         stream->urb_size = 0;
>  }
>
> +static gfp_t uvc_alloc_gfp_flags(struct device *dev)
> +{
> +       u64 mask = dma_get_mask(dev);
> +
> +       if (dev->bus_dma_mask)
> +               mask &= dev->bus_dma_mask;
> +
> +       if (mask < DMA_BIT_MASK(32) && IS_ENABLED(CONFIG_ZONE_DMA))
> +               return GFP_DMA;
> +
> +       if (mask < DMA_BIT_MASK(64)) {
> +               if (IS_ENABLED(CONFIG_ZONE_DMA32))
> +                       return GFP_DMA32;
> +               if (IS_ENABLED(CONFIG_ZONE_DMA))
> +                       return GFP_DMA;
> +       }
> +
> +       return 0;
> +}
> +
> +static char *uvc_alloc_urb_buffer(struct device *dev, size_t size,
> +                                 gfp_t gfp_flags, dma_addr_t *dma_handle)
> +{
> +       void *buffer = kzalloc(size, gfp_flags | uvc_alloc_gfp_flags(dev));
> +
> +       if (!buffer)
> +               return NULL;
> +
> +       *dma_handle = dma_map_single(dev, buffer, size, DMA_FROM_DEVICE);
> +       if (dma_mapping_error(dev, *dma_handle)) {
> +               kfree(buffer);
> +               return NULL;
> +       }
> +
> +       return buffer;
> +}
> +
>  /*
>   * Allocate transfer buffers. This function can be called with buffers
>   * already allocated when resuming from suspend, in which case it will
> @@ -1607,18 +1642,14 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
>
>         /* Retry allocations until one succeed. */
>         for (; npackets > 1; npackets /= 2) {
> +               stream->urb_size = psize * npackets;
> +
>                 for (i = 0; i < UVC_URBS; ++i) {
>                         struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
>
> -                       stream->urb_size = psize * npackets;
> -#ifndef CONFIG_DMA_NONCOHERENT
> -                       uvc_urb->buffer = usb_alloc_coherent(
> -                               stream->dev->udev, stream->urb_size,
> +                       uvc_urb->buffer = uvc_alloc_urb_buffer(
> +                               &stream->dev->udev->dev, stream->urb_size,
>                                 gfp_flags | __GFP_NOWARN, &uvc_urb->dma);
> -#else
> -                       uvc_urb->buffer =
> -                           kmalloc(stream->urb_size, gfp_flags | __GFP_NOWARN);
> -#endif
>                         if (!uvc_urb->buffer) {
>                                 uvc_free_urb_buffers(stream);
>                                 break;
> @@ -1728,12 +1759,8 @@ static int uvc_init_video_isoc(struct uvc_streaming *stream,
>                 urb->context = uvc_urb;
>                 urb->pipe = usb_rcvisocpipe(stream->dev->udev,
>                                 ep->desc.bEndpointAddress);
> -#ifndef CONFIG_DMA_NONCOHERENT
>                 urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
>                 urb->transfer_dma = uvc_urb->dma;
> -#else
> -               urb->transfer_flags = URB_ISO_ASAP;
> -#endif
>                 urb->interval = ep->desc.bInterval;
>                 urb->transfer_buffer = uvc_urb->buffer;
>                 urb->complete = uvc_video_complete;
> @@ -1793,10 +1820,8 @@ static int uvc_init_video_bulk(struct uvc_streaming *stream,
>
>                 usb_fill_bulk_urb(urb, stream->dev->udev, pipe, uvc_urb->buffer,
>                                   size, uvc_video_complete, uvc_urb);
> -#ifndef CONFIG_DMA_NONCOHERENT
>                 urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
>                 urb->transfer_dma = uvc_urb->dma;
> -#endif
>
>                 uvc_urb->urb = urb;
>         }
> --
> 2.22.0.770.g0f2c4a37fd-goog
>

Gentle ping.

Also, oops, looks like we forgot to add Kieran on CC. Let me fix it now.

Best regards,
Tomasz
