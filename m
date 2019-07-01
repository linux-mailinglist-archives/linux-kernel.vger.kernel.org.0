Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE7859A85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfF1MVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:21:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfF1MUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gD5FzOREchq+JJ0oJEh3iM6IvcLiFvL1QH79Y0JPa/4=; b=FeQ/Ry3qie60CXQ+wWJuA4/p7u
        NyjIfMjPjDoCIllhX9U+k85iXDZI/HsI8b0UJWVjT0POfStFoPMs+WwqBA5MIs7MTrhEVZdJC+LKV
        iHchdC47DrUlx/wRo5QPJ/aaNVtyfeCiK4yfPpT300NTNr3tIBInF1vxHf6bJqOU8WaLUhdVHaoRW
        aME1kG7c239mQOjyIJbU3RGWTOoap0t4K/pVGX0raApQq8Y93jHUw38U5vdQqfduHIiJ+NnFg1XGR
        1mK+K6jnSWM98tFP5vYIbI6NigETEggotIhJ7K90mbn5Ap5/MxpEVBLNqlDtzMKvnTz4/XO1Mf+6D
        kmQ/VcAg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-00009r-1I; Fri, 28 Jun 2019 12:20:44 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-000577-3j; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/43] docs: locking: convert docs to ReST and rename to *.rst
Date:   Fri, 28 Jun 2019 09:20:00 -0300
Message-Id: <0a4ec1e39a9e2cec38ffb7d24b3b911e9f11f47a.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the locking documents to ReST and add them to the
kernel development book where it belongs.

Most of the stuff here is just to make Sphinx to properly
parse the text file, as they're already in good shape,
not requiring massive changes in order to be parsed.

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/kernel-hacking/locking.rst      |   2 +-
 Documentation/locking/index.rst               |  24 +++
 ...{lockdep-design.txt => lockdep-design.rst} |  51 +++--
 Documentation/locking/lockstat.rst            | 204 ++++++++++++++++++
 Documentation/locking/lockstat.txt            | 183 ----------------
 .../{locktorture.txt => locktorture.rst}      | 105 +++++----
 .../{mutex-design.txt => mutex-design.rst}    |  26 ++-
 ...t-mutex-design.txt => rt-mutex-design.rst} | 139 ++++++------
 .../locking/{rt-mutex.txt => rt-mutex.rst}    |  30 +--
 .../locking/{spinlocks.txt => spinlocks.rst}  |  32 ++-
 ...w-mutex-design.txt => ww-mutex-design.rst} |  82 +++----
 Documentation/pi-futex.txt                    |   2 +-
 .../it_IT/kernel-hacking/locking.rst          |   2 +-
 drivers/gpu/drm/drm_modeset_lock.c            |   2 +-
 include/linux/lockdep.h                       |   2 +-
 include/linux/mutex.h                         |   2 +-
 include/linux/rwsem.h                         |   2 +-
 kernel/locking/mutex.c                        |   2 +-
 kernel/locking/rtmutex.c                      |   2 +-
 lib/Kconfig.debug                             |   4 +-
 20 files changed, 511 insertions(+), 387 deletions(-)
 create mode 100644 Documentation/locking/index.rst
 rename Documentation/locking/{lockdep-design.txt => lockdep-design.rst} (93%)
 create mode 100644 Documentation/locking/lockstat.rst
 delete mode 100644 Documentation/locking/lockstat.txt
 rename Documentation/locking/{locktorture.txt => locktorture.rst} (57%)
 rename Documentation/locking/{mutex-design.txt => mutex-design.rst} (94%)
 rename Documentation/locking/{rt-mutex-design.txt => rt-mutex-design.rst} (91%)
 rename Documentation/locking/{rt-mutex.txt => rt-mutex.rst} (71%)
 rename Documentation/locking/{spinlocks.txt => spinlocks.rst} (89%)
 rename Documentation/locking/{ww-mutex-design.txt => ww-mutex-design.rst} (93%)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index dc698ea456e0..a8518ac0d31d 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1364,7 +1364,7 @@ Futex API reference
 Further reading
 ===============
 
--  ``Documentation/locking/spinlocks.txt``: Linus Torvalds' spinlocking
+-  ``Documentation/locking/spinlocks.rst``: Linus Torvalds' spinlocking
    tutorial in the kernel sources.
 
 -  Unix Systems for Modern Architectures: Symmetric Multiprocessing and
diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.rst
new file mode 100644
index 000000000000..ef5da7fe9aac
--- /dev/null
+++ b/Documentation/locking/index.rst
@@ -0,0 +1,24 @@
+:orphan:
+
+=======
+locking
+=======
+
+.. toctree::
+    :maxdepth: 1
+
+    lockdep-design
+    lockstat
+    locktorture
+    mutex-design
+    rt-mutex-design
+    rt-mutex
+    spinlocks
+    ww-mutex-design
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.rst
similarity index 93%
rename from Documentation/locking/lockdep-design.txt
rename to Documentation/locking/lockdep-design.rst
index f189d130e543..23fcbc4d3fc0 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.rst
@@ -2,6 +2,7 @@ Runtime locking correctness validator
 =====================================
 
 started by Ingo Molnar <mingo@redhat.com>
+
 additions by Arjan van de Ven <arjan@linux.intel.com>
 
 Lock-class
@@ -56,7 +57,7 @@ where the last 1 category is:
 
 When locking rules are violated, these usage bits are presented in the
 locking error messages, inside curlies, with a total of 2 * n STATEs bits.
-A contrived example:
+A contrived example::
 
    modprobe/2287 is trying to acquire lock:
     (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
@@ -70,12 +71,14 @@ of the lock and readlock (if exists), for each of the n STATEs listed
 above respectively, and the character displayed at each bit position
 indicates:
 
+   ===  ===================================================
    '.'  acquired while irqs disabled and not in irq context
    '-'  acquired in irq context
    '+'  acquired with irqs enabled
    '?'  acquired in irq context with irqs enabled.
+   ===  ===================================================
 
-The bits are illustrated with an example:
+The bits are illustrated with an example::
 
     (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
                          ||||
@@ -90,13 +93,13 @@ context and whether that STATE is enabled yields four possible cases as
 shown in the table below. The bit character is able to indicate which
 exact case is for the lock as of the reporting time.
 
-   -------------------------------------------
+  +--------------+-------------+--------------+
   |              | irq enabled | irq disabled |
-  |-------------------------------------------|
+  +--------------+-------------+--------------+
   | ever in irq  |      ?      |       -      |
-  |-------------------------------------------|
+  +--------------+-------------+--------------+
   | never in irq |      +      |       .      |
-   -------------------------------------------
+  +--------------+-------------+--------------+
 
 The character '-' suggests irq is disabled because if otherwise the
 charactor '?' would have been shown instead. Similar deduction can be
@@ -113,7 +116,7 @@ is irq-unsafe means it was ever acquired with irq enabled.
 
 A softirq-unsafe lock-class is automatically hardirq-unsafe as well. The
 following states must be exclusive: only one of them is allowed to be set
-for any lock-class based on its usage:
+for any lock-class based on its usage::
 
  <hardirq-safe> or <hardirq-unsafe>
  <softirq-safe> or <softirq-unsafe>
@@ -134,7 +137,7 @@ Multi-lock dependency rules:
 The same lock-class must not be acquired twice, because this could lead
 to lock recursion deadlocks.
 
-Furthermore, two locks can not be taken in inverse order:
+Furthermore, two locks can not be taken in inverse order::
 
  <L1> -> <L2>
  <L2> -> <L1>
@@ -148,7 +151,7 @@ operations; the validator will still find whether these locks can be
 acquired in a circular fashion.
 
 Furthermore, the following usage based lock dependencies are not allowed
-between any two lock-classes:
+between any two lock-classes::
 
    <hardirq-safe>   ->  <hardirq-unsafe>
    <softirq-safe>   ->  <softirq-unsafe>
@@ -204,16 +207,16 @@ the ordering is not static.
 In order to teach the validator about this correct usage model, new
 versions of the various locking primitives were added that allow you to
 specify a "nesting level". An example call, for the block device mutex,
-looks like this:
+looks like this::
 
-enum bdev_bd_mutex_lock_class
-{
+  enum bdev_bd_mutex_lock_class
+  {
        BD_MUTEX_NORMAL,
        BD_MUTEX_WHOLE,
        BD_MUTEX_PARTITION
-};
+  };
 
- mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_PARTITION);
+mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_PARTITION);
 
 In this case the locking is done on a bdev object that is known to be a
 partition.
@@ -234,7 +237,7 @@ must be held: lockdep_assert_held*(&lock) and lockdep_*pin_lock(&lock).
 As the name suggests, lockdep_assert_held* family of macros assert that a
 particular lock is held at a certain time (and generate a WARN() otherwise).
 This annotation is largely used all over the kernel, e.g. kernel/sched/
