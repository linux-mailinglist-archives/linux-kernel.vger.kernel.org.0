Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA598472
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfHUTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:31:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57314 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbfHUTbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WK0-0004Fa-Fn; Wed, 21 Aug 2019 21:31:04 +0200
Message-Id: <20190821192921.895254344@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 28/38] posix-cpu-timers: Restructure expiry array
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the abused struct task_cputime is gone, it's more natural to
bundle the expiry cache and the list head of each clock into a struct and
have an array of those structs.

Follow the hrtimer naming convention of 'bases' and rename the expiry cache
to 'nextevt' and adapt all usage sites.

Generates also better code .text size shrinks by 80 bytes.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 include/linux/posix-timers.h   |   41 ++++++++++------
 kernel/time/posix-cpu-timers.c |  104 +++++++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 63 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -63,24 +63,33 @@ static inline int clockid_to_fd(const cl
 }
 
 #ifdef CONFIG_POSIX_TIMERS
+
 /**
- * posix_cputimers - Container for posix CPU timer related data
- * @expiries:		Earliest-expiration cache array based
+ * posix_cputimer_base - Container per posix CPU clock
+ * @nextevt:		Earliest-expiration cache
  * @cpu_timers:		List heads to queue posix CPU timers
+ */
+struct posix_cputimer_base {
+	u64			nextevt;
+	struct list_head	cpu_timers;
+};
+
+/**
+ * posix_cputimers - Container for posix CPU timer related data
+ * @bases:		Base container for posix CPU clocks
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
-	u64			expiries[CPUCLOCK_MAX];
-	struct list_head	cpu_timers[CPUCLOCK_MAX];
+	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
-	memset(&pct->expiries, 0, sizeof(pct->expiries));
-	INIT_LIST_HEAD(&pct->cpu_timers[0]);
-	INIT_LIST_HEAD(&pct->cpu_timers[1]);
-	INIT_LIST_HEAD(&pct->cpu_timers[2]);
+	memset(pct->bases, 0, sizeof(pct->bases));
+	INIT_LIST_HEAD(&pct->bases[0].cpu_timers);
+	INIT_LIST_HEAD(&pct->bases[1].cpu_timers);
+	INIT_LIST_HEAD(&pct->bases[2].cpu_timers);
 }
 
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit);
@@ -88,19 +97,23 @@ void posix_cputimers_group_init(struct p
 static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 					       u64 runtime)
 {
-	pct->expiries[CPUCLOCK_SCHED] = runtime;
+	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
 
 /* Init task static initializer */
-#define INIT_CPU_TIMERLISTS(c)	{					\
-	LIST_HEAD_INIT(c.cpu_timers[0]),				\
-	LIST_HEAD_INIT(c.cpu_timers[1]),				\
-	LIST_HEAD_INIT(c.cpu_timers[2]),				\
+#define INIT_CPU_TIMERBASE(b) {						\
+	.cpu_timers = LIST_HEAD_INIT(b.cpu_timers),			\
+}
+
+#define INIT_CPU_TIMERBASES(b) {					\
+	INIT_CPU_TIMERBASE(b[0]),					\
+	INIT_CPU_TIMERBASE(b[1]),					\
+	INIT_CPU_TIMERBASE(b[2]),					\
 }
 
 #define INIT_CPU_TIMERS(s)						\
 	.posix_cputimers = {						\
-		.cpu_timers = INIT_CPU_TIMERLISTS(s.posix_cputimers),	\
+		.bases = INIT_CPU_TIMERBASES(s.posix_cputimers.bases),	\
 	},
 #else
 struct posix_cputimers { };
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -24,13 +24,13 @@ void posix_cputimers_group_init(struct p
 {
 	posix_cputimers_init(pct);
 	if (cpu_limit != RLIM_INFINITY)
-		pct->expiries[CPUCLOCK_PROF] = cpu_limit * NSEC_PER_SEC;
+		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
 }
 
 /*
  * Called after updating RLIMIT_CPU to run cpu timer and update
- * tsk->signal->posix_cputimers.expiries expiration cache if
- * necessary. Needs siglock protection since other code may update
+ * tsk->signal->posix_cputimers.bases[clock].nextevt expiration cache if
+ * necessary. Needs siglock protection since other code may update the
  * expiration cache as well.
  */
 void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
@@ -122,9 +122,11 @@ static void bump_cpu_timer(struct k_itim
 	}
 }
 
