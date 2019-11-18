Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D3100730
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKROSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:18:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33473 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKROSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:18:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so19721510wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 06:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HeUNoECzus+G93MTOrN06Sencf6XibkCqoM0Nj92904=;
        b=Cspi6aBgwJX5jgl6Nz5JXilwXAuRKBh2hfkis1de3YR0zoC71aIBEPo0+22yRJwgC5
         kJWFf0tfLomW4u/RjFzYIREyVf81ce5urXj2mQiog4ClouZQWMm6zy2kcccX9+KkoMFA
         u5QOwFZfNxGI3hL+OWCLK3DcMmBWK9kCEwMx8Pw6DRnggedDvbH+b8SxYpLDe+P7NcxQ
         X86GjjNnnvo3PUiEt3e1s6/PA1vEuu44/q/uKUHasOoK11j4jka92NJYWeUkDLkouvph
         hK/RriUlLjyFZbsK9imCNPdHTSpmxhqCGfEJsm9tf3gi1r9CI+IyzSOUe+Ph4XhQ0luL
         5Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HeUNoECzus+G93MTOrN06Sencf6XibkCqoM0Nj92904=;
        b=umHO6jxn/TCoO416rkGPL43ntTgl169vdPWU42T+a4lnYgOP1VAHiyhmUF8UICSh9F
         MfH1ZcvLZKsPZkjSvdtCa02m9IlKqsltJWbUVmsGswjYO+HLg6/iwd6MWC80KU2N7nz/
         TLvYvnqWvPwjht6RoaUyKqSkhOOeIVuycyH+4cUXggAYysRnPKKlUKl/d8Y0R66xU9XG
         wjP1/v3cOu7xdBtUS1MafXDFvJyAMRChlac2n390uWTd8/tGZoipoUZU+VxjyUIwlhkI
         O3xczYnh7xhjyLPoPomOVeZSlCFS0vOVPIyz9fcQqcLAnfgLW700j1lrEXekP/zs63Sv
         BTvg==
X-Gm-Message-State: APjAAAWhLExmL+qDYPz48/9RkgCFa2uKvMy3Cl5tUQ/MJkZSU0qquLrb
        i9q/J45UQlJq5fWw7O0sksqHHg==
X-Google-Smtp-Source: APXvYqzuOkLLd3o3uSNCKr5R03VUILaokCsi9sUPTC1yROWRtuVbe85/LkggIdB0E1BO00BLVIdO5g==
X-Received: by 2002:adf:9dcb:: with SMTP id q11mr29112167wre.42.1574086688673;
        Mon, 18 Nov 2019 06:18:08 -0800 (PST)
Received: from [192.168.0.100] (88-147-66-190.dyn.eolo.it. [88.147.66.190])
        by smtp.gmail.com with ESMTPSA id r2sm23501666wrp.64.2019.11.18.06.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 06:18:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v1] block, bfq: set default slice_idle to zero for SSDs
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1573656800-14815-1-git-send-email-ppvk@codeaurora.org>
Date:   Mon, 18 Nov 2019 15:18:06 +0100
Cc:     stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAC257FC-8E86-4A1D-8F96-1CF1B9E513FA@linaro.org>
References: <1573656800-14815-1-git-send-email-ppvk@codeaurora.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 13 nov 2019, alle ore 15:53, Pradeep P V K =
<ppvk@codeaurora.org> ha scritto:
>=20
> With default 8ms as a slice idle time, we seen few time bounded
> applications(sensors) on v4.19 kernel are getting timedout during
> multimedia tests (audio, video playbacks etc) with Reboots and
> leading to crash. The timeout configured for these applications
> (sensors) are 20sec.
>=20
> In crash dumps, we seen few synchronous requests from sensors/other
> applications were in their bfq_queues for more than 12-20sec.
>=20
> Idling due to anticipation of future near-by IO requests and wait on
> completion of submitted requests, will effect in choosing the next
> bfq-queue and its scheduling. There by it effecting some time bounded
> applications.
>=20
> After making the slice idle to zero,

As written in the comments that your patch modifies, idling is
essential for controlling I/O.  So your change is
unacceptable unfortunately.

I would recommend you to analyze carefully why this anomaly occurs
with non-zero slice idle.  I'd be willing to help in that.

Alternatively, if you don't want to waste your time finding out the
cause of this problem, then just set slice_idle to 0 manually for your
application.

