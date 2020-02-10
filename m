Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A2B15722C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 10:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgBJJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 04:56:39 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:58818 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgBJJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:56:39 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 53E9B2E1371;
        Mon, 10 Feb 2020 12:56:33 +0300 (MSK)
Received: from sas2-3e4aeb094591.qloud-c.yandex.net (sas2-3e4aeb094591.qloud-c.yandex.net [2a02:6b8:c08:7192:0:640:3e4a:eb09])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 0vKdKy6GVI-uWS4lMj0;
        Mon, 10 Feb 2020 12:56:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1581328593; bh=xLIZUyrlKQyvIu98wR3ddE+VzTihLfGlyT45GEHuQzQ=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=KwoREwEX94qzRI13zzl3tDVg6geR3HdGLQK01dRKstu25/ly4fzjJPBpBYN39FkWu
         lXgByrRyT1MhUvJ066XYtT41q/uFamuHytcAG8KHchh7ulyoDkAPRUO99ugjJaXqUB
         2IsgruhFife0c4rCl9xSpvCsUCElNJwhwgLFuksA=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by sas2-3e4aeb094591.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id diG09ln6vM-uWWiuGWa;
        Mon, 10 Feb 2020 12:56:32 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] lib/test_lockup: test module to generate lockups
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Mon, 10 Feb 2020 12:56:31 +0300
Message-ID: <158132859146.2797.525923171323227836.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_TEST_LOCKUP=m adds module "test_lockup" that helps to make sure
that watchdogs and lockup detectors are working properly.

Depending on module parameters test_lockup could emulate soft or hard
lockup, "hung task", hold arbitrary lock, allocate bunch of pages.

Also it could generate series of lockups with cooling-down periods,
in this way it could be used as "ping" for locks or page allocator.
Loop checks signals between iteration thus could be stopped by ^C.


# modinfo test_lockup
...
parm:           time_secs:lockup time in seconds, default 0 (uint)
parm:           time_nsecs:nanoseconds part of lockup time, default 0 (uint)
parm:           cooldown_secs:cooldown time between iterations in seconds, default 0 (uint)
parm:           cooldown_nsecs:nanoseconds part of cooldown, default 0 (uint)
parm:           iterations:lockup iterations, default 1 (uint)
parm:           all_cpus:trigger lockup at all cpus at once (bool)
parm:           state:wait in 'R' running (default), 'D' uninterruptible, 'K' killable, 'S' interruptible state (charp)
parm:           use_hrtimer:use high-resolution timer for sleeping (bool)
parm:           iowait:account sleep time as iowait (bool)
parm:           lock_read:lock read-write locks for read (bool)
parm:           lock_single:acquire locks only at one cpu (bool)
parm:           reacquire_locks:release and reacquire locks/irq/preempt between iterations (bool)
parm:           touch_softlockup:touch soft-lockup watchdog between iterations (bool)
parm:           touch_hardlockup:touch hard-lockup watchdog between iterations (bool)
parm:           call_cond_resched:call cond_resched() between iterations (bool)
parm:           measure_lock_wait:measure lock wait time (bool)
parm:           lock_wait_threshold:print lock wait time longer than this in nanoseconds, default off (ulong)
parm:           disable_irq:disable interrupts: generate hard-lockups (bool)
parm:           disable_softirq:disable bottom-half irq handlers (bool)
parm:           disable_preempt:disable preemption: generate soft-lockups (bool)
parm:           lock_rcu:grab rcu_read_lock: generate rcu stalls (bool)
parm:           lock_mmap_sem:lock mm->mmap_sem: block procfs interfaces (bool)
parm:           lock_rwsem_ptr:lock rw_semaphore at address (ulong)
parm:           lock_mutex_ptr:lock mutex at address (ulong)
parm:           lock_spinlock_ptr:lock spinlock at address (ulong)
parm:           lock_rwlock_ptr:lock rwlock at address (ulong)
parm:           alloc_pages_nr:allocate and free pages under locks (uint)
parm:           alloc_pages_order:page order to allocate (uint)
parm:           alloc_pages_gfp:allocate pages with this gfp_mask, default GFP_KERNEL (uint)
parm:           alloc_pages_atomic:allocate pages with GFP_ATOMIC (bool)
parm:           reallocate_pages:free and allocate pages between iterations (bool)


