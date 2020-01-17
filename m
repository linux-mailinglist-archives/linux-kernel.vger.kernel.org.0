Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2B140ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 17:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAQQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 11:19:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35837 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQQTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:19:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so23198208qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ksShp609WmlgGazovESTfC8zF2Gamd4gDpDZLRxcRk=;
        b=iytTpGicofKCD/Tkfin09tV1c0mrYUGasptFcG4VEnvps8EUcpwXYoUy8f4bA5QUto
         hnoYfLYmJD353HimjKcadn5IkvqaH8O5QJHp22F1UctW7WHOREOKbDlxdey1YML1KHbS
         C793UlYZMAgDrCxA7K99qxSuQDYBeJP8pAYU1n6lvHfBHmzWaEyBkfD7+aLTBbSYNbE/
         8DQEwRhT15UtK1FMjQKInCbB1Zxk+5GJ0CpZK2iqyVYdLP5pvnOg/MRkAd9FBz5W7dSH
         wsMPO5htXK84i3WhC+cLa8RlSzxl+FupD245pGrrbiWez7g2eOM8PkBTdfmmRAGMWPMZ
         lOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ksShp609WmlgGazovESTfC8zF2Gamd4gDpDZLRxcRk=;
        b=h9TKOPo9cs174YtcDSNzJT/ngOEnJHkIlR6gXrYEDZqpGgLU1LupZCKmRG58leD0fJ
         wmAWSpiGL0d+yKq5kf/alc3Ml7sxO0IcksVRyT41Jwp74YRkLap2912ZT7sZIwMYzQCL
         GyHpTIR6n4yek/2adc0NMPyoC9J4uLOEd2YHbV4Hj2i7eHUJ2KZpGNfHPaHLd6I7zmHn
         2BwWcqhXliHtycVvJiNxMaJd/9FxCbFhunxw3X30TWDsr8qZ3ABn3eyHoBc5tEL+cCco
         HcwGjGpvbAXo+Jee9SUZmmyuMpbPaGJHcPVFk1WAt4fuTgJ95Ab57KhuKAgvmWr8uSV6
         wGBQ==
X-Gm-Message-State: APjAAAU93q0N+p56uRH6AAJ7aaLKgL8n8UbT8Pa6O2e2mqNGVuluauuj
        vdlddm0hP8ECrpWqmGJpn/U6gg==
X-Google-Smtp-Source: APXvYqx+Hch2YxCMI6B8ZI/ZRwCayOWXLy9wJenC+VDHAZjdP0eSsb4+gnBKqkRbsz/hkWEa8ZCB1g==
X-Received: by 2002:a05:620a:134f:: with SMTP id c15mr38120524qkl.115.1579277952925;
        Fri, 17 Jan 2020 08:19:12 -0800 (PST)
Received: from ovpn-120-112.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m23sm4446192qtp.6.2020.01.17.08.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:19:12 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v5] mm/hotplug: silence a lockdep splat with printk()
Date:   Fri, 17 Jan 2020 11:19:02 -0500
Message-Id: <20200117161902.20125-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not that hard to trigger lockdep splats by calling printk from
under zone->lock. Most of them are false positives caused by lock chains
introduced early in the boot process and they do not cause any real
problems (although most of the early boot lock dependencies could
happen after boot as well). There are some console drivers which do
allocate from the printk context as well and those should be fixed. In
any case, false positives are not that trivial to workaround and it is
far from optimal to lose lockdep functionality for something that is a
non-issue.

So change has_unmovable_pages() so that it no longer calls dump_page()
itself - instead it returns a "struct page *" of the unmovable page back
to the caller so that in the case of a has_unmovable_pages() failure,
the caller can call dump_page() after releasing zone->lock. Also, make
dump_page() is able to report a CMA page as well, so the reason string
from has_unmovable_pages() can be removed.

