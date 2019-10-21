Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E1DEE12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfJUNlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbfJUNlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DD621A4A;
        Mon, 21 Oct 2019 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665305;
        bh=VPPOmTTd0Ef8+Q5kLGWYN9sQTCtRSIT8I/QHiNjobSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfzHD2ZlYnrT1TFvmVlMAC/qKVyyhNkChwifEx2/v6K1XFRulAg3JYjgDj0BuaLcD
         IBFkFG/0ZU7LanMC8/sKHgErPwJumM1KsCA1R/UKsGYiWdeXf6Dw7d1M0Ustg6KJ4f
         j25hGVz1u+y7frWfcm0bG0CY5lKvSaD08+lLKtmI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 56/57] perf trace: Wire up strarray__strtoul_flags()
Date:   Mon, 21 Oct 2019 10:38:33 -0300
Message-Id: <20191021133834.25998-57-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now anything that uses STRARRAY_FLAGS, like the 'fsmount' syscall will
support mapping or-ed strings back to a value that can be used in a
filter.

In some cases, where STRARRAY_FLAGS isn't used but instead the scnprintf
is a special one because of specific needs, like for mmap, then one has
to set the ->pars to the strarray. See the next cset.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-r2lpqo7dfsrhi4ll0npsb3u7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 6 ++++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 73c5c14b52eb..7bb84c4a8f29 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -540,6 +540,11 @@ bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *ar
 	return strarray__strtoul(arg->parm, bf, size, ret);
 }
 
+bool syscall_arg__strtoul_strarray_flags(char *bf, size_t size, struct syscall_arg *arg, u64 *ret)
+{
+	return strarray__strtoul_flags(arg->parm, bf, size, ret);
+}
+
 bool syscall_arg__strtoul_strarrays(char *bf, size_t size, struct syscall_arg *arg, u64 *ret)
 {
 	return strarrays__strtoul(arg->parm, bf, size, ret);
@@ -882,6 +887,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 #define STRARRAY_FLAGS(name, array) \
 	  { .scnprintf	= SCA_STRARRAY_FLAGS, \
+	    .strtoul	= STUL_STRARRAY_FLAGS, \
 	    .parm	= &strarray__##array, }
 
 #include "trace/beauty/arch_errno_names.c"
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index e12b2228b892..5a61043c2ff7 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -126,6 +126,9 @@ size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct sysca
 bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
 #define STUL_STRARRAY syscall_arg__strtoul_strarray
 
+bool syscall_arg__strtoul_strarray_flags(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
+#define STUL_STRARRAY_FLAGS syscall_arg__strtoul_strarray_flags
+
 bool syscall_arg__strtoul_strarrays(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
 #define STUL_STRARRAYS syscall_arg__strtoul_strarrays
 
-- 
2.21.0