-core.c
+core.c::
 
   void update_rq_clock(struct rq *rq)
   {
@@ -253,7 +256,7 @@ out to be especially helpful to debug code with callbacks, where an upper
 layer assumes a lock remains taken, but a lower layer thinks it can maybe drop
 and reacquire the lock ("unwittingly" introducing races). lockdep_pin_lock()
 returns a 'struct pin_cookie' that is then used by lockdep_unpin_lock() to check
-that nobody tampered with the lock, e.g. kernel/sched/sched.h
+that nobody tampered with the lock, e.g. kernel/sched/sched.h::
 
   static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
   {
@@ -280,7 +283,7 @@ correctness) in the sense that for every simple, standalone single-task
 locking sequence that occurred at least once during the lifetime of the
 kernel, the validator proves it with a 100% certainty that no
 combination and timing of these locking sequences can cause any class of
-lock related deadlock. [*]
+lock related deadlock. [1]_
 
 I.e. complex multi-CPU and multi-task locking scenarios do not have to
 occur in practice to prove a deadlock: only the simple 'component'
@@ -299,7 +302,9 @@ possible combination of locking interaction between CPUs, combined with
 every possible hardirq and softirq nesting scenario (which is impossible
 to do in practice).
 
-[*] assuming that the validator itself is 100% correct, and no other
+.. [1]
+
+    assuming that the validator itself is 100% correct, and no other
     part of the system corrupts the state of the validator in any way.
     We also assume that all NMI/SMM paths [which could interrupt
     even hardirq-disabled codepaths] are correct and do not interfere
@@ -310,7 +315,7 @@ to do in practice).
 Performance:
 ------------
 
-The above rules require _massive_ amounts of runtime checking. If we did
+The above rules require **massive** amounts of runtime checking. If we did
 that for every lock taken and for every irqs-enable event, it would
 render the system practically unusably slow. The complexity of checking
 is O(N^2), so even with just a few hundred lock-classes we'd have to do
@@ -369,17 +374,17 @@ be harder to do than to say.
 
 Of course, if you do run out of lock classes, the next thing to do is
 to find the offending lock classes.  First, the following command gives
-you the number of lock classes currently in use along with the maximum:
+you the number of lock classes currently in use along with the maximum::
 
 	grep "lock-classes" /proc/lockdep_stats
 
-This command produces the following output on a modest system:
+This command produces the following output on a modest system::
 
-	 lock-classes:                          748 [max: 8191]
+	lock-classes:                          748 [max: 8191]
 
 If the number allocated (748 above) increases continually over time,
 then there is likely a leak.  The following command can be used to
-identify the leaking lock classes:
+identify the leaking lock classes::
 
 	grep "BD" /proc/lockdep
 
