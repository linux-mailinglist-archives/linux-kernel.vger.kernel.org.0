Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADAA3B2411
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfIMQ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 12:28:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37456 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388794AbfIMQ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:28:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id g13so34208220qtj.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FzLVd4YDDf6CZHY+6NYMzJKE4UH1hHVZOJxIC0ZTZKs=;
        b=jhroHVwhxY0ImX8RYoKgbgXiFb41c1FPA0YOv565qjgzVCGyKRAw4BllIcUKTj2rgk
         +tFNixuHa1jZJT/LTE8nghJLU3TRsvKY/8gIJw0ISG2PgHYld3aaqa0uGVZ+VelOJpAe
         oe3RKf4RCdL05Tay8dzvIEgpGda+oVGzRw+HWJW2fxzAJQ2mFdmKiJRTmLxDhClf7ymF
         YU6RmzfwbcEVZgd5jnkYD9hBC+ZmK5cFBZgvW3Bdwy6KXtphGjrouUreqe6lokn5qo0v
         HcfflPLex25ZFKPwL9zMVjk3fblqxF6hu+25fvfHgIr3uaCXTpnwslkW65cVaYPUJer3
         TO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FzLVd4YDDf6CZHY+6NYMzJKE4UH1hHVZOJxIC0ZTZKs=;
        b=MZxBJLugiX/zQo8mKJ2TxKVH7SWThwabarBNBBl73dS+1ZKvtxk/4xVY/ICQ1EJua0
         /DpgIE6Bw06ztZKfdcHo18sYAUfTXgAU4Kd+ftZJGqyWxtTFL3+u1HUwb2wCFym9wYSk
         4B0+HcQPYMuAgKaLp7JWY71hg9MWxlqGCWMq3E30rI9JkizLq1PlaYwW0nWeEU1LxqbM
         lisoA6H9hGNIN3WNBExjj0eHzFwAyRkox8OUQ4v+SVetti88CrYV5Cfylvs1IsR2nhqR
         wSGFU6ao3j9oGninO+AtaGP3aaMjaTLz1aDseGodO8EDwZpONfOupVJ22aZ6h3xRH8KV
         bv3A==
X-Gm-Message-State: APjAAAWjhTD6UpJh8M+xcrbTDOKe8p3tDuHST183BQMmS+fs9/Uob1/b
        ozQkK/Rh5oV4phN3fNa5DL7UHw==
X-Google-Smtp-Source: APXvYqzYPGdr90xcWpNbrBsq3Fr5/fv1rtRpTvfoiFz3PN7JiLtha4N9VGncD/OzPu1BcxjjbnlkDQ==
X-Received: by 2002:ac8:1307:: with SMTP id e7mr3959203qtj.183.1568392092139;
        Fri, 13 Sep 2019 09:28:12 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v81sm13216533qka.88.2019.09.13.09.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 09:28:11 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, thgarnie@google.com,
        peterz@infradead.org, tytso@mit.edu, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, mingo@redhat.com,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
