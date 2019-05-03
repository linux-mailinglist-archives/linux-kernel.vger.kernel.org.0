Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0A12F50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfECNh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 09:37:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfECNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jr7I/fSX0tEk3rSwsCDMjnJycCAgKZn0ribRjxnDjz4=; b=SZr1HNFtCdwLsMUKiHBimEMzh
        wM8XlxiZ2AWfWEixT4HbCXGbjVeqmk0sTS741OozMXx2gH9rp1ekJY63Zw/PQhJBSR9XCQN9hUFD0
        ocIlCiU2Npna3SrUEGqs/gX+LHZ8BfJIeIKsy+3PyG2Lo7X3CPzfHl0orj2U/d1oS7yS086ssl/Zp
        RMNc/mOHKgsEXu5VsxRicBPwr3mUi0hFksfntWsxd0GrR43CthZWo7Mb5RPUp8P6OtVcx92NczHSb
        jeStg9nyH3FkqvqRAD1XbrqqAKX90HVtM2AzRdGWp7vNAb9tsykyN5+HArT8fHHuyG1imJwMTOSby
        Wsx4DYy1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMYNL-0005Oq-5A; Fri, 03 May 2019 13:37:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EDDD214242ED; Fri,  3 May 2019 15:37:17 +0200 (CEST)
Date:   Fri, 3 May 2019 15:37:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v7 09/20] locking/rwsem: Always release wait_lock
 before waking up tasks
Message-ID: <20190503133717.GG2623@hirez.programming.kicks-ass.net>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-10-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428212557.13482-10-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 05:25:46PM -0400, Waiman Long wrote:

> +			/*
> +			 * This waiter may have become first in the wait
> +			 * list after re-acquring the wait_lock. The
> +			 * rwsem_first_waiter() test in the main while
> +			 * loop below will correctly detect that. We do
> +			 * need to reload count to perform proper trylock
> +			 * and avoid missed wakeup.
> +			 */
> +			count = atomic_long_read(&sem->count);
> +		}
>  	} else {
>  		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
>  	}

I've been eyeing that count usage for the past few patches, and this
here makes me think we should get rid of it.

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -400,13 +400,14 @@ static void __rwsem_mark_wake(struct rw_
  * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
  * bit is set or the lock is acquired with handoff bit cleared.
  */
-static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
+static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					enum writer_wait_state wstate)
 {
-	long new;
+	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
 
+	count = atomic_long_read(&sem->count);
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
@@ -760,25 +761,16 @@ rwsem_down_write_slowpath(struct rw_sema
 			wake_up_q(&wake_q);
 			wake_q_init(&wake_q);	/* Used again, reinit */
 			raw_spin_lock_irq(&sem->wait_lock);
-			/*
-			 * This waiter may have become first in the wait
-			 * list after re-acquring the wait_lock. The
-			 * rwsem_first_waiter() test in the main while
-			 * loop below will correctly detect that. We do
-			 * need to reload count to perform proper trylock
-			 * and avoid missed wakeup.
-			 */
-			count = atomic_long_read(&sem->count);
 		}
 	} else {
-		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
+		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
 	}
 
 wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	for (;;) {
-		if (rwsem_try_write_lock(count, sem, wstate))
+		if (rwsem_try_write_lock(sem, wstate))
 			break;
 
 		raw_spin_unlock_irq(&sem->wait_lock);
@@ -819,7 +811,6 @@ rwsem_down_write_slowpath(struct rw_sema
 		}
 
 		raw_spin_lock_irq(&sem->wait_lock);
-		count = atomic_long_read(&sem->count);
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
