Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E94DF478
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 19:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfJURme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 13:42:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34310 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfJURmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:42:33 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so17010184ion.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzgvuE8ZrpsBhL/phFPBQTgfRoYdysA2uEVHuY0C2yw=;
        b=xGDuT/cwuXVfrZ+nz3kCY7rJ4/vWXGtj4UhZPRfa1YSHzBQi74gMGk3/6SU0Gtig48
         Xk9/MF0CSKB8e3EGEL8DWYkliLdOwoSxm8ANLKoggtZUnf4HaFcrW+EBQgg8ccs/Uqc+
         DrOQPNGyGpOKS2H1DL93zVaj4ubM13Q6xBRWHZeMTUi0kIDdJZIbQNiHFW0YeVmCCcIV
         a75LJZAK0rp8/y94c7fKSIUrc4CeFq3x1B/fFNaZKcdQyWziXKmEwYexxLwwrzAi9uh/
         qQ5V19+IoHfGF1ZRC4ygCBLkYIi/3jcAmw01ZHMl6ravgAh++EozyicyZh3hlUoU7jXT
         SgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzgvuE8ZrpsBhL/phFPBQTgfRoYdysA2uEVHuY0C2yw=;
        b=YTF6TJ9Js3iII7Oxr/BKS2Tvl8OFfv1UiA3wo4yi8k8RdnBLVIgeL8FzQJwrKWNmsY
         wsrkUJypx3veCusaiS1UxPjZzd+x6jZBAOXx4JW5DQ/XFB9PIher7rDVREJ2MkGtaqcW
         u19KfHUeA71zFVmM+vCz8A2ajentIftGAhUzxTVPPF0xWM12pDf3WCWKg7XuH2V208dO
         Qb0fXD09Fnu5js8R0ok+4FPvViBO/fw/0f/spnLq2g0TYBSP8+fOMSKaYtCTjj9O8vdn
         fh12uNsujQnanDSySzCdn4zO5Dl5fgsXxjBPRfzFXJZIAX7+eMjo52JupwW5Tp1STemm
         5ttA==
X-Gm-Message-State: APjAAAW/InlSZuo8AvNObE0naCrQI+2PnG/538J4liKcKeAS9zfmGKer
        uJAe6COmH4AvSQCMxvOaOMRJHgvGpa2NBr1CEAFUTQ==
X-Google-Smtp-Source: APXvYqzesuSl1eIcJuavpZhunNVJw70OVV3BzrNelIbrZm7vXlXp4JjJxP1ijjy9Y9ZJW5V4knNFXtI/ftAGh75ZFso=
X-Received: by 2002:a05:6638:392:: with SMTP id y18mr16267547jap.98.1571679752652;
 Mon, 21 Oct 2019 10:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191021074808.25795-1-leo.yan@linaro.org>
In-Reply-To: <20191021074808.25795-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 21 Oct 2019 11:42:21 -0600
Message-ID: <CANLsYkyvDKw4E7=+fsq7W41iS0P57Rau3fxJffrg8cEScyOOBw@mail.gmail.com>
Subject: Re: [PATCH] perf cs-etm: Fix definition of macro TO_CS_QUEUE_NR
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 at 01:48, Leo Yan <leo.yan@linaro.org> wrote:
>
> Macro TO_CS_QUEUE_NR definition has a typo, which uses 'trace_id_chan'
> as its parameter, this doesn't match with its definition body which uses
> 'trace_chan_id'.  So renames the parameter to 'trace_chan_id'.
>
> It's luck to have a local variable 'trace_chan_id' in the function
> cs_etm__setup_queue(), even we wrongly define the macro TO_CS_QUEUE_NR,
> the local variable 'trace_chan_id' is used rather than the macro's
> parameter 'trace_id_chan'; so the compiler doesn't complain for this
> before.
>
> After renaming the parameter, it leads to a compiling error due
> cs_etm__setup_queue() has no variable 'trace_id_chan'.  This patch uses
> the variable 'trace_chan_id' for the macro so that fixes the compiling
> error.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4ba0f871f086..f5f855fff412 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -110,7 +110,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
>   * encode the etm queue number as the upper 16 bit and the channel as
>   * the lower 16 bit.
>   */
> -#define TO_CS_QUEUE_NR(queue_nr, trace_id_chan)        \
> +#define TO_CS_QUEUE_NR(queue_nr, trace_chan_id)        \
>                       (queue_nr << 16 | trace_chan_id)
>  #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
>  #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
> @@ -819,7 +819,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>          * Note that packets decoded above are still in the traceID's packet
>          * queue and will be processed in cs_etm__process_queues().
>          */
> -       cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_id_chan);
> +       cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
>         ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
>  out:
>         return ret;

Really good catch - Arnaldo please consider.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> --
> 2.17.1
>