diff --git a/Documentation/locking/lockstat.rst b/Documentation/locking/lockstat.rst
new file mode 100644
index 000000000000..536eab8dbd99
--- /dev/null
+++ b/Documentation/locking/lockstat.rst
@@ -0,0 +1,204 @@
+===============
+Lock Statistics
+===============
+
+What
+====
+
+As the name suggests, it provides statistics on locks.
+
+
+Why
+===
+
+Because things like lock contention can severely impact performance.
+
+How
+===
+
+Lockdep already has hooks in the lock functions and maps lock instances to
+lock classes. We build on that (see Documentation/locking/lockdep-design.rst).
+The graph below shows the relation between the lock functions and the various
+hooks therein::
+
+        __acquire
+            |
+           lock _____
+            |        \
+            |    __contended
+            |         |
+            |       <wait>
+            | _______/
+            |/
+            |
+       __acquired
+            |
+            .
+          <hold>
+            .
+            |
+       __release
+            |
+         unlock
+
+  lock, unlock	- the regular lock functions
+  __*		- the hooks
+  <> 		- states
+
+With these hooks we provide the following statistics:
+
+ con-bounces
+	- number of lock contention that involved x-cpu data
+ contentions
+	- number of lock acquisitions that had to wait
+ wait time
+     min
+	- shortest (non-0) time we ever had to wait for a lock
+     max
+	- longest time we ever had to wait for a lock
+     total
+	- total time we spend waiting on this lock
+     avg
+	- average time spent waiting on this lock
+ acq-bounces
+	- number of lock acquisitions that involved x-cpu data
+ acquisitions
+	- number of times we took the lock
+ hold time
+     min
+	- shortest (non-0) time we ever held the lock
+     max
+	- longest time we ever held the lock
+     total
+	- total time this lock was held
+     avg
+	- average time this lock was held
+
+These numbers are gathered per lock class, per read/write state (when
+applicable).
+
+It also tracks 4 contention points per class. A contention point is a call site
+that had to wait on lock acquisition.
+
+Configuration
+-------------
+
+Lock statistics are enabled via CONFIG_LOCK_STAT.
+
+Usage
+-----
+
+Enable collection of statistics::
+
+	# echo 1 >/proc/sys/kernel/lock_stat
+
+Disable collection of statistics::
+
+	# echo 0 >/proc/sys/kernel/lock_stat
+
+Look at the current lock statistics::
+
+  ( line numbers not part of actual output, done for clarity in the explanation
+    below )
+
+  # less /proc/lock_stat
+
+  01 lock_stat version 0.4
+  02-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
+  03                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
+  04-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
+  05
+  06                         &mm->mmap_sem-W:            46             84           0.26         939.10       16371.53         194.90          47291        2922365           0.16     2220301.69 17464026916.32        5975.99
+  07                         &mm->mmap_sem-R:            37            100           1.31      299502.61      325629.52        3256.30         212344       34316685           0.10        7744.91    95016910.20           2.77
+  08                         ---------------
+  09                           &mm->mmap_sem              1          [<ffffffff811502a7>] khugepaged_scan_mm_slot+0x57/0x280
+  10                           &mm->mmap_sem             96          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
+  11                           &mm->mmap_sem             34          [<ffffffff81113d77>] vm_mmap_pgoff+0x87/0xd0
+  12                           &mm->mmap_sem             17          [<ffffffff81127e71>] vm_munmap+0x41/0x80
+  13                         ---------------
+  14                           &mm->mmap_sem              1          [<ffffffff81046fda>] dup_mmap+0x2a/0x3f0
+  15                           &mm->mmap_sem             60          [<ffffffff81129e29>] SyS_mprotect+0xe9/0x250
+  16                           &mm->mmap_sem             41          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
+  17                           &mm->mmap_sem             68          [<ffffffff81113d77>] vm_mmap_pgoff+0x87/0xd0
+  18
+  19.............................................................................................................................................................................................................................
+  20
+  21                         unix_table_lock:           110            112           0.21          49.24         163.91           1.46          21094          66312           0.12         624.42       31589.81           0.48
+  22                         ---------------
+  23                         unix_table_lock             45          [<ffffffff8150ad8e>] unix_create1+0x16e/0x1b0
+  24                         unix_table_lock             47          [<ffffffff8150b111>] unix_release_sock+0x31/0x250
+  25                         unix_table_lock             15          [<ffffffff8150ca37>] unix_find_other+0x117/0x230
+  26                         unix_table_lock              5          [<ffffffff8150a09f>] unix_autobind+0x11f/0x1b0
+  27                         ---------------
+  28                         unix_table_lock             39          [<ffffffff8150b111>] unix_release_sock+0x31/0x250
+  29                         unix_table_lock             49          [<ffffffff8150ad8e>] unix_create1+0x16e/0x1b0
+  30                         unix_table_lock             20          [<ffffffff8150ca37>] unix_find_other+0x117/0x230
+  31                         unix_table_lock              4          [<ffffffff8150a09f>] unix_autobind+0x11f/0x1b0
+
+
+This excerpt shows the first two lock class statistics. Line 01 shows the
+output version - each time the format changes this will be updated. Line 02-04
+show the header with column descriptions. Lines 05-18 and 20-31 show the actual
+statistics. These statistics come in two parts; the actual stats separated by a
+short separator (line 08, 13) from the contention points.
+
+Lines 09-12 show the first 4 recorded contention points (the code
+which tries to get the lock) and lines 14-17 show the first 4 recorded
+contended points (the lock holder). It is possible that the max
+con-bounces point is missing in the statistics.
+
+The first lock (05-18) is a read/write lock, and shows two lines above the
+short separator. The contention points don't match the column descriptors,
+they have two: contentions and [<IP>] symbol. The second set of contention
+points are the points we're contending with.
+
+The integer part of the time values is in us.
+
+Dealing with nested locks, subclasses may appear::
+
+  32...........................................................................................................................................................................................................................
+  33
+  34                               &rq->lock:       13128          13128           0.43         190.53      103881.26           7.91          97454        3453404           0.00         401.11    13224683.11           3.82
+  35                               ---------
+  36                               &rq->lock          645          [<ffffffff8103bfc4>] task_rq_lock+0x43/0x75
+  37                               &rq->lock          297          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
+  38                               &rq->lock          360          [<ffffffff8103c4c5>] select_task_rq_fair+0x1f0/0x74a
+  39                               &rq->lock          428          [<ffffffff81045f98>] scheduler_tick+0x46/0x1fb
+  40                               ---------
+  41                               &rq->lock           77          [<ffffffff8103bfc4>] task_rq_lock+0x43/0x75
+  42                               &rq->lock          174          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
+  43                               &rq->lock         4715          [<ffffffff8103ed4b>] double_rq_lock+0x42/0x54
+  44                               &rq->lock          893          [<ffffffff81340524>] schedule+0x157/0x7b8
+  45
+  46...........................................................................................................................................................................................................................
+  47
+  48                             &rq->lock/1:        1526          11488           0.33         388.73      136294.31          11.86          21461          38404           0.00          37.93      109388.53           2.84
+  49                             -----------
+  50                             &rq->lock/1        11526          [<ffffffff8103ed58>] double_rq_lock+0x4f/0x54
+  51                             -----------
+  52                             &rq->lock/1         5645          [<ffffffff8103ed4b>] double_rq_lock+0x42/0x54
+  53                             &rq->lock/1         1224          [<ffffffff81340524>] schedule+0x157/0x7b8
+  54                             &rq->lock/1         4336          [<ffffffff8103ed58>] double_rq_lock+0x4f/0x54
+  55                             &rq->lock/1          181          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
+
+Line 48 shows statistics for the second subclass (/1) of &rq->lock class
+(subclass starts from 0), since in this case, as line 50 suggests,
+double_rq_lock actually acquires a nested lock of two spinlocks.
+
+View the top contending locks::
+
+  # grep : /proc/lock_stat | head
+			clockevents_lock:       2926159        2947636           0.15       46882.81  1784540466.34         605.41        3381345        3879161           0.00        2260.97    53178395.68          13.71
+		     tick_broadcast_lock:        346460         346717           0.18        2257.43    39364622.71         113.54        3642919        4242696           0.00        2263.79    49173646.60          11.59
+		  &mapping->i_mmap_mutex:        203896         203899           3.36      645530.05 31767507988.39      155800.21        3361776        8893984           0.17        2254.15    14110121.02           1.59
+			       &rq->lock:        135014         136909           0.18         606.09      842160.68           6.15        1540728       10436146           0.00         728.72    17606683.41           1.69
+	       &(&zone->lru_lock)->rlock:         93000          94934           0.16          59.18      188253.78           1.98        1199912        3809894           0.15         391.40     3559518.81           0.93
+			 tasklist_lock-W:         40667          41130           0.23        1189.42      428980.51          10.43         270278         510106           0.16         653.51     3939674.91           7.72
+			 tasklist_lock-R:         21298          21305           0.20        1310.05      215511.12          10.12         186204         241258           0.14        1162.33     1179779.23           4.89
+			      rcu_node_1:         47656          49022           0.16         635.41      193616.41           3.95         844888        1865423           0.00         764.26     1656226.96           0.89
+       &(&dentry->d_lockref.lock)->rlock:         39791          40179           0.15        1302.08       88851.96           2.21        2790851       12527025           0.10        1910.75     3379714.27           0.27
+			      rcu_node_0:         29203          30064           0.16         786.55     1555573.00          51.74          88963         244254           0.00         398.87      428872.51           1.76
+
+Clear the statistics::
+
+  # echo 0 > /proc/lock_stat
diff --git a/Documentation/locking/lockstat.txt b/Documentation/locking/lockstat.txt
deleted file mode 100644
index fdbeb0c45ef3..000000000000
--- a/Documentation/locking/lockstat.txt
+++ /dev/null
@@ -1,183 +0,0 @@
-
-LOCK STATISTICS
-
-- WHAT
-
-As the name suggests, it provides statistics on locks.
-
-- WHY
-
-Because things like lock contention can severely impact performance.
-
-- HOW
-
-Lockdep already has hooks in the lock functions and maps lock instances to
-lock classes. We build on that (see Documentation/locking/lockdep-design.txt).
-The graph below shows the relation between the lock functions and the various
-hooks therein.
-
-        __acquire
-            |
-           lock _____
-            |        \
-            |    __contended
-            |         |
-            |       <wait>
-            | _______/
-            |/
-            |
-       __acquired
-            |
-            .
-          <hold>
-            .
-            |
-       __release
-            |
-         unlock
-
-lock, unlock	- the regular lock functions
-__*		- the hooks
-<> 		- states
-
-With these hooks we provide the following statistics:
-
- con-bounces       - number of lock contention that involved x-cpu data
- contentions       - number of lock acquisitions that had to wait
- wait time min     - shortest (non-0) time we ever had to wait for a lock
-           max     - longest time we ever had to wait for a lock
-	   total   - total time we spend waiting on this lock
-	   avg     - average time spent waiting on this lock
- acq-bounces       - number of lock acquisitions that involved x-cpu data
- acquisitions      - number of times we took the lock
- hold time min     - shortest (non-0) time we ever held the lock
-	   max     - longest time we ever held the lock
-	   total   - total time this lock was held
-	   avg     - average time this lock was held
-
-These numbers are gathered per lock class, per read/write state (when
-applicable).
-
-It also tracks 4 contention points per class. A contention point is a call site
-that had to wait on lock acquisition.
-
- - CONFIGURATION
-
-Lock statistics are enabled via CONFIG_LOCK_STAT.
-
- - USAGE
-
-Enable collection of statistics:
-
-# echo 1 >/proc/sys/kernel/lock_stat
-
-Disable collection of statistics:
-
-# echo 0 >/proc/sys/kernel/lock_stat
-
-Look at the current lock statistics:
-
-( line numbers not part of actual output, done for clarity in the explanation
-  below )
-
-# less /proc/lock_stat
-
-01 lock_stat version 0.4
-02-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-03                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-04-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-05
-06                         &mm->mmap_sem-W:            46             84           0.26         939.10       16371.53         194.90          47291        2922365           0.16     2220301.69 17464026916.32        5975.99
-07                         &mm->mmap_sem-R:            37            100           1.31      299502.61      325629.52        3256.30         212344       34316685           0.10        7744.91    95016910.20           2.77
-08                         ---------------
-09                           &mm->mmap_sem              1          [<ffffffff811502a7>] khugepaged_scan_mm_slot+0x57/0x280
-10                           &mm->mmap_sem             96          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
-11                           &mm->mmap_sem             34          [<ffffffff81113d77>] vm_mmap_pgoff+0x87/0xd0
-12                           &mm->mmap_sem             17          [<ffffffff81127e71>] vm_munmap+0x41/0x80
-13                         ---------------
-14                           &mm->mmap_sem              1          [<ffffffff81046fda>] dup_mmap+0x2a/0x3f0
-15                           &mm->mmap_sem             60          [<ffffffff81129e29>] SyS_mprotect+0xe9/0x250
-16                           &mm->mmap_sem             41          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
-17                           &mm->mmap_sem             68          [<ffffffff81113d77>] vm_mmap_pgoff+0x87/0xd0
-18
-19.............................................................................................................................................................................................................................
-20
-21                         unix_table_lock:           110            112           0.21          49.24         163.91           1.46          21094          66312           0.12         624.42       31589.81           0.48
-22                         ---------------
-23                         unix_table_lock             45          [<ffffffff8150ad8e>] unix_create1+0x16e/0x1b0
-24                         unix_table_lock             47          [<ffffffff8150b111>] unix_release_sock+0x31/0x250
-25                         unix_table_lock             15          [<ffffffff8150ca37>] unix_find_other+0x117/0x230
-26                         unix_table_lock              5          [<ffffffff8150a09f>] unix_autobind+0x11f/0x1b0
-27                         ---------------
-28                         unix_table_lock             39          [<ffffffff8150b111>] unix_release_sock+0x31/0x250
-29                         unix_table_lock             49          [<ffffffff8150ad8e>] unix_create1+0x16e/0x1b0
-30                         unix_table_lock             20          [<ffffffff8150ca37>] unix_find_other+0x117/0x230
-31                         unix_table_lock              4          [<ffffffff8150a09f>] unix_autobind+0x11f/0x1b0
-
-
-This excerpt shows the first two lock class statistics. Line 01 shows the
-output version - each time the format changes this will be updated. Line 02-04
-show the header with column descriptions. Lines 05-18 and 20-31 show the actual
-statistics. These statistics come in two parts; the actual stats separated by a
-short separator (line 08, 13) from the contention points.
-
-Lines 09-12 show the first 4 recorded contention points (the code
-which tries to get the lock) and lines 14-17 show the first 4 recorded
-contended points (the lock holder). It is possible that the max
-con-bounces point is missing in the statistics.
-
-The first lock (05-18) is a read/write lock, and shows two lines above the
-short separator. The contention points don't match the column descriptors,
-they have two: contentions and [<IP>] symbol. The second set of contention
-points are the points we're contending with.
-
-The integer part of the time values is in us.
-
-Dealing with nested locks, subclasses may appear:
-
-32...........................................................................................................................................................................................................................
-33
-34                               &rq->lock:       13128          13128           0.43         190.53      103881.26           7.91          97454        3453404           0.00         401.11    13224683.11           3.82
-35                               ---------
-36                               &rq->lock          645          [<ffffffff8103bfc4>] task_rq_lock+0x43/0x75
-37                               &rq->lock          297          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
-38                               &rq->lock          360          [<ffffffff8103c4c5>] select_task_rq_fair+0x1f0/0x74a
-39                               &rq->lock          428          [<ffffffff81045f98>] scheduler_tick+0x46/0x1fb
-40                               ---------
-41                               &rq->lock           77          [<ffffffff8103bfc4>] task_rq_lock+0x43/0x75
-42                               &rq->lock          174          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
-43                               &rq->lock         4715          [<ffffffff8103ed4b>] double_rq_lock+0x42/0x54
-44                               &rq->lock          893          [<ffffffff81340524>] schedule+0x157/0x7b8
-45
-46...........................................................................................................................................................................................................................
-47
-48                             &rq->lock/1:        1526          11488           0.33         388.73      136294.31          11.86          21461          38404           0.00          37.93      109388.53           2.84
-49                             -----------
-50                             &rq->lock/1        11526          [<ffffffff8103ed58>] double_rq_lock+0x4f/0x54
-51                             -----------
-52                             &rq->lock/1         5645          [<ffffffff8103ed4b>] double_rq_lock+0x42/0x54
-53                             &rq->lock/1         1224          [<ffffffff81340524>] schedule+0x157/0x7b8
-54                             &rq->lock/1         4336          [<ffffffff8103ed58>] double_rq_lock+0x4f/0x54
-55                             &rq->lock/1          181          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
-
-Line 48 shows statistics for the second subclass (/1) of &rq->lock class
-(subclass starts from 0), since in this case, as line 50 suggests,
-double_rq_lock actually acquires a nested lock of two spinlocks.
-
-View the top contending locks:
-
-# grep : /proc/lock_stat | head
-			clockevents_lock:       2926159        2947636           0.15       46882.81  1784540466.34         605.41        3381345        3879161           0.00        2260.97    53178395.68          13.71
-		     tick_broadcast_lock:        346460         346717           0.18        2257.43    39364622.71         113.54        3642919        4242696           0.00        2263.79    49173646.60          11.59
-		  &mapping->i_mmap_mutex:        203896         203899           3.36      645530.05 31767507988.39      155800.21        3361776        8893984           0.17        2254.15    14110121.02           1.59
-			       &rq->lock:        135014         136909           0.18         606.09      842160.68           6.15        1540728       10436146           0.00         728.72    17606683.41           1.69
-	       &(&zone->lru_lock)->rlock:         93000          94934           0.16          59.18      188253.78           1.98        1199912        3809894           0.15         391.40     3559518.81           0.93
-			 tasklist_lock-W:         40667          41130           0.23        1189.42      428980.51          10.43         270278         510106           0.16         653.51     3939674.91           7.72
-			 tasklist_lock-R:         21298          21305           0.20        1310.05      215511.12          10.12         186204         241258           0.14        1162.33     1179779.23           4.89
-			      rcu_node_1:         47656          49022           0.16         635.41      193616.41           3.95         844888        1865423           0.00         764.26     1656226.96           0.89
-       &(&dentry->d_lockref.lock)->rlock:         39791          40179           0.15        1302.08       88851.96           2.21        2790851       12527025           0.10        1910.75     3379714.27           0.27
-			      rcu_node_0:         29203          30064           0.16         786.55     1555573.00          51.74          88963         244254           0.00         398.87      428872.51           1.76
-
-Clear the statistics:
-
-# echo 0 > /proc/lock_stat
diff --git a/Documentation/locking/locktorture.txt b/Documentation/locking/locktorture.rst
similarity index 57%
rename from Documentation/locking/locktorture.txt
rename to Documentation/locking/locktorture.rst
index 6a8df4cd19bf..e79eeeca3ac6 100644
--- a/Documentation/locking/locktorture.txt
+++ b/Documentation/locking/locktorture.rst
@@ -1,6 +1,9 @@
+==================================
 Kernel Lock Torture Test Operation
