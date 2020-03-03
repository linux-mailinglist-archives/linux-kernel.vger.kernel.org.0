Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38106178523
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 22:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCCV7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 16:59:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37069 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCV7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:59:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so2187900pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 13:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddapSUJt6ntLiYzzjDAEz3gG4fW9QkFbYIQvX7Nl4Wc=;
        b=HvFSulAcRQ9FH1nMyqzV2UlBduKJxbKupcWDMN6FDg342qavq7XRv4+kauubRe7OTf
         tpJHVbvlzT18i/r27rTEYINBnzpXMkhr1uHas5plyxkywdThRYkPbDsuMUaWbmR822aY
         hSNDw3l5DDYqBaG51Km/QULhrlNGyRDPM/LKMOs1/mNfuTyNM66y+opv9NXbB62zcmAF
         Ihu7ymArZ2+Jf1c9TA6FaFHstjgRfeCjxNdCKF5DN0IJS0o0Fm/85jn6TmD7BquCdDdk
         MWPtVQnns4SH1MqLxMGFcngWwdrSDQkOUWeHmcBc2cnJd8Tpp/jqjsVIf6kwSBOUe4HR
         ihZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddapSUJt6ntLiYzzjDAEz3gG4fW9QkFbYIQvX7Nl4Wc=;
        b=eGBq0K+aq2Z80goF6FRzuD2tdQrJ5n8Y8Uu8rJ3/ufX2rYmVhF//peonyQEr4D7voS
         acIvP5F0RtGRnYM9UVWAaL/gBTL3QtlnZ/GAoUmzMsVeX/EpdBUruBYMhcaGNK8qXbUA
         tQ/5dvfU+yk4gW2akjhLwiKIJe1qml3OIyqfDsIMcpXC7+RcvFPuLr31U3kkBQyUQCX3
         QalYoIW/UIQXx0mRHhGr0u+0fVd4sH3HyWnv/ficRTY9HqzxYM2syM3rz9hQ/ThPMhVY
         sJKysV4E1cQ1ZnpjbmZBBhOTHFTBL9wjv98sOyS55eSkTq/pbPigYKHyZLNLJL0pnreH
         rnXA==
X-Gm-Message-State: ANhLgQ3n921Ux6pS2rNQO811avtv9Nv+EY8+fO4YSoR11LWBDQ2Aa7EY
        1YWC8K2Z44NXmuywURn+bA1zGIue+Bcga/pFfAq5pQ==
X-Google-Smtp-Source: ADFU+vuSSO5ovOYN0PsHWrzzb/fJClDu5pNQ9UPGolmosCGXWuIMIFmAgxO6x7bG2Tpjw+xFGeX17CX9X2YpTRcLBuc=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr6056814pgb.263.1583272747246;
 Tue, 03 Mar 2020 13:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20200302224217.22590-1-natechancellor@gmail.com>
In-Reply-To: <20200302224217.22590-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Mar 2020 13:58:56 -0800
Message-ID: <CAKwvOdkaiU39xmtEheM=754sdGMTB-sP1GRGacpW4DGkdjugfw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove pointless NULL checks in dmub_psr_copy_settings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 2:43 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:31: warning:
> address of 'pipe_ctx->plane_res' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
>                          ~ ~~~~~~~~~~^~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:56: warning:
> address of 'pipe_ctx->stream_res' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
>                                                   ~ ~~~~~~~~~~^~~~~~~~~~
> 2 warnings generated.
>
> As long as pipe_ctx is not NULL, the address of members in this struct
> cannot be NULL, which means these checks will always evaluate to false.
>
> Fixes: 4c1a1335dfe0 ("drm/amd/display: Driverside changes to support PSR in DMCUB")
> Link: https://github.com/ClangBuiltLinux/linux/issues/915
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Indeed, they are not pointers, and no members within `struct
plane_resource` or `struct stream_resource` seem to indicate that they
are somehow invalid.  Good job sleuthing out the correct fixes by tag.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 2c932c29f1f9..a9e1c01e9d9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -144,7 +144,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
>                 }
>         }
>
> -       if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
> +       if (!pipe_ctx)
>                 return false;
>
>         // First, set the psr version
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
