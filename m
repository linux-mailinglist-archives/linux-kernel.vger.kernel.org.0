Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C40B47F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 09:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392526AbfIQHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 03:16:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730666AbfIQHQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:16:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7437DB116;
        Tue, 17 Sep 2019 07:16:32 +0000 (UTC)
Date:   Tue, 17 Sep 2019 00:16:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: locktorture: Do not include rwlock.h directly
Message-ID: <20190917071614.kcmux562y6wbskj5@linux-p48b>
References: <20190916145404.bukcmlliequu77wk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190916145404.bukcmlliequu77wk@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Sebastian Andrzej Siewior wrote:

>From: Wolfgang M. Reimer <linuxball@gmail.com>
>
>Including rwlock.h directly will cause kernel builds to fail
>if CONFIG_PREEMPT_RT is defined. The correct header file
>(rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
>is included by locktorture.c anyway.
>
>Remove the include of linux/rwlock.h.
>

Acked-by: Davidlohr Bueso <dbueso@suse.de>

>Signed-off-by: Wolfgang M. Reimer <linuxball@gmail.com>
>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>---
> kernel/locking/locktorture.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>index c513031cd7e33..9fb042d610d23 100644
>--- a/kernel/locking/locktorture.c
>+++ b/kernel/locking/locktorture.c
>@@ -16,7 +16,6 @@
> #include <linux/kthread.h>
> #include <linux/sched/rt.h>
> #include <linux/spinlock.h>
>-#include <linux/rwlock.h>
> #include <linux/mutex.h>
> #include <linux/rwsem.h>
> #include <linux/smp.h>
>-- 
>2.23.0
>
