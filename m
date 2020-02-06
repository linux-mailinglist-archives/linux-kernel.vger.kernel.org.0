Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC4154B16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 19:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 13:28:08 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35474 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:28:08 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so5986742ild.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HW00T6Osm6WH4TyAw4D1VjVNdK7xc2XqYCF6kdJYx0=;
        b=p+tk1qgQXb5MKd11ClypwRaVeIVdMZ4K2SD+LwlQ7GOM6fhKhbWva4FwPXvXOTGMWa
         DGj8rNa/PNMeIRlw+JnrjTPWtpL4lkNNMO0F2m1NFve1Mneh8erKwo0pr9ACTGBf0Vx/
         1tPD/PXcE5bZ+8XAs8F37YkCFMsK7kdgusMnmj/JbLNUbQ2uAbCjEQRNElvlZiM7vAmI
         hdtGWwONx5WxJtut7/1nJyAgCfCxMcaMSEMFbn8v+wHLLKQ0eL0O9jdW42FJ23ngwG67
         KqVjIWWUxrQrCwIXxNmORZcMn8+m2aXsWHSimGL+rqAVaKBGxBqOVapp1JP3jfje4pwJ
         Iw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HW00T6Osm6WH4TyAw4D1VjVNdK7xc2XqYCF6kdJYx0=;
        b=d9KnsHmDbICp6Npv108DcYws8hc2km7fpdhXHJdEuq5Mhu5paAoSrAwYkEr4TymPTp
         eI+vJ81enbtEORGh4anAWvh9lgswMIXVCzd4uclDrm0u89S4PqZ/9S1B77Q2L2IK3WP8
         ITdAtNmIOouJ34YLfhtW/sRQnncVSjLrdlgRSGwKWio1jdGDOZMjZruJqbLdfrE1j8Yg
         ZiKcGjdRu6rC/GG1rIim/EcCQasCzp9uaFHQyMRW63Xf0bYpsALx/e9VdIvLRiSouvMx
         84nIy2HCkuQxyzEhh+Pc+SztfDAWW5Y87ZDJ54SbifwWjGkHpGmqYrLNeXUX7nUlCQvR
         LxSQ==
X-Gm-Message-State: APjAAAV8L+fT0FzOKVCfS/oiQF7c4X5h68gTYJOfuoPja57BLYT+nYLj
        EEhXzDW2L31vERF+uvfKDy9s7mYoYaJ/1HqgLA0=
X-Google-Smtp-Source: APXvYqyZHwa2nq6KKqKvIuJYn93vumUv6IBXrHaKHhs6sEs86YWEhSWwob0M4z8F+GAhJSeeCgWniAlw4vBvHBIWArM=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr34797002ioq.84.1581013687236;
 Thu, 06 Feb 2020 10:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20200206111416.31269-1-kraxel@redhat.com>
In-Reply-To: <20200206111416.31269-1-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 6 Feb 2020 10:27:56 -0800
Message-ID: <CAPaKu7Tfp-thov9xCe-Gbq1zZe_uvDAno8SV_3tc=tU0gse=uA@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: fix ring free check
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 3:14 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> If the virtio device supports indirect ring descriptors we need only one
> ring entry for the whole command.  Take that into account when checking
> whenever the virtqueue has enough free entries for our command.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 41e475fbd67b..a2ec09dba530 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -328,7 +328,8 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>  {
>         struct virtqueue *vq = vgdev->ctrlq.vq;
>         bool notify = false;
> -       int ret;
> +       bool indirect;
> +       int vqcnt, ret;
>
>  again:
>         spin_lock(&vgdev->ctrlq.qlock);
> @@ -341,9 +342,11 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>                 return;
>         }
>
> -       if (vq->num_free < elemcnt) {
> +       indirect = virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC);
> +       vqcnt = indirect ? 1 : elemcnt;
Is the feature dynamic and require the lock held?  If not, the result
can be cached and the fixup can happen before grabbing the lock

  if (vgdev->has_indirect_desc)
    elemcnt = 1;

Either way, patch is

  Reviewed-by: Chia-I Wu <olvaffe@gmail.com>


> +       if (vq->num_free < vqcnt) {
>                 spin_unlock(&vgdev->ctrlq.qlock);
> -               wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
> +               wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= vqcnt);
>                 goto again;
>         }
>
> --
> 2.18.1
>
