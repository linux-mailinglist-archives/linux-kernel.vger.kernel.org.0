Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4424A83AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 23:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfHFVVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 17:21:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37652 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFVU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:20:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so9432052pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9e7S8TrD0898SjDj4NPcFNFKq3auEaKnAUGXYGMacs=;
        b=FHtoj00SFXYz9Ocv29fXxIgCSphCBpH+7QGuhpfDFAu7KVTK+rjK7H/vDySbAYwgKs
         dq6W7LwZNfA0wHzerpwoWDefre9782Z8l5lUx5zT5F/Cr4Ce6h7rhrC4nIZou7uFuRec
         EbS19ksqgEqqVlMwLoHLUZnuOAyERLlhoj3II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9e7S8TrD0898SjDj4NPcFNFKq3auEaKnAUGXYGMacs=;
        b=m2OXEKIqkjCSibzD4fl/tyf5bGCoIAEnFCfhIUNoRXI848mI5zXAO7DlodutYkLiYH
         /+qk8/wFAR1dRnMqpWscWQMyuPnmC3/qLrL5NJJkiM7T/N11Cr5czDIWNA/rwz3RbaC/
         YYwaUBygZM3uT/BFJepmGykaO1XsYyx6mbQaBMLiMro0csvq8bPVPXRJtILxLmur0Cbc
         pC+sUaNY1af9i2KnT/U8VL+Z3mX/Gj0xpqt4a6F7prnfWlF0yBjEZdcZM2AEvd6uHflL
         Zi/SXQbH/ExK6I1njtpcD2IJtsC36gPJn9Lcu1QpTFxoBt5y5KkcRlrdpu+fKp/NcLMK
         uzpQ==
X-Gm-Message-State: APjAAAU/PeG06KUHTkTMMgtcxKu+hm/XZgeUnd0yRoj6QS/OJuka/7XA
        cjXb9hmlq+EOgZRe57ZDp0UY3mBA6E4=
X-Google-Smtp-Source: APXvYqxUMMrVF51fG6EmqFcKlkvhIe9o4aUH/przcyi0pZg3//PdYqNBT1vU98Crh/5pfYshN/iCTQ==
X-Received: by 2002:a63:4562:: with SMTP id u34mr4699564pgk.288.1565126457886;
        Tue, 06 Aug 2019 14:20:57 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b126sm128786325pfa.126.2019.08.06.14.20.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:20:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC v1 2/2] rcuperf: Add kfree_rcu performance Tests
Date:   Tue,  6 Aug 2019 17:20:41 -0400
Message-Id: <20190806212041.118146-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190806212041.118146-1-joel@joelfernandes.org>
References: <20190806212041.118146-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test runs kfree_rcu in a loop to measure performance of the new
kfree_rcu, with and without patch.

To see improvement, run with boot parameters:
rcuperf.kfree_loops=2000 rcuperf.kfree_alloc_num=100 rcuperf.perf_type=kfree

Without patch, test runs in 6.9 seconds.
With patch, test runs in 6.1 seconds (+13% improvement)

If it is desired to run the test but with the traditional (non-batched)
kfree_rcu, for example to compare results, then you could pass along the
rcuperf.kfree_no_batch=1 boot parameter.

Cc: max.byungchul.park@gmail.com
Cc: byungchul.park@lge.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuperf.c | 169 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 7a6890b23c5f..34658760da5e 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -89,7 +89,7 @@ torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
-MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, ...)");
+MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, kfree,...)");
 
 static int nrealreaders;
 static int nrealwriters;
@@ -592,6 +592,170 @@ rcu_perf_shutdown(void *arg)
 	return -EINVAL;
 }
 
