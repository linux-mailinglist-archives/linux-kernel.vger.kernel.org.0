Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D313B3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 22:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgANVEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 16:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgANVDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E4E24688;
        Tue, 14 Jan 2020 21:03:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLf-000DC2-Ey; Tue, 14 Jan 2020 16:03:39 -0500
Message-Id: <20200114210339.338772772@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 25/26] Documentation: tracing: Add boot-time tracing document
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a documentation about boot-time tracing options in
boot config.

Link: http://lkml.kernel.org/r/157867246028.17873.8047384554383977870.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst |   2 +
 Documentation/trace/boottime-trace.rst   | 184 +++++++++++++++++++++++
 Documentation/trace/index.rst            |   1 +
 3 files changed, 187 insertions(+)
 create mode 100644 Documentation/trace/boottime-trace.rst

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index f7475df2a718..c8f7cd4cf44e 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _bootconfig:
+
 ==================
 Boot Configuration
 ==================
diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
new file mode 100644
index 000000000000..1d10fdebf1b2
--- /dev/null
+++ b/Documentation/trace/boottime-trace.rst
@@ -0,0 +1,184 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Boot-time tracing
+=================
+
+:Author: Masami Hiramatsu <mhiramat@kernel.org>
+
+Overview
+========
+
+Boot-time tracing allows users to trace boot-time process including
+device initialization with full features of ftrace including per-event
+filter and actions, histograms, kprobe-events and synthetic-events,
+and trace instances.
+Since kernel cmdline is not enough to control these complex features,
+this uses bootconfig file to describe tracing feature programming.
+
+Options in the Boot Config
+==========================
+
+Here is the list of available options list for boot time tracing in
+boot config file [1]_. All options are under "ftrace." or "kernel."
+refix. See kernel parameters for the options which starts
+with "kernel." prefix [2]_.
+
+.. [1] See :ref:`Documentation/admin-guide/bootconfig.rst <bootconfig>`
+.. [2] See :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
+
+Ftrace Global Options
+---------------------
+
+Ftrace global options have "kernel." prefix in boot config, which means
+these options are passed as a part of kernel legacy command line.
+
+kernel.tp_printk
+   Output trace-event data on printk buffer too.
+
+kernel.dump_on_oops [= MODE]
+   Dump ftrace on Oops. If MODE = 1 or omitted, dump trace buffer
+   on all CPUs. If MODE = 2, dump a buffer on a CPU which kicks Oops.
+
+kernel.traceoff_on_warning
+   Stop tracing if WARN_ON() occurs.
+
+kernel.fgraph_max_depth = MAX_DEPTH
+   Set MAX_DEPTH to maximum depth of fgraph tracer.
+
+kernel.fgraph_filters = FILTER[, FILTER2...]
+   Add fgraph tracing function filters.
+
+kernel.fgraph_notraces = FILTER[, FILTER2...]
+   Add fgraph non tracing function filters.
+
+
+Ftrace Per-instance Options
+---------------------------
+
+These options can be used for each instance including global ftrace node.
+
+ftrace.[instance.INSTANCE.]options = OPT1[, OPT2[...]]
+   Enable given ftrace options.
+
+ftrace.[instance.INSTANCE.]trace_clock = CLOCK
+   Set given CLOCK to ftrace's trace_clock.
+
+ftrace.[instance.INSTANCE.]buffer_size = SIZE
+   Configure ftrace buffer size to SIZE. You can use "KB" or "MB"
+   for that SIZE.
+
+ftrace.[instance.INSTANCE.]alloc_snapshot
+   Allocate snapshot buffer.
+
+ftrace.[instance.INSTANCE.]cpumask = CPUMASK
+   Set CPUMASK as trace cpu-mask.
+
+ftrace.[instance.INSTANCE.]events = EVENT[, EVENT2[...]]
+   Enable given events on boot. You can use a wild card in EVENT.
+
+ftrace.[instance.INSTANCE.]tracer = TRACER
+   Set TRACER to current tracer on boot. (e.g. function)
+
+ftrace.[instance.INSTANCE.]ftrace.filters
+   This will take an array of tracing function filter rules
+
+ftrace.[instance.INSTANCE.]ftrace.notraces
+   This will take an array of NON-tracing function filter rules
+
+
+Ftrace Per-Event Options
+------------------------
+
+These options are setting per-event options.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable
+   Enables GROUP:EVENT tracing.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER
+   Set FILTER rule to the GROUP:EVENT.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.actions = ACTION[, ACTION2[...]]
+   Set ACTIONs to the GROUP:EVENT.
+
+ftrace.[instance.INSTANCE.]event.kprobes.EVENT.probes = PROBE[, PROBE2[...]]
+   Defines new kprobe event based on PROBEs. It is able to define
+   multiple probes on one event, but those must have same type of
+   arguments. This option is available only for the event which
+   group name is "kprobes".
+
+ftrace.[instance.INSTANCE.]event.synthetic.EVENT.fields = FIELD[, FIELD2[...]]
+   Defines new synthetic event with FIELDs. Each field should be
+   "type varname".
+
+Note that kprobe and synthetic event definitions can be written under
+instance node, but those are also visible from other instances. So please
+take care for event name conflict.
+
+
+Examples
+========
+
+For example, to add filter and actions for each event, define kprobe
+events, and synthetic events with histogram, write a boot config like
+below::
+
+  ftrace.event {
+        task.task_newtask {
+                filter = "pid < 128"
+                enable
+        }
+        kprobes.vfs_read {
+                probes = "vfs_read $arg1 $arg2"
+                filter = "common_pid < 200"
+                enable
+        }
+        synthetic.initcall_latency {
+                fields = "unsigned long func", "u64 lat"
+                actions = "hist:keys=func.sym,lat:vals=lat:sort=lat"
+        }
+        initcall.initcall_start {
+                actions = "hist:keys=func:ts0=common_timestamp.usecs"
+        }
+        initcall.initcall_finish {
+                actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)"
+        }
+  }
+
+Also, boottime tracing supports "instance" node, which allows us to run
+several tracers for different purpose at once. For example, one tracer
+is for tracing functions start with "user\_", and others tracing "kernel\_"
+functions, you can write boot config as below::
+
+  ftrace.instance {
+        foo {
+                tracer = "function"
+                ftrace.filters = "user_*"
+        }
+        bar {
+                tracer = "function"
+                ftrace.filters = "kernel_*"
+        }
+  }
+
+The instance node also accepts event nodes so that each instance
+can customize its event tracing.
+
+This boot-time tracing also supports ftrace kernel parameters via boot
+config.
+For example, following kernel parameters::
+
+ trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M ftrace=function ftrace_filter="vfs*"
+
+This can be written in boot config like below::
+
+  kernel {
+        trace_options = sym-addr
+        trace_event = "initcall:*"
+        tp_printk
+        trace_buf_size = 1M
+        ftrace = function
+        ftrace_filter = "vfs*"
+  }
+
+Note that parameters start with "kernel" prefix instead of "ftrace".
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 04acd277c5f6..fa9e1c730f6a 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -19,6 +19,7 @@ Linux Tracing Technologies
    events-msr
    mmiotrace
    histogram
+   boottime-trace
    hwlat_detector
    intel_th
    stm
-- 
2.24.1


