Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01BDEDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfJUNji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbfJUNjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA8F21872;
        Mon, 21 Oct 2019 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665174;
        bh=4N6w7Fo7XN9S+sqU/NYumbkrW5+PoAemvrXz1ejBPQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2gEZ/dB6y8eBG3VyPjLlnMmj4e3JkqIe5HmJo2ODDpeS69fC+AGnDpk7PshtVTVj3
         WCmLUpnH86eFoc39l1w3jNahUijzYJYhM5ZunnwlCuC1pClQN9jdi8RAOumM/YXZ17
         vMXonukwsNpf3CVl28pZUtPkpnrG388EA/Mhw+nM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 16/57] perf string: Export asprintf__tp_filter_pids()
Date:   Mon, 21 Oct 2019 10:37:53 -0300
Message-Id: <20191021133834.25998-17-acme@kernel.org>
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

Will be used directly in 'perf trace' for setting up the command line
argv array to pass to cmd_record, as this was how 'perf trace record'
was implemented, following the model used in 'perf kvm record', 'perf
sched record', etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w3cuwjs63lxf5zpryy3145uv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c  | 3 ++-
 tools/perf/util/string2.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8793b4e322b0..0f9cd703e725 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -21,6 +21,7 @@
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
+#include "util/string2.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -959,7 +960,7 @@ int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
-static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
+char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
 	size_t i;
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 708805f5573e..73df616ced43 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -4,6 +4,7 @@
 
 #include <linux/string.h>
 #include <linux/types.h>
+#include <sys/types.h> // pid_t
 #include <stddef.h>
 #include <string.h>
 
@@ -32,6 +33,8 @@ static inline char *asprintf_expr_not_in_ints(const char *var, size_t nints, int
 	return asprintf_expr_inout_ints(var, false, nints, ints);
 }
 
+char *asprintf__tp_filter_pids(size_t npids, pid_t *pids);
+
 char *strpbrk_esc(char *str, const char *stopset);
 char *strdup_esc(const char *str);
 
-- 
2.21.0