Even though has_unmovable_pages doesn't hold any reference to the
returned page this should be reasonably safe for the purpose of
reporting the page (dump_page) because it cannot be hotremoved in the
context of memory unplug. The state of the page might change but that is
the case even with the existing code as zone->lock only plays role for
free pages.

While at it, remove a similar but unnecessary debug-only printk() as
well. A sample of one of those lockdep splats is,

WARNING: possible circular locking dependency detected
------------------------------------------------------
test.sh/8653 is trying to acquire lock:
ffffffff865a4460 (console_owner){-.-.}, at:
console_unlock+0x207/0x750

but task is already holding lock:
ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (&(&zone->lock)->rlock){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock+0x2f/0x40
       rmqueue_bulk.constprop.21+0xb6/0x1160
       get_page_from_freelist+0x898/0x22c0
       __alloc_pages_nodemask+0x2f3/0x1cd0
       alloc_pages_current+0x9c/0x110
       allocate_slab+0x4c6/0x19c0
       new_slab+0x46/0x70
       ___slab_alloc+0x58b/0x960
       __slab_alloc+0x43/0x70
       __kmalloc+0x3ad/0x4b0
       __tty_buffer_request_room+0x100/0x250
       tty_insert_flip_string_fixed_flag+0x67/0x110
       pty_write+0xa2/0xf0
       n_tty_write+0x36b/0x7b0
       tty_write+0x284/0x4c0
       __vfs_write+0x50/0xa0
       vfs_write+0x105/0x290
       redirected_tty_write+0x6a/0xc0
       do_iter_write+0x248/0x2a0
       vfs_writev+0x106/0x1e0
       do_writev+0xd4/0x180
       __x64_sys_writev+0x45/0x50
       do_syscall_64+0xcc/0x76c
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&(&port->lock)->rlock){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock_irqsave+0x3a/0x50
       tty_port_tty_get+0x20/0x60
       tty_port_default_wakeup+0xf/0x30
       tty_port_tty_wakeup+0x39/0x40
       uart_write_wakeup+0x2a/0x40
       serial8250_tx_chars+0x22e/0x440
       serial8250_handle_irq.part.8+0x14a/0x170
       serial8250_default_handle_irq+0x5c/0x90
       serial8250_interrupt+0xa6/0x130
       __handle_irq_event_percpu+0x78/0x4f0
       handle_irq_event_percpu+0x70/0x100
       handle_irq_event+0x5a/0x8b
       handle_edge_irq+0x117/0x370
       do_IRQ+0x9e/0x1e0
       ret_from_intr+0x0/0x2a
       cpuidle_enter_state+0x156/0x8e0
       cpuidle_enter+0x41/0x70
       call_cpuidle+0x5e/0x90
       do_idle+0x333/0x370
       cpu_startup_entry+0x1d/0x1f
       start_secondary+0x290/0x330
       secondary_startup_64+0xb6/0xc0

-> #1 (&port_lock_key){-.-.}:
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       _raw_spin_lock_irqsave+0x3a/0x50
       serial8250_console_write+0x3e4/0x450
       univ8250_console_write+0x4b/0x60
       console_unlock+0x501/0x750
       vprintk_emit+0x10d/0x340
       vprintk_default+0x1f/0x30
       vprintk_func+0x44/0xd4
       printk+0x9f/0xc5

-> #0 (console_owner){-.-.}:
       check_prev_add+0x107/0xea0
       validate_chain+0x8fc/0x1200
       __lock_acquire+0x5b3/0xb40
       lock_acquire+0x126/0x280
       console_unlock+0x269/0x750
       vprintk_emit+0x10d/0x340
       vprintk_default+0x1f/0x30
       vprintk_func+0x44/0xd4
       printk+0x9f/0xc5
       __offline_isolated_pages.cold.52+0x2f/0x30a
       offline_isolated_pages_cb+0x17/0x30
       walk_system_ram_range+0xda/0x160
       __offline_pages+0x79c/0xa10
       offline_pages+0x11/0x20
       memory_subsys_offline+0x7e/0xc0
       device_offline+0xd5/0x110
       state_store+0xc6/0xe0
       dev_attr_store+0x3f/0x60
       sysfs_kf_write+0x89/0xb0
       kernfs_fop_write+0x188/0x240
       __vfs_write+0x50/0xa0
       vfs_write+0x105/0x290
       ksys_write+0xc6/0x160
       __x64_sys_write+0x43/0x50
       do_syscall_64+0xcc/0x76c
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  console_owner --> &(&port->lock)->rlock --> &(&zone->lock)->rlock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&zone->lock)->rlock);
                               lock(&(&port->lock)->rlock);
                               lock(&(&zone->lock)->rlock);
  lock(console_owner);

 *** DEADLOCK ***

