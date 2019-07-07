Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C25460CAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfGEUqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 16:46:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40984 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbfGEUqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:46:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so4757721pgj.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XzzO0Y0muxyCTarasdfBqM0rZwh4sARbpmUi8znvM5U=;
        b=CK1eajRF2s8dzkxA8XOhzyOHOTdlg8IsG1U0nKowEtjkv/luoRcDfrvBCi1ptCB7lf
         nqIWQ3vZiMQFGAA7rM0hrvrTSr2McuT3mZcN+0YEBNY+bzqwsJMmZv6sCH9C0X7r4smm
         y0ZTgMxLTkoZ9iJIJRemj+C1qNGSbkUIF7zzpq1xvT2FrGmZ1f5bGqxYsks+1pEyKwCg
         ROXFJYRPRvzt9QypZGqGTgYiSi1WakADWTXP875T4snIWk1tNx7auJyCNnnoewlyJOLL
         cGxBViOTsastUdTD2AYmhYe8K5TwJIQFmLrLL2LpxFBhdWH7hX1YUDnFNjUAWlZI4Bdo
         xqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XzzO0Y0muxyCTarasdfBqM0rZwh4sARbpmUi8znvM5U=;
        b=MCFMv0Kj14etpiv/pByF3x40DDtD9ecPrx4/KDUwbx+h4v45DFZ+TfZnOcbdSqRYrN
         DSeR+PdGBbP5Y7jOpDc8nj+I7hiaolb83aJNJoRUqzecFy7v/cHZ/zFwZsVQJH7v/3YO
         bSDeNaB+HFXPco9CpVxk6wd3EwsXifLEIA6SWPAXm8fmXBKUczwZmPzXDCf4MChL5djj
         CJYG4qDRY3nf51Q7u1yAikjxHhZENdjIOgzeugstM+bZC6EWYMqcuSaXM+VbEk4FLxA5
         C6jKDZ4ntPas4BXJQOVEVWW+hk/8g33R1Crq0wPC9CYwZBJa2kxqbyoh0pxw4idCL1W/
         nt2w==
X-Gm-Message-State: APjAAAWBZujsWIWnNnYutWyAQ6PwgZ8kqGY+Aly1HEidaxLF2OL/zWcW
        ND3uCSQbSA04lgrGMCKZTmA99UeDGkn0nQ==
X-Google-Smtp-Source: APXvYqxj0MTQu3wfzOdQPSFs4pUyKTyHmwh8PkyMVVx1JRzdA3p+f7ccJapheXoAu6Pho6wWqW6WRg==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr7079078pga.397.1562359568697;
        Fri, 05 Jul 2019 13:46:08 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id k3sm8705352pgo.81.2019.07.05.13.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 13:46:07 -0700 (PDT)
Subject: Re: [PATCH] blk-iolatency: fix STS_AGAIN handling
To:     Dennis Zhou <dennis@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190705203228.77695-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4558ef3a-bc60-aa56-8aa4-4427206e2864@kernel.dk>
Date:   Fri, 5 Jul 2019 14:46:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705203228.77695-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/19 2:32 PM, Dennis Zhou wrote:
> The iolatency controller is based on rq_qos. It increments on
> rq_qos_throttle() and decrements on either rq_qos_cleanup() or
> rq_qos_done_bio(). a3fb01ba5af0 fixes the double accounting issue where
> blk_mq_make_request() may call both rq_qos_cleanup() and
> rq_qos_done_bio() on REQ_NO_WAIT. So checking STS_AGAIN prevents the
> double decrement.
> 
> The above works upstream as the only way we can get STS_AGAIN is from
> blk_mq_get_request() failing. The STS_AGAIN handling isn't a real
> problem as bio_endio() skipping only happens on reserved tag allocation
> failures which can only be caused by driver bugs and already triggers
> WARN.
> 
> However, the fix creates a not so great dependency on how STS_AGAIN can
> be propagated. Internally, we (Facebook) carry a patch that kills read
> ahead if a cgroup is io congested or a fatal signal is pending. This
> combined with chained bios progagate their bi_status to the parent is
> not already set can can cause the parent bio to not clean up properly
> even though it was successful. This consequently leaks the inflight
> counter and can hang all IOs under that blkg.
> 
> To nip the adverse interaction early, this removes the rq_qos_cleanup()
> callback in iolatency in favor of cleaning up always on the
> rq_qos_done_bio() path.
> 
> Fixes: a3fb01ba5af0 ("blk-iolatency: only account submitted bios")
> Debugged-by: Tejun Heo <tj@kernel.org>
> Debugged-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>   block/blk-iolatency.c | 29 +++--------------------------
>   1 file changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index e8859350ab6e..c956eebf2d97 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -600,10 +600,6 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
>   	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
>   		return;
>   
> -	/* We didn't actually submit this bio, don't account it. */
> -	if (bio->bi_status == BLK_STS_AGAIN)
> -		return;
> -
>   	iolat = blkg_to_lat(bio->bi_blkg);
>   	if (!iolat)
>   		return;
> @@ -622,6 +618,9 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
>   
>   		inflight = atomic_dec_return(&rqw->inflight);
>   		WARN_ON_ONCE(inflight < 0);
> +		/* We didn't actually submit this bio, don't account for it. */
> +		if (bio->bi_status == BLK_STS_AGAIN)
> +			goto next;
>   		if (iolat->min_lat_nsec == 0)
>   			goto next;
>   		iolatency_record_time(iolat, &bio->bi_issue, now,

Patch in general looks fine to me, but let's get rid of this next label,
it's pretty silly. Only one use of it, why not just make it a nested if?

-- 
Jens Axboe

