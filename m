Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F117C86E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 23:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCFWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 17:37:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54588 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFWhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:37:38 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jALb4-0005Ng-LY; Fri, 06 Mar 2020 23:37:34 +0100
Date:   Fri, 6 Mar 2020 23:37:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.24-rt15
Message-ID: <20200306223734.65nlltijm3cxbejz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.24-rt15 patch set. 

Changes since v5.4.24-rt14:

  - A warning in kmalloc() has been added. On RT with
    CONFIG_DEBUG_ATOMIC_SLEEP enabled it triggers on memory allocations
    in atomic context.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.4.24-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.24-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.24-rt15

The RT patch against v5.4.24 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.24-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.24-rt15.tar.xz

Sebastian

diff --git a/localversion-rt b/localversion-rt
index 08b3e75841adc..18777ec0c27d4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
diff --git a/mm/slub.c b/mm/slub.c
index 2cff48d13e3a7..7b2773c45e1ff 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2742,6 +2742,9 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	struct page *page;
 	unsigned long tid;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
+		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (!s)
 		return NULL;
@@ -3202,6 +3205,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	LIST_HEAD(to_free);
 	int i;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
+		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+
 	/* memcg and kmem_cache debug support */
 	s = slab_pre_alloc_hook(s, flags);
 	if (unlikely(!s))