+==================================
 
 CONFIG_LOCK_TORTURE_TEST
+========================
 
 The CONFIG LOCK_TORTURE_TEST config option provides a kernel module
 that runs torture tests on core kernel locking primitives. The kernel
@@ -18,61 +21,77 @@ can be simulated by either enlarging this critical region hold time and/or
 creating more kthreads.
 
 
-MODULE PARAMETERS
+Module Parameters
+=================
 
 This module has the following parameters:
 
 
-	    ** Locktorture-specific **
+Locktorture-specific
+--------------------
 
-nwriters_stress   Number of kernel threads that will stress exclusive lock
+nwriters_stress
+		  Number of kernel threads that will stress exclusive lock
 		  ownership (writers). The default value is twice the number
 		  of online CPUs.
 
-nreaders_stress   Number of kernel threads that will stress shared lock
+nreaders_stress
+		  Number of kernel threads that will stress shared lock
 		  ownership (readers). The default is the same amount of writer
 		  locks. If the user did not specify nwriters_stress, then
 		  both readers and writers be the amount of online CPUs.
 
-torture_type	  Type of lock to torture. By default, only spinlocks will
+torture_type
+		  Type of lock to torture. By default, only spinlocks will
 		  be tortured. This module can torture the following locks,
 		  with string values as follows:
 
-		     o "lock_busted": Simulates a buggy lock implementation.
+		     - "lock_busted":
+				Simulates a buggy lock implementation.
 
-		     o "spin_lock": spin_lock() and spin_unlock() pairs.
+		     - "spin_lock":
+				spin_lock() and spin_unlock() pairs.
 
-		     o "spin_lock_irq": spin_lock_irq() and spin_unlock_irq()
-					pairs.
+		     - "spin_lock_irq":
+				spin_lock_irq() and spin_unlock_irq() pairs.
 
-		     o "rw_lock": read/write lock() and unlock() rwlock pairs.
+		     - "rw_lock":
+				read/write lock() and unlock() rwlock pairs.
 
-		     o "rw_lock_irq": read/write lock_irq() and unlock_irq()
-				      rwlock pairs.
+		     - "rw_lock_irq":
+				read/write lock_irq() and unlock_irq()
+				rwlock pairs.
 
-		     o "mutex_lock": mutex_lock() and mutex_unlock() pairs.
+		     - "mutex_lock":
+				mutex_lock() and mutex_unlock() pairs.
 
-		     o "rtmutex_lock": rtmutex_lock() and rtmutex_unlock()
-				       pairs. Kernel must have CONFIG_RT_MUTEX=y.
+		     - "rtmutex_lock":
+				rtmutex_lock() and rtmutex_unlock() pairs.
+				Kernel must have CONFIG_RT_MUTEX=y.
 
-		     o "rwsem_lock": read/write down() and up() semaphore pairs.
+		     - "rwsem_lock":
+				read/write down() and up() semaphore pairs.
 
 
-	    ** Torture-framework (RCU + locking) **
+Torture-framework (RCU + locking)
+---------------------------------
 
-shutdown_secs	  The number of seconds to run the test before terminating
+shutdown_secs
+		  The number of seconds to run the test before terminating
 		  the test and powering off the system.  The default is
 		  zero, which disables test termination and system shutdown.
 		  This capability is useful for automated testing.
 
-onoff_interval	  The number of seconds between each attempt to execute a
+onoff_interval
+		  The number of seconds between each attempt to execute a
 		  randomly selected CPU-hotplug operation.  Defaults
 		  to zero, which disables CPU hotplugging.  In
 		  CONFIG_HOTPLUG_CPU=n kernels, locktorture will silently
 		  refuse to do any CPU-hotplug operations regardless of
 		  what value is specified for onoff_interval.
 
-onoff_holdoff	  The number of seconds to wait until starting CPU-hotplug
+onoff_holdoff
+		  The number of seconds to wait until starting CPU-hotplug
 		  operations.  This would normally only be used when
 		  locktorture was built into the kernel and started
 		  automatically at boot time, in which case it is useful
@@ -80,53 +99,59 @@ onoff_holdoff	  The number of seconds to wait until starting CPU-hotplug
 		  coming and going. This parameter is only useful if
 		  CONFIG_HOTPLUG_CPU is enabled.
 
