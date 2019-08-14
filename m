Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E818D254
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 13:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfHNLii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 07:38:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40325 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:38:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so79093309lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tl4lHPgUKyjZ4PA5frXihhV1cgSueNxdkLcdZsBaY4I=;
        b=jbPsuqGC/o2ZqbZIV5mCeR3UJ7x6ztoAqdeOaM7bCjV7XeQ2b2f5KSNZRWcy5T2J1F
         nhf36FHFqaSyVDvmlGFM3VfNnoGwd6y14WLITLKeO607r5sFOoZY2t9WNLsEX++muVKG
         FvIB2nYIXiTZ5DBylglUMRIypMmbVkAjleOlU8tGJpKD1PYbLOZVNMVnixtiI4DAP3lz
         jikVx7bcSI8WeTCcfEHqLoa2EwRwtE4bIj/HjAWX9k0U78xbi4AlhNCTfiIwbTD3WmDU
         j78kMNCxdbgOggwf8Z5c3Ckm88BxzvbfnG516bYC+LKJru+dvuDZcGYad6olsS+OaK6h
         G7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl4lHPgUKyjZ4PA5frXihhV1cgSueNxdkLcdZsBaY4I=;
        b=A44KI54wUpSgb644NrVRF6IHgPNUFFGgDrdgqTsPSPmDEA4gO6SBpP+Q9Zx0swX486
         q6MH0wjoY53XbywM1pInTOrTHQiQ1BCBjHtNXZR6xTg5o2wkpPrZ45/rE0jWjNeleINS
         +j8YuPdpiOXHHhfcgrsE3oz1WUefMXQwOfnfOPREilsnGzJ60IP7e6neo3qwWhCMwb8D
         GTMDv1eSeNzxsqvp2T4W4s8ggMfkxUvPWgHOw8IpxwGjxUtWBpTCkyV95XsN9XJth/Ya
         RpvcUzdt6vh44PuNuFF4xFu3C6iWoDAsrMKQrGe5KSxkSWk7Nad3Uwb/xVK0kJv4/WoD
         Zqpw==
X-Gm-Message-State: APjAAAW6x9Eq8sLez/QcQJcV69RKW5VnRDHRkjrvrw275pE2o3feMsc1
        zwGRr3ixT7WnVsqokcYIFk7i1P5xQs6QmuH7fVn6bQ==
X-Google-Smtp-Source: APXvYqwdp0z7dISVyQdXlhFPeViRhkBkT7bHEq6kyIgkUCGOt5rMfFVE/QcTv/yI+SBrUgZYYqu3wwbwFOkJT3h5PoY=
X-Received: by 2002:ac2:4ac4:: with SMTP id m4mr24826096lfp.172.1565782716019;
 Wed, 14 Aug 2019 04:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <20190814113348.GA525@ming.t460p>
In-Reply-To: <20190814113348.GA525@ming.t460p>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 14 Aug 2019 13:38:25 +0200
Message-ID: <CAB0TPYHdaOTUKf5ix-oU7cXsV12ZW6YDYBsG+VKr6zk=RCW2NA@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 1:34 PM Ming Lei <ming.lei@redhat.com> wrote:
> Another candidate is to not switch to q_usage_counter's percpu mode
> until loop becomes Lo_bound, and this way may be more clean.

Thanks! I had considered this too, but thought it a bit risky to mess
with the init flag from the loop driver. Maybe we could delay
switching q_usage_counter to per-cpu mode in the block layer in
general, until the first request comes in?

This would also address our issues, and potentially be an even smaller change.

Martijn
>
> Something like the following patch:
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a7461f482467..8791f9242583 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1015,6 +1015,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>          */
>         bdgrab(bdev);
>         mutex_unlock(&loop_ctl_mutex);
> +
> +       percpu_ref_switch_to_percpu(&lo->lo_queue->q_usage_counter);
> +
>         if (partscan)
>                 loop_reread_partitions(lo, bdev);
>         if (claimed_bdev)
> @@ -1171,6 +1174,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>         lo->lo_state = Lo_unbound;
>         mutex_unlock(&loop_ctl_mutex);
>
> +       percpu_ref_switch_to_atomic(&lo->lo_queue->q_usage_counter, NULL);
> +
>         /*
>          * Need not hold loop_ctl_mutex to fput backing file.
>          * Calling fput holding loop_ctl_mutex triggers a circular
> @@ -2003,6 +2008,12 @@ static int loop_add(struct loop_device **l, int i)
>         }
>         lo->lo_queue->queuedata = lo;
>
> +       /*
> +        * cheat block layer for not switching to q_usage_counter's
> +        * percpu mode before loop becomes Lo_bound
> +        */
> +       blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, lo->lo_queue);
> +
>         blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
>
>         /*
>
>
> thanks,
> Ming
