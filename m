Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8B1639CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 03:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBSCEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 21:04:45 -0500
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:37802 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727208AbgBSCEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:04:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 64FE31802DF6C;
        Wed, 19 Feb 2020 02:04:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1500:1515:1535:1544:1711:1730:1747:1777:1792:2393:2559:2562:2901:3138:3139:3140:3141:3142:3355:3865:3867:3868:4321:5007:6120:6261:7903:8660:10004:10848:11026:11473:11658:11914:12043:12291:12296:12297:12438:12555:12683:12895:13148:13230:13894:14110:14181:14721:21080:21451:21627:21990:30029:30054:30080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mice82_807752c462551
X-Filterd-Recvd-Size: 5466
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 02:04:42 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] trace: Move data to new section _ftrace_data
Date:   Tue, 18 Feb 2020 18:03:17 -0800
Message-Id: <45725c93cb9bc3cf78e2c6304a9d04ee92eda2b4.1582077699.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1582077698.git.joe@perches.com>
References: <cover.1582077698.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the data used by tracing to a separate section to
help identify and perhaps control access to tracing data.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/trace/trace_events.h | 31 ++++++++++++++++++++++---------
 kernel/trace/trace_export.c  | 10 +++++++---
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 502c7b..361999f 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -369,7 +369,9 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 									\
 	return trace_handle_return(s);					\
 }									\
-static struct trace_event_functions trace_event_type_funcs_##call = {	\
+static struct trace_event_functions					\
+__attribute__((section("_ftrace_data")))				\
+trace_event_type_funcs_##call = {					\
 	.trace			= trace_raw_output_##call,		\
 };
 
@@ -439,9 +441,12 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
-static struct trace_event_fields trace_event_fields_##call[] = {	\
+static struct trace_event_fields					\
+__attribute__((section("_ftrace_data")))				\
+trace_event_fields_##call[] = {						\
 	tstruct								\
-	{} };
+	{}								\
+};
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)
@@ -746,7 +751,8 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 _TRACE_PERF_PROTO(call, PARAMS(proto));					\
-static char print_fmt_##call[] = print;					\
+static char __attribute__((section("_ftrace_data")))			\
+print_fmt_##call[] = print;						\
 static struct trace_event_class __used __refdata event_class_##call = { \
 	.system			= TRACE_SYSTEM_STRING,			\
 	.fields_array		= trace_event_fields_##call,		\
@@ -760,7 +766,9 @@ static struct trace_event_class __used __refdata event_class_##call = { \
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
-static struct trace_event_call __used event_##call = {			\
+static struct trace_event_call __used					\
+__attribute__((section("_ftrace_data")))				\
+event_##call = {							\
 	.class			= &event_class_##template,		\
 	{								\
 		.tp			= &__tracepoint_##call,		\
@@ -770,14 +778,18 @@ static struct trace_event_call __used event_##call = {			\
 	.flags			= TRACE_EVENT_FL_TRACEPOINT,		\
 };									\
 static struct trace_event_call __used					\
-__attribute__((section("_ftrace_events"))) *__event_##call = &event_##call
+__attribute__((section("_ftrace_events")))				\
+*__event_##call = &event_##call
 
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, call, proto, args, print)		\
 									\
-static char print_fmt_##call[] = print;					\
+static char __attribute__((section("_ftrace_data")))			\
+print_fmt_##call[] = print;						\
 									\
-static struct trace_event_call __used event_##call = {			\
+static struct trace_event_call __used					\
+__attribute__((section("_ftrace_data")))				\
+event_##call = {							\
 	.class			= &event_class_##template,		\
 	{								\
 		.tp			= &__tracepoint_##call,		\
@@ -787,6 +799,7 @@ static struct trace_event_call __used event_##call = {			\
 	.flags			= TRACE_EVENT_FL_TRACEPOINT,		\
 };									\
 static struct trace_event_call __used					\
-__attribute__((section("_ftrace_events"))) *__event_##call = &event_##call
+__attribute__((section("_ftrace_events")))				\
+*__event_##call = &event_##call
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 77ce5a..90af7c9 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -111,9 +111,12 @@ static void __always_unused ____ftrace_check_##name(void)		\
 
 #undef FTRACE_ENTRY
 #define FTRACE_ENTRY(name, struct_name, id, tstruct, print)		\
-static struct trace_event_fields ftrace_event_fields_##name[] = {	\
+static struct trace_event_fields					\
+__attribute__((section("_ftrace_data")))				\
+ftrace_event_fields_##name[] = {					\
 	tstruct								\
-	{} };
+	{}								\
+};
 
 #include "trace_entries.h"
 
@@ -150,7 +153,8 @@ static struct trace_event_class __refdata event_class_ftrace_##call = {	\
 	.reg			= regfn,				\
 };									\
 									\
-struct trace_event_call __used event_##call = {				\
+struct trace_event_call __used __attribute((section("_ftrace_data")))	\
+event_##call = {							\
 	.class			= &event_class_ftrace_##call,		\
 	{								\
 		.name			= #call,			\
-- 
2.24.0

