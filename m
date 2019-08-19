Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496A991FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfHSJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 05:06:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39891 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSJGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:06:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id x4so1029417ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=go6Fia+2oUYQIymod2azs8D08VfJ/HmbYRyQmFxd89A=;
        b=UWaHk5oEerHfLKS2cmpeDCb3YNnTl9A8bKmqgSH7efWz9q53FNMXuzRnaeKO+ydNdw
         wo8FWZXd9/UFnUKOg2uDtbJkvdqzqPfr4Kz+AUk3Nwno3GaWfpNOLpgZdzCPoOHC3FPF
         +268WiGdzDOGSb14MjnwrlZ/vziwSQU3B4vxMXWaIUZF4cTw7a36iyLusBHI9EnlCSup
         t8P+iT0HhgGWvE/vj/X+2d9hR82TDvjtbvNBlOtgyCbMkGFLW3T0ruzP+mhs7qY77wjP
         QhAKuuo9kMCP8alNtVj34LY7HEAVt/s0aD8cQHwVTNsey8jme1viz8Wvs8+Irj0Tp6nG
         xXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=go6Fia+2oUYQIymod2azs8D08VfJ/HmbYRyQmFxd89A=;
        b=mW+RolEHn4Fron6cBbqpmCvtqEHvPSzHx75+uUBU15st82iPCMANM0/sp2LkQYab2H
         L91KCEnJEX56UJgfZNeTRwLjw86gPYqgiQfPQTjdkE18ih5atojHmnbFbeyUCelTS4u+
         SWrxty+8XnxY1Iu4tIoRfzMl8GZiZPOIIfbPmWSjSsPJoOXPh4XI75/kvAXEBJ31npGe
         WyWxXW+ljg56z1D7hix46CBXIGL3kBK33kw6jkmw6aY/HHkL7oQ9B2bYDY3TKqxrO19z
         rmowANXltNjaZpq9/PuSKE6de6IUi0iyQoAMCOVXzE9Z7x5bVhO+LsrqnwQpob1Rnco7
         l4nQ==
X-Gm-Message-State: APjAAAVw/1S28rE3/1i27hTtv5Npwhqa2GWJZTuoRnO4XM8QexzfIn8B
        BkKDjLiizN7WkhCc2B/aLjACXjB3UDnLfwBXLMC7bw==
X-Google-Smtp-Source: APXvYqzHfH2e05Zqc2osyVo+KtOEUYoxk9EXt9fxGHWlfCkmBrUFmllOuebgrzndF2yz2wS2Q08N4RmmSgUM3w+pa/c=
X-Received: by 2002:a2e:9903:: with SMTP id v3mr10537275lji.37.1566205589781;
 Mon, 19 Aug 2019 02:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <20190814113348.GA525@ming.t460p>
In-Reply-To: <20190814113348.GA525@ming.t460p>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 19 Aug 2019 11:06:18 +0200
Message-ID: <CAB0TPYFzgm7pJvXfYYER6qqHM3J8dU7WXWv8ct51e2CGctydzw@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
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

I was thinking about this more; our current sequence is:

1) LOOP_SET_FD
2) LOOP_SET_STATUS64 // for lo_offset/lo_sizelimit
3) LOOP_SET_BLOCK_SIZE // to make sure block size is correct for DIO
4) LOOP_SET_DIRECT_IO // to enable DIO

I noticed that LOOP_SET_FD already tries to configure DIO if the
underlying file is opened with O_DIRECT; but in this case, it will
still fail, because the logical block size of the loop queue must
exceed the logical I/O size of the backing device. But the default
logical block size of mq is 512.

One idea to fix is to call blk_queue_logical_block_size() as part of
LOOP_SET_FD, to match the block size of the backing fs in case the
backing file is opened with O_DIRECT; you could argue that if the
backing file is opened with O_DIRECT, this is what the user wanted
anyway. This would allow us to get rid of the latter two ioctl's and
already save quite some time.

Thanks,
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