>  we didn't seen any crash during
> our 72hrs of testing and also it increases the IO throughput.
>=20
> Following FIO benchmark results were taken on a local SSD run:
>=20
> RandomReads that were taken on v4.19 kernel:
>=20
> Idling   iops    avg-lat(us)    stddev       bw
> ----------------------------------------------------
> On       4136    1189.07        17221.65    16.9MB/s
> Off      7246     670.11        1054.76     29.7MB/s
>=20

This is anomalous too.  Probably the kernel you are using lacks
commits made after 4.19 (around one hundred commits IIRC).

Thanks,
Paolo

>    fio --name=3Dtemp --size=3D5G --time_based --ioengine=3Dsync \
> 	--randrepeat=3D0 --direct=3D1 --invalidate=3D1 --verify=3D0 \
> 	--verify_fatal=3D0 --rw=3Drandread --blocksize=3D4k \
> 	--group_reporting=3D1 --directory=3D/data --runtime=3D10 \
> 	--iodepth=3D64 --numjobs=3D5
>=20
> Following code changes were made based on [1],[2] and [3].
>=20
> [1] https://lkml.org/lkml/2018/11/1/1285
> [2] Commit 41c0126b3f22 ("block: Make CFQ default to IOPS mode on
>    SSDs")
> [3] Commit 0bb979472a74 ("cfq-iosched: fix the setting of IOPS mode on
>    SSDs")
>=20
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
> Documentation/block/bfq-iosched.rst |  7 ++++---
> block/bfq-iosched.c                 | 13 +++++++++++++
> block/elevator.c                    |  2 ++
> include/linux/elevator.h            |  1 +
> 4 files changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/block/bfq-iosched.rst =
b/Documentation/block/bfq-iosched.rst
> index 0d237d4..244f4ca 100644
> --- a/Documentation/block/bfq-iosched.rst
> +++ b/Documentation/block/bfq-iosched.rst
> @@ -329,9 +329,10 @@ slice_idle
>=20
> This parameter specifies how long BFQ should idle for next I/O
> request, when certain sync BFQ queues become empty. By default
> -slice_idle is a non-zero value. Idling has a double purpose: boosting
> -throughput and making sure that the desired throughput distribution =
is
> -respected (see the description of how BFQ works, and, if needed, the
> +slice_idle is a non-zero value for rotational devices.
> +Idling has a double purpose: boosting throughput and making
> +sure that the desired throughput distribution is respected
> +(see the description of how BFQ works, and, if needed, the
> papers referred there).
>=20
> As for throughput, idling can be very helpful on highly seeky media
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0319d63..9c994d1 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6514,6 +6514,18 @@ static int bfq_init_queue(struct request_queue =
*q, struct elevator_type *e)
> 	return -ENOMEM;
> }
>=20
> +static void bfq_registered_queue(struct request_queue *q)
> +{
> +	struct elevator_queue *e =3D q->elevator;
> +	struct bfq_data *bfqd =3D e->elevator_data;
> +
> +	/*
> +	 * Default to IOPS mode with no idling for SSDs
> +	 */
> +	if (blk_queue_nonrot(q))
> +		bfqd->bfq_slice_idle =3D 0;
> +}
> +
> static void bfq_slab_kill(void)
> {
> 	kmem_cache_destroy(bfq_pool);
> @@ -6761,6 +6773,7 @@ static ssize_t bfq_low_latency_store(struct =
elevator_queue *e,
> 		.init_hctx		=3D bfq_init_hctx,
> 		.init_sched		=3D bfq_init_queue,
> 		.exit_sched		=3D bfq_exit_queue,
> +		.elevator_registered_fn =3D bfq_registered_queue,
> 	},
>=20
> 	.icq_size =3D		sizeof(struct bfq_io_cq),
> diff --git a/block/elevator.c b/block/elevator.c
> index 076ba73..b882d25 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -504,6 +504,8 @@ int elv_register_queue(struct request_queue *q, =
bool uevent)
> 			kobject_uevent(&e->kobj, KOBJ_ADD);
>=20
> 		e->registered =3D 1;
> +		if (e->type->ops.elevator_registered_fn)
> +			e->type->ops.elevator_registered_fn(q);
> 	}
> 	return error;
> }
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 901bda3..23dcc35 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -50,6 +50,7 @@ struct elevator_mq_ops {
> 	struct request *(*next_request)(struct request_queue *, struct =
request *);
> 	void (*init_icq)(struct io_cq *);
> 	void (*exit_icq)(struct io_cq *);
> +	void (*elevator_registered_fn)(struct request_queue *q);
> };
>=20
> #define ELV_NAME_MAX	(16)
> --=20
> 1.9.1
>=20

