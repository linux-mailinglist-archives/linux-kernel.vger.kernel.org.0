Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA4BA9210
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfIDSt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 14:49:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32820 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732885AbfIDSt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:49:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so8752259pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=dv4kjZQzOKcDKJtMMXuFfodnvyC/6cLAtve2XJNA6UA=;
        b=oHsjX8yG3QpiipJ1imp1jZOpm0dc5Rw0OZi6IKwTFOnlCQY/tLXcgMsossXG4uDoxL
         +McyzLHzQd1BMGZyx300rZbmFjBvNZbQoqXlZvCzTlvtHk4OCEjSA1LQOACarIoJFEcg
         YK93AyGlgI/agaOocse1OJ6qSFkSHNbuyrqNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=dv4kjZQzOKcDKJtMMXuFfodnvyC/6cLAtve2XJNA6UA=;
        b=GUedMwhHizaLvvYShQXaXmfZgnmwxTKDy56lvK8fVYgdPt2MEuyQoh1SxhoDo9Hw1j
         R2wUMXIZAQrWGpLzsl75MICuHoxva15t+YhEWkQ6gOoGgT5qdyehJ7fKcHk6QlRyFsKS
         XhBuR7waKam9doqdOQeipxdVKbqexo3AosXq+OR95lmefne0wpW9G1HTloQZvu9weZ+y
         XENxTwonx72lh6BxHnpA2cBATRxbpQ9Lj1qwrg6cEt7gzX7dDpaHP/fV5cnvAJjt1PWr
         MOc41M/pJm1MNKxmu+CR9S5nkAHosEhaSx1/YefrQQYBK+TuGseZ50si4N9JDxdcQK8V
         9V3Q==
X-Gm-Message-State: APjAAAUqYRvFIjbyAM3XgqiL2PbAfODkSd1ZdsRpukhBPSCqmzCEjFI1
        AYndXp5TOdRxS7AGjdxydyFSXRbGFN51ow==
X-Google-Smtp-Source: APXvYqzwu62145L8GhAJeLFjGa8/7BYyg5VJS2UxCCGWWQXy7m7M+nVBfxxus3kX/ZIdiEKHERwdkA==
X-Received: by 2002:a62:4e09:: with SMTP id c9mr21882592pfb.152.1567622998642;
        Wed, 04 Sep 2019 11:49:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y10sm3500713pjp.27.2019.09.04.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 11:49:58 -0700 (PDT)
Message-ID: <5d700756.1c69fb81.77c08.9c82@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190904110038.2bx25byitrejlteu@flow>
References: <20190904110038.2bx25byitrejlteu@flow>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Keerthy <j-keerthy@ti.com>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] random: Support freezable kthreads in add_hwgenerator_randomness()
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 04 Sep 2019 11:49:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sebastian Andrzej Siewior (2019-09-04 04:00:38)
> On 2019-08-22 15:55:19 [+1000], Herbert Xu wrote:
> > Patch applied.  Thanks.
> [ ff296293b3538 ("random: Support freezable kthreads in add_hwgenerator_r=
andomness()") ]
>=20
> and since kthread_freezable_should_stop() has might_sleep() in it, I get
> this:
>=20
> |: do not call blocking ops when !TASK_RUNNING; state=3D1 set at [<000000=
00349d1489>] prepare_to_wait_event+0x5a/0x180
> |: WARNING: CPU: 0 PID: 828 at kernel/sched/core.c:6741 __might_sleep+0x6=
f/0x80
> |: Modules linked in:
> |:
> |: CPU: 0 PID: 828 Comm: hwrng Not tainted 5.3.0-rc7-next-20190903+ #46
> |: RIP: 0010:__might_sleep+0x6f/0x80
> =E2=80=A6
> |: Call Trace:
> |:  kthread_freezable_should_stop+0x1b/0x60
> |:  add_hwgenerator_randomness+0xdd/0x130
> |:  hwrng_fillfn+0xbf/0x120
> |:  kthread+0x10c/0x140
> |:  ret_from_fork+0x27/0x50
>=20

Ugh ok. Thanks for the report.

We're getting warnings because the task is in TASK_INTERRUPTIBLE state
when we call kthread_freezable_should_stop() from deep within the wait
event code. We shouldn't do that, and instead we should call
wait_event_freezable() and kthread_should_stop() in the condition. This
way we'll call into the freezer when the task is woken up by the suspend
path.

Can you try this?

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9b54cdb301d3..d3beed084c0a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -327,6 +327,7 @@
 #include <linux/percpu.h>
 #include <linux/cryptohash.h>
 #include <linux/fips.h>
+#include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/workqueue.h>
 #include <linux/irq.h>
@@ -2429,7 +2430,6 @@ void add_hwgenerator_randomness(const char *buffer, s=
ize_t count,
 				size_t entropy)
 {
 	struct entropy_store *poolp =3D &input_pool;
-	bool frozen =3D false;
=20
 	if (unlikely(crng_init =3D=3D 0)) {
 		crng_fast_load(buffer, count);
@@ -2440,13 +2440,11 @@ void add_hwgenerator_randomness(const char *buffer,=
 size_t count,
 	 * We'll be woken up again once below random_write_wakeup_thresh,
 	 * or when the calling thread is about to terminate.
 	 */
-	wait_event_interruptible(random_write_wait,
-			kthread_freezable_should_stop(&frozen) ||
+	wait_event_freezable(random_write_wait,
+			kthread_should_stop() ||
 			ENTROPY_BITS(&input_pool) <=3D random_write_wakeup_bits);
-	if (!frozen) {
-		mix_pool_bytes(poolp, buffer, count);
-		credit_entropy_bits(poolp, entropy);
-	}
+	mix_pool_bytes(poolp, buffer, count);
+	credit_entropy_bits(poolp, entropy);
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
=20

