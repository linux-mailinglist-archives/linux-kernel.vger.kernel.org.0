Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD55FF1BC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 17:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfKFQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 11:56:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfKFQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:56:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so19348549pfl.7;
        Wed, 06 Nov 2019 08:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ErFvsiihKQ/TLXQPsUzha/GiLNxE+XS6ofvNrP/WeGE=;
        b=c9EQNTAvwUYTMIbULAKddQWCcGafjlORftve/zzw41d4qRXmeMxGNAv1CJ7Ng9q9zA
         oSz5QzVI83OSLbUPydS57xEcwvdeULHOU+mRJ46tES1IYFjpYcW0RuEHK6p0AhHTlrqv
         x8802VCDxAcJAa5YSdzZJU+GFU5iJvAVI7JOKef37eoKtRzt5fRbbzq8mekO6P1ohyED
         Eye/H8K5Z/Fk6qZzLLr4VvL50TIT2u7I0Us1KgUre5uNcaui5t/Q7BI5EUjMIrOFeYDB
         LCUPNU+gsBD+UGbVl3PiSzIRhzA5p2sea/O9FdwtfoxtsJU7xalD+44ImExaqwapDdON
         iJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ErFvsiihKQ/TLXQPsUzha/GiLNxE+XS6ofvNrP/WeGE=;
        b=FB1tIYyBM4IOmjKCgIe9iu7Jf44bffO94LakM2pTjCYkwTXPIuX2MvEYKQxaqr0sW4
         drkEdDoqE/xe+nGtluI5h7x0qNOtponWiFVy9sxJZz830/w198FPTV2LC4ZjhLPwgaji
         Oa36JrKf8COwYVflw6O2UP5d1LzwnXkHvwPigb4IPHWJ7tstEAkc+GhRrc/S1rCh5y2d
         Gy2Dnqs1mYz8uAHykAJnZgYzQ7Uq5J//z7Y1X8qj1GAcM2OV0/vs+LpbPPpW3G9CBwmL
         EfV8qssvGVPiOz7a9xTcSTFxXxohcyuwWYPtVe9BzWHu4iLhkNumr0TprqTNgkURAE6Z
         dg/A==
X-Gm-Message-State: APjAAAVgV+raMz+war//SlMPLycHDOrFiBm81pX3/nLL82JmlDj9baNa
        9pn77CY4vYr9rGT+9MTOaCM=
X-Google-Smtp-Source: APXvYqwi685odlAshjG7KUbWMS67eljs0IK6ffKBubzOvSC6I89IlW4gf8Pdd46c1qqB99R5u+KoQg==
X-Received: by 2002:a17:90b:906:: with SMTP id bo6mr5103547pjb.11.1573059386917;
        Wed, 06 Nov 2019 08:56:26 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.253.230])
        by smtp.gmail.com with ESMTPSA id i16sm24620738pfa.184.2019.11.06.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 08:56:26 -0800 (PST)
Date:   Wed, 6 Nov 2019 22:26:17 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Phong Tran <tranmanphong@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Documentation: RCU: rcubarrier: Convert to reST
Message-ID: <20191106165617.GA12205@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert rcubarrier.txt to rcubarrier.rst and
add it to index.rst