9 locks held by test.sh/8653:
 #0: ffff88839ba7d408 (sb_writers#4){.+.+}, at:
vfs_write+0x25f/0x290
 #1: ffff888277618880 (&of->mutex){+.+.}, at:
kernfs_fop_write+0x128/0x240
 #2: ffff8898131fc218 (kn->count#115){.+.+}, at:
kernfs_fop_write+0x138/0x240
 #3: ffffffff86962a80 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x16/0x50
 #4: ffff8884374f4990 (&dev->mutex){....}, at:
device_offline+0x70/0x110
 #5: ffffffff86515250 (cpu_hotplug_lock.rw_sem){++++}, at:
__offline_pages+0xbf/0xa10
 #6: ffffffff867405f0 (mem_hotplug_lock.rw_sem){++++}, at:
percpu_down_write+0x87/0x2f0
 #7: ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0
 #8: ffffffff865a4920 (console_lock){+.+.}, at:
vprintk_emit+0x100/0x340

stack backtrace:
Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10,
BIOS U34 05/21/2019
Call Trace:
 dump_stack+0x86/0xca
 print_circular_bug.cold.31+0x243/0x26e
 check_noncircular+0x29e/0x2e0
 check_prev_add+0x107/0xea0
 validate_chain+0x8fc/0x1200
 __lock_acquire+0x5b3/0xb40
 lock_acquire+0x126/0x280
 console_unlock+0x269/0x750
 vprintk_emit+0x10d/0x340
 vprintk_default+0x1f/0x30
 vprintk_func+0x44/0xd4
 printk+0x9f/0xc5
 __offline_isolated_pages.cold.52+0x2f/0x30a
 offline_isolated_pages_cb+0x17/0x30
 walk_system_ram_range+0xda/0x160
 __offline_pages+0x79c/0xa10
 offline_pages+0x11/0x20
 memory_subsys_offline+0x7e/0xc0
 device_offline+0xd5/0x110
 state_store+0xc6/0xe0
 dev_attr_store+0x3f/0x60
 sysfs_kf_write+0x89/0xb0
 kernfs_fop_write+0x188/0x240
 __vfs_write+0x50/0xa0
 vfs_write+0x105/0x290
 ksys_write+0xc6/0x160
 __x64_sys_write+0x43/0x50
 do_syscall_64+0xcc/0x76c
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Qian Cai <cai@lca.pw>
---

v5: Update comments and fix minor issues thanks to David.
    Remove unnecessary changes in is_pageblock_removable_nolock().
v4: Update the commit log again thanks to Michal.
v3: Rebase to next-20200115 for the mm/debug change and update some
    comments thanks to Michal.
v2: Improve the commit log and report CMA in dump_page() per Andrew.
    has_unmovable_pages() returns a "struct page *" to the caller.

 include/linux/page-isolation.h |  4 ++--
 mm/debug.c                     | 10 +++++++++-
 mm/page_alloc.c                | 23 ++++++++++-------------
 mm/page_isolation.c            | 11 ++++++++++-
 4 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 148e65a9c606..da043ae86488 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -33,8 +33,8 @@ static inline bool is_migrate_isolate(int migratetype)
 #define MEMORY_OFFLINE	0x1
 #define REPORT_FAILURE	0x2
 
-bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
-			 int flags);
+struct page *has_unmovable_pages(struct zone *zone, struct page *page, int
+				 migratetype, int flags);
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
diff --git a/mm/debug.c b/mm/debug.c
index 6a52316af839..a90da5337c14 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -46,6 +46,13 @@ void __dump_page(struct page *page, const char *reason)
 {
 	struct address_space *mapping;
 	bool page_poisoned = PagePoisoned(page);
+	/*
+	 * Accessing the pageblock without the zone lock. It could change to
+	 * "isolate" again in the meantime, but since we are just dumping the
+	 * state for debugging, it should be fine to accept a bit of
+	 * inaccuracy here due to racing.
+	 */
+	bool page_cma = is_migrate_cma_page(page);
 	int mapcount;
 	char *type = "";
 
@@ -92,7 +99,8 @@ void __dump_page(struct page *page, const char *reason)
 	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
-	pr_warn("%sflags: %#lx(%pGp)\n", type, page->flags, &page->flags);
+	pr_warn("%sflags: %#lx(%pGp)%s\n", type, page->flags, &page->flags,
+		page_cma ? " CMA" : "");
 
 hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e56cd1f33242..621716a25639 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8202,13 +8202,17 @@ void *__init alloc_large_system_hash(const char *tablename,
  * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
  * check without lock_page also may miss some movable non-lru pages at
  * race condition. So you can't expect this function should be exact.
+ *
+ * Returns a page without holding a reference. If the caller wants to
+ * dereference that page (e.g., dumping), it has to make sure that that it
+ * cannot get removed (e.g., via memory unplug) concurrently.
+ *
  */
-bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
-			 int flags)
+struct page *has_unmovable_pages(struct zone *zone, struct page *page,
+				 int migratetype, int flags)
 {
 	unsigned long iter = 0;
 	unsigned long pfn = page_to_pfn(page);
-	const char *reason = "unmovable page";
 
 	/*
 	 * TODO we could make this much more efficient by not checking every
@@ -8225,9 +8229,8 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
 		 * so consider them movable here.
 		 */
 		if (is_migrate_cma(migratetype))
-			return false;
+			return NULL;
 
-		reason = "CMA page";
 		goto unmovable;
 	}
 
@@ -8302,12 +8305,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
 		 */
 		goto unmovable;
 	}
-	return false;
+	return NULL;
 unmovable:
 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-	if (flags & REPORT_FAILURE)
-		dump_page(pfn_to_page(pfn + iter), reason);
-	return true;
+	return pfn_to_page(pfn + iter);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
@@ -8711,10 +8712,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		BUG_ON(!PageBuddy(page));
 		order = page_order(page);
 		offlined_pages += 1 << order;
-#ifdef CONFIG_DEBUG_VM
-		pr_info("remove from free list %lx %d %lx\n",
-			pfn, 1 << order, end_pfn);
-#endif
 		del_page_from_free_area(page, &zone->free_area[order]);
 		pfn += (1 << order);
 	}
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 1f8b9dfecbe8..e70586523ca3 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -17,6 +17,7 @@
 
 static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
 {
+	struct page *unmovable = NULL;
 	struct zone *zone;
 	unsigned long flags;
 	int ret = -EBUSY;
@@ -37,7 +38,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	if (!has_unmovable_pages(zone, page, migratetype, isol_flags)) {
+	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
+	if (!unmovable) {
 		unsigned long nr_pages;
 		int mt = get_pageblock_migratetype(page);
 
@@ -54,6 +56,13 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret)
 		drain_all_pages(zone);
+	else if ((isol_flags & REPORT_FAILURE) && unmovable)
+		/*
+		 * printk() with zone->lock held will guarantee to trigger a
+		 * lockdep splat, so defer it here.
+		 */
+		dump_page(unmovable, "unmovable page");
+
 	return ret;
 }
 
-- 
2.21.0 (Apple Git-122.2)