-stat_interval	  Number of seconds between statistics-related printk()s.
+stat_interval
+		  Number of seconds between statistics-related printk()s.
 		  By default, locktorture will report stats every 60 seconds.
 		  Setting the interval to zero causes the statistics to
 		  be printed -only- when the module is unloaded, and this
 		  is the default.
 
-stutter		  The length of time to run the test before pausing for this
+stutter
+		  The length of time to run the test before pausing for this
 		  same period of time.  Defaults to "stutter=5", so as
 		  to run and pause for (roughly) five-second intervals.
 		  Specifying "stutter=0" causes the test to run continuously
 		  without pausing, which is the old default behavior.
 
-shuffle_interval  The number of seconds to keep the test threads affinitied
+shuffle_interval
+		  The number of seconds to keep the test threads affinitied
 		  to a particular subset of the CPUs, defaults to 3 seconds.
 		  Used in conjunction with test_no_idle_hz.
 
-verbose		  Enable verbose debugging printing, via printk(). Enabled
+verbose
+		  Enable verbose debugging printing, via printk(). Enabled
 		  by default. This extra information is mostly related to
 		  high-level errors and reports from the main 'torture'
 		  framework.
 
 
-STATISTICS
+Statistics
+==========
 
-Statistics are printed in the following format:
+Statistics are printed in the following format::
 
-spin_lock-torture: Writes:  Total: 93746064  Max/Min: 0/0   Fail: 0
-   (A)		    (B)		   (C)		  (D)	       (E)
+  spin_lock-torture: Writes:  Total: 93746064  Max/Min: 0/0   Fail: 0
+     (A)		    (B)		   (C)		  (D)	       (E)
 
-(A): Lock type that is being tortured -- torture_type parameter.
+  (A): Lock type that is being tortured -- torture_type parameter.
 
-(B): Number of writer lock acquisitions. If dealing with a read/write primitive
-     a second "Reads" statistics line is printed.
+  (B): Number of writer lock acquisitions. If dealing with a read/write
+       primitive a second "Reads" statistics line is printed.
 
-(C): Number of times the lock was acquired.
+  (C): Number of times the lock was acquired.
 
-(D): Min and max number of times threads failed to acquire the lock.
+  (D): Min and max number of times threads failed to acquire the lock.
 
-(E): true/false values if there were errors acquiring the lock. This should
-     -only- be positive if there is a bug in the locking primitive's
-     implementation. Otherwise a lock should never fail (i.e., spin_lock()).
-     Of course, the same applies for (C), above. A dummy example of this is
-     the "lock_busted" type.
+  (E): true/false values if there were errors acquiring the lock. This should
+       -only- be positive if there is a bug in the locking primitive's
+       implementation. Otherwise a lock should never fail (i.e., spin_lock()).
+       Of course, the same applies for (C), above. A dummy example of this is
+       the "lock_busted" type.
 
-USAGE
+Usage
+=====
 
-The following script may be used to torture locks:
+The following script may be used to torture locks::
 
 	#!/bin/sh
 
diff --git a/Documentation/locking/mutex-design.txt b/Documentation/locking/mutex-design.rst
similarity index 94%
rename from Documentation/locking/mutex-design.txt
rename to Documentation/locking/mutex-design.rst
index 818aca19612f..4d8236b81fa5 100644
--- a/Documentation/locking/mutex-design.txt
+++ b/Documentation/locking/mutex-design.rst
@@ -1,6 +1,9 @@
+=======================
 Generic Mutex Subsystem
+=======================
 
 started by Ingo Molnar <mingo@redhat.com>
+
 updated by Davidlohr Bueso <davidlohr@hp.com>
 
 What are mutexes?
@@ -23,7 +26,7 @@ Implementation
 Mutexes are represented by 'struct mutex', defined in include/linux/mutex.h
 and implemented in kernel/locking/mutex.c. These locks use an atomic variable
 (->owner) to keep track of the lock state during its lifetime.  Field owner
-actually contains 'struct task_struct *' to the current lock owner and it is
+actually contains `struct task_struct *` to the current lock owner and it is
 therefore NULL if not currently owned. Since task_struct pointers are aligned
 at at least L1_CACHE_BYTES, low bits (3) are used to store extra state (e.g.,
 if waiter list is non-empty).  In its most basic form it also includes a
@@ -101,29 +104,36 @@ features that make lock debugging easier and faster:
 
 Interfaces
 ----------
-Statically define the mutex:
+Statically define the mutex::
+
    DEFINE_MUTEX(name);
 
-Dynamically initialize the mutex:
+Dynamically initialize the mutex::
+
    mutex_init(mutex);
 
-Acquire the mutex, uninterruptible:
+Acquire the mutex, uninterruptible::
+
    void mutex_lock(struct mutex *lock);
    void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
    int  mutex_trylock(struct mutex *lock);
 
-Acquire the mutex, interruptible:
+Acquire the mutex, interruptible::
+
    int mutex_lock_interruptible_nested(struct mutex *lock,
 				       unsigned int subclass);
    int mutex_lock_interruptible(struct mutex *lock);
 
-Acquire the mutex, interruptible, if dec to 0:
+Acquire the mutex, interruptible, if dec to 0::
+
    int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
-Unlock the mutex:
+Unlock the mutex::
+
    void mutex_unlock(struct mutex *lock);
 
-Test if the mutex is taken:
+Test if the mutex is taken::
+
    int mutex_is_locked(struct mutex *lock);
 
 Disadvantages
diff --git a/Documentation/locking/rt-mutex-design.txt b/Documentation/locking/rt-mutex-design.rst
similarity index 91%
rename from Documentation/locking/rt-mutex-design.txt
rename to Documentation/locking/rt-mutex-design.rst
index 3d7b865539cc..59c2a64efb21 100644
--- a/Documentation/locking/rt-mutex-design.txt
+++ b/Documentation/locking/rt-mutex-design.rst
@@ -1,14 +1,15 @@
-#
-# Copyright (c) 2006 Steven Rostedt
-# Licensed under the GNU Free Documentation License, Version 1.2
-#
-
+==============================
 RT-mutex implementation design
-------------------------------
+==============================
+
+Copyright (c) 2006 Steven Rostedt
+
+Licensed under the GNU Free Documentation License, Version 1.2
+
 
 This document tries to describe the design of the rtmutex.c implementation.
 It doesn't describe the reasons why rtmutex.c exists. For that please see
-Documentation/locking/rt-mutex.txt.  Although this document does explain problems
+Documentation/locking/rt-mutex.rst.  Although this document does explain problems
 that happen without this code, but that is in the concept to understand
 what the code actually is doing.
 
@@ -41,17 +42,17 @@ to release the lock, because for all we know, B is a CPU hog and will
 never give C a chance to release the lock.  This is called unbounded priority
 inversion.
 
-Here's a little ASCII art to show the problem.
+Here's a little ASCII art to show the problem::
 
-   grab lock L1 (owned by C)
-     |
-A ---+
-        C preempted by B
-          |
-C    +----+
+     grab lock L1 (owned by C)
+       |
+  A ---+
+          C preempted by B
+            |
+  C    +----+
 
-B         +-------->
-                B now keeps A from running.
+  B         +-------->
+                  B now keeps A from running.
 
 
 Priority Inheritance (PI)
@@ -75,24 +76,29 @@ Terminology
 Here I explain some terminology that is used in this document to help describe
 the design that is used to implement PI.
 
-PI chain - The PI chain is an ordered series of locks and processes that cause
+PI chain
+         - The PI chain is an ordered series of locks and processes that cause
            processes to inherit priorities from a previous process that is
            blocked on one of its locks.  This is described in more detail
            later in this document.
 
-mutex    - In this document, to differentiate from locks that implement
+mutex
+         - In this document, to differentiate from locks that implement
            PI and spin locks that are used in the PI code, from now on
            the PI locks will be called a mutex.
 
-lock     - In this document from now on, I will use the term lock when
+lock
+         - In this document from now on, I will use the term lock when
            referring to spin locks that are used to protect parts of the PI
            algorithm.  These locks disable preemption for UP (when
            CONFIG_PREEMPT is enabled) and on SMP prevents multiple CPUs from
            entering critical sections simultaneously.
 
-spin lock - Same as lock above.
+spin lock
+         - Same as lock above.
 
-waiter   - A waiter is a struct that is stored on the stack of a blocked
+waiter
+         - A waiter is a struct that is stored on the stack of a blocked
            process.  Since the scope of the waiter is within the code for
            a process being blocked on the mutex, it is fine to allocate
            the waiter on the process's stack (local variable).  This
@@ -104,14 +110,18 @@ waiter   - A waiter is a struct that is stored on the stack of a blocked
            waiter is sometimes used in reference to the task that is waiting
            on a mutex. This is the same as waiter->task.
 
-waiters  - A list of processes that are blocked on a mutex.
+waiters
+         - A list of processes that are blocked on a mutex.
 