Date:   Fri, 13 Sep 2019 12:27:44 -0400
Message-Id: <1568392064-3052-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit b7d5dc21072c ("random: add a spinlock_t to struct
batched_entropy") insists on acquiring "batched_entropy_u32.lock" in
get_random_u32() which introduced the lock chain,

"&rq->lock --> batched_entropy_u32.lock"

even after crng init. As the result, it could result in deadlock below.
Fix it by using get_random_bytes() in shuffle_freelist() which does not
need to take on the batched_entropy locks.

WARNING: possible circular locking dependency detected
5.3.0-rc7-mm1+ #3 Tainted: G             L
------------------------------------------------------
make/7937 is trying to acquire lock:
ffff900012f225f8 (random_write_wait.lock){....}, at:
__wake_up_common_lock+0xa8/0x11c

but task is already holding lock:
ffff0096b9429c00 (batched_entropy_u32.lock){-.-.}, at:
get_random_u32+0x6c/0x1dc

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (batched_entropy_u32.lock){-.-.}:
       lock_acquire+0x31c/0x360
       _raw_spin_lock_irqsave+0x7c/0x9c
       get_random_u32+0x6c/0x1dc
       new_slab+0x234/0x6c0
       ___slab_alloc+0x3c8/0x650
       kmem_cache_alloc+0x4b0/0x590
       __debug_object_init+0x778/0x8b4
       debug_object_init+0x40/0x50
       debug_init+0x30/0x29c
       hrtimer_init+0x30/0x50
       init_dl_task_timer+0x24/0x44
       __sched_fork+0xc0/0x168
       init_idle+0x78/0x26c
       fork_idle+0x12c/0x178
       idle_threads_init+0x108/0x178
       smp_init+0x20/0x1bc
       kernel_init_freeable+0x198/0x26c
       kernel_init+0x18/0x334
       ret_from_fork+0x10/0x18

-> #2 (&rq->lock){-.-.}:
       lock_acquire+0x31c/0x360
       _raw_spin_lock+0x64/0x80
       task_fork_fair+0x5c/0x1b0
       sched_fork+0x15c/0x2dc
       copy_process+0x9e0/0x244c
       _do_fork+0xb8/0x644
       kernel_thread+0xc4/0xf4
       rest_init+0x30/0x238
       arch_call_rest_init+0x10/0x18
       start_kernel+0x424/0x52c

-> #1 (&p->pi_lock){-.-.}:
       lock_acquire+0x31c/0x360
       _raw_spin_lock_irqsave+0x7c/0x9c
       try_to_wake_up+0x74/0x8d0
       default_wake_function+0x38/0x48
       pollwake+0x118/0x158
       __wake_up_common+0x130/0x1c4
       __wake_up_common_lock+0xc8/0x11c
       __wake_up+0x3c/0x4c
       account+0x390/0x3e0
       extract_entropy+0x2cc/0x37c
       _xfer_secondary_pool+0x35c/0x3c4
       push_to_pool+0x54/0x308
       process_one_work+0x4f4/0x950
       worker_thread+0x390/0x4bc
       kthread+0x1cc/0x1e8
       ret_from_fork+0x10/0x18

-> #0 (random_write_wait.lock){....}:
       validate_chain+0xd10/0x2bcc
       __lock_acquire+0x7f4/0xb8c
       lock_acquire+0x31c/0x360
       _raw_spin_lock_irqsave+0x7c/0x9c
       __wake_up_common_lock+0xa8/0x11c
       __wake_up+0x3c/0x4c
       account+0x390/0x3e0
       extract_entropy+0x2cc/0x37c
       crng_reseed+0x60/0x2f8
       _extract_crng+0xd8/0x164
       crng_reseed+0x7c/0x2f8
       _extract_crng+0xd8/0x164
       get_random_u32+0xec/0x1dc
       new_slab+0x234/0x6c0
       ___slab_alloc+0x3c8/0x650
       kmem_cache_alloc+0x4b0/0x590
       getname_flags+0x44/0x1c8
       user_path_at_empty+0x3c/0x68
       vfs_statx+0xa4/0x134
       __arm64_sys_newfstatat+0x94/0x120
       el0_svc_handler+0x170/0x240
       el0_svc+0x8/0xc

other info that might help us debug this:

Chain exists of:
  random_write_wait.lock --> &rq->lock --> batched_entropy_u32.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(batched_entropy_u32.lock);
                               lock(&rq->lock);
                               lock(batched_entropy_u32.lock);
  lock(random_write_wait.lock);

 *** DEADLOCK ***

1 lock held by make/7937:
 #0: ffff0096b9429c00 (batched_entropy_u32.lock){-.-.}, at:
get_random_u32+0x6c/0x1dc

stack backtrace:
CPU: 220 PID: 7937 Comm: make Tainted: G             L    5.3.0-rc7-mm1+
Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS
L50_5.13_1.11 06/18/2019
Call trace:
 dump_backtrace+0x0/0x248
 show_stack+0x20/0x2c
 dump_stack+0xd0/0x140
 print_circular_bug+0x368/0x380
 check_noncircular+0x248/0x250
 validate_chain+0xd10/0x2bcc
 __lock_acquire+0x7f4/0xb8c
 lock_acquire+0x31c/0x360
 _raw_spin_lock_irqsave+0x7c/0x9c
 __wake_up_common_lock+0xa8/0x11c
 __wake_up+0x3c/0x4c
 account+0x390/0x3e0
 extract_entropy+0x2cc/0x37c
 crng_reseed+0x60/0x2f8
 _extract_crng+0xd8/0x164
 crng_reseed+0x7c/0x2f8
 _extract_crng+0xd8/0x164
 get_random_u32+0xec/0x1dc
 new_slab+0x234/0x6c0
 ___slab_alloc+0x3c8/0x650
 kmem_cache_alloc+0x4b0/0x590
 getname_flags+0x44/0x1c8
 user_path_at_empty+0x3c/0x68
 vfs_statx+0xa4/0x134
 __arm64_sys_newfstatat+0x94/0x120
 el0_svc_handler+0x170/0x240
 el0_svc+0x8/0xc

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8834563cdb4b..96cdd36f9380 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1598,8 +1598,15 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
 	if (page->objects < 2 || !s->random_seq)
 		return false;
 
+	/*
+	 * Don't use get_random_int() here as it might deadlock due to
+	 * "&rq->lock --> batched_entropy_u32.lock" chain.
+	 */
+	if (!arch_get_random_int((int *)&pos))
+		get_random_bytes(&pos, sizeof(int));
+
 	freelist_count = oo_objects(s->oo);
-	pos = get_random_int() % freelist_count;
+	pos %= freelist_count;
 
 	page_limit = page->objects * s->size;
 	start = fixup_red_left(s, page_address(page));
-- 
1.8.3.1