+/*
+ * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
+ * of iterations and measure total time for all iterations to complete.
+ */
+
+torture_param(int, kfree_nthreads, -1, "Number of RCU reader threads");
+torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done by a thread");
+torture_param(int, kfree_alloc_size, 16,  "Size of each allocation");
+torture_param(int, kfree_loops, 10, "Size of each allocation");
+torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu");
+
+static struct task_struct **kfree_reader_tasks;
+static int kfree_nrealthreads;
+static atomic_t n_kfree_perf_thread_started;
+static atomic_t n_kfree_perf_thread_ended;
+
+#define KFREE_OBJ_BYTES 8
+
+struct kfree_obj {
+	char kfree_obj[KFREE_OBJ_BYTES];
+	struct rcu_head rh;
+};
+
+void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
+
+static int
+kfree_perf_thread(void *arg)
+{
+	int i, l = 0;
+	long me = (long)arg;
+	struct kfree_obj **alloc_ptrs;
+	u64 start_time, end_time;
+
+	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+	atomic_inc(&n_kfree_perf_thread_started);
+
+	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
+						  GFP_KERNEL);
+	if (!alloc_ptrs)
+		return -ENOMEM;
+
+	start_time = ktime_get_mono_fast_ns();
+	do {
+		for (i = 0; i < kfree_alloc_num; i++) {
+			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
+			if (!alloc_ptrs[i])
+				return -ENOMEM;
+		}
+
+		for (i = 0; i < kfree_alloc_num; i++) {
+			if (!kfree_no_batch) {
+				kfree_rcu(alloc_ptrs[i], rh);
+			} else {
+				rcu_callback_t cb;
+
+				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
+				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
+			}
+		}
+
+		schedule_timeout_uninterruptible(2);
+	} while (!torture_must_stop() && ++l < kfree_loops);
+
+	kfree(alloc_ptrs);
+
+	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
+		end_time = ktime_get_mono_fast_ns();
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d\n",
+		       (unsigned long long)(end_time - start_time), kfree_loops);
+		if (shutdown) {
+			smp_mb(); /* Assign before wake. */
+			wake_up(&shutdown_wq);
+		}
+	}
+
+	torture_kthread_stopping("kfree_perf_thread");
+	return 0;
+}
+
+static void
+kfree_perf_cleanup(void)
+{
+	int i;
+
+	if (torture_cleanup_begin())
+		return;
+
+	if (kfree_reader_tasks) {
+		for (i = 0; i < kfree_nrealthreads; i++)
+			torture_stop_kthread(kfree_perf_thread,
+					     kfree_reader_tasks[i]);
+		kfree(kfree_reader_tasks);
+	}
+
+	torture_cleanup_end();
+}
+
+/*
+ * shutdown kthread.  Just waits to be awakened, then shuts down system.
+ */
+static int
+kfree_perf_shutdown(void *arg)
+{
+	do {
+		wait_event(shutdown_wq,
+			   atomic_read(&n_kfree_perf_thread_ended) >=
+			   kfree_nrealthreads);
+	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
+
+	smp_mb(); /* Wake before output. */
+
+	kfree_perf_cleanup();
+	kernel_power_off();
+	return -EINVAL;
+}
+
+static int __init
+kfree_perf_init(void)
+{
+	long i;
+	int firsterr = 0;
+
+	if (!torture_init_begin("kfree_perf", verbose))
+		return -EBUSY;
+
+	kfree_nrealthreads = compute_real(kfree_nthreads);
+	/* Start up the kthreads. */
+	if (shutdown) {
+		init_waitqueue_head(&shutdown_wq);
+		firsterr = torture_create_kthread(kfree_perf_shutdown, NULL,
+						  shutdown_task);
+		if (firsterr)
+			goto unwind;
+		schedule_timeout_uninterruptible(1);
+	}
+
+	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
+			       GFP_KERNEL);
+	if (kfree_reader_tasks == NULL) {
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+
+	for (i = 0; i < kfree_nrealthreads; i++) {
+		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
+						  kfree_reader_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
+
+	while (atomic_read(&n_kfree_perf_thread_started) < kfree_nrealthreads)
+		schedule_timeout_uninterruptible(1);
+
+	torture_init_end();
+	return 0;
+
+unwind:
+	torture_init_end();
+	kfree_perf_cleanup();
+	return firsterr;
+}
+
 static int __init
 rcu_perf_init(void)
 {
@@ -601,6 +765,9 @@ rcu_perf_init(void)
 		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
 	};
 
+	if (strcmp(perf_type, "kfree") == 0)
+		return kfree_perf_init();
+
 	if (!torture_init_begin(perf_type, verbose))
 		return -EBUSY;
 
-- 
2.22.0.770.g0f2c4a37fd-goog