-top waiter - The highest priority process waiting on a specific mutex.
+top waiter
+         - The highest priority process waiting on a specific mutex.
 
-top pi waiter - The highest priority process waiting on one of the mutexes
+top pi waiter
+              - The highest priority process waiting on one of the mutexes
                 that a specific process owns.
 
-Note:  task and process are used interchangeably in this document, mostly to
+Note:
+       task and process are used interchangeably in this document, mostly to
        differentiate between two processes that are being described together.
 
 
@@ -123,7 +133,7 @@ inheritance to take place.  Multiple chains may converge, but a chain
 would never diverge, since a process can't be blocked on more than one
 mutex at a time.
 
-Example:
+Example::
 
    Process:  A, B, C, D, E
    Mutexes:  L1, L2, L3, L4
@@ -137,21 +147,21 @@ Example:
                          D owns L4
                                 E blocked on L4
 
-The chain would be:
+The chain would be::
 
    E->L4->D->L3->C->L2->B->L1->A
 
 To show where two chains merge, we could add another process F and
 another mutex L5 where B owns L5 and F is blocked on mutex L5.
 
-The chain for F would be:
+The chain for F would be::
 
    F->L5->B->L1->A
 
 Since a process may own more than one mutex, but never be blocked on more than
 one, the chains merge.
 
-Here we show both chains:
+Here we show both chains::
 
    E->L4->D->L3->C->L2-+
                        |
@@ -165,12 +175,12 @@ than the processes to the left or below in the chain.
 
 Also since a mutex may have more than one process blocked on it, we can
 have multiple chains merge at mutexes.  If we add another process G that is
-blocked on mutex L2:
+blocked on mutex L2::
 
   G->L2->B->L1->A
 
 And once again, to show how this can grow I will show the merging chains
-again.
+again::
 
    E->L4->D->L3->C-+
                    +->L2-+
@@ -184,7 +194,7 @@ the chain (A and B in this example), must have their priorities increased
 to that of G.
 
 Mutex Waiters Tree
------------------
+------------------
 
 Every mutex keeps track of all the waiters that are blocked on itself. The
 mutex has a rbtree to store these waiters by priority.  This tree is protected
@@ -219,19 +229,19 @@ defined.  But is very complex to figure it out, since it depends on all
 the nesting of mutexes.  Let's look at the example where we have 3 mutexes,
 L1, L2, and L3, and four separate functions func1, func2, func3 and func4.
 The following shows a locking order of L1->L2->L3, but may not actually
-be directly nested that way.
+be directly nested that way::
 
-void func1(void)
-{
+  void func1(void)
+  {
 	mutex_lock(L1);
 
 	/* do anything */
 
 	mutex_unlock(L1);
-}
+  }
 
-void func2(void)
-{
+  void func2(void)
+  {
 	mutex_lock(L1);
 	mutex_lock(L2);
 
@@ -239,10 +249,10 @@ void func2(void)
 
 	mutex_unlock(L2);
 	mutex_unlock(L1);
-}
+  }
 
-void func3(void)
-{
+  void func3(void)
+  {
 	mutex_lock(L2);
 	mutex_lock(L3);
 
@@ -250,30 +260,30 @@ void func3(void)
 
 	mutex_unlock(L3);
 	mutex_unlock(L2);
-}
+  }
 
-void func4(void)
-{
+  void func4(void)
+  {
 	mutex_lock(L3);
 
 	/* do something again */
 
 	mutex_unlock(L3);
-}
+  }
 
 Now we add 4 processes that run each of these functions separately.
 Processes A, B, C, and D which run functions func1, func2, func3 and func4
 respectively, and such that D runs first and A last.  With D being preempted
-in func4 in the "do something again" area, we have a locking that follows:
+in func4 in the "do something again" area, we have a locking that follows::
 
-D owns L3
-       C blocked on L3
-       C owns L2
-              B blocked on L2
-              B owns L1
-                     A blocked on L1
+  D owns L3
+         C blocked on L3
+         C owns L2
+                B blocked on L2
+                B owns L1
+                       A blocked on L1
 
-And thus we have the chain A->L1->B->L2->C->L3->D.
+  And thus we have the chain A->L1->B->L2->C->L3->D.
 
 This gives us a PI depth of 4 (four processes), but looking at any of the
 functions individually, it seems as though they only have at most a locking
@@ -298,7 +308,7 @@ not true, the rtmutex.c code will be broken!), this allows for the least
 significant bit to be used as a flag.  Bit 0 is used as the "Has Waiters"
 flag. It's set whenever there are waiters on a mutex.
 
-See Documentation/locking/rt-mutex.txt for further details.
+See Documentation/locking/rt-mutex.rst for further details.
 
 cmpxchg Tricks
 --------------
@@ -307,17 +317,17 @@ Some architectures implement an atomic cmpxchg (Compare and Exchange).  This
 is used (when applicable) to keep the fast path of grabbing and releasing
 mutexes short.
 
-cmpxchg is basically the following function performed atomically:
+cmpxchg is basically the following function performed atomically::
 
-unsigned long _cmpxchg(unsigned long *A, unsigned long *B, unsigned long *C)
-{
+  unsigned long _cmpxchg(unsigned long *A, unsigned long *B, unsigned long *C)
+  {
 	unsigned long T = *A;
 	if (*A == *B) {
 		*A = *C;
 	}
 	return T;
-}
-#define cmpxchg(a,b,c) _cmpxchg(&a,&b,&c)
+  }
+  #define cmpxchg(a,b,c) _cmpxchg(&a,&b,&c)
 
 This is really nice to have, since it allows you to only update a variable
 if the variable is what you expect it to be.  You know if it succeeded if
@@ -352,9 +362,10 @@ Then rt_mutex_setprio is called to adjust the priority of the task to the
 new priority. Note that rt_mutex_setprio is defined in kernel/sched/core.c
 to implement the actual change in priority.
 
-(Note:  For the "prio" field in task_struct, the lower the number, the
+Note:
+	For the "prio" field in task_struct, the lower the number, the
 	higher the priority. A "prio" of 5 is of higher priority than a
-	"prio" of 10.)
+	"prio" of 10.
 
 It is interesting to note that rt_mutex_adjust_prio can either increase
 or decrease the priority of the task.  In the case that a higher priority
@@ -439,6 +450,7 @@ wait_lock, which this code currently holds. So setting the "Has Waiters" flag
 forces the current owner to synchronize with this code.
 
 The lock is taken if the following are true:
+
    1) The lock has no owner
    2) The current task is the highest priority against all other
       waiters of the lock
@@ -546,10 +558,13 @@ Credits
 -------
 
 Author:  Steven Rostedt <rostedt@goodmis.org>
+
 Updated: Alex Shi <alex.shi@linaro.org>	- 7/6/2017
 
-Original Reviewers:  Ingo Molnar, Thomas Gleixner, Thomas Duetsch, and
+Original Reviewers:
+		     Ingo Molnar, Thomas Gleixner, Thomas Duetsch, and
 		     Randy Dunlap
+
 Update (7/6/2017) Reviewers: Steven Rostedt and Sebastian Siewior
 
 Updates
diff --git a/Documentation/locking/rt-mutex.txt b/Documentation/locking/rt-mutex.rst
similarity index 71%
rename from Documentation/locking/rt-mutex.txt
rename to Documentation/locking/rt-mutex.rst
index 35793e003041..c365dc302081 100644
--- a/Documentation/locking/rt-mutex.txt
+++ b/Documentation/locking/rt-mutex.rst
@@ -1,5 +1,6 @@
+==================================
 RT-mutex subsystem with PI support
-----------------------------------
+==================================
 
 RT-mutexes with priority inheritance are used to support PI-futexes,
 which enable pthread_mutex_t priority inheritance attributes
@@ -46,27 +47,30 @@ The state of the rt-mutex is tracked via the owner field of the rt-mutex
 structure:
 
 lock->owner holds the task_struct pointer of the owner. Bit 0 is used to
-keep track of the "lock has waiters" state.
+keep track of the "lock has waiters" state:
 
- owner        bit0
+ ============ ======= ================================================
+ owner        bit0    Notes
+ ============ ======= ================================================
  NULL         0       lock is free (fast acquire possible)
  NULL         1       lock is free and has waiters and the top waiter
-			is going to take the lock*
+		      is going to take the lock [1]_
  taskpointer  0       lock is held (fast release possible)
- taskpointer  1       lock is held and has waiters**
+ taskpointer  1       lock is held and has waiters [2]_
+ ============ ======= ================================================
 
 The fast atomic compare exchange based acquire and release is only
 possible when bit 0 of lock->owner is 0.
 
