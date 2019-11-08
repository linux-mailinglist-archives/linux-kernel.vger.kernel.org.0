Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF4F5363
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 19:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfKHSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 13:17:48 -0500
Received: from gentwo.org ([3.19.106.255]:39048 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfKHSRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:17:48 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 979943E957; Fri,  8 Nov 2019 18:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 967713E89A;
        Fri,  8 Nov 2019 18:17:47 +0000 (UTC)
Date:   Fri, 8 Nov 2019 18:17:47 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] percpu-refcount: Use normal instead of RCU-sched"
In-Reply-To: <20191108173553.lxsdic6wa4y3ifsr@linutronix.de>
Message-ID: <alpine.DEB.2.21.1911081813330.1687@www.lameter.com>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de> <20191107091319.6zf5tmdi54amtann@linutronix.de> <20191107161749.GA93945@dennisz-mbp> <20191107162842.2qgd3db2cjmmsxeh@linutronix.de> <20191107165519.GA99408@dennisz-mbp> <20191107172434.ylz4hyxw4rbmhre2@linutronix.de>
 <20191107173653.GA1242@dennisz-mbp> <20191108173553.lxsdic6wa4y3ifsr@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Sebastian Andrzej Siewior wrote:

> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index 7aef0abc194a2..390031e816dcd 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -186,14 +186,14 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>  {
>  	unsigned long __percpu *percpu_count;
>
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>
>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_add(*percpu_count, nr);

You can use

	__this_cpu_add()

instead since rcu_read_lock implies preempt disable.

This will not change the code for x86 but other platforms that do not use
atomic operation here will be able to avoid including to code to disable
preempt for the per cpu operations.

Same is valid for all other per cpu operations in the patch.

