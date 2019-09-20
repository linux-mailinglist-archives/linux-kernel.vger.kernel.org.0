Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFFAB9203
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbfITO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 10:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389701AbfITO1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:27:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36DE5207E0;
        Fri, 20 Sep 2019 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989635;
        bh=92bPkqsTEmQUcN6clhYV++mR5dIp5caEa0LsHoRbgro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrQ3PJOuZp8LPxl1+RgClYc+ttsZg2lZhvOTC+c5fDxPDJaHFOX+wdD/OKiEdGPsX
         aGg/4UGjdhtSF2QgPSXcrTI8c3W52A+C2NS4OdOmpOoUdE4o5xuPu8Su1fxfF5o9bK
         AD95ZnZ+wRYDweggCugG80Ut/4MnV3iDOOI0qr44=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/31] perf kvm: Move kvm-stat header file from conditional inclusion to common include section
Date:   Fri, 20 Sep 2019 11:25:40 -0300
Message-Id: <20190920142542.12047-30-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Move kvm-stat header file to the common include section, and make the
definitions in the header file under the conditional inclusion `#ifdef
HAVE_KVM_STAT_SUPPORT`.

This helps to define other 'perf kvm' related function prototypes in
kvm-stat header file, which may not need kvm-stat support.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-By: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20190718181749.30612-1-anju@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c   | 2 +-
 tools/perf/util/kvm-stat.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ac6d6e061dc5..2b822be87673 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -21,6 +21,7 @@
 #include "util/top.h"
 #include "util/data.h"
 #include "util/ordered-events.h"
+#include "util/kvm-stat.h"
 #include "ui/ui.h"
 
 #include <sys/prctl.h>
@@ -59,7 +60,6 @@ static const char *get_filename_for_perf_kvm(void)
 }
 
 #ifdef HAVE_KVM_STAT_SUPPORT
-#include "util/kvm-stat.h"
 
 void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 46913637085b..8fd6ec20662c 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -2,6 +2,8 @@
 #ifndef __PERF_KVM_STAT_H
 #define __PERF_KVM_STAT_H
 
+#ifdef HAVE_KVM_STAT_SUPPORT
+
 #include "tool.h"
 #include "stat.h"
 #include "record.h"
@@ -144,5 +146,6 @@ extern const int decode_str_len;
 extern const char *kvm_exit_reason;
 extern const char *kvm_entry_trace;
 extern const char *kvm_exit_trace;
+#endif /* HAVE_KVM_STAT_SUPPORT */
 
 #endif /* __PERF_KVM_STAT_H */
-- 
2.21.0

