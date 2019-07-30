Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8E7A372
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfG3Izc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 04:55:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40738 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbfG3Izb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:55:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so64827578wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=00/2lnNVI0NytkyLvSGsc6rORdGpJUTtFQLuungivnI=;
        b=TsE5Wj8vSgmc3kLvFgyg7jJN9x4nfVxov3ZJCnGzzN/CkfYNsu79kWNit5t7SCY7wh
         3NC51htq+o5uMKybd4eeVegSEcnXD1b6KnyTfzwwpqr0KUc2ZK3cWEAQd82NMvpaUnVi
         F8/YKo2dynGkHpOWi4pBG9bi4lSO6HSRHo5Sn+zNP2rS27qt+H4kZ7RYzHS/6NAisUmR
         +JAW2C2RYA8xNBkVU7VBLWXNCejADsaSF6+siHpGfQmrSn678PW3SpbxiT4vOgtr86on
         7IyXQETfZrr4+lJO8UN3qZLg3fqkWuu6FAl86u4OmYuk0Ct56eYT2XG39u9hKbrBd/rH
         G4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=00/2lnNVI0NytkyLvSGsc6rORdGpJUTtFQLuungivnI=;
        b=WLvXWhnUYzjpTDZ8B7y/V/pdaGw0l3r4sXF279r0sZiJrcpUVl2mG1iHRiMs35OUgt
         ZCc7IkztePGhZoiKJhjsPuEWaS2PGqAU+pVlcRytuUf+svIdmpD5iMrKAGVeCiZKLtfW
         IWwKAs8YS/LUGYotdgJgwII9KdndNYwslSelKTlwEDKoKHmHg5bNrFOW2KX7Ex1HsPAE
         i4XUuKe0eyYmBXBLF6l+KJv8uXH3mLFMbcmrEQPpBcXsaaWssn6XS3i4/yCygWdj47DG
         WT4CaAnJqluY7+rXNwkY7dxiw60EHno1RED66vgu14cfJHrXuqti6TqvVGiFkgDHXcZm
         NXgQ==
X-Gm-Message-State: APjAAAUMueok+dtb3HN9kPgsU6QAYgswfIMM4kv/T9XxpIBsa619yanB
        Ta5Y4KPR2wwoJtEKW0BN7FgogwSYPWU=
X-Google-Smtp-Source: APXvYqzWSKSRj6o4jPvgSE0gPnWfNFJzTFWSE/dmKJ0wKZTqDce5Bhgih+DOrwF3JWu99XoOkgxM3Q==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr37669430wrt.295.1564476928476;
        Tue, 30 Jul 2019 01:55:28 -0700 (PDT)
Received: from [192.168.0.101] (88-147-34-208.dyn.eolo.it. [88.147.34.208])
        by smtp.gmail.com with ESMTPSA id k63sm78640645wmb.2.2019.07.30.01.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 01:55:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190728151931.GA29181@roeck-us.net>
Date:   Tue, 30 Jul 2019 10:55:24 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BCD5EDA-6D08-4023-9EEA-087F0AB99D47@linaro.org>
References: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
 <20190728151931.GA29181@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,
sorry for the delay (Dolomiti's fault).

I didn't consider that rq->elv-icq might have been NULL also
because of OOM.  Thanks for spotting this issue.

As for the other places where the return value of bfq_init_rq is used,
unfortunately I think they matter too.  Those other places are related
to request merging, which is the alternative destiny of requests
(instead of being just inserted).  But, regardless of whether a
request is to be merged or inserted, that request may be destined to a
bfq_queue (possibly merged with a request already in a bfq_queue), and
a NULL return value by bfq_init_rq leads to a crash.  I guess you can
reproduce your failure also for the merge case, by generating
sequential, direct I/O with queue depth > 1, and of course by enabling
failslab.

If my considerations above are correct, do you want to propose a
complete fix yourself?

Thanks,
Paolo

> Il giorno 28 lug 2019, alle ore 17:19, Guenter Roeck =
<linux@roeck-us.net> ha scritto:
>=20
> ping ... just in case this patch got lost in Paolo's queue.
>=20
> Guenter
>=20
> On Mon, Jul 22, 2019 at 10:30:48AM -0700, Guenter Roeck wrote:
>> In bfq_insert_request(), bfqq is initialized with:
>> 	bfqq =3D bfq_init_rq(rq);
>> In bfq_init_rq(), we find:
>> 	if (unlikely(!rq->elv.icq))
>> 		return NULL;
>> Indeed, rq->elv.icq can be NULL if the memory allocation in
>> create_task_io_context() failed.
>>=20
>> A comment in bfq_insert_request() suggests that bfqq is supposed to =
be
>> non-NULL if 'at_head || blk_rq_is_passthrough(rq)' is false. Yet, as
>> debugging and practical experience shows, this is not the case in the
>> above situation.
>>=20
>> This results in the following crash.
>>=20
>> Unable to handle kernel NULL pointer dereference
>> 	at virtual address 00000000000001b0
>> ...
>> Call trace:
>> bfq_setup_cooperator+0x44/0x134
>> bfq_insert_requests+0x10c/0x630
>> blk_mq_sched_insert_requests+0x60/0xb4
>> blk_mq_flush_plug_list+0x290/0x2d4
>> blk_flush_plug_list+0xe0/0x230
>> blk_finish_plug+0x30/0x40
>> generic_writepages+0x60/0x94
>> blkdev_writepages+0x24/0x30
>> do_writepages+0x74/0xac
>> __filemap_fdatawrite_range+0x94/0xc8
>> file_write_and_wait_range+0x44/0xa0
>> blkdev_fsync+0x38/0x68
>> vfs_fsync_range+0x68/0x80
>> do_fsync+0x44/0x80
>>=20
>> The problem is relatively easy to reproduce by running an image with
>> failslab enabled, such as with:
>>=20
>> cd /sys/kernel/debug/failslab
>> echo 10 > probability
>> echo 300 > times
>>=20
>> Avoid the problem by checking if bfqq is NULL before using it. With =
the
>> NULL check in place, requests with missing io context are queued
>> immediately, and the crash is no longer seen.
>>=20
>> Fixes: 18e5a57d79878 ("block, bfq: postpone rq preparation to insert =
or merge")
>> Reported-by: Hsin-Yi Wang  <hsinyi@google.com>
>> Cc: Hsin-Yi Wang <hsinyi@google.com>
>> Cc: Nicolas Boichat <drinkcat@chromium.org>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> block/bfq-iosched.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 72860325245a..56f3f4227010 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5417,7 +5417,7 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
>>=20
>> 	spin_lock_irq(&bfqd->lock);
>> 	bfqq =3D bfq_init_rq(rq);
>> -	if (at_head || blk_rq_is_passthrough(rq)) {
>> +	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>> 		if (at_head)
>> 			list_add(&rq->queuelist, &bfqd->dispatch);
>> 		else
>> --=20
>> 2.7.4
>>=20