-static inline bool expiry_cache_is_zero(const u64 *ec)
+static inline bool expiry_cache_is_zero(const struct posix_cputimers *pct)
 {
-	return !(ec[CPUCLOCK_PROF] | ec[CPUCLOCK_VIRT] | ec[CPUCLOCK_SCHED]);
+	return !(pct->bases[CPUCLOCK_PROF].nextevt |
+		 pct->bases[CPUCLOCK_VIRT].nextevt |
+		 pct->bases[CPUCLOCK_SCHED].nextevt);
 }
 
 static int
@@ -432,9 +434,9 @@ static void cleanup_timers_list(struct l
  */
 static void cleanup_timers(struct posix_cputimers *pct)
 {
-	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_PROF]);
-	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_VIRT]);
-	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_SCHED]);
+	cleanup_timers_list(&pct->bases[CPUCLOCK_PROF].cpu_timers);
+	cleanup_timers_list(&pct->bases[CPUCLOCK_VIRT].cpu_timers);
+	cleanup_timers_list(&pct->bases[CPUCLOCK_SCHED].cpu_timers);
 }
 
 /*
@@ -464,21 +466,19 @@ static void arm_timer(struct k_itimer *t
 {
 	struct cpu_timer_list *const nt = &timer->it.cpu;
 	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
-	u64 *cpuexp, newexp = timer->it.cpu.expires;
 	struct task_struct *p = timer->it.cpu.task;
+	u64 newexp = timer->it.cpu.expires;
+	struct posix_cputimer_base *base;
 	struct list_head *head, *listpos;
 	struct cpu_timer_list *next;
 
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		head = p->posix_cputimers.cpu_timers + clkidx;
-		cpuexp = p->posix_cputimers.expiries + clkidx;
-	} else {
-		head = p->signal->posix_cputimers.cpu_timers + clkidx;
-		cpuexp = p->signal->posix_cputimers.expiries + clkidx;
-	}
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		base = p->posix_cputimers.bases + clkidx;
+	else
+		base = p->signal->posix_cputimers.bases + clkidx;
 
-	listpos = head;
-	list_for_each_entry(next, head, entry) {
+	listpos = head = &base->cpu_timers;
+	list_for_each_entry(next,head, entry) {
 		if (nt->expires < next->expires)
 			break;
 		listpos = &next->entry;
@@ -494,8 +494,8 @@ static void arm_timer(struct k_itimer *t
 	 * for process timers we share expiration cache with itimers
 	 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
 	 */
