Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89E81043F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfKTTJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 14:09:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38060 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfKTTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:09:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKJ8sLl015112;
        Wed, 20 Nov 2019 19:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=OTkMRHAtyKC5SZUnZGwA9Q6Ai3RevxRZGRghgoS4JYE=;
 b=dp9gURhUGOP0KlOQUOMxuuE5bDKNZnmwNt/0z13MgfX4de5nRleQvaju1DYeKeWotlhs
 Y/kEMC5dwsZQdCgatuIgoqtW6e7npxTfjleSbEN5nIOp/f6xUSxY7I8UrUHS9f5SUNJA
 N4PwRZHgLcyuxEVKIxKgwXS1l6GdcZAtZuHsU24hYPhVI7ANs2iGG9AnkBy0Xtn/wmDL
 F4pL+8X66faYkmtKa8EqoEZtN8iBFc0/rQnHWXgwjPYeujxwcEGE6lOUrz6srroUds2x
 QlzIqXJz8QyUpWjX8QOFqLs10ybRLRtVMdxAErZkHi1coXazukea3+gTi2Ihi1ixfItB DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wa9rqqh94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 19:08:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKJ4EEw031747;
        Wed, 20 Nov 2019 19:08:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wd46wxacw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 19:08:53 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAKJ8qVA014419;
        Wed, 20 Nov 2019 19:08:53 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 11:08:52 -0800
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: [PATCH 2/2] tracing: Sample module to demonstrate kernel access to Ftrace instances.
Date:   Wed, 20 Nov 2019 11:08:39 -0800
Message-Id: <1574276919-11119-3-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574276919-11119-2-git-send-email-divya.indi@oracle.com>
References: <1574276919-11119-1-git-send-email-divya.indi@oracle.com>
 <1574276919-11119-2-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a sample module to demonstrate the use of the newly introduced and
exported APIs to access Ftrace instances from within the kernel.

Newly introduced APIs used here -

1. Create/Lookup a trace array with the given name.
struct trace_array *trace_array_get_by_name(const char *name)

2. Destroy/Remove a trace array.
int trace_array_destroy(struct trace_array *tr)

4. Enable/Disable trace events:
int trace_array_set_clr_event(struct trace_array *tr, const char *system,
        const char *event, bool enable);

Exported APIs -
1. trace_printk equivalent for instances.
int trace_array_printk(struct trace_array *tr,
               unsigned long ip, const char *fmt, ...);

2. Helper function.
void trace_printk_init_buffers(void);

3. To decrement the reference counter.
void trace_array_put(struct trace_array *tr)

Sample output(contents of /sys/kernel/tracing/instances/sample-instance)
NOTE: Tracing disabled after ~5 sec)

                              _-----=> irqs-off
                             / _----=> need-resched
                            | / _---=> hardirq/softirq
                            || / _--=> preempt-depth
                            ||| /     delay
           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
              | |       |   ||||       |         |
sample-instance-1452  [002] ....    49.430948: simple_thread: trace_array_printk: count=0
sample-instance-1452  [002] ....    49.430951: sample_event: count value=0 at jiffies=4294716608
sample-instance-1452  [002] ....    50.454847: simple_thread: trace_array_printk: count=1
sample-instance-1452  [002] ....    50.454849: sample_event: count value=1 at jiffies=4294717632
sample-instance-1452  [002] ....    51.478748: simple_thread: trace_array_printk: count=2
sample-instance-1452  [002] ....    51.478750: sample_event: count value=2 at jiffies=4294718656
sample-instance-1452  [002] ....    52.502652: simple_thread: trace_array_printk: count=3
sample-instance-1452  [002] ....    52.502655: sample_event: count value=3 at jiffies=4294719680
sample-instance-1452  [002] ....    53.526533: simple_thread: trace_array_printk: count=4
sample-instance-1452  [002] ....    53.526535: sample_event: count value=4 at jiffies=4294720704
sample-instance-1452  [002] ....    54.550438: simple_thread: trace_array_printk: count=5
sample-instance-1452  [002] ....    55.574336: simple_thread: trace_array_printk: count=6

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 samples/Kconfig                              |   7 ++
 samples/Makefile                             |   1 +
 samples/ftrace_instance/Makefile             |   6 ++
 samples/ftrace_instance/sample-trace-array.c | 131 +++++++++++++++++++++++++++
 samples/ftrace_instance/sample-trace-array.h |  84 +++++++++++++++++
 5 files changed, 229 insertions(+)
 create mode 100644 samples/ftrace_instance/Makefile
 create mode 100644 samples/ftrace_instance/sample-trace-array.c
 create mode 100644 samples/ftrace_instance/sample-trace-array.h

