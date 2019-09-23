Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4EBB4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406972AbfIWNG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 09:06:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42738 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404887AbfIWNGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:06:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so11978147otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWMdX2rIumO1GGvTnOo85SqMCzGocAk99kTMXN+5voM=;
        b=T2Q9YrLmDbc/dSlsc7YzZ3wdkswPcnBFBPIEQUbWCAZr7QX4BEb8eero1hWbjFx1FU
         AEEg0Bfdw5oIlOm5UmhjvmOSLVKadCsdLQ2awZ8GHL9w5sLrSiTSQYODuvhbM6aU9ZrJ
         719vCSSW87KlOjvAUE6Z+pwIWX/Q+f5QUFozM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWMdX2rIumO1GGvTnOo85SqMCzGocAk99kTMXN+5voM=;
        b=XczUrB9KUliEFiDMaqAJHc0d5FS+oMfmtdm8Nck+OBlXVIGJL53RJJRoT55SxCzMFx
         fiy3i5A3442LFTRLP20hNsNkhccZCSkSoqujnXqyPNpEAVm4j6Cr2cOuD6Scn6nQb1qL
         qDnNoVKVxjeBRNd8rxs6QFyXJ2qMh/enkFd8tJQiI7+3bTeNymPu4nPlYDPfJCyTs6eu
         mpQZtDV9vkkr/kXshZNuwY+U46ZHi2sWmfZ50EtFqvXfLDdHEJZPQnSOgO4jxEpfBX5i
         wkcGmLLY3mELoHQLJrmjIumv/L3otrG048ylgb9LOpNBSRpo8H2iAv6PqHnSOyjl2Oka
         1z7Q==
X-Gm-Message-State: APjAAAWf6UP1mlDxt1O384v3Jdr62bHDqGMQuYtdWsuCeMFMdwGHrJ2Y
        wWjJkp31hf2gYEaH762zQZVIzXsYqc2l7JdW7cZNaQ==
X-Google-Smtp-Source: APXvYqwgtkLRp8aeEaiNYYBoQy8HuyZotHru36MdoeJ4pAVhvGXFsfJBIa03oIV9otlRW1zKRuc6EwC3ex+GS7G6O3k=
X-Received: by 2002:a05:6830:17c1:: with SMTP id p1mr9724600ota.188.1569244013467;
 Mon, 23 Sep 2019 06:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <1569242365-182133-1-git-send-email-hjc@rock-chips.com> <1569242365-182133-2-git-send-email-hjc@rock-chips.com>
In-Reply-To: <1569242365-182133-2-git-send-email-hjc@rock-chips.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 23 Sep 2019 15:06:42 +0200
Message-ID: <CAKMK7uFSSoahOesvxL2jQVPXUhG=TuWE4GMfXEAkdTRNbAsp+w@mail.gmail.com>
Subject: Re: [PATCH 01/36] drm/fourcc: Add 2 plane YCbCr 10bit format support
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 2:40 PM Sandy Huang <hjc@rock-chips.com> wrote:
>
> The drm_format_info.cpp[3] unit is BytePerPlane, when we add define
> 10bit YUV format, here have some problem.
> So we change cpp to bpp, use unit BitPerPlane to describe the data
> format.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

Whatever the layout you have for these (it's not really defined in
your patch here down to the level of detail we want) I think this
should be described with the block_h/w and char_per_block
functionality. Not by extending the legacy and depcrecated cpp
somehow.
-Daniel

