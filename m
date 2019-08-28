Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593E59F9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 07:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfH1F0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 01:26:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46707 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfH1F0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:26:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id z51so1466163edz.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y90bCa/d7k2F5GCP68IZqACDWsMgvWKD3m+cc4Aso8w=;
        b=nUiPuvsjgo0x0G+3p93DjTxMg1oku0XihQfxrJubEGGbW0r8TMaAWdqFqBcNGD8eOs
         zYr+5dwh1FjEoBjzetSuJci1U6VKtIUA5Q2XFZ3sgWyp3EI4qJjegDHKzkIHqdonzimK
         J8A9wMBYHtyZGR4Z1E0Pa6yO8iUC1/lem+zwMjE12DO48/K8TsTQn6HoDVz29ufoBvIW
         Yu7MpFfDJhCyVi7HD8ZefRkPKSrxXSFEn71X7nK4kQQ55U6LV26EtKT7YZKZMOjMrV4L
         A99fgJPk1uCCQkzjtorFD0GYZfcz7f6WVRX/t6RUV3EBq9nDs5jPteeSeDdaciLzf0J6
         vHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y90bCa/d7k2F5GCP68IZqACDWsMgvWKD3m+cc4Aso8w=;
        b=Dyq7cq5asgCcewcH5hJ/lhxQykc3tztj+A11tS2Me47cTjuUUPvOWA1aK+FkUZ0idN
         GtGrX/61ZEeLEWZBZmsP90LagETAXB2Exdnx8mvFJ/BDz7J64E6Y1zLo7F0fEkDFwb+2
         iMORJoWQv6hpUWImM+4O0LoaskWDwySp0mHfsNF990aOuh3pYMyCwmysMSH/ob+5kB5q
         b+KvndcX6W3wwDal7rJmAOEHy9QWrVnC79rMIt2LxzoBUlXxVpFOcT2zJFIBY/f7C7Gp
         1v8qtofhrCiNDB5V54CoTkltww97dneF/40ulpLq3zeVtjtslSr5VyWNJLYm3TMr6SGD
         dQNA==
X-Gm-Message-State: APjAAAWLo+pRvo5+2F/syN1i3m5/Z1TNzmeg+/+z3FQdjtKQUZur4LJ6
        qfa0f3YOQdqh/nEk8SBVNLIEEg==
X-Google-Smtp-Source: APXvYqx2YnGPmRyVLV2EkhHwXX4ywcuno8YHiYxdSqhvi98OAHSidZEolAxjBuiIqKIES7vkj/w91A==
X-Received: by 2002:a17:906:c445:: with SMTP id ck5mr1493551ejb.15.1566969974110;
        Tue, 27 Aug 2019 22:26:14 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id la5sm213063ejb.30.2019.08.27.22.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 22:26:13 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 1/3] tracing: correct kdoc formats
Date:   Tue, 27 Aug 2019 22:25:47 -0700
Message-Id: <20190828052549.2472-2-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828052549.2472-1-jakub.kicinski@netronome.com>
References: <20190828052549.2472-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following kdoc warnings:

kernel/trace/trace.c:1579: warning: Function parameter or member 'tr' not described in 'update_max_tr_single'
kernel/trace/trace.c:1579: warning: Function parameter or member 'tsk' not described in 'update_max_tr_single'
kernel/trace/trace.c:1579: warning: Function parameter or member 'cpu' not described in 'update_max_tr_single'
kernel/trace/trace.c:1776: warning: Function parameter or member 'type' not described in 'register_tracer'
kernel/trace/trace.c:2239: warning: Function parameter or member 'task' not described in 'tracing_record_taskinfo'
kernel/trace/trace.c:2239: warning: Function parameter or member 'flags' not described in 'tracing_record_taskinfo'
kernel/trace/trace.c:2269: warning: Function parameter or member 'prev' not described in 'tracing_record_taskinfo_sched_switch'
kernel/trace/trace.c:2269: warning: Function parameter or member 'next' not described in 'tracing_record_taskinfo_sched_switch'
kernel/trace/trace.c:2269: warning: Function parameter or member 'flags' not described in 'tracing_record_taskinfo_sched_switch'
kernel/trace/trace.c:3078: warning: Function parameter or member 'ip' not described in 'trace_vbprintk'
kernel/trace/trace.c:3078: warning: Function parameter or member 'fmt' not described in 'trace_vbprintk'
kernel/trace/trace.c:3078: warning: Function parameter or member 'args' not described in 'trace_vbprintk'

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 kernel/trace/trace.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 642474b26ba7..947ba433865f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1567,9 +1567,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 
 /**
  * update_max_tr_single - only copy one trace over, and reset the rest
- * @tr - tracer
- * @tsk - task with the latency
- * @cpu - the cpu of the buffer to copy.
+ * @tr: tracer
+ * @tsk: task with the latency
+ * @cpu: the cpu of the buffer to copy.
  *
  * Flip the trace of a single CPU buffer between the @tr and the max_tr.
  */
@@ -1767,7 +1767,7 @@ static void __init apply_trace_boot_options(void);
 
 /**
  * register_tracer - register a tracer with the ftrace system.
- * @type - the plugin for the tracer
+ * @type: the plugin for the tracer
  *
  * Register a new plugin tracer.
  */
@@ -2230,9 +2230,9 @@ static bool tracing_record_taskinfo_skip(int flags)
 /**
  * tracing_record_taskinfo - record the task info of a task
  *
- * @task  - task to record
- * @flags - TRACE_RECORD_CMDLINE for recording comm
- *        - TRACE_RECORD_TGID for recording tgid
+ * @task:  task to record
+ * @flags: TRACE_RECORD_CMDLINE for recording comm
+ *         TRACE_RECORD_TGID for recording tgid
  */
 void tracing_record_taskinfo(struct task_struct *task, int flags)
 {
@@ -2258,10 +2258,10 @@ void tracing_record_taskinfo(struct task_struct *task, int flags)
 /**
  * tracing_record_taskinfo_sched_switch - record task info for sched_switch
  *
- * @prev - previous task during sched_switch
- * @next - next task during sched_switch
- * @flags - TRACE_RECORD_CMDLINE for recording comm
- *          TRACE_RECORD_TGID for recording tgid
+ * @prev: previous task during sched_switch
+ * @next: next task during sched_switch
+ * @flags: TRACE_RECORD_CMDLINE for recording comm
+ *         TRACE_RECORD_TGID for recording tgid
  */
 void tracing_record_taskinfo_sched_switch(struct task_struct *prev,
 					  struct task_struct *next, int flags)
@@ -3072,7 +3072,9 @@ static void trace_printk_start_stop_comm(int enabled)
 
 /**
  * trace_vbprintk - write binary msg to tracing buffer
- *
+ * @ip:    The address of the caller
+ * @fmt:   The string format to write to the buffer
+ * @args:  Arguments for @fmt
  */
 int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 {
-- 
2.21.0