Format file according to reST
- Add headings and sub-headings
- Add code segments
- Add cross-references to quizes and answers

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 Documentation/RCU/index.rst                   |   1 +
 .../RCU/{rcubarrier.txt => rcubarrier.rst}    | 220 ++++++++++--------
 2 files changed, 125 insertions(+), 96 deletions(-)
 rename Documentation/RCU/{rcubarrier.txt => rcubarrier.rst} (73%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index c81d0e4fd999..81a0a1e5f767 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -8,6 +8,7 @@ RCU concepts
    :maxdepth: 3
 
    arrayRCU
+   rcubarrier
    rcu_dereference
    whatisRCU
    rcu
diff --git a/Documentation/RCU/rcubarrier.txt b/Documentation/RCU/rcubarrier.rst
similarity index 73%
rename from Documentation/RCU/rcubarrier.txt
rename to Documentation/RCU/rcubarrier.rst
index a2782df69732..1aa9ed1d1b5b 100644
--- a/Documentation/RCU/rcubarrier.txt
+++ b/Documentation/RCU/rcubarrier.rst
@@ -1,4 +1,7 @@
+.. _rcu_barrier:
+
 RCU and Unloadable Modules
+==========================
 
 [Originally published in LWN Jan. 14, 2007: http://lwn.net/Articles/217484/]
 
@@ -21,7 +24,7 @@ given that readers might well leave absolutely no trace of their
 presence? There is a synchronize_rcu() primitive that blocks until all
 pre-existing readers have completed. An updater wishing to delete an
 element p from a linked list might do the following, while holding an
-appropriate lock, of course:
+appropriate lock, of course::
 
 	list_del_rcu(p);
 	synchronize_rcu();
@@ -32,13 +35,13 @@ primitive must be used instead. This primitive takes a pointer to an
 rcu_head struct placed within the RCU-protected data structure and
 another pointer to a function that may be invoked later to free that
 structure. Code to delete an element p from the linked list from IRQ
-context might then be as follows:
+context might then be as follows::
 
 	list_del_rcu(p);
 	call_rcu(&p->rcu, p_callback);
 
 Since call_rcu() never blocks, this code can safely be used from within
-IRQ context. The function p_callback() might be defined as follows:
+IRQ context. The function p_callback() might be defined as follows::
 
 	static void p_callback(struct rcu_head *rp)
 	{
@@ -49,6 +52,7 @@ IRQ context. The function p_callback() might be defined as follows:
 
 
 Unloading Modules That Use call_rcu()
+-------------------------------------
 
 But what if p_callback is defined in an unloadable module?
 
@@ -69,10 +73,11 @@ in realtime kernels in order to avoid excessive scheduling latencies.
 
 
 rcu_barrier()
+-------------
 
 We instead need the rcu_barrier() primitive.  Rather than waiting for
 a grace period to elapse, rcu_barrier() waits for all outstanding RCU
-callbacks to complete.  Please note that rcu_barrier() does -not- imply
+callbacks to complete.  Please note that rcu_barrier() does **not** imply
 synchronize_rcu(), in particular, if there are no RCU callbacks queued
 anywhere, rcu_barrier() is within its rights to return immediately,
 without waiting for a grace period to elapse.
@@ -89,78 +94,78 @@ module uses multiple flavors of call_rcu(), then it must also use multiple
 flavors of rcu_barrier() when unloading that module.  For example, if
 it uses call_rcu(), call_srcu() on srcu_struct_1, and call_srcu() on
 srcu_struct_2(), then the following three lines of code will be required
-when unloading:
+when unloading::
 
  1 rcu_barrier();
  2 srcu_barrier(&srcu_struct_1);
  3 srcu_barrier(&srcu_struct_2);
 
 The rcutorture module makes use of rcu_barrier() in its exit function
-as follows:
+as follows::
 
- 1 static void
- 2 rcu_torture_cleanup(void)
- 3 {
- 4   int i;
+ 1  static void
+ 2  rcu_torture_cleanup(void)
+ 3  {
+ 4    int i;
  5
- 6   fullstop = 1;
- 7   if (shuffler_task != NULL) {
+ 6    fullstop = 1;
+ 7    if (shuffler_task != NULL) {
  8     VERBOSE_PRINTK_STRING("Stopping rcu_torture_shuffle task");
  9     kthread_stop(shuffler_task);
-10   }
-11   shuffler_task = NULL;
-12
-13   if (writer_task != NULL) {
-14     VERBOSE_PRINTK_STRING("Stopping rcu_torture_writer task");
-15     kthread_stop(writer_task);
-16   }
-17   writer_task = NULL;
-18
-19   if (reader_tasks != NULL) {
-20     for (i = 0; i < nrealreaders; i++) {
-21       if (reader_tasks[i] != NULL) {
-22         VERBOSE_PRINTK_STRING(
-23           "Stopping rcu_torture_reader task");
-24         kthread_stop(reader_tasks[i]);
-25       }
-26       reader_tasks[i] = NULL;
-27     }
-28     kfree(reader_tasks);
-29     reader_tasks = NULL;
-30   }
-31   rcu_torture_current = NULL;
-32
-33   if (fakewriter_tasks != NULL) {
-34     for (i = 0; i < nfakewriters; i++) {
-35       if (fakewriter_tasks[i] != NULL) {
-36         VERBOSE_PRINTK_STRING(
-37           "Stopping rcu_torture_fakewriter task");
-38         kthread_stop(fakewriter_tasks[i]);
-39       }
-40       fakewriter_tasks[i] = NULL;
-41     }
-42     kfree(fakewriter_tasks);
-43     fakewriter_tasks = NULL;
-44   }
-45
-46   if (stats_task != NULL) {
-47     VERBOSE_PRINTK_STRING("Stopping rcu_torture_stats task");
-48     kthread_stop(stats_task);
-49   }
-50   stats_task = NULL;
-51
-52   /* Wait for all RCU callbacks to fire. */
-53   rcu_barrier();
-54
-55   rcu_torture_stats_print(); /* -After- the stats thread is stopped! */
-56
-57   if (cur_ops->cleanup != NULL)
-58     cur_ops->cleanup();
-59   if (atomic_read(&n_rcu_torture_error))
-60     rcu_torture_print_module_parms("End of test: FAILURE");
-61   else
-62     rcu_torture_print_module_parms("End of test: SUCCESS");
-63 }
+ 10   }
+ 11   shuffler_task = NULL;
+ 12
+ 13   if (writer_task != NULL) {
+ 14     VERBOSE_PRINTK_STRING("Stopping rcu_torture_writer task");
+ 15     kthread_stop(writer_task);
+ 16   }
+ 17   writer_task = NULL;
+ 18
+ 19   if (reader_tasks != NULL) {
+ 20     for (i = 0; i < nrealreaders; i++) {
+ 21       if (reader_tasks[i] != NULL) {
+ 22         VERBOSE_PRINTK_STRING(
+ 23           "Stopping rcu_torture_reader task");
+ 24         kthread_stop(reader_tasks[i]);
+ 25       }
+ 26       reader_tasks[i] = NULL;
+ 27     }
+ 28     kfree(reader_tasks);
+ 29     reader_tasks = NULL;
+ 30   }
+ 31   rcu_torture_current = NULL;
+ 32
+ 33   if (fakewriter_tasks != NULL) {
+ 34     for (i = 0; i < nfakewriters; i++) {
+ 35       if (fakewriter_tasks[i] != NULL) {
+ 36         VERBOSE_PRINTK_STRING(
+ 37           "Stopping rcu_torture_fakewriter task");
+ 38         kthread_stop(fakewriter_tasks[i]);
+ 39       }
+ 40       fakewriter_tasks[i] = NULL;
+ 41     }
+ 42     kfree(fakewriter_tasks);
+ 43     fakewriter_tasks = NULL;
+ 44   }
+ 45
+ 46   if (stats_task != NULL) {
+ 47     VERBOSE_PRINTK_STRING("Stopping rcu_torture_stats task");
+ 48     kthread_stop(stats_task);
+ 49   }
+ 50   stats_task = NULL;
+ 51
+ 52   /* Wait for all RCU callbacks to fire. */
+ 53   rcu_barrier();
+ 54
+ 55   rcu_torture_stats_print(); /* -After- the stats thread is stopped! */
+ 56
+ 57   if (cur_ops->cleanup != NULL)
+ 58     cur_ops->cleanup();
+ 59   if (atomic_read(&n_rcu_torture_error))
+ 60     rcu_torture_print_module_parms("End of test: FAILURE");
+ 61   else
+ 62     rcu_torture_print_module_parms("End of test: SUCCESS");
+ 63 }
 
 Line 6 sets a global variable that prevents any RCU callbacks from
 re-posting themselves. This will not be necessary in most cases, since
@@ -176,9 +181,14 @@ for any pre-existing callbacks to complete.
 Then lines 55-62 print status and do operation-specific cleanup, and
 then return, permitting the module-unload operation to be completed.
 
-Quick Quiz #1: Is there any other situation where rcu_barrier() might
+.. _rcubarrier_quiz_1:
+
+Quick Quiz #1:
+	Is there any other situation where rcu_barrier() might
 	be required?
 
+:ref:`Answer to Quick Quiz #1 <answer_rcubarrier_quiz_1>`
+
 Your module might have additional complications. For example, if your
 module invokes call_rcu() from timers, you will need to first cancel all
 the timers, and only then invoke rcu_barrier() to wait for any remaining
@@ -188,11 +198,12 @@ Of course, if you module uses call_rcu(), you will need to invoke
 rcu_barrier() before unloading.  Similarly, if your module uses
 call_srcu(), you will need to invoke srcu_barrier() before unloading,
 and on the same srcu_struct structure.  If your module uses call_rcu()
--and- call_srcu(), then you will need to invoke rcu_barrier() -and-
+-and- call_srcu(), then you will need to invoke rcu_barrier() **and**
 srcu_barrier().
 
 
 Implementing rcu_barrier()
+--------------------------
 
 Dipankar Sarma's implementation of rcu_barrier() makes use of the fact
 that RCU callbacks are never reordered once queued on one of the per-CPU
@@ -200,19 +211,19 @@ queues. His implementation queues an RCU callback on each of the per-CPU
 callback queues, and then waits until they have all started executing, at
 which point, all earlier RCU callbacks are guaranteed to have completed.
 
-The original code for rcu_barrier() was as follows:
+The original code for rcu_barrier() was as follows::
 
- 1 void rcu_barrier(void)
- 2 {
- 3   BUG_ON(in_interrupt());
- 4   /* Take cpucontrol mutex to protect against CPU hotplug */
- 5   mutex_lock(&rcu_barrier_mutex);
- 6   init_completion(&rcu_barrier_completion);
- 7   atomic_set(&rcu_barrier_cpu_count, 0);
- 8   on_each_cpu(rcu_barrier_func, NULL, 0, 1);
- 9   wait_for_completion(&rcu_barrier_completion);
-10   mutex_unlock(&rcu_barrier_mutex);
-11 }
+ 1  void rcu_barrier(void)
+ 2  {
+ 3    BUG_ON(in_interrupt());
+ 4    /* Take cpucontrol mutex to protect against CPU hotplug */
+ 5    mutex_lock(&rcu_barrier_mutex);
+ 6    init_completion(&rcu_barrier_completion);
+ 7    atomic_set(&rcu_barrier_cpu_count, 0);
+ 8    on_each_cpu(rcu_barrier_func, NULL, 0, 1);
+ 9    wait_for_completion(&rcu_barrier_completion);
+ 10   mutex_unlock(&rcu_barrier_mutex);
+ 11 }
 
 Line 3 verifies that the caller is in process context, and lines 5 and 10
 use rcu_barrier_mutex to ensure that only one rcu_barrier() is using the
@@ -226,18 +237,18 @@ This code was rewritten in 2008 and several times thereafter, but this
 still gives the general idea.
 
 The rcu_barrier_func() runs on each CPU, where it invokes call_rcu()
-to post an RCU callback, as follows:
+to post an RCU callback, as follows::
 
- 1 static void rcu_barrier_func(void *notused)
- 2 {
- 3 int cpu = smp_processor_id();
- 4 struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
- 5 struct rcu_head *head;
+ 1  static void rcu_barrier_func(void *notused)
+ 2  {
+ 3    int cpu = smp_processor_id();
+ 4    struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+ 5    struct rcu_head *head;
  6
- 7 head = &rdp->barrier;
- 8 atomic_inc(&rcu_barrier_cpu_count);
- 9 call_rcu(head, rcu_barrier_callback);
-10 }
+ 7    head = &rdp->barrier;
+ 8    atomic_inc(&rcu_barrier_cpu_count);
+ 9    call_rcu(head, rcu_barrier_callback);
+ 10 }
 
 Lines 3 and 4 locate RCU's internal per-CPU rcu_data structure,
 which contains the struct rcu_head that needed for the later call to
@@ -248,20 +259,25 @@ the current CPU's queue.
 
 The rcu_barrier_callback() function simply atomically decrements the
 rcu_barrier_cpu_count variable and finalizes the completion when it
-reaches zero, as follows:
+reaches zero, as follows::
 
  1 static void rcu_barrier_callback(struct rcu_head *notused)
  2 {
- 3 if (atomic_dec_and_test(&rcu_barrier_cpu_count))
- 4 complete(&rcu_barrier_completion);
+ 3   if (atomic_dec_and_test(&rcu_barrier_cpu_count))
+ 4     complete(&rcu_barrier_completion);
  5 }
 
-Quick Quiz #2: What happens if CPU 0's rcu_barrier_func() executes
+.. _rcubarrier_quiz_2:
+
+Quick Quiz #2:
+	What happens if CPU 0's rcu_barrier_func() executes
 	immediately (thus incrementing rcu_barrier_cpu_count to the
 	value one), but the other CPU's rcu_barrier_func() invocations
 	are delayed for a full grace period? Couldn't this result in
 	rcu_barrier() returning prematurely?
 
+:ref:`Answer to Quick Quiz #2 <answer_rcubarrier_quiz_2>`
+
 The current rcu_barrier() implementation is more complex, due to the need
 to avoid disturbing idle CPUs (especially on battery-powered systems)
 and the need to minimally disturb non-idle CPUs in real-time systems.
@@ -269,6 +285,7 @@ However, the code above illustrates the concepts.
 
 
 rcu_barrier() Summary
+---------------------
 
 The rcu_barrier() primitive has seen relatively little use, since most
 code using RCU is in the core kernel rather than in modules. However, if
@@ -277,8 +294,12 @@ so that your module may be safely unloaded.
 
 
 Answers to Quick Quizzes
+------------------------
+
+.. _answer_rcubarrier_quiz_1:
 
-Quick Quiz #1: Is there any other situation where rcu_barrier() might
+Quick Quiz #1:
+	Is there any other situation where rcu_barrier() might
 	be required?
 
 Answer: Interestingly enough, rcu_barrier() was not originally
@@ -292,7 +313,12 @@ Answer: Interestingly enough, rcu_barrier() was not originally
 	implementing rcutorture, and found that rcu_barrier() solves
 	this problem as well.
 
-Quick Quiz #2: What happens if CPU 0's rcu_barrier_func() executes
+:ref:`Back to Quick Quiz #1 <rcubarrier_quiz_1>`
+
+.. _answer_rcubarrier_quiz_2:
+
+Quick Quiz #2:
+	What happens if CPU 0's rcu_barrier_func() executes
 	immediately (thus incrementing rcu_barrier_cpu_count to the
 	value one), but the other CPU's rcu_barrier_func() invocations
 	are delayed for a full grace period? Couldn't this result in
@@ -323,3 +349,5 @@ Answer: This cannot happen. The reason is that on_each_cpu() has its last
 	is to add an rcu_read_lock() before line 8 of rcu_barrier()
 	and an rcu_read_unlock() after line 8 of this same function. If
 	you can think of a better change, please let me know!
+
+:ref:`Back to Quick Quiz #2 <rcubarrier_quiz_2>`
-- 
2.20.1

