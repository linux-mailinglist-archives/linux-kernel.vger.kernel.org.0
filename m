Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273F211BBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 19:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbfLKS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 13:27:51 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42101 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfLKS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:27:51 -0500
Received: by mail-io1-f68.google.com with SMTP id f82so23690334ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzDObby2jR84VqCAR2NNwsNmUH6L34aJzVs2dTgYaFM=;
        b=SQutmLP/sTlMS+zEASMFyKHYZa5f7ZvuA3wQ6jac0fGgK7KhPy0pJYlK9Ep86yG+qw
         wzyZcPvXgatCP1WzKGQ9qaWIfawy6sjA+myEUnoItidWjoBwaXzm6GzH8/YNDPrFYuNi
         KI1ImvVwYFkcjW2tTODNRvj/3xdCFvtFVcraGylloS+K8e19bwK5TLnyt3JKe/jYM7/q
         MRhQX0c6GfsJx/dvNnwivAkIfnoi4aXV/lLLKOWOsYzeiFLRupKYp1Z3i6jc9iTsZ9d8
         sdmC37PlxSS1zykHsxTjLMi/rf/gqm3CKQU1vUKQHLuQbovcOtO8cKbIH3pwgCb1Qyxe
         Y4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzDObby2jR84VqCAR2NNwsNmUH6L34aJzVs2dTgYaFM=;
        b=dyF+FUYx8uiPhKNims6mZTXdToN4MunUjCsD94bc3yWPJRsqF4k5m3z/H2wEdNjEPT
         QfQKhQo6Ropw/o5CbgF+yg8MG0BNVvZWPPHbUp6JVPWJHh+prWk5yJxk6RgCwdO9tmEz
         dxPb32fvtIt60jV4ImHFdT9Mrew1SCZGcAW3AhfYOBGywfdLpHDiQLE3/tc5Ur20Twh5
         vwNZEhVB6T4DhOf0Tymd4RMqcDJ3ic5+x2zAeZDk3Zu2drCbGrPTwg6s+XzFkdbvJVEI
         kyJ+L3D4nO5GPwrque9R7xpXOwO6JO74kttthoItKPa7bS71pGgYAdD5jw+QbNOSlbRT
         SSgg==
X-Gm-Message-State: APjAAAXS0eV8pXEZ8sAzQ8498t8bQ1yT+Y1xXLKEhyOY0wctvPtekQkt
        JCneYzerK+TKH4Mcjt52WKjN8mezK6bb2cyjxOwg7cVt
X-Google-Smtp-Source: APXvYqzr/oijDkWCcNuhvBnIVjwCPuuM7oI1QguAVqVj6YMeD8ttf/i0DbRLSFLpONolcFkrV56yhH2S3xvlzv460ao=
X-Received: by 2002:a6b:1455:: with SMTP id 82mr3759846iou.200.1576088870232;
 Wed, 11 Dec 2019 10:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20191211084216.25405-1-kraxel@redhat.com> <20191211084216.25405-2-kraxel@redhat.com>
In-Reply-To: <20191211084216.25405-2-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 11 Dec 2019 10:27:39 -0800
Message-ID: <CAPaKu7TyMPt4Wpq9FoWyTJSppURrz9XuFqD4fmFg6aX_9p+jtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/virtio: skip set_scanout if framebuffer didn't change
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:42 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 31 ++++++++++++++------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index bc4bc4475a8c..a0f91658c2bc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -151,20 +151,23 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>         if (bo->dumb)
>                 virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
>
> -       DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
> -                 bo->hw_res_handle,
> -                 plane->state->crtc_w, plane->state->crtc_h,
> -                 plane->state->crtc_x, plane->state->crtc_y,
> -                 plane->state->src_w >> 16,
> -                 plane->state->src_h >> 16,
> -                 plane->state->src_x >> 16,
> -                 plane->state->src_y >> 16);
> -       virtio_gpu_cmd_set_scanout(vgdev, output->index,
> -                                  bo->hw_res_handle,
> -                                  plane->state->src_w >> 16,
> -                                  plane->state->src_h >> 16,
> -                                  plane->state->src_x >> 16,
> -                                  plane->state->src_y >> 16);
> +       if (plane->state->fb != old_state->fb) {
Should we check src_{w,h,x,y} as well?
> +               DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
> +                         bo->hw_res_handle,
> +                         plane->state->crtc_w, plane->state->crtc_h,
> +                         plane->state->crtc_x, plane->state->crtc_y,
> +                         plane->state->src_w >> 16,
> +                         plane->state->src_h >> 16,
> +                         plane->state->src_x >> 16,
> +                         plane->state->src_y >> 16);
> +               virtio_gpu_cmd_set_scanout(vgdev, output->index,
> +                                          bo->hw_res_handle,
> +                                          plane->state->src_w >> 16,
> +                                          plane->state->src_h >> 16,
> +                                          plane->state->src_x >> 16,
> +                                          plane->state->src_y >> 16);
> +       }
> +
>         virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
>                                       plane->state->src_x >> 16,
>                                       plane->state->src_y >> 16,
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
