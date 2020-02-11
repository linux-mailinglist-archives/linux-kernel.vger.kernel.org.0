Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9371E1594E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgBKQ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:27:19 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46301 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgBKQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:27:18 -0500
Received: by mail-wr1-f48.google.com with SMTP id z7so13091577wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bb55gTYbvX5LbdEf+EUAlbMGla2WoqoUJ8i650G+fRc=;
        b=bWg35xF/yD9pqZ9r9gAfcFYbcO01dATtpd5p/Yu+BmIBqo+lRQ7+4bsut1tsRWTfl8
         ToapJrBfwq6ld3O/77RBF5A79hiOM6g53wO86v0uru9JZHUyJafV178juS00IiaXfjAe
         9pGroEiCI1KvXxFiQhXBU1zOAE3dv4jVg2ed1BQvvhevAE33L4S4WpnjFLif2zoIOgBC
         lVi8zE6ih4CZRsKn5tpzo6dd5D1pro92eh6b1R9vnZRMtYQBvnjX9bwHlrxsLCw/KV3u
         6u84QJPojqmGpfz+rDkMuVWm5A5qe2jRENq8gsrIXsz6I3e+XyVF7K8vM58p/7rPxR7l
         KyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bb55gTYbvX5LbdEf+EUAlbMGla2WoqoUJ8i650G+fRc=;
        b=mEb6ShYopRRxpIGqv0/NNwqDUq+1FdU7qtR9fPFNYuXBIPVfkq7WgS2rIdqGYhgYx+
         ONGzC22fIz7Knsj9obx2slnKT69+D5pBrpa5pCD/v8H33roseyXWQr+VukfFDvM04xMQ
         mVW88VQ+f9pRDu7GTb59ZRbnlQzUSso5pqr/7czyJlLkFvzPknrKM2LchpdUvSe7jA+K
         /VmRgWLSY7ZhLPLw2U7J5U/LvLNfLgTOyqghpL3dJ6GfsaUeZlN4/DtUpljtSkwhXYVn
         E+LZj8AC69yDgas2/H4A1TM/Qlan0g0nS4jaTgsNJ5bTvyTqQ2XkTCL/Kg+bEe1JzZk2
         Feqw==
X-Gm-Message-State: APjAAAXEcxiTzIUfk/YvxYv6I+tsReTrHa9Nscwc4if9igxrE/64LRMc
        sIXHYjZz2X073EuMX2BmVPdBlkksnJTIpETgJgY=
X-Google-Smtp-Source: APXvYqxJIVk57by6TFkLMzF0DpAckbyFa0fFzF1uA/eHJG2PTvQ3sdvui9aGi+JIzbggU7p4lUEdYv2UQenZQmQYUyM=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr9786904wrn.124.1581438437502;
 Tue, 11 Feb 2020 08:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20200210150826.35200-1-yuehaibing@huawei.com>
In-Reply-To: <20200210150826.35200-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 11 Feb 2020 11:27:06 -0500
Message-ID: <CADnq5_My4OM4CvDHHWN3MxVKAon78pvbw71mO2yzer-FdxYu1w@mail.gmail.com>
Subject: Re: [RFC PATCH -next] drm/amd/display: Remove set but not unused
 variable 'stream_status'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        "Cyr, Aric" <aric.cyr@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Martin Leung <martin.leung@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:38 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:
>  In function dcn10_post_unlock_program_front_end:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2623:29:
>  warning: variable stream_status set but not used [-Wunused-but-set-variable]
>
> commit bbf5f6c3f83b ("drm/amd/display: Split program front end part that occur outside lock")
> involved this unused variable.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 42fcfee..b2ed0fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2610,7 +2610,7 @@ void dcn10_post_unlock_program_front_end(
>                 struct dc *dc,
>                 struct dc_state *context)
>  {
> -       int i, j;
> +       int i;
>
>         DC_LOGGER_INIT(dc->ctx->logger);
>
> @@ -2620,14 +2620,8 @@ void dcn10_post_unlock_program_front_end(
>                 if (!pipe_ctx->top_pipe &&
>                         !pipe_ctx->prev_odm_pipe &&
>                         pipe_ctx->stream) {
> -                       struct dc_stream_status *stream_status = NULL;
>                         struct timing_generator *tg = pipe_ctx->stream_res.tg;
>
> -                       for (j = 0; j < context->stream_count; j++) {
> -                               if (pipe_ctx->stream == context->streams[j])
> -                                       stream_status = &context->stream_status[j];
> -                       }
> -
>                         if (context->stream_status[i].plane_count == 0)
>                                 false_optc_underflow_wa(dc, pipe_ctx->stream, tg);
>                 }
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
