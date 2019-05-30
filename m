Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE32F835
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfE3IDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:03:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45995 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:03:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U83FAu2901342
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:03:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U83FAu2901342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203396;
        bh=NRJWcde2jKWRjwmJQ0pTxVArWkbJNzjOKychCYNKfaQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=fyKw3IczQaFu5v/xF4EqjCpSpuRzynqbZYYBAQ5/PEcocK48SYEij8sF3O0ssvq6l
         pFGY0RNvUtOpqCtRYTVQkDk6zxdPJYpCOktY/ujUb0DQFjAcI0NrQLIB2FLw9HKy6D
         KGaJykO+q9UysS9M05zuBH1m2ti8U6GtLbDFKUBtTDK6Dbvqs8H9nQblvyptMH8XOh
         EfB92e/LR1SH1aA+z51jmxncCBSSKlAcIJWEoIKq58fWny3pvZOrJ0OHqq6iEH6nOy
         IkWivyJr23ruEsW82spkcltDkZDyM4BwDtx5H64TW32CqbuWrEL1zQs0w46sQDAfC3
         I081gQzqYFRFQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U83EP12901336;
        Thu, 30 May 2019 01:03:14 -0700
Date:   Thu, 30 May 2019 01:03:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-nnt25wkpkow2w0yefhi6sb7q@git.kernel.org>
Cc:     adrian.hunter@intel.com, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org, brendan.d.gregg@gmail.com, mingo@kernel.org,
        lclaudio@redhat.com
Reply-To: acme@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
          lclaudio@redhat.com, mingo@kernel.org, brendan.d.gregg@gmail.com,
          jolsa@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Introduce
 syscall_arg__scnprintf_strarray_flags
Git-Commit-ID: f5b91dbba1a51d30a3fe78a5c6096392fa99471e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f5b91dbba1a51d30a3fe78a5c6096392fa99471e
Gitweb:     https://git.kernel.org/tip/f5b91dbba1a51d30a3fe78a5c6096392fa99471e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 23 May 2019 18:05:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf trace: Introduce syscall_arg__scnprintf_strarray_flags

So that one can just define a strarray and process it as a set of flags,
similar to syscall_arg__scnprintf_strarray() with plain arrays.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nnt25wkpkow2w0yefhi6sb7q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 5 +++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 87b6dd3c33f5..16bb8c04c689 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -403,6 +403,11 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 #define SCA_STRARRAY syscall_arg__scnprintf_strarray
 
+size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	return strarray__scnprintf_flags(arg->parm, bf, size, arg->show_string_prefix, arg->val);
+}
+
 size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
 	size_t printed;
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 90c1ee708dc9..ad874e0beba5 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -108,6 +108,9 @@ struct syscall_arg {
 
 unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
 
+size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_STRARRAY_FLAGS syscall_arg__scnprintf_strarray_flags
+
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
 