> ---
>  drivers/gpu/drm/drm_client.c        |   4 +-
>  drivers/gpu/drm/drm_fb_helper.c     |   8 +-
>  drivers/gpu/drm/drm_format_helper.c |   4 +-
>  drivers/gpu/drm/drm_fourcc.c        | 172 +++++++++++++++++++-----------------
>  drivers/gpu/drm/drm_framebuffer.c   |   2 +-
>  include/drm/drm_fourcc.h            |   4 +-
>  include/uapi/drm/drm_fourcc.h       |  15 ++++
>  7 files changed, 115 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index d9a2e36..a36ffbe 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -263,7 +263,7 @@ drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u
>
>         dumb_args.width = width;
>         dumb_args.height = height;
> -       dumb_args.bpp = info->cpp[0] * 8;
> +       dumb_args.bpp = info->bpp[0];
>         ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
>         if (ret)
>                 goto err_delete;
> @@ -366,7 +366,7 @@ static int drm_client_buffer_addfb(struct drm_client_buffer *buffer,
>         int ret;
>
>         info = drm_format_info(format);
> -       fb_req.bpp = info->cpp[0] * 8;
> +       fb_req.bpp = info->bpp[0];
>         fb_req.depth = info->depth;
>         fb_req.width = width;
>         fb_req.height = height;
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index a7ba5b4..b30e782 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -382,7 +382,7 @@ static void drm_fb_helper_dirty_blit_real(struct drm_fb_helper *fb_helper,
>                                           struct drm_clip_rect *clip)
>  {
>         struct drm_framebuffer *fb = fb_helper->fb;
> -       unsigned int cpp = fb->format->cpp[0];
> +       unsigned int cpp = fb->format->bpp[0] / 8;
>         size_t offset = clip->y1 * fb->pitches[0] + clip->x1 * cpp;
>         void *src = fb_helper->fbdev->screen_buffer + offset;
>         void *dst = fb_helper->buffer->vaddr + offset;
> @@ -1320,14 +1320,14 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>          * Changes struct fb_var_screeninfo are currently not pushed back
>          * to KMS, hence fail if different settings are requested.
>          */
> -       if (var->bits_per_pixel != fb->format->cpp[0] * 8 ||
> +       if (var->bits_per_pixel != fb->format->bpp[0] ||
>             var->xres > fb->width || var->yres > fb->height ||
>             var->xres_virtual > fb->width || var->yres_virtual > fb->height) {
>                 DRM_DEBUG("fb requested width/height/bpp can't fit in current fb "
>                           "request %dx%d-%d (virtual %dx%d) > %dx%d-%d\n",
>                           var->xres, var->yres, var->bits_per_pixel,
>                           var->xres_virtual, var->yres_virtual,
> -                         fb->width, fb->height, fb->format->cpp[0] * 8);
> +                         fb->width, fb->height, fb->format->bpp[0]);
>                 return -EINVAL;
>         }
>
> @@ -1678,7 +1678,7 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
>         info->pseudo_palette = fb_helper->pseudo_palette;
>         info->var.xres_virtual = fb->width;
>         info->var.yres_virtual = fb->height;
> -       info->var.bits_per_pixel = fb->format->cpp[0] * 8;
> +       info->var.bits_per_pixel = fb->format->bpp[0];
>         info->var.accel_flags = FB_ACCELF_TEXT;
>         info->var.xoffset = 0;
>         info->var.yoffset = 0;
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 0897cb9..eea3afb 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -36,7 +36,7 @@ static unsigned int clip_offset(struct drm_rect *clip,
>  void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
>                    struct drm_rect *clip)
>  {
> -       unsigned int cpp = fb->format->cpp[0];
> +       unsigned int cpp = fb->format->bpp[0] / 8;
>         size_t len = (clip->x2 - clip->x1) * cpp;
>         unsigned int y, lines = clip->y2 - clip->y1;
>
> @@ -63,7 +63,7 @@ void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
>                            struct drm_framebuffer *fb,
>                            struct drm_rect *clip)
>  {
> -       unsigned int cpp = fb->format->cpp[0];
> +       unsigned int cpp = fb->format->bpp[0] / 8;
>         unsigned int offset = clip_offset(clip, fb->pitches[0], cpp);
>         size_t len = (clip->x2 - clip->x1) * cpp;
>         unsigned int y, lines = clip->y2 - clip->y1;
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index c630064..071dc07 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -157,89 +157,95 @@ EXPORT_SYMBOL(drm_get_format_name);
>  const struct drm_format_info *__drm_format_info(u32 format)
>  {
>         static const struct drm_format_info formats[] = {
> -               { .format = DRM_FORMAT_C8,              .depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_RGB332,          .depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_BGR233,          .depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_XRGB4444,        .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_XBGR4444,        .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_RGBX4444,        .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_BGRX4444,        .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_ARGB4444,        .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_ABGR4444,        .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_RGBA4444,        .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_BGRA4444,        .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_XRGB1555,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_XBGR1555,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_RGBX5551,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_BGRX5551,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_ARGB1555,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_ABGR1555,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_RGBA5551,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_BGRA5551,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_RGB565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_BGR565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_RGB888,          .depth = 24, .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_BGR888,          .depth = 24, .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_XRGB8888,        .depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_XBGR8888,        .depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_RGBX8888,        .depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_BGRX8888,        .depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_RGB565_A8,       .depth = 24, .num_planes = 2, .cpp = { 2, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_BGR565_A8,       .depth = 24, .num_planes = 2, .cpp = { 2, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_XRGB2101010,     .depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_XBGR2101010,     .depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_RGBX1010102,     .depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_BGRX1010102,     .depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_ARGB2101010,     .depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_ABGR2101010,     .depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_RGBA1010102,     .depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_BGRA1010102,     .depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_ARGB8888,        .depth = 32, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_ABGR8888,        .depth = 32, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_RGBA8888,        .depth = 32, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_BGRA8888,        .depth = 32, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_XRGB16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_XBGR16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
> -               { .format = DRM_FORMAT_ARGB16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_ABGR16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_RGB888_A8,       .depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_BGR888_A8,       .depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_XRGB8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_XBGR8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_RGBX8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_BGRX8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> -               { .format = DRM_FORMAT_YUV410,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4, .is_yuv = true },
> -               { .format = DRM_FORMAT_YVU410,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4, .is_yuv = true },
> -               { .format = DRM_FORMAT_YUV411,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_YVU411,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_YUV420,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> -               { .format = DRM_FORMAT_YVU420,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> -               { .format = DRM_FORMAT_YUV422,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_YVU422,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_YUV444,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_YVU444,          .depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_NV12,            .depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> -               { .format = DRM_FORMAT_NV21,            .depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> -               { .format = DRM_FORMAT_NV16,            .depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_NV61,            .depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_NV24,            .depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_NV42,            .depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_YUYV,            .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_YVYU,            .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_UYVY,            .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_VYUY,            .depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_XYUV8888,        .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_VUY888,          .depth = 0,  .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_AYUV,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> -               { .format = DRM_FORMAT_Y210,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_Y212,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_Y216,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_Y410,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> -               { .format = DRM_FORMAT_Y412,            .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> -               { .format = DRM_FORMAT_Y416,            .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> -               { .format = DRM_FORMAT_XVYU2101010,     .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_XVYU12_16161616, .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> -               { .format = DRM_FORMAT_XVYU16161616,    .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_C8,              .depth = 8,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_RGB332,          .depth = 8,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_BGR233,          .depth = 8,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_XRGB4444,        .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_XBGR4444,        .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_RGBX4444,        .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_BGRX4444,        .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_ARGB4444,        .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_ABGR4444,        .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_RGBA4444,        .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_BGRA4444,        .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_XRGB1555,        .depth = 15, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_XBGR1555,        .depth = 15, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_RGBX5551,        .depth = 15, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_BGRX5551,        .depth = 15, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_ARGB1555,        .depth = 15, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_ABGR1555,        .depth = 15, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_RGBA5551,        .depth = 15, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_BGRA5551,        .depth = 15, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_RGB565,          .depth = 16, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_BGR565,          .depth = 16, .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_RGB888,          .depth = 24, .num_planes = 1, .cpp = { 24, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_BGR888,          .depth = 24, .num_planes = 1, .cpp = { 24, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_XRGB8888,        .depth = 24, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_XBGR8888,        .depth = 24, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_RGBX8888,        .depth = 24, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_BGRX8888,        .depth = 24, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_RGB565_A8,       .depth = 24, .num_planes = 2, .cpp = { 16, 8, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_BGR565_A8,       .depth = 24, .num_planes = 2, .cpp = { 16, 8, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_XRGB2101010,     .depth = 30, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_XBGR2101010,     .depth = 30, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_RGBX1010102,     .depth = 30, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_BGRX1010102,     .depth = 30, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_ARGB2101010,     .depth = 30, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_ABGR2101010,     .depth = 30, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_RGBA1010102,     .depth = 30, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_BGRA1010102,     .depth = 30, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_ARGB8888,        .depth = 32, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_ABGR8888,        .depth = 32, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_RGBA8888,        .depth = 32, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_BGRA8888,        .depth = 32, .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_XRGB16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_XBGR16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1 },
> +               { .format = DRM_FORMAT_ARGB16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_ABGR16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_RGB888_A8,       .depth = 32, .num_planes = 2, .cpp = { 24, 8, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_BGR888_A8,       .depth = 32, .num_planes = 2, .cpp = { 24, 8, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_XRGB8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 32, 8, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_XBGR8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 32, 8, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_RGBX8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 32, 8, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_BGRX8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 32, 8, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_YUV410,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 4, .vsub = 4, .is_yuv = true },
> +               { .format = DRM_FORMAT_YVU410,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 4, .vsub = 4, .is_yuv = true },
> +               { .format = DRM_FORMAT_YUV411,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 4, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_YVU411,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 4, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_YUV420,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 2, .vsub = 2, .is_yuv = true },
> +               { .format = DRM_FORMAT_YVU420,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 2, .vsub = 2, .is_yuv = true },
> +               { .format = DRM_FORMAT_YUV422,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_YVU422,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_YUV444,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_YVU444,          .depth = 0,  .num_planes = 3, .cpp = { 8, 8, 8 },  .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV12,            .depth = 0,  .num_planes = 2, .cpp = { 8, 16, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV21,            .depth = 0,  .num_planes = 2, .cpp = { 8, 16, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV16,            .depth = 0,  .num_planes = 2, .cpp = { 8, 16, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV61,            .depth = 0,  .num_planes = 2, .cpp = { 8, 16, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV24,            .depth = 0,  .num_planes = 2, .cpp = { 8, 16, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV42,            .depth = 0,  .num_planes = 2, .cpp = { 8, 16, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV12_10,         .depth = 0,  .num_planes = 2, .cpp = { 10, 20, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV21_10,         .depth = 0,  .num_planes = 2, .cpp = { 10, 20, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV16_10,         .depth = 0,  .num_planes = 2, .cpp = { 10, 20, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV61_10,         .depth = 0,  .num_planes = 2, .cpp = { 10, 20, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV24_10,         .depth = 0,  .num_planes = 2, .cpp = { 10, 20, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_NV42_10,         .depth = 0,  .num_planes = 2, .cpp = { 10, 20, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_YUYV,            .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_YVYU,            .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_UYVY,            .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_VYUY,            .depth = 0,  .num_planes = 1, .cpp = { 16, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_XYUV8888,        .depth = 0,  .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_VUY888,          .depth = 0,  .num_planes = 1, .cpp = { 24, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_AYUV,            .depth = 0,  .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> +               { .format = DRM_FORMAT_Y210,            .depth = 0,  .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_Y212,            .depth = 0,  .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_Y216,            .depth = 0,  .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_Y410,            .depth = 0,  .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> +               { .format = DRM_FORMAT_Y412,            .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> +               { .format = DRM_FORMAT_Y416,            .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> +               { .format = DRM_FORMAT_XVYU2101010,     .depth = 0,  .num_planes = 1, .cpp = { 32, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_XVYU12_16161616, .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1, .is_yuv = true },
> +               { .format = DRM_FORMAT_XVYU16161616,    .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 },  .hsub = 1, .vsub = 1, .is_yuv = true },
>                 { .format = DRM_FORMAT_Y0L0,            .depth = 0,  .num_planes = 1,
>                   .char_per_block = { 8, 0, 0 }, .block_w = { 2, 0, 0 }, .block_h = { 2, 0, 0 },
>                   .hsub = 2, .vsub = 2, .has_alpha = true, .is_yuv = true },
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 0b72468..7b29e97 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -530,7 +530,7 @@ int drm_mode_getfb(struct drm_device *dev,
>         r->height = fb->height;
>         r->width = fb->width;
>         r->depth = fb->format->depth;
> -       r->bpp = fb->format->cpp[0] * 8;
> +       r->bpp = fb->format->bpp[0];
>         r->pitch = fb->pitches[0];
>
>         /* GET_FB() is an unprivileged ioctl so we must not return a
> diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> index 306d1ef..021358d 100644
> --- a/include/drm/drm_fourcc.h
> +++ b/include/drm/drm_fourcc.h
> @@ -73,12 +73,12 @@ struct drm_format_info {
>                 /**
>                  * @cpp:
>                  *
> -                * Number of bytes per pixel (per plane), this is aliased with
> +                * Number of bits per pixel (per plane), this is aliased with
>                  * @char_per_block. It is deprecated in favour of using the
>                  * triplet @char_per_block, @block_w, @block_h for better
>                  * describing the pixel format.
>                  */
> -               u8 cpp[3];
> +               u8 bpp[3];
>
>                 /**
>                  * @char_per_block:
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 3feeaa3..5fe89e9 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -266,6 +266,21 @@ extern "C" {
>  #define DRM_FORMAT_P016                fourcc_code('P', '0', '1', '6') /* 2x2 subsampled Cr:Cb plane 16 bits per channel */
>
>  /*
> + * 2 plane YCbCr 10bit
> + * index 0 = Y plane, [9:0] Y
> + * index 1 = Cr:Cb plane, [19:0] Cr:Cb little endian
> + * or
> + * index 1 = Cb:Cr plane, [19:0] Cb:Cr little endian
> + */
> +
> +#define DRM_FORMAT_NV12_10     fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV21_10     fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
> +#define DRM_FORMAT_NV16_10     fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV61_10     fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
> +#define DRM_FORMAT_NV24_10     fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV42_10     fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
> +
> +/*
>   * 3 plane YCbCr
>   * index 0: Y plane, [7:0] Y
>   * index 1: Cb plane, [7:0] Cb
> --
> 2.7.4
>
>
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
