Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D28D621F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfEQUeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 16:34:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43267 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfEQUel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:34:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id i26so9494911qtr.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VeOHKUgWc5lzs0lL8W8bL8bApiz7pnYC5IgVm7QTTfQ=;
        b=pPiWKxIb6t9pa81kUBWYHCae94g7GcL/7GzBqEVXdUZPvG10Gy+uCdnNdY5dreStqg
         aobDdlgUEt3oSjLpHg6yUjwXErXrEKpuKwL8oQeyySTfuErXv13Tq0CPfF47vagHkUDK
         9gOfa+nJ28G9l/GitVr1OVKTfkCMb3czwuND+9soMghl93i8fnPSOEnI5yhwz4VT77kB
         9lO3ERGhxSQTuKbCI+Fk7O/IKt9TMx4hpB4azrWNPj/ReG/qY8VeLMlU1bdsbfbz/qVg
         uMMi+zAwN/OgDJpkdoGj7Cw3miZnNjGyO5vpT15oMNWLRI8F1epNAZanHyu2FvcoQuC2
         5Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VeOHKUgWc5lzs0lL8W8bL8bApiz7pnYC5IgVm7QTTfQ=;
        b=AJ3mDsLC6/xz/GvW0hA+rR3BrKb9TJbZwIzq171p1SDiwIEOOTnoffc9JBs8uk+nfG
         pyP3cnXvm1MS4ShnZ2RHt7hVrGMx8IaoVmEi+axcBUlxB+eUwmPFx+McdLY/0qrkcLOh
         7sNG27tXiZpQcSPHpthEO6XuMEbvK5s0lrT0UKD8hzjeGuB91NQcW0nqIs9o1r+VrR9/
         94jNtoS9MAW6HRDB2/9FDSUnA4TtnZhqYbcrlo1Szqn8cfS3AAhIvZ+A/29h5W76qMm2
         P0brv8hWlo11Rmnm2I+ocsp1F4SB0jw3JeTwnFgFJbH43WPAIlPRLTgDA/s//NE/2N1C
         M88Q==
X-Gm-Message-State: APjAAAUaaj0FrWlY2ApTbpS3dv+PQFS7igHVaDZ7XuT6W8EvTbx6KgRb
        HjrrxHsrRRSxLHQZEa5VOg==
X-Google-Smtp-Source: APXvYqwhWmiA6rmwChflj5hnt0JntmoArUdp2VGvib4MgAN+FAVQWr7GzAX4jYaHPEYxZG2E3h1F5g==
X-Received: by 2002:aed:22ad:: with SMTP id p42mr48888837qtc.86.1558125280492;
        Fri, 17 May 2019 13:34:40 -0700 (PDT)
Received: from localhost.localdomain ([92.117.189.151])
        by smtp.gmail.com with ESMTPSA id u5sm5499145qtj.95.2019.05.17.13.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 13:34:39 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v4 2/4] preemptirq_delay_test: Add the burst feature and a sysfs trigger
Date:   Fri, 17 May 2019 22:34:28 +0200
Message-Id: <20190517203430.6729-3-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517203430.6729-1-viktor.rosendahl@gmail.com>
References: <20190517203430.6729-1-viktor.rosendahl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This burst feature enables the user to generate a burst of
preempt/irqsoff latencies. This makes it possible to test whether we
are able to detect latencies that systematically occur very close to
each other.

The maximum burst size is 10. We also create 10 identical test
functions, so that we get 10 different backtraces; this is useful
when we want to test whether we can detect all the latencies in a
burst. Otherwise, there would be no easy way of differentiating
between which latency in a burst was captured by the tracer.

In addition, there is a sysfs trigger, so that it's not necessary to
reload the module to repeat the test. The trigger will appear as
/sys/kernel/preemptirq_delay_test/trigger in sysfs.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
---
 kernel/trace/Kconfig                 |   6 +-
 kernel/trace/preemptirq_delay_test.c | 145 +++++++++++++++++++++++----
 2 files changed, 129 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5d965cef6c77..aab8909dfbff 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -740,9 +740,9 @@ config PREEMPTIRQ_DELAY_TEST
 	  configurable delay. The module busy waits for the duration of the
 	  critical section.
 
-	  For example, the following invocation forces a one-time irq-disabled
-	  critical section for 500us:
-	  modprobe preemptirq_delay_test test_mode=irq delay=500000
+	  For example, the following invocation generates a burst of three
+	  irq-disabled critical sections for 500us:
+	  modprobe preemptirq_delay_test test_mode=irq delay=500 burst_size=3
 
 	  If unsure, say N
 
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index d8765c952fab..dc281fa75198 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -3,6 +3,7 @@
  * Preempt / IRQ disable delay thread to test latency tracers
  *
  * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
+ * Copyright (C) 2018, 2019 BMW Car IT GmbH
  */
 
 #include <linux/trace_clock.h>
@@ -10,18 +11,25 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 
 static ulong delay = 100;
-static char test_mode[10] = "irq";
+static char test_mode[12] = "irq";
+static uint burst_size = 1;
 
