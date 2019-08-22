Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED0298991
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 04:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfHVCmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 22:42:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46946 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfHVCmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:42:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so3847707wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 19:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZTqUkxfZYE8+T40PWA8Sviu0JhKS/WcBoRu0Cn0BrM=;
        b=mc6wu6La8/4N/vQ/oGhBjfkxaO0ZCMtFFiLDtkCyj7U5FVSV5+dN9NaY5PO9Il5wk5
         TU3LAGPC6vYjU8+3nAVhF8ITJC6ap5ALHDs6MXIJ9VbYawneMwqAxE/I0Vzmw9Ou70fx
         MhWbDwOFYVgHAeVoTodS4nb4F9gon/cnu85XusFz2tnUjLPE7Fg2TL/Xdvqf3QrnhTIP
         CVDH6HLy4/aCWJJbj6CM+a2u3YcqxqFdFmC1gx05144uk1xPCEMyL6a36wYpPaoNmr6U
         Aq11tSItE1YzqzBImzTNQe015vQK0I4J1yvAdhx4k8Yx94yMdNWhgriyMaxvTPhr+lr8
         gMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZTqUkxfZYE8+T40PWA8Sviu0JhKS/WcBoRu0Cn0BrM=;
        b=ONClxmaAoluijO8rzFKHfpkb8lR62gpaaX5gyzJKpCvovsVEw/cyo3dYCtKUzTx9e3
         20CiYki8AVzMslOHE6u092Qen4eOl2iMDMj1hncBUas8BX/XRgUjny/qrNJJ0JWK/+rT
         lU+BRTEb2QNDhVyHBuuRCKtHrESlUOtpLXuFTgBHu5j4rLwN+3eaWKZlbb1FF/JLVRPs
         B4fDUUIQG15wxQTxq6KXqFfqToEN0AejakHFjfAeFCkDFLXanOnNBOVxmv8ibeI1CpKn
         yRlEfXahXRSEiJHxk6TcpmzZO29uuluSuvu49UIOWFWVkpqOBaw9hpJyyWKuli2r0FAx
         QJxQ==
X-Gm-Message-State: APjAAAUD9YA2mhMhtooNO4dX8ZdQZiqHy6eAQOuRo0xGYsocI2c68uOL
        MPez8cH//a2okHunvG4F8WpNJiDKURc/gZi+2NM=
X-Google-Smtp-Source: APXvYqxSqm3tWIWgCc/6KxQxwfATvNMi8h6Sxb5iMQ/oDJF0Re6IhFTmtGx5rG71zlRanlu/EWaTgaaMoJ/HYJ5KVOU=
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr37920862wrc.4.1566441753566;
 Wed, 21 Aug 2019 19:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190726075131.14688-1-yuehaibing@huawei.com>
In-Reply-To: <20190726075131.14688-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Aug 2019 22:42:21 -0400
Message-ID: <CADnq5_PNA5L=O2=r22JGZ=HU4V5F_D6LMeo85mW+3KvvY1=QeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicated include from dc_link.c
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied. thanks!

Alex

On Fri, Jul 26, 2019 at 5:42 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 193d6f1..a14785d 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -45,10 +45,6 @@
>  #include "dpcd_defs.h"
>  #include "dmcu.h"
>  #include "hw/clk_mgr.h"
> -#if defined(CONFIG_DRM_AMD_DC_DCN2_0)
> -#include "resource.h"
> -#endif
> -#include "hw/clk_mgr.h"
>
>  #define DC_LOGGER_INIT(logger)
>
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
