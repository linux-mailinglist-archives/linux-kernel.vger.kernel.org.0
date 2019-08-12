Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF78A78F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 21:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfHLTwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 15:52:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38717 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfHLTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:52:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id r20so13708784ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdTaSZFMc5c0WlaR2P3h3aNLmfWS7MtBN6nvtQBsHM0=;
        b=wOXQsMpKls2n2TWvbygbodoRbilCT7zxfywZx8W9fg1DsdaPvB+TWjAJKecI0MwLma
         HPkyKCzyphSBstyhyr2OoGDSiqolOIW4UYiEmDOYnlvbZs/T+IHfNmqjCEm0mUnV0zDN
         K66Rav+9mPw4nRCZh8YzfrZzyTewjwRc/YQatITPJNKwAlkwb2IbNsGNKetKp9nyyQ6L
         bu8DgM2Uccyr/Y0L/CuazZBwuIWOvb8pp/lrMVDZgK1+WuKSciTIRyvm4uO67nE5iCVA
         YYUjAE1TiFd1125P2QenAH5Wti81+Pj5qr9pBmKXoSiE6s0tWuBYW1+jD2R8nYKNvHzg
         rjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdTaSZFMc5c0WlaR2P3h3aNLmfWS7MtBN6nvtQBsHM0=;
        b=geZUVx4LFGvdh7B9xBTO6K96aggQVG2sEM3dLjvA4tnphMOnUhNLBwPn4muu5tcUGI
         xcrocP/EHw7oRzDfJ/Ac2gmO0Gx7pgT8v19A3QKw60zcGyYezbZoJ36Iz4NqEQLVsAHQ
         RBX024p96qz39sDj+t3iFf0KC1LF/4RhCVYMqcS7vucexD/nr4jyJb8PT1aBF8y9Mkye
         /+30d3roNngJ/7w7I3LXmvsQ/5nNBktpbmQE2qS8bXRO/pADjdlUcgu2ulULy/LZvb8I
         SNQhn8kSQYDGF4GkkBYlaGUAe718vygM4iUHA5EYB7hx8HSBDw3+4L68i80q1NE5ff2y
         qLig==
X-Gm-Message-State: APjAAAX1Dp+NbX5mIZO2xziOrO+XfUoDXtFlrzlbyKZMSgezPC4wGnCr
        wKMuB059NOyrv3C5mZWhmrrOX19jBEtfCvN5q9Jd4w==
X-Google-Smtp-Source: APXvYqzinv8BUq2fw3XQtW9LprZZERQgtghAKjpvgwtfCTXV7yJ0blJuAWMqywLxj6o39rgOmGzFbULPKs7Hcam4rvM=
X-Received: by 2002:a02:8663:: with SMTP id e90mr40014405jai.98.1565639543943;
 Mon, 12 Aug 2019 12:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190805233738.136357-1-yabinc@google.com>
In-Reply-To: <20190805233738.136357-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 12 Aug 2019 13:52:12 -0600
Message-ID: <CANLsYkzdu9CBYhDmMwOC5azmQgyqcjCU-CM9R8JfnaF_KbQomg@mail.gmail.com>
Subject: Re: [PATCH] coresight: tmc-etr: Fix updating buffer in not-snapshot mode.
To:     Yabin Cui <yabinc@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Yabin,

With this patch you are addressing a long time itch I had - please read on.

On Mon, 5 Aug 2019 at 17:37, Yabin Cui <yabinc@google.com> wrote:
>
> TMC etr always copies all available data to perf aux buffer, which
> may exceed the available space in perf aux buffer. It isn't suitable
> for not-snapshot mode, because:
> 1) It may overwrite previously written data.
> 2) It may make the perf_event_mmap_page->aux_head report having more
> or less data than the reality.
>
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 17006705287a..697e68d492af 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1410,9 +1410,10 @@ static void tmc_free_etr_buffer(void *config)
>   * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
>   * buffer to the perf ring buffer.
>   */
> -static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
> +                                    unsigned long to_copy)
>  {
> -       long bytes, to_copy;
> +       long bytes;
>         long pg_idx, pg_offset, src_offset;
>         unsigned long head = etr_perf->head;
>         char **dst_pages, *src_buf;
> @@ -1423,7 +1424,6 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
>         pg_offset = head & (PAGE_SIZE - 1);
>         dst_pages = (char **)etr_perf->pages;
>         src_offset = etr_buf->offset;
> -       to_copy = etr_buf->len;
>
>         while (to_copy > 0) {
>                 /*
> @@ -1501,7 +1501,11 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         size = etr_buf->len;
> -       tmc_etr_sync_perf_buffer(etr_perf);
> +       if (!etr_perf->snapshot && size > handle->size) {
> +               size = handle->size;
> +               lost = true;
> +       }

Perfect - this is in line with what is done for ETB and ETF.

> +       tmc_etr_sync_perf_buffer(etr_perf, size);

Here tmc_etr_sync_perf_buffer() will copy data to the perf ring buffer
starting at @etr_perf->offset for @size, clipping the _end_ of the
trace data accumulated in the trace buffer.  This is contrary to what
is done for ETB and ETF where the equivalent of @etr_perf->offset is
moved forward (clipping the _beginning_ of the trace data) in order to
keep as much of the end as possible.

I would rather enact the same heuristic here.

Thanks,
Mathieu

>
>         /*
>          * In snapshot mode we simply increment the head by the number of byte
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
