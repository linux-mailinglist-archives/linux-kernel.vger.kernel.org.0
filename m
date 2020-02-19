Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675BD164DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 19:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSSrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 13:47:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34075 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:47:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so1498771ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qdBelafRS90mTJR0ZDhtL9NP9IOAcj+85dHIAJNr6Y=;
        b=g/hXqb8CuIqhNgD9Aswj3CS8reUvchKD3YqrkSYdHc1XyfIaTm0iuYRJGW+4Hv2amW
         U4jy2Pbu0q4W8wAf2jA6gK2MCum2ae1wu9MGDw+XOHopf5JhfEIekVcXwGY16IY06UfG
         MJ+T9jeRz5aBpVE5xAkeWsdwp/C8mu3RDBkDhEplrfJi3F3Hfjir5Lz6AXWUDBbL2aN/
         UcsGyxAx3lnoSwZq9Y9cEFTZLndcpbXeBTRxZ7lmubVxJRq2RVmpMeK3CUS2Ffl13Ren
         Q5R6zf3ovrbbSa8n87WduWq9MaaD2B8AtXDhGgOZ3kPEPfpADXy7m/Vq0NHSEEbs+B7Q
         lkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qdBelafRS90mTJR0ZDhtL9NP9IOAcj+85dHIAJNr6Y=;
        b=BFVLny658UxWy+RSMt9RI7F0ReE+mj7ZswypmX7ObJs918hqxeouYAvOQ4kQ4+GN0f
         P4LQCrJhS9GJNOIRQva6aB+jeeF+QbjTXYpHG0lwXcf0ofmM9vRaXma6GnvOSMqblWwf
         mOQpxBX4UJFoNdrrmlHCuLSDM06mHEV4yRyeoYnVawco9cxTfy9BuRhYqp2pYH9loteV
         Vh4RGbm/ewyPKpHj7TsNtqbXRy0FnR4oIFnPJ7caXyjSdBUeGDETG5a/KFBh9xY8vCYU
         dDjVXcLMblxrXR6ku6DuXNyv/KsuPi49qCD/3BKCqaVb68yJ94DAeHpYxj+nPBVz/Mya
         4D1A==
X-Gm-Message-State: APjAAAXGeoCTEsOd0FT29sUZudmt68hNINyjzTzjEYubc2iLeqm8bH54
        nDvslaeThB3uDnUNPt7gI3nRlQkjkwcU5aY9XzWvSQ==
X-Google-Smtp-Source: APXvYqxA8uqB6LLhbUTY2CBVeT9BkI9HDujCxv9SmCmpPAjbCdsc2LCwJ4xqHohQStpPlOjiBLUjOuMxDy7AU78zpEY=
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr15305071ljp.22.1582138029452;
 Wed, 19 Feb 2020 10:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20200218172821.18378-1-wambui.karugax@gmail.com> <20200218172821.18378-7-wambui.karugax@gmail.com>
In-Reply-To: <20200218172821.18378-7-wambui.karugax@gmail.com>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 19 Feb 2020 10:46:58 -0800
Message-ID: <CADaigPXx=sT58fPabvBBMdopQ3Gz4=_r76dj0CY=y=8bNteVKA@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: make v3d_debugfs_init return 0
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 9:28 AM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> As drm_debugfs_create_files should return void, remove its use as the
> return value of v3d_debugfs_init and have the function return 0
> directly.

If we're going this route, then this function should be returning void, too.

>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/v3d/v3d_debugfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
> index 9e953ce64ef7..57dded6a3957 100644
> --- a/drivers/gpu/drm/v3d/v3d_debugfs.c
> +++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
> @@ -261,7 +261,8 @@ static const struct drm_info_list v3d_debugfs_list[] = {
>  int
>  v3d_debugfs_init(struct drm_minor *minor)
>  {
> -       return drm_debugfs_create_files(v3d_debugfs_list,
> -                                       ARRAY_SIZE(v3d_debugfs_list),
> -                                       minor->debugfs_root, minor);
> +       drm_debugfs_create_files(v3d_debugfs_list,
> +                                ARRAY_SIZE(v3d_debugfs_list),
> +                                minor->debugfs_root, minor);
> +       return 0;
>  }
> --
> 2.25.0
>