-module_param_named(delay, delay, ulong, S_IRUGO);
-module_param_string(test_mode, test_mode, 10, S_IRUGO);
-MODULE_PARM_DESC(delay, "Period in microseconds (100 uS default)");
-MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt or irq (default irq)");
+module_param_named(delay, delay, ulong, 0444);
+module_param_string(test_mode, test_mode, 12, 0444);
+module_param_named(burst_size, burst_size, uint, 0444);
+MODULE_PARM_DESC(delay, "Period in microseconds (100 us default)");
+MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt, irq, or alternate (default irq)");
+MODULE_PARM_DESC(burst_size, "The size of a burst (default 1)");
+
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
 
 static void busy_wait(ulong time)
 {
@@ -34,37 +42,136 @@ static void busy_wait(ulong time)
 	} while ((end - start) < (time * 1000));
 }
 
-static int preemptirq_delay_run(void *data)
+static __always_inline void irqoff_test(void)
 {
 	unsigned long flags;
+	local_irq_save(flags);
+	busy_wait(delay);
+	local_irq_restore(flags);
+}
 
-	if (!strcmp(test_mode, "irq")) {
-		local_irq_save(flags);
-		busy_wait(delay);
-		local_irq_restore(flags);
-	} else if (!strcmp(test_mode, "preempt")) {
-		preempt_disable();
-		busy_wait(delay);
-		preempt_enable();
+static __always_inline void preemptoff_test(void)
+{
+	preempt_disable();
+	busy_wait(delay);
+	preempt_enable();
+}
+
+static void execute_preemptirqtest(int idx)
+{
+	if (!strcmp(test_mode, "irq"))
+		irqoff_test();
+	else if (!strcmp(test_mode, "preempt"))
+		preemptoff_test();
+	else if (!strcmp(test_mode, "alternate")) {
+		if (idx % 2 == 0)
+			irqoff_test();
+		else
+			preemptoff_test();
 	}
+}
+
+#define DECLARE_TESTFN(POSTFIX)				\
+	static void preemptirqtest_##POSTFIX(int idx)	\
+	{						\
+		execute_preemptirqtest(idx);		\
+	}						\
 
+/*
+ * We create 10 different functions, so that we can get 10 different
+ * backtraces.
+ */
+DECLARE_TESTFN(0)
+DECLARE_TESTFN(1)
+DECLARE_TESTFN(2)
+DECLARE_TESTFN(3)
+DECLARE_TESTFN(4)
+DECLARE_TESTFN(5)
+DECLARE_TESTFN(6)
+DECLARE_TESTFN(7)
+DECLARE_TESTFN(8)
+DECLARE_TESTFN(9)
+
+static void (*testfuncs[])(int)  = {
+	preemptirqtest_0,
+	preemptirqtest_1,
+	preemptirqtest_2,
+	preemptirqtest_3,
+	preemptirqtest_4,
+	preemptirqtest_5,
+	preemptirqtest_6,
+	preemptirqtest_7,
+	preemptirqtest_8,
+	preemptirqtest_9,
+};
+
+#define NR_TEST_FUNCS ARRAY_SIZE(testfuncs)
+
+static int preemptirq_delay_run(void *data)
+{
+	int i;
+	int s = MIN(burst_size, NR_TEST_FUNCS);
+
+	for (i = 0; i < s; i++)
+		(testfuncs[i])(i);
 	return 0;
 }
 
-static int __init preemptirq_delay_init(void)
+static struct task_struct *preemptirq_start_test(void)
 {
 	char task_name[50];
-	struct task_struct *test_task;
 
 	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
+	return kthread_run(preemptirq_delay_run, NULL, task_name);
+}
+
+
+static ssize_t trigger_store(struct kobject *kobj, struct kobj_attribute *attr,
+			 const char *buf, size_t count)
+{
+	preemptirq_start_test();
+	return count;
+}
+
+static struct kobj_attribute trigger_attribute =
+	__ATTR(trigger, 0200, NULL, trigger_store);
+
+static struct attribute *attrs[] = {
+	&trigger_attribute.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = attrs,
+};
+
+static struct kobject *preemptirq_delay_kobj;
+
+static int __init preemptirq_delay_init(void)
+{
+	struct task_struct *test_task;
+	int retval;
+
+	test_task = preemptirq_start_test();
+	retval = PTR_ERR_OR_ZERO(test_task);
+	if (retval != 0)
+		return retval;
+
+	preemptirq_delay_kobj = kobject_create_and_add("preemptirq_delay_test",
+						       kernel_kobj);
+	if (!preemptirq_delay_kobj)
+		return -ENOMEM;
+
+	retval = sysfs_create_group(preemptirq_delay_kobj, &attr_group);
+	if (retval)
+		kobject_put(preemptirq_delay_kobj);
 
-	test_task = kthread_run(preemptirq_delay_run, NULL, task_name);
-	return PTR_ERR_OR_ZERO(test_task);
+	return retval;
 }
 
 static void __exit preemptirq_delay_exit(void)
 {
-	return;
+	kobject_put(preemptirq_delay_kobj);
 }
 
 module_init(preemptirq_delay_init)
-- 
2.17.1