-(*) It also can be a transitional state when grabbing the lock
-with ->wait_lock is held. To prevent any fast path cmpxchg to the lock,
-we need to set the bit0 before looking at the lock, and the owner may be
-NULL in this small time, hence this can be a transitional state.
+.. [1] It also can be a transitional state when grabbing the lock
+       with ->wait_lock is held. To prevent any fast path cmpxchg to the lock,
+       we need to set the bit0 before looking at the lock, and the owner may
+       be NULL in this small time, hence this can be a transitional state.
 
-(**) There is a small time when bit 0 is set but there are no
-waiters. This can happen when grabbing the lock in the slow path.
-To prevent a cmpxchg of the owner releasing the lock, we need to
-set this bit before looking at the lock.
+.. [2] There is a small time when bit 0 is set but there are no
+       waiters. This can happen when grabbing the lock in the slow path.
+       To prevent a cmpxchg of the owner releasing the lock, we need to
+       set this bit before looking at the lock.
 
 BTW, there is still technically a "Pending Owner", it's just not called
 that anymore. The pending owner happens to be the top_waiter of a lock
diff --git a/Documentation/locking/spinlocks.txt b/Documentation/locking/spinlocks.rst
similarity index 89%
rename from Documentation/locking/spinlocks.txt
rename to Documentation/locking/spinlocks.rst
index ff35e40bdf5b..098107fb7d86 100644
--- a/Documentation/locking/spinlocks.txt
+++ b/Documentation/locking/spinlocks.rst
@@ -1,8 +1,13 @@
+===============
+Locking lessons
+===============
+
 Lesson 1: Spin locks
+====================
 
-The most basic primitive for locking is spinlock.
+The most basic primitive for locking is spinlock::
 
-static DEFINE_SPINLOCK(xxx_lock);
+  static DEFINE_SPINLOCK(xxx_lock);
 
 	unsigned long flags;
 
@@ -19,23 +24,25 @@ worry about UP vs SMP issues: the spinlocks work correctly under both.
    NOTE! Implications of spin_locks for memory are further described in:
 
      Documentation/memory-barriers.txt
+
        (5) LOCK operations.
+
        (6) UNLOCK operations.
 
 The above is usually pretty simple (you usually need and want only one
 spinlock for most things - using more than one spinlock can make things a
 lot more complex and even slower and is usually worth it only for
-sequences that you _know_ need to be split up: avoid it at all cost if you
+sequences that you **know** need to be split up: avoid it at all cost if you
 aren't sure).
 
 This is really the only really hard part about spinlocks: once you start
 using spinlocks they tend to expand to areas you might not have noticed
 before, because you have to make sure the spinlocks correctly protect the
-shared data structures _everywhere_ they are used. The spinlocks are most
+shared data structures **everywhere** they are used. The spinlocks are most
 easily added to places that are completely independent of other code (for
 example, internal driver data structures that nobody else ever touches).
 
-   NOTE! The spin-lock is safe only when you _also_ use the lock itself
+   NOTE! The spin-lock is safe only when you **also** use the lock itself
    to do locking across CPU's, which implies that EVERYTHING that
    touches a shared variable has to agree about the spinlock they want
    to use.
@@ -43,6 +50,7 @@ example, internal driver data structures that nobody else ever touches).
 ----
 
 Lesson 2: reader-writer spinlocks.
+==================================
 
 If your data accesses have a very natural pattern where you usually tend
 to mostly read from the shared variables, the reader-writer locks
@@ -54,7 +62,7 @@ to change the variables it has to get an exclusive write lock.
    simple spinlocks.  Unless the reader critical section is long, you
    are better off just using spinlocks.
 
-The routines look the same as above:
+The routines look the same as above::
 
    rwlock_t xxx_lock = __RW_LOCK_UNLOCKED(xxx_lock);
 
@@ -71,7 +79,7 @@ The routines look the same as above:
 The above kind of lock may be useful for complex data structures like
 linked lists, especially searching for entries without changing the list
 itself.  The read lock allows many concurrent readers.  Anything that
-_changes_ the list will have to get the write lock.
+**changes** the list will have to get the write lock.
 
    NOTE! RCU is better for list traversal, but requires careful
    attention to design detail (see Documentation/RCU/listRCU.txt).
@@ -87,10 +95,11 @@ to get the write-lock at the very beginning.
 ----
 
 Lesson 3: spinlocks revisited.
+==============================
 
 The single spin-lock primitives above are by no means the only ones. They
 are the most safe ones, and the ones that work under all circumstances,
-but partly _because_ they are safe they are also fairly slow. They are slower
+but partly **because** they are safe they are also fairly slow. They are slower
 than they'd need to be, because they do have to disable interrupts
 (which is just a single instruction on a x86, but it's an expensive one -
 and on other architectures it can be worse).
@@ -98,7 +107,7 @@ and on other architectures it can be worse).
 If you have a case where you have to protect a data structure across
 several CPU's and you want to use spinlocks you can potentially use
 cheaper versions of the spinlocks. IFF you know that the spinlocks are
-never used in interrupt handlers, you can use the non-irq versions:
+never used in interrupt handlers, you can use the non-irq versions::
 
 	spin_lock(&lock);
 	...
@@ -110,7 +119,7 @@ This is useful if you know that the data in question is only ever
 manipulated from a "process context", ie no interrupts involved.
 
 The reasons you mustn't use these versions if you have interrupts that
-play with the spinlock is that you can get deadlocks:
+play with the spinlock is that you can get deadlocks::
 
 	spin_lock(&lock);
 	...
@@ -147,9 +156,10 @@ indeed), while write-locks need to protect themselves against interrupts.
 ----
 
 Reference information:
+======================
 
 For dynamic initialization, use spin_lock_init() or rwlock_init() as
-appropriate:
+appropriate::
 
    spinlock_t xxx_lock;
    rwlock_t xxx_rw_lock;
diff --git a/Documentation/locking/ww-mutex-design.txt b/Documentation/locking/ww-mutex-design.rst
similarity index 93%
rename from Documentation/locking/ww-mutex-design.txt
rename to Documentation/locking/ww-mutex-design.rst
index f0ed7c30e695..1846c199da23 100644
--- a/Documentation/locking/ww-mutex-design.txt
+++ b/Documentation/locking/ww-mutex-design.rst
@@ -1,3 +1,4 @@
+======================================
 Wound/Wait Deadlock-Proof Mutex Design
 ======================================
 
@@ -85,6 +86,7 @@ Furthermore there are three different class of w/w lock acquire functions:
   no deadlock potential and hence the ww_mutex_lock call will block and not
   prematurely return -EDEADLK. The advantage of the _slow functions is in
   interface safety:
+
   - ww_mutex_lock has a __must_check int return type, whereas ww_mutex_lock_slow
     has a void return type. Note that since ww mutex code needs loops/retries
     anyway the __must_check doesn't result in spurious warnings, even though the
@@ -115,36 +117,36 @@ expect the number of simultaneous competing transactions to be typically small,
 and you want to reduce the number of rollbacks.
 
 Three different ways to acquire locks within the same w/w class. Common
-definitions for methods #1 and #2:
+definitions for methods #1 and #2::
 
-static DEFINE_WW_CLASS(ww_class);
+  static DEFINE_WW_CLASS(ww_class);
 
-struct obj {
+  struct obj {
 	struct ww_mutex lock;
 	/* obj data */
-};
+  };
 
-struct obj_entry {
+  struct obj_entry {
 	struct list_head head;
 	struct obj *obj;
-};
+  };
 
 Method 1, using a list in execbuf->buffers that's not allowed to be reordered.
 This is useful if a list of required objects is already tracked somewhere.
 Furthermore the lock helper can use propagate the -EALREADY return code back to
 the caller as a signal that an object is twice on the list. This is useful if
 the list is constructed from userspace input and the ABI requires userspace to
-not have duplicate entries (e.g. for a gpu commandbuffer submission ioctl).
+not have duplicate entries (e.g. for a gpu commandbuffer submission ioctl)::
 
