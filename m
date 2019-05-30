Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A214D2F860
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfE3IOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:14:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfE3IOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:14:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8DM9r2904672
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:13:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8DM9r2904672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204003;
        bh=/ioW6yGJRyHtX0+Z4Qkx6d7146EF2dtM1ImJ/o2v1xU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rqs1FBmkpkw2YJmuejtryIc9QfWh2ifyKvrjD0n8B4RsH1spSq2+S72t44D/AVijs
         0N18Fp2cfcN7S4LokH3Mz37PKOg40SgQXxufUZrqkMwEcknZ/WX/BySehdWWky8UnZ
         6HHUIa1+bqYjWg+onDkwmivwOUhCPrKuDs0HfKqJH37hO5IDm0AtkGpRhaUySDWUnm
         tKwvmVCuCL73/ZSGP7jtKkwU/TS2PNjTIeWtk0aPAMjCv2g2jBbEWV4zvoNfEetm2y
         BWyAcqVmiMvh10F42G1vQ3ebfH9X0xPKlKDwcDwgzkoVdLZ3iQvR2OUUA5M0ow//30
         riL/ehScbv/Dw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8DMfE2904669;
        Thu, 30 May 2019 01:13:22 -0700
Date:   Thu, 30 May 2019 01:13:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-8201787cbb723a20bf262ecb41b74962ad27e659@git.kernel.org>
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, ak@linux.intel.com, acme@redhat.com,
        mingo@kernel.org, songliubraving@fb.com, tglx@linutronix.de,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, sdf@google.com,
        hpa@zytor.com, adrian.hunter@intel.com
Reply-To: peterz@infradead.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          ak@linux.intel.com, mingo@kernel.org, tglx@linutronix.de,
          songliubraving@fb.com, jolsa@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, sdf@google.com
In-Reply-To: <20190508132010.14512-12-jolsa@kernel.org>
References: <20190508132010.14512-12-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Remove superfluous BPF event titles
Git-Commit-ID: 8201787cbb723a20bf262ecb41b74962ad27e659
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8201787cbb723a20bf262ecb41b74962ad27e659
Gitweb:     https://git.kernel.org/tip/8201787cbb723a20bf262ecb41b74962ad27e659
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:09 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf script: Remove superfluous BPF event titles

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
