Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE92BC30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 00:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfE0WlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 18:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfE0WlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:41:03 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A5A208C3;
        Mon, 27 May 2019 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996862;
        bh=r+vEbdNJKs3mSy6G5eVzNm4Ll2YSveQDwNrfCgP0WnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npmIstb2rTx1KyOPEiFArgHlTHHF7BP8CslL+8wB2DUITHUMUapMilzTHoUxybknC
         bsLQeNTW6QuXrhfO3xO5uAYG8fLK5dcvGYzTvGkES+ezfuF+2JBXgGMz1z59P057wV
         xfRUUUvs1aSOgXl6pWMMOHyXhsKQ3rpkVWEQsxxQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH 41/44] perf script: Remove superfluous BPF event titles
Date:   Mon, 27 May 2019 19:37:27 -0300
Message-Id: <20190527223730.11474-42-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need to display "ksymbol event with" text for the
PERF_RECORD_KSYMBOL event and "bpf event with" test for the
PERF_RECORD_BPF_EVENT event.

Remove it so it also goes along with other side-band events display.

Before:

  # perf script --show-bpf-events
  ...
  swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0ef971d len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
  swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 36

After:

  # perf script --show-bpf-events
  ...
  swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL addr ffffffffc0ef971d len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
  swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT type 1, flags 0, id 36

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index d1ad6c419724..c9c6857360e4 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1486,7 +1486,7 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " ksymbol event with addr %" PRIx64 " len %u type %u flags 0x%x name %s\n",
+	return fprintf(fp, " addr %" PRIx64 " len %u type %u flags 0x%x name %s\n",
 		       event->ksymbol_event.addr, event->ksymbol_event.len,
 		       event->ksymbol_event.ksym_type,
 		       event->ksymbol_event.flags, event->ksymbol_event.name);
@@ -1494,7 +1494,7 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " bpf event with type %u, flags %u, id %u\n",
+	return fprintf(fp, " type %u, flags %u, id %u\n",
 		       event->bpf_event.type, event->bpf_event.flags,
 		       event->bpf_event.id);
 }
-- 
2.20.1