-int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
-{
+  int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
+  {
 	struct obj *res_obj = NULL;
 	struct obj_entry *contended_entry = NULL;
 	struct obj_entry *entry;
 
 	ww_acquire_init(ctx, &ww_class);
 
-retry:
+  retry:
 	list_for_each_entry (entry, list, head) {
 		if (entry->obj == res_obj) {
 			res_obj = NULL;
@@ -160,7 +162,7 @@ retry:
 	ww_acquire_done(ctx);
 	return 0;
 
-err:
+  err:
 	list_for_each_entry_continue_reverse (entry, list, head)
 		ww_mutex_unlock(&entry->obj->lock);
 
@@ -176,14 +178,14 @@ err:
 	ww_acquire_fini(ctx);
 
 	return ret;
-}
+  }
 
 Method 2, using a list in execbuf->buffers that can be reordered. Same semantics
 of duplicate entry detection using -EALREADY as method 1 above. But the
-list-reordering allows for a bit more idiomatic code.
+list-reordering allows for a bit more idiomatic code::
 
-int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
-{
+  int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
+  {
 	struct obj_entry *entry, *entry2;
 
 	ww_acquire_init(ctx, &ww_class);
@@ -216,24 +218,25 @@ int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
 
 	ww_acquire_done(ctx);
 	return 0;
-}
+  }
 
-Unlocking works the same way for both methods #1 and #2:
+Unlocking works the same way for both methods #1 and #2::
 
-void unlock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
-{
+  void unlock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
+  {
 	struct obj_entry *entry;
 
 	list_for_each_entry (entry, list, head)
 		ww_mutex_unlock(&entry->obj->lock);
 
 	ww_acquire_fini(ctx);
-}
+  }
 
 Method 3 is useful if the list of objects is constructed ad-hoc and not upfront,
 e.g. when adjusting edges in a graph where each node has its own ww_mutex lock,
 and edges can only be changed when holding the locks of all involved nodes. w/w
 mutexes are a natural fit for such a case for two reasons:
+
 - They can handle lock-acquisition in any order which allows us to start walking
   a graph from a starting point and then iteratively discovering new edges and
   locking down the nodes those edges connect to.
@@ -243,6 +246,7 @@ mutexes are a natural fit for such a case for two reasons:
   as a starting point).
 
 Note that this approach differs in two important ways from the above methods:
+
 - Since the list of objects is dynamically constructed (and might very well be
   different when retrying due to hitting the -EDEADLK die condition) there's
   no need to keep any object on a persistent list when it's not locked. We can
@@ -260,17 +264,17 @@ any interface misuse for these cases.
 
 Also, method 3 can't fail the lock acquisition step since it doesn't return
 -EALREADY. Of course this would be different when using the _interruptible
-variants, but that's outside of the scope of these examples here.
+variants, but that's outside of the scope of these examples here::
 
-struct obj {
+  struct obj {
 	struct ww_mutex ww_mutex;
 	struct list_head locked_list;
-};
+  };
 
-static DEFINE_WW_CLASS(ww_class);
+  static DEFINE_WW_CLASS(ww_class);
 
-void __unlock_objs(struct list_head *list)
-{
+  void __unlock_objs(struct list_head *list)
+  {
 	struct obj *entry, *temp;
 
 	list_for_each_entry_safe (entry, temp, list, locked_list) {
@@ -279,15 +283,15 @@ void __unlock_objs(struct list_head *list)
 		list_del(&entry->locked_list);
 		ww_mutex_unlock(entry->ww_mutex)
 	}
-}
+  }
 
-void lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
-{
+  void lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
+  {
 	struct obj *obj;
 
 	ww_acquire_init(ctx, &ww_class);
 
-retry:
+  retry:
 	/* re-init loop start state */
 	loop {
 		/* magic code which walks over a graph and decides which objects
@@ -312,13 +316,13 @@ retry:
 
 	ww_acquire_done(ctx);
 	return 0;
-}
+  }
 
-void unlock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
-{
+  void unlock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
+  {
 	__unlock_objs(list);
 	ww_acquire_fini(ctx);
-}
+  }
 
 Method 4: Only lock one single objects. In that case deadlock detection and
 prevention is obviously overkill, since with grabbing just one lock you can't
@@ -329,11 +333,14 @@ Implementation Details
 ----------------------
 
 Design:
+^^^^^^^
+
   ww_mutex currently encapsulates a struct mutex, this means no extra overhead for
   normal mutex locks, which are far more common. As such there is only a small
   increase in code size if wait/wound mutexes are not used.
 
   We maintain the following invariants for the wait list:
+
   (1) Waiters with an acquire context are sorted by stamp order; waiters
       without an acquire context are interspersed in FIFO order.
   (2) For Wait-Die, among waiters with contexts, only the first one can have
@@ -355,6 +362,8 @@ Design:
   therefore be directed towards the uncontended cases.
 
 Lockdep:
+^^^^^^^^
+
   Special care has been taken to warn for as many cases of api abuse
   as possible. Some common api abuses will be caught with
   CONFIG_DEBUG_MUTEXES, but CONFIG_PROVE_LOCKING is recommended.
@@ -379,5 +388,6 @@ Lockdep:
      having called ww_acquire_fini on the first.
    - 'normal' deadlocks that can occur.
 
-FIXME: Update this section once we have the TASK_DEADLOCK task state flag magic
-implemented.
+FIXME:
+  Update this section once we have the TASK_DEADLOCK task state flag magic
+  implemented.
diff --git a/Documentation/pi-futex.txt b/Documentation/pi-futex.txt
index b154f6c0c36e..c33ba2befbf8 100644
--- a/Documentation/pi-futex.txt
+++ b/Documentation/pi-futex.txt
@@ -119,4 +119,4 @@ properties of futexes, and all four combinations are possible: futex,
 robust-futex, PI-futex, robust+PI-futex.
 
 More details about priority inheritance can be found in
-Documentation/locking/rt-mutex.txt.
+Documentation/locking/rt-mutex.rst.
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 5fd8a1abd2be..b9a6be4b8499 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1404,7 +1404,7 @@ Riferimento per l'API dei Futex
 Approfondimenti
 ===============
 
--  ``Documentation/locking/spinlocks.txt``: la guida di Linus Torvalds agli
+-  ``Documentation/locking/spinlocks.rst``: la guida di Linus Torvalds agli
    spinlock del kernel.
 
 -  Unix Systems for Modern Architectures: Symmetric Multiprocessing and
diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 53187821df01..fcfe1a03c4a1 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -36,7 +36,7 @@
  * of extra utility/tracking out of our acquire-ctx.  This is provided
  * by &struct drm_modeset_lock and &struct drm_modeset_acquire_ctx.
  *
- * For basic principles of &ww_mutex, see: Documentation/locking/ww-mutex-design.txt
+ * For basic principles of &ww_mutex, see: Documentation/locking/ww-mutex-design.rst
  *
  * The basic usage pattern is to::
  *
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 57baa27f238c..0b0d7259276d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -5,7 +5,7 @@
  *  Copyright (C) 2006,2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  *
- * see Documentation/locking/lockdep-design.txt for more details.
+ * see Documentation/locking/lockdep-design.rst for more details.
  */
 #ifndef __LINUX_LOCKDEP_H
 #define __LINUX_LOCKDEP_H
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 3093dd162424..dcd03fee6e01 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -151,7 +151,7 @@ static inline bool mutex_is_locked(struct mutex *lock)
 
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
- * Also see Documentation/locking/mutex-design.txt.
+ * Also see Documentation/locking/mutex-design.rst.
  */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index e401358c4e7e..9d9c663987d8 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -160,7 +160,7 @@ extern void downgrade_write(struct rw_semaphore *sem);
  * static then another method for expressing nested locking is
  * the explicit definition of lock class keys and the use of
  * lockdep_set_class() at lock initialization time.
- * See Documentation/locking/lockdep-design.txt for more details.)
+ * See Documentation/locking/lockdep-design.rst for more details.)
  */
 extern void down_read_nested(struct rw_semaphore *sem, int subclass);
 extern void down_write_nested(struct rw_semaphore *sem, int subclass);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 0c601ae072b3..edd1c082dbf5 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -16,7 +16,7 @@
  *    by Steven Rostedt, based on work by Gregory Haskins, Peter Morreale
  *    and Sven Dietrich.
  *
- * Also see Documentation/locking/mutex-design.txt.
+ * Also see Documentation/locking/mutex-design.rst.
  */
 #include <linux/mutex.h>
 #include <linux/ww_mutex.h>
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 38fbf9fa7f1b..fa83d36e30c6 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -9,7 +9,7 @@
  *  Copyright (C) 2005 Kihon Technologies Inc., Steven Rostedt
  *  Copyright (C) 2006 Esben Nielsen
  *
- *  See Documentation/locking/rt-mutex-design.txt for details.
+ *  See Documentation/locking/rt-mutex-design.rst for details.
  */
 #include <linux/spinlock.h>
 #include <linux/export.h>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6d2799190fba..18e8c180a874 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1139,7 +1139,7 @@ config PROVE_LOCKING
 	 the proof of observed correctness is also maintained for an
 	 arbitrary combination of these separate locking variants.
 
-	 For more details, see Documentation/locking/lockdep-design.txt.
+	 For more details, see Documentation/locking/lockdep-design.rst.
 
 config LOCK_STAT
 	bool "Lock usage statistics"
@@ -1153,7 +1153,7 @@ config LOCK_STAT
 	help
 	 This feature enables tracking lock contention points
 
-	 For more details, see Documentation/locking/lockstat.txt
+	 For more details, see Documentation/locking/lockstat.rst
 
 	 This also enables lock events required by "perf lock",
 	 subcommand of perf.
-- 
2.21.0

