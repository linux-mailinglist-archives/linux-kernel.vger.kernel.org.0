Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417C38DC74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfHNR4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 13:56:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50330 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfHNR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:56:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHrsSB120495;
        Wed, 14 Aug 2019 17:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=O5qyQGqRzB3DH00IKQpFul126IdPssQOLGQ9cRhUOg0=;
 b=QgWzazUobbdayJG3M4gcf/s7qYr7PVsIABVqjIGm+5lKqLpKvqfF+xgMH3kfQqq/pBXP
 dSzYMGMgfIRQH7pnacro1FtHkyOX/oA8cyyUNGg3dOVHCQbb6VpJ+betMKgAycu152Io
 xb2LZ3nxOMzu0/RKThWWTJA4X2EA24kVXUYR3Lm+L8YwBqFS86RKGckxhUTRtBfBZOjR
 Yk3KrUD/AcWovKHEFOJu3Ncr64ms8T162ORYvwQXgdUJGg1lIXaCbg0cWH1j5vJcPXmC
 M0izSkn72oyq1nH2jF3NGN/GvthxtsBiIYptKQaGsWRn1T84PUfbCYVGUYtxuy3FS0Lp nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u9nvpef67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHrZ73112092;
        Wed, 14 Aug 2019 17:55:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ubwrhja5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7EHtcgS008260;
        Wed, 14 Aug 2019 17:55:38 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 10:55:38 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: [PATCH 1/5] tracing: Declare newly exported APIs in include/linux/trace.h
Date:   Wed, 14 Aug 2019 10:55:23 -0700
Message-Id: <1565805327-579-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the newly introduced and exported APIs in the header file -
include/linux/trace.h. Moving previous declarations from
kernel/trace/trace.h to include/linux/trace.h.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 include/linux/trace.h | 7 +++++++
 kernel/trace/trace.h  | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index b95ffb2..24fcf07 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -24,6 +24,13 @@ struct trace_export {
 int register_ftrace_export(struct trace_export *export);
 int unregister_ftrace_export(struct trace_export *export);
 
+struct trace_array;
+
+void trace_printk_init_buffers(void);
+int trace_array_printk(struct trace_array *tr, unsigned long ip,
+		const char *fmt, ...);
+struct trace_array *trace_array_create(const char *name);
+int trace_array_destroy(struct trace_array *tr);
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f086..66ff63e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -11,6 +11,7 @@
 #include <linux/mmiotrace.h>
 #include <linux/tracepoint.h>
 #include <linux/ftrace.h>
+#include <linux/trace.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/trace_seq.h>
 #include <linux/trace_events.h>
@@ -852,8 +853,6 @@ extern int trace_selftest_startup_branch(struct tracer *trace,
 extern int
 trace_array_vprintk(struct trace_array *tr,
 		    unsigned long ip, const char *fmt, va_list args);
-int trace_array_printk(struct trace_array *tr,
-		       unsigned long ip, const char *fmt, ...);
 int trace_array_printk_buf(struct ring_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...);
 void trace_printk_seq(struct trace_seq *s);
@@ -1869,7 +1868,6 @@ extern int trace_event_enable_disable(struct trace_event_file *file,
 extern const char *__stop___tracepoint_str[];
 
 void trace_printk_control(bool enabled);
-void trace_printk_init_buffers(void);
 void trace_printk_start_comm(void);
 int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
-- 
1.8.3.1