diff --git a/samples/Kconfig b/samples/Kconfig
index d63cc8a..1c7864b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -20,6 +20,13 @@ config SAMPLE_TRACE_PRINTK
 	 This builds a module that calls trace_printk() and can be used to
 	 test various trace_printk() calls from a module.
 
+config SAMPLE_TRACE_ARRAY
+        tristate "Build sample module for kernel access to Ftrace instancess"
+	depends on EVENT_TRACING && m
+	help
+	 This builds a module that demonstrates the use of various APIs to
+	 access Ftrace instances from within the kernel.
+
 config SAMPLE_KOBJECT
 	tristate "Build kobject examples"
 	help
diff --git a/samples/Makefile b/samples/Makefile
index debf892..02c444e 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
 subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
+obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace_instance/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
diff --git a/samples/ftrace_instance/Makefile b/samples/ftrace_instance/Makefile
new file mode 100644
index 0000000..3603b13
--- /dev/null
+++ b/samples/ftrace_instance/Makefile
@@ -0,0 +1,6 @@
+# Builds a module that calls various routines to access Ftrace instances.
+# To use(as root):  insmod sample-trace-array.ko
+
+CFLAGS_sample-trace-array.o := -I$(src)
+
+obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace_instance/sample-trace-array.c b/samples/ftrace_instance/sample-trace-array.c
new file mode 100644
index 0000000..d523450
--- /dev/null
+++ b/samples/ftrace_instance/sample-trace-array.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/trace.h>
+#include <linux/trace_events.h>
+#include <linux/timer.h>
+#include <linux/err.h>
+#include <linux/jiffies.h>
+
+/*
+ * Any file that uses trace points, must include the header.
+ * But only one file, must include the header by defining
+ * CREATE_TRACE_POINTS first.  This will make the C code that
+ * creates the handles for the trace points.
+ */
+#define CREATE_TRACE_POINTS
+#include "sample-trace-array.h"
+
+struct trace_array *tr;
+static void mytimer_handler(struct timer_list *unused);
+static struct task_struct *simple_tsk;
+
+/*
+ * mytimer: Timer setup to disable tracing for event "sample_event". This
+ * timer is only for the purposes of the sample module to demonstrate access of
+ * Ftrace instances from within kernel.
+ */
+static DEFINE_TIMER(mytimer, mytimer_handler);
+
+static void mytimer_handler(struct timer_list *unused)
+{
+	/*
+	 * Disable tracing for event "sample_event".
+	 */
+	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event",
+			false);
+}
+
+static void simple_thread_func(int count)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(HZ);
+
+	/*
+	 * Printing count value using trace_array_printk() - trace_printk()
+	 * equivalent for the instance buffers.
+	 */
+	trace_array_printk(tr, _THIS_IP_, "trace_array_printk: count=%d\n",
+			count);
+	/*
+	 * Tracepoint for event "sample_event". This will print the
+	 * current value of count and current jiffies.
+	 */
+	trace_sample_event(count, jiffies);
+}
+
+static int simple_thread(void *arg)
+{
+	int count = 0;
+	unsigned long delay = msecs_to_jiffies(5000);
+
+	/*
+	 * Enable tracing for "sample_event".
+	 */
+	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event", true);
+
+	/*
+	 * Adding timer - mytimer. This timer will disable tracing after
+	 * delay seconds.
+	 *
+	 */
+	add_timer(&mytimer);
+	mod_timer(&mytimer, jiffies+delay);
+
+	while (!kthread_should_stop())
+		simple_thread_func(count++);
+
+	del_timer(&mytimer);
+
+	/*
+	 * trace_array_put() decrements the reference counter associated with
+	 * the trace array - "tr". We are done using the trace array, hence
+	 * decrement the reference counter so that it can be destroyed using
+	 * trace_array_destroy().
+	 */
+	trace_array_put(tr);
+
+	return 0;
+}
+
+static int __init sample_trace_array_init(void)
+{
+	/*
+	 * Return a pointer to the trace array with name "sample-instance" if it
+	 * exists, else create a new trace array.
+	 *
+	 * NOTE: This function increments the reference counter
+	 * associated with the trace array - "tr".
+	 */
+	tr = trace_array_get_by_name("sample-instance");
+
+	if (!tr)
+		return -1;
+	/*
+	 * If context specific per-cpu buffers havent already been allocated.
+	 */
+	trace_printk_init_buffers();
+
+	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
+	if (IS_ERR(simple_tsk))
+		return -1;
+	return 0;
+}
+
+static void __exit sample_trace_array_exit(void)
+{
+	kthread_stop(simple_tsk);
+
+	/*
+	 * We are unloading our module and no longer require the trace array.
+	 * Remove/destroy "tr" using trace_array_destroy()
+	 */
+	trace_array_destroy(tr);
+}
+
+module_init(sample_trace_array_init);
+module_exit(sample_trace_array_exit);
+
+MODULE_AUTHOR("Divya Indi");
+MODULE_DESCRIPTION("Sample module for kernel access to Ftrace instances");
+MODULE_LICENSE("GPL");
diff --git a/samples/ftrace_instance/sample-trace-array.h b/samples/ftrace_instance/sample-trace-array.h
new file mode 100644
index 0000000..6f89624
--- /dev/null
+++ b/samples/ftrace_instance/sample-trace-array.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * If TRACE_SYSTEM is defined, that will be the directory created
+ * in the ftrace directory under /sys/kernel/tracing/events/<system>
+ *
+ * The define_trace.h below will also look for a file name of
+ * TRACE_SYSTEM.h where TRACE_SYSTEM is what is defined here.
+ * In this case, it would look for sample-trace.h
+ *
+ * If the header name will be different than the system name
+ * (as in this case), then you can override the header name that
+ * define_trace.h will look up by defining TRACE_INCLUDE_FILE
+ *
+ * This file is called sample-trace-array.h but we want the system
+ * to be called "sample-subsystem". Therefore we must define the name of this
+ * file:
+ *
+ * #define TRACE_INCLUDE_FILE sample-trace-array
+ *
+ * As we do in the bottom of this file.
+ *
+ * Notice that TRACE_SYSTEM should be defined outside of #if
+ * protection, just like TRACE_INCLUDE_FILE.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sample-subsystem
+
+/*
+ * TRACE_SYSTEM is expected to be a C valid variable (alpha-numeric
+ * and underscore), although it may start with numbers. If for some
+ * reason it is not, you need to add the following lines:
+ */
+#undef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR sample_subsystem
+
+/*
+ * But the above is only needed if TRACE_SYSTEM is not alpha-numeric
+ * and underscored. By default, TRACE_SYSTEM_VAR will be equal to
+ * TRACE_SYSTEM. As TRACE_SYSTEM_VAR must be alpha-numeric, if
+ * TRACE_SYSTEM is not, then TRACE_SYSTEM_VAR must be defined with
+ * only alpha-numeric and underscores.
+ *
+ * The TRACE_SYSTEM_VAR is only used internally and not visible to
+ * user space.
+ */
+
+/*
+ * Notice that this file is not protected like a normal header.
+ * We also must allow for rereading of this file. The
+ *
+ *  || defined(TRACE_HEADER_MULTI_READ)
+ *
+ * serves this purpose.
+ */
+#if !defined(_SAMPLE_TRACE_ARRAY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _SAMPLE_TRACE_ARRAY_H
+
+#include <linux/tracepoint.h>
+TRACE_EVENT(sample_event,
+
+	TP_PROTO(int count, unsigned long time),
+
+	TP_ARGS(count, time),
+
+	TP_STRUCT__entry(
+		__field(int, count)
+		__field(unsigned long, time)
+	),
+
+	TP_fast_assign(
+		__entry->count = count;
+		__entry->time = time;
+	),
+
+	TP_printk("count value=%d at jiffies=%lu", __entry->count,
+		__entry->time)
+	);
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE sample-trace-array
+#include <trace/define_trace.h>
-- 
1.8.3.1