Parameters for locking by address are unsafe and taints kernel. With
CONFIG_DEBUG_SPINLOCK=y they at least check magics for embedded spinlocks.


Examples:

task hang in D-state:
modprobe test_lockup time_secs=1 iterations=60 state=D

task hang in io-wait D-state:
modprobe test_lockup time_secs=1 iterations=60 state=D iowait

softlockup:
modprobe test_lockup time_secs=1 iterations=60 state=R

hardlockup:
modprobe test_lockup time_secs=1 iterations=60 state=R disable_irq

system-wide hardlockup:
modprobe test_lockup time_secs=1 iterations=60 state=R \
 disable_irq all_cpus

rcu stall:
modprobe test_lockup time_secs=1 iterations=60 state=R \
 lock_rcu touch_softlockup

lock mmap_sem / block procfs interfaces:
modprobe test_lockup time_secs=1 iterations=60 state=S lock_mmap_sem

lock tasklist_lock for read / block forks:
TASKLIST_LOCK=$(awk '$3 == "tasklist_lock" {print "0x"$1}' /proc/kallsyms)
modprobe test_lockup time_secs=1 iterations=60 state=R \
 disable_irq lock_read lock_rwlock_ptr=$TASKLIST_LOCK

lock namespace_sem / block vfs mount operations:
NAMESPACE_SEM=$(awk '$3 == "namespace_sem" {print "0x"$1}' /proc/kallsyms)
modprobe test_lockup time_secs=1 iterations=60 state=S \
 lock_rwsem_ptr=$NAMESPACE_SEM

lock cgroup mutex / block cgroup operations:
CGROUP_MUTEX=$(awk '$3 == "cgroup_mutex" {print "0x"$1}' /proc/kallsyms)
modprobe test_lockup time_secs=1 iterations=60 state=S \
 lock_mutex_ptr=$CGROUP_MUTEX

ping cgroup_mutex every second and measure maximum lock wait time:
modprobe test_lockup cooldown_secs=1 iterations=60 state=S \
 lock_mutex_ptr=$CGROUP_MUTEX reacquire_locks measure_lock_wait

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 lib/Kconfig.debug |   12 +
 lib/Makefile      |    1 
 lib/test_lockup.c |  554 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 567 insertions(+)
 create mode 100644 lib/test_lockup.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df00..8feaf71dab15 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -978,6 +978,18 @@ config WQ_WATCHDOG
 	  state.  This can be configured through kernel parameter
 	  "workqueue.watchdog_thresh" and its sysfs counterpart.
 
+config TEST_LOCKUP
+	tristate "Test module to generate lockups"
+	help
+	  This builds the "test_lockup" module that helps to make sure
+	  that watchdogs and lockup detectors are working properly.
+
+	  Depending on module parameters it could emulate soft or hard
+	  lockup, "hung task", or locking arbitrary lock for a long time.
+	  Also it could generate series of lockups with cooling-down periods.
+
+	  If unsure, say N.
+
 endmenu # "Debug lockups and hangs"
 
 menu "Scheduler Debugging"
diff --git a/lib/Makefile b/lib/Makefile
index 5d64890d6b6a..b5372a83ebe2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
 obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
 obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
+obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
diff --git a/lib/test_lockup.c b/lib/test_lockup.c
new file mode 100644
index 000000000000..f91cd44ad75a
--- /dev/null
+++ b/lib/test_lockup.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test module to generate lockups
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/clock.h>
+#include <linux/cpu.h>
+#include <linux/nmi.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+
+static unsigned int time_secs;
+module_param(time_secs, uint, 0600);
+MODULE_PARM_DESC(time_secs, "lockup time in seconds, default 0");
+
+static unsigned int time_nsecs;
+module_param(time_nsecs, uint, 0600);
+MODULE_PARM_DESC(time_nsecs, "nanoseconds part of lockup time, default 0");
+
+static unsigned int cooldown_secs;
+module_param(cooldown_secs, uint, 0600);
+MODULE_PARM_DESC(cooldown_secs, "cooldown time between iterations in seconds, default 0");
+
+static unsigned int cooldown_nsecs;
+module_param(cooldown_nsecs, uint, 0600);
+MODULE_PARM_DESC(cooldown_nsecs, "nanoseconds part of cooldown, default 0");
+
+static unsigned int iterations = 1;
+module_param(iterations, uint, 0600);
+MODULE_PARM_DESC(iterations, "lockup iterations, default 1");
+
+static bool all_cpus;
+module_param(all_cpus, bool, 0400);
+MODULE_PARM_DESC(all_cpus, "trigger lockup at all cpus at once");
+
+static int wait_state;
+static char *state = "R";
+module_param(state, charp, 0400);
+MODULE_PARM_DESC(state, "wait in 'R' running (default), 'D' uninterruptible, 'K' killable, 'S' interruptible state");
+
+static bool use_hrtimer;
+module_param(use_hrtimer, bool, 0400);
+MODULE_PARM_DESC(use_hrtimer, "use high-resolution timer for sleeping");
+
+static bool iowait;
+module_param(iowait, bool, 0400);
+MODULE_PARM_DESC(iowait, "account sleep time as iowait");
+
+static bool lock_read;
+module_param(lock_read, bool, 0400);
+MODULE_PARM_DESC(lock_read, "lock read-write locks for read");
+
+static bool lock_single;
+module_param(lock_single, bool, 0400);
+MODULE_PARM_DESC(lock_single, "acquire locks only at one cpu");
+
+static bool reacquire_locks;
+module_param(reacquire_locks, bool, 0400);
+MODULE_PARM_DESC(reacquire_locks, "release and reacquire locks/irq/preempt between iterations");
+
+static bool touch_softlockup;
+module_param(touch_softlockup, bool, 0600);
+MODULE_PARM_DESC(touch_softlockup, "touch soft-lockup watchdog between iterations");
+
+static bool touch_hardlockup;
+module_param(touch_hardlockup, bool, 0600);
+MODULE_PARM_DESC(touch_hardlockup, "touch hard-lockup watchdog between iterations");
+
+static bool call_cond_resched;
+module_param(call_cond_resched, bool, 0600);
+MODULE_PARM_DESC(call_cond_resched, "call cond_resched() between iterations");
+
+static bool measure_lock_wait;
+module_param(measure_lock_wait, bool, 0400);
+MODULE_PARM_DESC(measure_lock_wait, "measure lock wait time");
+
+static unsigned long lock_wait_threshold = ULONG_MAX;
+module_param(lock_wait_threshold, ulong, 0400);
+MODULE_PARM_DESC(lock_wait_threshold, "print lock wait time longer than this in nanoseconds, default off");
+
+static bool disable_irq;
+module_param(disable_irq, bool, 0400);
+MODULE_PARM_DESC(disable_irq, "disable interrupts: generate hard-lockups");
+
+static bool disable_softirq;
+module_param(disable_softirq, bool, 0400);
+MODULE_PARM_DESC(disable_softirq, "disable bottom-half irq handlers");
+
+static bool disable_preempt;
+module_param(disable_preempt, bool, 0400);
+MODULE_PARM_DESC(disable_preempt, "disable preemption: generate soft-lockups");
+
+static bool lock_rcu;
+module_param(lock_rcu, bool, 0400);
+MODULE_PARM_DESC(lock_rcu, "grab rcu_read_lock: generate rcu stalls");
+
+static bool lock_mmap_sem;
+module_param(lock_mmap_sem, bool, 0400);
+MODULE_PARM_DESC(lock_mmap_sem, "lock mm->mmap_sem: block procfs interfaces");
+
+static unsigned long lock_rwsem_ptr;
+module_param_unsafe(lock_rwsem_ptr, ulong, 0400);
+MODULE_PARM_DESC(lock_rwsem_ptr, "lock rw_semaphore at address");
+
+static unsigned long lock_mutex_ptr;
+module_param_unsafe(lock_mutex_ptr, ulong, 0400);
+MODULE_PARM_DESC(lock_mutex_ptr, "lock mutex at address");
+
+static unsigned long lock_spinlock_ptr;
+module_param_unsafe(lock_spinlock_ptr, ulong, 0400);
+MODULE_PARM_DESC(lock_spinlock_ptr, "lock spinlock at address");
+
+static unsigned long lock_rwlock_ptr;
+module_param_unsafe(lock_rwlock_ptr, ulong, 0400);
+MODULE_PARM_DESC(lock_rwlock_ptr, "lock rwlock at address");
+
+static unsigned int alloc_pages_nr;
+module_param_unsafe(alloc_pages_nr, uint, 0600);
+MODULE_PARM_DESC(alloc_pages_nr, "allocate and free pages under locks");
+
+static unsigned int alloc_pages_order;
+module_param(alloc_pages_order, uint, 0400);
+MODULE_PARM_DESC(alloc_pages_order, "page order to allocate");
+
+static gfp_t alloc_pages_gfp = GFP_KERNEL;
+module_param_unsafe(alloc_pages_gfp, uint, 0400);
+MODULE_PARM_DESC(alloc_pages_gfp, "allocate pages with this gfp_mask, default GFP_KERNEL");
+
+static bool alloc_pages_atomic;
+module_param(alloc_pages_atomic, bool, 0400);
+MODULE_PARM_DESC(alloc_pages_atomic, "allocate pages with GFP_ATOMIC");
+
+static bool reallocate_pages;
+module_param(reallocate_pages, bool, 0400);
+MODULE_PARM_DESC(reallocate_pages, "free and allocate pages between iterations");
+
+static atomic_t alloc_pages_failed = ATOMIC_INIT(0);
+
+static atomic64_t max_lock_wait = ATOMIC64_INIT(0);
+
+static struct task_struct *main_task;
+static int master_cpu;
+
+static void test_lock(bool master, bool verbose)
+{
+	u64 uninitialized_var(wait_start);
+
+	if (measure_lock_wait)
+		wait_start = local_clock();
+
+	if (lock_mutex_ptr && master) {
+		if (verbose)
+			pr_notice("lock mutex %ps\n", (void *)lock_mutex_ptr);
+		mutex_lock((struct mutex *)lock_mutex_ptr);
+	}
+
+	if (lock_rwsem_ptr && master) {
+		if (verbose)
+			pr_notice("lock rw_semaphore %ps\n",
+				  (void *)lock_rwsem_ptr);
+		if (lock_read)
+			down_read((struct rw_semaphore *)lock_rwsem_ptr);
+		else
+			down_write((struct rw_semaphore *)lock_rwsem_ptr);
+	}
+
+	if (lock_mmap_sem && master) {
+		if (verbose)
+			pr_notice("lock mmap_sem pid=%d\n", main_task->pid);
+		if (lock_read)
+			down_read(&main_task->mm->mmap_sem);
+		else
+			down_write(&main_task->mm->mmap_sem);
+	}
+
+	if (disable_irq)
+		local_irq_disable();
+
+	if (disable_softirq)
+		local_bh_disable();
+
+	if (disable_preempt)
+		preempt_disable();
+
+	if (lock_rcu)
+		rcu_read_lock();
+
+	if (lock_spinlock_ptr && master) {
+		if (verbose)
+			pr_notice("lock spinlock %ps\n",
+				  (void *)lock_spinlock_ptr);
+		spin_lock((spinlock_t *)lock_spinlock_ptr);
+	}
+
+	if (lock_rwlock_ptr && master) {
+		if (verbose)
+			pr_notice("lock rwlock %ps\n",
+				  (void *)lock_rwlock_ptr);
+		if (lock_read)
+			read_lock((rwlock_t *)lock_rwlock_ptr);
+		else
+			write_lock((rwlock_t *)lock_rwlock_ptr);
+	}
+
+	if (measure_lock_wait) {
+		s64 cur_wait = local_clock() - wait_start;
+		s64 max_wait = atomic64_read(&max_lock_wait);
+
+		do {
+			if (cur_wait < max_wait)
+				break;
+			max_wait = atomic64_cmpxchg(&max_lock_wait,
+						    max_wait, cur_wait);
+		} while (max_wait != cur_wait);
+
+		if (cur_wait > lock_wait_threshold)
+			pr_notice_ratelimited("lock wait %lld ns\n", cur_wait);
+	}
+}
+
+static void test_unlock(bool master, bool verbose)
+{
+	if (lock_rwlock_ptr && master) {
+		if (lock_read)
+			read_unlock((rwlock_t *)lock_rwlock_ptr);
+		else
+			write_unlock((rwlock_t *)lock_rwlock_ptr);
+		if (verbose)
+			pr_notice("unlock rwlock %ps\n",
+				  (void *)lock_rwlock_ptr);
+	}
+
+	if (lock_spinlock_ptr && master) {
+		spin_unlock((spinlock_t *)lock_spinlock_ptr);
+		if (verbose)
+			pr_notice("unlock spinlock %ps\n",
+				  (void *)lock_spinlock_ptr);
+	}
+
+	if (lock_rcu)
+		rcu_read_unlock();
+
+	if (disable_preempt)
+		preempt_enable();
+
+	if (disable_softirq)
+		local_bh_enable();
+
+	if (disable_irq)
+		local_irq_enable();
+
+	if (lock_mmap_sem && master) {
+		if (lock_read)
+			up_read(&main_task->mm->mmap_sem);
+		else
+			up_write(&main_task->mm->mmap_sem);
+		if (verbose)
+			pr_notice("unlock mmap_sem pid=%d\n", main_task->pid);
+	}
+
+	if (lock_rwsem_ptr && master) {
+		if (lock_read)
+			up_read((struct rw_semaphore *)lock_rwsem_ptr);
+		else
+			up_write((struct rw_semaphore *)lock_rwsem_ptr);
+		if (verbose)
+			pr_notice("unlock rw_semaphore %ps\n",
+				  (void *)lock_rwsem_ptr);
+	}
+
+	if (lock_mutex_ptr && master) {
+		mutex_unlock((struct mutex *)lock_mutex_ptr);
+		if (verbose)
+			pr_notice("unlock mutex %ps\n",
+				  (void *)lock_mutex_ptr);
+	}
+}
+
+static void test_alloc_pages(struct list_head *pages)
+{
+	struct page *page;
+	unsigned int i;
+
+	for (i = 0; i < alloc_pages_nr; i++) {
+		page = alloc_pages(alloc_pages_gfp, alloc_pages_order);
+		if (!page) {
+			atomic_inc(&alloc_pages_failed);
+			break;
+		}
+		list_add(&page->lru, pages);
+	}
+}
+
+static void test_free_pages(struct list_head *pages)
+{
+	struct page *page, *next;
+
+	list_for_each_entry_safe(page, next, pages, lru)
+		__free_pages(page, alloc_pages_order);
+	INIT_LIST_HEAD(pages);
+}
+
+static void test_wait(unsigned int secs, unsigned int nsecs)
+{
+	if (wait_state == TASK_RUNNING) {
+		if (secs)
+			mdelay(secs * MSEC_PER_SEC);
+		if (nsecs)
+			ndelay(nsecs);
+		return;
+	}
+
+	__set_current_state(wait_state);
+	if (use_hrtimer) {
+		ktime_t time;
+
+		time = ns_to_ktime((u64)secs * NSEC_PER_SEC + nsecs);
+		schedule_hrtimeout(&time, HRTIMER_MODE_REL);
+	} else {
+		schedule_timeout(secs * HZ + nsecs_to_jiffies(nsecs));
+	}
+}
+
+static void test_lockup(bool master)
+{
+	u64 lockup_start = local_clock();
+	unsigned int iter = 0;
+	LIST_HEAD(pages);
+
+	pr_notice("Start on CPU%d\n", raw_smp_processor_id());
+
+	test_lock(master, true);
+
+	test_alloc_pages(&pages);
+
+	while (iter++ < iterations && !signal_pending(main_task)) {
+
+		if (iowait)
+			current->in_iowait = 1;
+
+		test_wait(time_secs, time_nsecs);
+
+		if (iowait)
+			current->in_iowait = 0;
+
+		if (reallocate_pages)
+			test_free_pages(&pages);
+
+		if (reacquire_locks)
+			test_unlock(master, false);
+
+		if (touch_softlockup)
+			touch_softlockup_watchdog();
+
+		if (touch_hardlockup)
+			touch_nmi_watchdog();
+
+		if (call_cond_resched)
+			cond_resched();
+
+		test_wait(cooldown_secs, cooldown_nsecs);
+
+		if (reacquire_locks)
+			test_lock(master, false);
+
+		if (reallocate_pages)
+			test_alloc_pages(&pages);
+	}
+
+	pr_notice("Finish on CPU%d in %lld ns\n", raw_smp_processor_id(),
+		  local_clock() - lockup_start);
+
+	test_free_pages(&pages);
+
+	test_unlock(master, true);
+}
+
+DEFINE_PER_CPU(struct work_struct, test_works);
+
+static void test_work_fn(struct work_struct *work)
+{
+	test_lockup(!lock_single ||
+		    work == per_cpu_ptr(&test_works, master_cpu));
+}
+
+static bool test_kernel_ptr(unsigned long addr, int size)
+{
+	void *ptr = (void *)addr;
+	char buf;
+
+	if (!addr)
+		return false;
+
+	/* should be at least readable kernel address */
+	if (access_ok(ptr, 1) ||
+	    access_ok(ptr + size - 1, 1) ||
+	    probe_kernel_address(ptr, buf) ||
+	    probe_kernel_address(ptr + size - 1, buf)) {
+		pr_err("invalid kernel ptr: %#lx\n", addr);
+		return true;
+	}
+
+	return false;
+}
+
+static bool __maybe_unused test_magic(unsigned long addr, int offset,
+				      unsigned int expected)
+{
+	void *ptr = (void *)addr + offset;
+	unsigned int magic = 0;
+
+	if (!addr)
+		return false;
+
+	if (probe_kernel_address(ptr, magic) || magic != expected) {
+		pr_err("invalid magic at %#lx + %#x = %#x, expected %#x\n",
+		       addr, offset, magic, expected);
+		return true;
+	}
+
+	return false;
+}
+
+static int __init test_lockup_init(void)
+{
+	u64 test_start = local_clock();
+
+	main_task = current;
+
+	switch (state[0]) {
+	case 'S':
+		wait_state = TASK_INTERRUPTIBLE;
+		break;
+	case 'D':
+		wait_state = TASK_UNINTERRUPTIBLE;
+		break;
+	case 'K':
+		wait_state = TASK_KILLABLE;
+		break;
+	case 'R':
+		wait_state = TASK_RUNNING;
+		break;
+	default:
+		pr_err("unknown state=%s\n", state);
+		return -EINVAL;
+	}
+
+	if (alloc_pages_atomic)
+		alloc_pages_gfp = GFP_ATOMIC;
+
+	if (test_kernel_ptr(lock_spinlock_ptr, sizeof(spinlock_t)) ||
+	    test_kernel_ptr(lock_rwlock_ptr, sizeof(rwlock_t)) ||
+	    test_kernel_ptr(lock_mutex_ptr, sizeof(struct mutex)) ||
+	    test_kernel_ptr(lock_rwsem_ptr, sizeof(struct rw_semaphore)))
+		return -EINVAL;
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+	if (test_magic(lock_spinlock_ptr,
+		       offsetof(spinlock_t, rlock.magic),
+		       SPINLOCK_MAGIC) ||
+	    test_magic(lock_rwlock_ptr,
+		       offsetof(rwlock_t, magic),
+		       RWLOCK_MAGIC) ||
+	    test_magic(lock_mutex_ptr,
+		       offsetof(struct mutex, wait_lock.rlock.magic),
+		       SPINLOCK_MAGIC) ||
+	    test_magic(lock_rwsem_ptr,
+		       offsetof(struct rw_semaphore, wait_lock.magic),
+		       SPINLOCK_MAGIC))
+		return -EINVAL;
+#endif
+
+	if ((wait_state != TASK_RUNNING ||
+	     (call_cond_resched && !reacquire_locks) ||
+	     (alloc_pages_nr && gfpflags_allow_blocking(alloc_pages_gfp))) &&
+	    (disable_irq || disable_softirq || disable_preempt || lock_rcu ||
+	     lock_spinlock_ptr || lock_rwlock_ptr)) {
+		pr_err("refuse to sleep in atomic context\n");
+		return -EINVAL;
+	}
+
+	if (lock_mmap_sem && !main_task->mm) {
+		pr_err("no mm to lock mmap_sem\n");
+		return -EINVAL;
+	}
+
+	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iteraions=%u state=%s %s%s%s%s%s%s%s%s%s%s%s\n",
+		  main_task->pid, time_secs, time_nsecs,
+		  cooldown_secs, cooldown_nsecs, iterations, state,
+		  all_cpus ? "all_cpus " : "",
+		  iowait ? "iowait " : "",
+		  disable_irq ? "disable_irq " : "",
+		  disable_softirq ? "disable_softirq " : "",
+		  disable_preempt ? "disable_preempt " : "",
+		  lock_rcu ? "lock_rcu " : "",
+		  lock_read ? "lock_read " : "",
+		  touch_softlockup ? "touch_softlockup " : "",
+		  touch_hardlockup ? "touch_hardlockup " : "",
+		  call_cond_resched ? "call_cond_resched " : "",
+		  reacquire_locks ? "reacquire_locks " : "");
+
+	if (alloc_pages_nr)
+		pr_notice("ALLOCATE PAGES nr=%u order=%u gfp=%pGg %s\n",
+			  alloc_pages_nr, alloc_pages_order, &alloc_pages_gfp,
+			  reallocate_pages ? "reallocate_pages " : "");
+
+	if (all_cpus) {
+		unsigned int cpu;
+
+		cpus_read_lock();
+
+		preempt_disable();
+		master_cpu = smp_processor_id();
+		for_each_online_cpu(cpu) {
+			INIT_WORK(per_cpu_ptr(&test_works, cpu), test_work_fn);
+			queue_work_on(cpu, system_highpri_wq,
+				      per_cpu_ptr(&test_works, cpu));
+		}
+		preempt_enable();
+
+		for_each_online_cpu(cpu)
+			flush_work(per_cpu_ptr(&test_works, cpu));
+
+		cpus_read_unlock();
+	} else {
+		test_lockup(true);
+	}
+
+	if (measure_lock_wait)
+		pr_notice("Maximum lock wait: %lld ns\n",
+			  atomic64_read(&max_lock_wait));
+
+	if (alloc_pages_nr)
+		pr_notice("Page allocation failed %u times\n",
+			  atomic_read(&alloc_pages_failed));
+
+	pr_notice("FINISH in %llu ns\n", local_clock() - test_start);
+
+	if (signal_pending(main_task))
+		return -EINTR;
+
+	return -EAGAIN;
+}
+module_init(test_lockup_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Konstantin Khlebnikov <khlebnikov@yandex-team.ru>");
+MODULE_DESCRIPTION("Test module to generate lockups");