-	if (expires_gt(*cpuexp, newexp))
-		*cpuexp = newexp;
+	if (expires_gt(base->nextevt, newexp))
+		base->nextevt = newexp;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
@@ -783,9 +783,9 @@ static inline void check_dl_overrun(stru
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
-	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
-	u64 stime, utime, *expires = tsk->posix_cputimers.expiries;
+	struct posix_cputimer_base *base = tsk->posix_cputimers.bases;
 	unsigned long soft;
+	u64 stime, utime;
 
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
@@ -794,14 +794,18 @@ static void check_thread_timers(struct t
 	 * If the expiry cache is zero, then there are no active per thread
 	 * CPU timers.
 	 */
-	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
+	if (expiry_cache_is_zero(&tsk->posix_cputimers))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
 
-	*expires++ = check_timers_list(timers, firing, utime + stime);
-	*expires++ = check_timers_list(++timers, firing, utime);
-	*expires = check_timers_list(++timers, firing, tsk->se.sum_exec_runtime);
+	base->nextevt = check_timers_list(&base->cpu_timers, firing,
+					  utime + stime);
+	base++;
+	base->nextevt = check_timers_list(&base->cpu_timers, firing, utime);
+	base++;
+	base->nextevt = check_timers_list(&base->cpu_timers, firing,
+					  tsk->se.sum_exec_runtime);
 
 	/*
 	 * Check for the special case thread timers.
@@ -840,7 +844,7 @@ static void check_thread_timers(struct t
 		}
 	}
 
-	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
+	if (expiry_cache_is_zero(&tsk->posix_cputimers))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -884,7 +888,7 @@ static void check_process_timers(struct
 				 struct list_head *firing)
 {
 	struct signal_struct *const sig = tsk->signal;
-	struct list_head *timers = sig->posix_cputimers.cpu_timers;
+	struct posix_cputimer_base *base = sig->posix_cputimers.bases;
 	u64 utime, ptime, virt_expires, prof_expires;
 	u64 sum_sched_runtime, sched_expires;
 	struct task_cputime cputime;
@@ -912,9 +916,12 @@ static void check_process_timers(struct
 	ptime = utime + cputime.stime;
 	sum_sched_runtime = cputime.sum_exec_runtime;
 
-	prof_expires = check_timers_list(timers, firing, ptime);
-	virt_expires = check_timers_list(++timers, firing, utime);
-	sched_expires = check_timers_list(++timers, firing, sum_sched_runtime);
+	prof_expires = check_timers_list(&base[CPUCLOCK_PROF].cpu_timers,
+					 firing, ptime);
+	virt_expires = check_timers_list(&base[CPUCLOCK_VIRT].cpu_timers,
+					 firing, utime);
+	sched_expires = check_timers_list(&base[CLPCLOCK_SCHED].cpu_timers,
+					  firing, sum_sched_runtime);
 
 	/*
 	 * Check for the special case process timers.
@@ -959,11 +966,11 @@ static void check_process_timers(struct
 			prof_expires = x;
 	}
 
-	sig->posix_cputimers.expiries[CPUCLOCK_PROF] = prof_expires;
-	sig->posix_cputimers.expiries[CPUCLOCK_VIRT] = virt_expires;
-	sig->posix_cputimers.expiries[CPUCLOCK_SCHED] = sched_expires;
+	base[CPUCLOCK_PROF].nextevt = prof_expires;
+	base[CPUCLOCK_VIRT].nextevt = virt_expires;
+	base[CPUCLOCK_SCHED].nextevt = sched_expires;
 
-	if (expiry_cache_is_zero(sig->posix_cputimers.expiries))
+	if (expiry_cache_is_zero(&sig->posix_cputimers))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
@@ -1028,20 +1035,21 @@ static void posix_cpu_timer_rearm(struct
 }
 
 /**
- * task_cputimers_expired - Compare two task_cputime entities.
+ * task_cputimers_expired - Check whether posix CPU timers are expired
  *
  * @samples:	Array of current samples for the CPUCLOCK clocks
- * @expiries:	Array of expiry values for the CPUCLOCK clocks
+ * @pct:	Pointer to a posix_cputimers container
  *
- * Returns true if any mmember of @samples is greater than the corresponding
- * member of @expiries if that member is non zero. False otherwise
+ * Returns true if any member of @samples is greater than the corresponding
+ * member of @pct->bases[CLK].nextevt. False otherwise
  */
-static inline bool task_cputimers_expired(const u64 *sample, const u64 *expiries)
+static inline bool
+task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
 {
 	int i;
 
 	for (i = 0; i < CPUCLOCK_MAX; i++) {
-		if (expiries[i] && sample[i] >= expiries[i])
+		if (sample[i] >= pct->bases[i].nextevt)
 			return true;
 	}
 	return false;
@@ -1059,14 +1067,13 @@ static inline bool task_cputimers_expire
  */
 static inline bool fastpath_timer_check(struct task_struct *tsk)
 {
-	u64 *expiries = tsk->posix_cputimers.expiries;
 	struct signal_struct *sig;
 
-	if (!expiry_cache_is_zero(expiries)) {
+	if (!expiry_cache_is_zero(&tsk->posix_cputimers)) {
 		u64 samples[CPUCLOCK_MAX];
 
 		task_sample_cputime(tsk, samples);
-		if (task_cputimers_expired(samples, expiries))
+		if (task_cputimers_expired(samples, &tsk->posix_cputimers))
 			return true;
 	}
 
@@ -1092,8 +1099,7 @@ static inline bool fastpath_timer_check(
 		proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic,
 					   samples);
 
-		if (task_cputimers_expired(samples,
-					   sig->posix_cputimers.expiries))
+		if (task_cputimers_expired(samples, &sig->posix_cputimers))
 			return true;
 	}
 
@@ -1176,7 +1182,7 @@ void run_posix_cpu_timers(void)
 void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			   u64 *newval, u64 *oldval)
 {
-	u64 now, *expiry = tsk->signal->posix_cputimers.expiries + clkid;
+	u64 now, *nextevt = &tsk->signal->posix_cputimers.bases[clkid].nextevt;
 
 	if (WARN_ON_ONCE(clkid >= CPUCLOCK_SCHED))
 		return;
@@ -1207,8 +1213,8 @@ void set_process_cpu_timer(struct task_s
 	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
 	 * expiry cache is also used by RLIMIT_CPU!.
 	 */
-	if (expires_gt(*expiry, *newval))
-		*expiry = *newval;
+	if (expires_gt(*nextevt, *newval))
+		*nextevt = *newval;
 
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
 }


