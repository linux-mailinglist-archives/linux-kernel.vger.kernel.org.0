Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86D137802
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 21:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgAJUfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 15:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgAJUf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:28 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7704220838;
        Fri, 10 Jan 2020 20:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688528;
        bh=YhBMJIvMTYGFSuOdcqnzo+uNNjCw+xoOLW1GRlj10UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=wSAeCmOuQGLSGyI5diKsWO2qdI0YSsfUVrbSZXVrVLSBSyL6imA7wOkGUcwNI2l1t
         J7BeUmX9kzXE0+KDgyngR40HH7UGJ54DzeiYWepmdBJJIDgpbeneUpKGEEKA5HJlSv
         WmN2q9JscdvJTuD/bToPABb5OAz9+G1C/UGkyNZQ=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 01/12] tracing: Add trace_array_find() to find instance trace arrays
Date:   Fri, 10 Jan 2020 14:35:07 -0600
Message-Id: <24b84188ea96d0ffddfd803b567a536f3fb9577e.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new trace_array_find() function that can be used to find a trace
array given the instance name, and replace existing code that does the
same thing with it.

Also make it available for use outside of trace.c.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c | 30 ++++++++++++++++++++----------
 kernel/trace/trace.h |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23459d53d576..3da836ef23ee 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8455,6 +8455,21 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
+/* Must have trace_types_lock held */
+struct trace_array *trace_array_find(const char *name)
+{
+	struct trace_array *tr, *found = NULL;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, name) == 0) {
+			found = tr;
+			break;
+		}
+	}
+
+	return found;
+}
+
 static struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
@@ -8531,10 +8546,8 @@ static int instance_mkdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -EEXIST;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0)
-			goto out_unlock;
-	}
+	if (trace_array_find(name))
+		goto out_unlock;
 
 	tr = trace_array_create(name);
 
@@ -8658,12 +8671,9 @@ static int instance_rmdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -ENODEV;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0) {
-			ret = __remove_instance(tr);
-			break;
-		}
-	}
+	tr = trace_array_find(name);
+	if (tr)
+		ret = __remove_instance(tr);
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 63bf60f79398..f37ef6524821 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -346,6 +346,7 @@ extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
 extern int tracing_check_open_get_tr(struct trace_array *tr);
+extern struct trace_array *trace_array_find(const char *name);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
-- 
2.14.1

