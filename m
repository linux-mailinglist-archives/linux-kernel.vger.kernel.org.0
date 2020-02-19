Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56D01639CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 03:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgBSCEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 21:04:47 -0500
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:40707 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727208AbgBSCEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:04:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C1DDE2C7C;
        Wed, 19 Feb 2020 02:04:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:2:41:69:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1605:1606:1730:1747:1777:1792:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3867:3868:4117:4321:5007:6120:6261:8660:10004:10848:11026:11473:11658:11914:12043:12296:12297:12438:12555:12895:12986:13148:13230:13894:21080:21433:21451:21627:21990:30029:30054:30080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bun57_80a920a39cb55
X-Filterd-Recvd-Size: 6568
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 02:04:44 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] trace_events/trace_export: Use __section
Date:   Tue, 18 Feb 2020 18:03:18 -0800
Message-Id: <71e7010925c59cd65273b4dbd3ec8ec8516d65cd.1582077699.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1582077698.git.joe@perches.com>
References: <cover.1582077698.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert __attribute__((section("foo"))) to __section(foo) to be a
bit more kernel style compliant and improve readability a tiny bit.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/trace/trace_events.h | 29 +++++++++++------------------
 kernel/trace/trace_export.c  |  9 ++++-----
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 361999f..a5b2eb 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -45,7 +45,7 @@ TRACE_MAKE_SYSTEM_STR();
 		.eval_value = a				\
 	};						\
 	static struct trace_eval_map __used		\
-	__attribute__((section("_ftrace_eval_map")))	\
+	__section(_ftrace_eval_map)			\
 	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
 
 #undef TRACE_DEFINE_SIZEOF
@@ -58,7 +58,7 @@ TRACE_MAKE_SYSTEM_STR();
 		.eval_value = sizeof(a)			\
 	};						\
 	static struct trace_eval_map __used		\
-	__attribute__((section("_ftrace_eval_map")))	\
+	__section(_ftrace_eval_map)			\
 	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
 
 /*
@@ -369,8 +369,7 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 									\
 	return trace_handle_return(s);					\
 }									\
-static struct trace_event_functions					\
-__attribute__((section("_ftrace_data")))				\
+static struct trace_event_functions __section(_ftrace_data)		\
 trace_event_type_funcs_##call = {					\
 	.trace			= trace_raw_output_##call,		\
 };
@@ -441,8 +440,7 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
-static struct trace_event_fields					\
-__attribute__((section("_ftrace_data")))				\
+static struct trace_event_fields __section(_ftrace_data)		\
 trace_event_fields_##call[] = {						\
 	tstruct								\
 	{}								\
@@ -624,7 +622,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
  * // its only safe to use pointers when doing linker tricks to
  * // create an array.
  * static struct trace_event_call __used
- * __attribute__((section("_ftrace_events"))) *__event_<call> = &event_<call>;
+ * __section(_ftrace_events) *__event_<call> = &event_<call>;
  *
  */
 
@@ -751,7 +749,7 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 _TRACE_PERF_PROTO(call, PARAMS(proto));					\
-static char __attribute__((section("_ftrace_data")))			\
+static char __section(_ftrace_data)					\
 print_fmt_##call[] = print;						\
 static struct trace_event_class __used __refdata event_class_##call = { \
 	.system			= TRACE_SYSTEM_STRING,			\
@@ -766,8 +764,7 @@ static struct trace_event_class __used __refdata event_class_##call = { \
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
-static struct trace_event_call __used					\
-__attribute__((section("_ftrace_data")))				\
+static struct trace_event_call __used __section(_ftrace_data)		\
 event_##call = {							\
 	.class			= &event_class_##template,		\
 	{								\
@@ -777,18 +774,15 @@ event_##call = {							\
 	.print_fmt		= print_fmt_##template,			\
 	.flags			= TRACE_EVENT_FL_TRACEPOINT,		\
 };									\
-static struct trace_event_call __used					\
-__attribute__((section("_ftrace_events")))				\
+static struct trace_event_call __used __section(_ftrace_events)		\
 *__event_##call = &event_##call
 
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, call, proto, args, print)		\
-									\
-static char __attribute__((section("_ftrace_data")))			\
+static char __section(_ftrace_data)					\
 print_fmt_##call[] = print;						\
 									\
-static struct trace_event_call __used					\
-__attribute__((section("_ftrace_data")))				\
+static struct trace_event_call __used __section(_ftrace_data)		\
 event_##call = {							\
 	.class			= &event_class_##template,		\
 	{								\
@@ -798,8 +792,7 @@ event_##call = {							\
 	.print_fmt		= print_fmt_##call,			\
 	.flags			= TRACE_EVENT_FL_TRACEPOINT,		\
 };									\
-static struct trace_event_call __used					\
-__attribute__((section("_ftrace_events")))				\
+static struct trace_event_call __used __section(_ftrace_events)		\
 *__event_##call = &event_##call
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 90af7c9..e38a672 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -111,8 +111,7 @@ static void __always_unused ____ftrace_check_##name(void)		\
 
 #undef FTRACE_ENTRY
 #define FTRACE_ENTRY(name, struct_name, id, tstruct, print)		\
-static struct trace_event_fields					\
-__attribute__((section("_ftrace_data")))				\
+static struct trace_event_fields __section(_ftrace_data)		\
 ftrace_event_fields_##name[] = {					\
 	tstruct								\
 	{}								\
@@ -153,7 +152,7 @@ static struct trace_event_class __refdata event_class_ftrace_##call = {	\
 	.reg			= regfn,				\
 };									\
 									\
-struct trace_event_call __used __attribute((section("_ftrace_data")))	\
+struct trace_event_call __used __section(_ftrace_data)			\
 event_##call = {							\
 	.class			= &event_class_ftrace_##call,		\
 	{								\
@@ -163,8 +162,8 @@ event_##call = {							\
 	.print_fmt		= print,				\
 	.flags			= TRACE_EVENT_FL_IGNORE_ENABLE,		\
 };									\
-static struct trace_event_call __used						\
-__attribute__((section("_ftrace_events"))) *__event_##call = &event_##call;
+static struct trace_event_call * __used __section(_ftrace_events)	\
+__event_##call = &event_##call;
 
 #undef FTRACE_ENTRY
 #define FTRACE_ENTRY(call, struct_name, etype, tstruct, print)		\
-- 
2.24.0

