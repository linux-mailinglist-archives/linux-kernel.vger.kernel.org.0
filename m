Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4CAE7333
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 15:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfJ1ODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 10:03:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40069 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfJ1ODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:03:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so9257582wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJWcxYoQBw9FC5bU2SEpgmxglktki3/N2UJx+E1uoHc=;
        b=DanefYv1nIEQfdUnfpue30LOoTxTvjUO5ceGUpcB0pjWXEVXGaoLDGqmzz1V/0GsbN
         4Aa1JZu7SxLgnmJDauSoR3WjisKMPOD/YjE5iZ7c6ZEOa8HMj5gtNPIQ/iM7xr/jhPmm
         3wTOXCVHpBZ0FG6f2Qo1g3R2fYzpI8Wy3hpsWoRJ0r+7NZ/wXB7NuNDa/fhqXjyG0AYU
         fdGyxvG6tb9xhM+ISjrWEepXeGS7MXlYw6qGlBExSPJfzXP0cyk4nlmnNMC3doTn5b7Z
         qGJJVt34VE/LK+gG95dBHx87hWDY5/UJdBZ2bh7Jqn5HjJLmav+IRJAEzP2I7vR8+8kn
         2jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJWcxYoQBw9FC5bU2SEpgmxglktki3/N2UJx+E1uoHc=;
        b=azrzzeOsLLEaR4YDTKG+nC6RV1/iFaXEKuFegwlj91HnurjIUr0E51lP8f2ENsIFDJ
         m8DSsM6xxYD/Dv1M/OrDRcP72G37Ke2fkyFvf/6nXkYrxHx1p5HWh1fjBE+M3fQZ5J+8
         Gnhs/ea+HUmqpkWuGXCsq9D246H/u5YJx2Qw9D27KoxH8hnEPKO/uEhBEGWiQkr2JiZ4
         NWEfCcSoVy3DhJ89jVgkqM/MCpBPXj8+odyHEXpSkI07lTq88iDjDCnozPqHWgzAdgQ8
         KIwkEB65JyrwftBatGx4Mfkb2nrWekhjxvEx8BwytOknV5k5Uh+h/CAgDemahLmCcYtP
         OyHw==
X-Gm-Message-State: APjAAAU75Cdgoc7HVuHgrIu+FGpguSM9BvM7xWSbaU2f6WNMGpIavlMw
        w4ZaTpKc1fw0IjGMfoP5Os1akLctCJ4w/TRdmJc=
X-Google-Smtp-Source: APXvYqzTcpDANF0xCHv5oY8VRV1/vSnNLjz/Lq4qlStLKG0XmYYPuKxqosYZHm6ZF4EgQwtb4EEs/MBIX4kXxxrE4I4=
X-Received: by 2002:a05:600c:24cb:: with SMTP id 11mr99575wmu.141.1572271387834;
 Mon, 28 Oct 2019 07:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191028092005.31121-1-wambui.karugax@gmail.com>
In-Reply-To: <20191028092005.31121-1-wambui.karugax@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 28 Oct 2019 10:02:55 -0400
Message-ID: <CADnq5_P7spc_po3rCYCVHwqCRp4x1CX60yTX2CXQcYCt9FXDqg@mail.gmail.com>
Subject: Re: [Outreachy][PATCH 0/2] sparse warning cleanup
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        outreachy-kernel@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 8:47 AM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> This patchset addresses the sparse warning about the
> `amdgpu_exp_hw_support` variable and corrects the mispelling of the
> word "_LENTH".
>
> Wambui Karuga (2):
>   drm/amd: declare amdgpu_exp_hw_support in amdgpu.h
>   drm/amd: correct "_LENTH" mispelling in constant

Applied the series.  Thanks!

Alex

>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
