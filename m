Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C689F4F408
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfFVGjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 02:39:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46493 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFVGjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:39:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6co2V2005211
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:38:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6co2V2005211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185530;
        bh=dy0gTJjEftMB9iQOLd79WJLoc9MNR9MLjb6PonAO8MY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BGrtvRg/ZMS6UL1FC9/kKN0g7ourMcEi5TbXuh1u9evZIpuuNzb7pVqg1xopSXVuY
         hbt4mJ5yMGJLff/Gy1FvgOqAo+0jdQojXMtV1Cw6mtUnobQ53edqFKtWc0310srzaE
         v8supQIi7mVJzCHXjwe0pOBDzDHqds8oYb4qj55yYE4GchwlOVeAHqYTPvNmJ3l0xN
         PFzPcpM8iAhE/FaJFWWCipZTEM7pbQn2SHNT+/Ys8zDQ5MJuPI/MLAFEvPk6BOfw7M
         q1mvsm8IIr19mmMPAYCySDh97X/0Tql0+zwEfzjEZn4J+46V8JMqn0W+dhvTndYz6W
         WWj+2I4bUXXMw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6cn2b2005208;
        Fri, 21 Jun 2019 23:38:49 -0700
Date:   Fri, 21 Jun 2019 23:38:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-0dfded34a2e3b517c149ee9c7d1e5173025017b7@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, jolsa@redhat.com
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com
In-Reply-To: <20190610072803.10456-6-adrian.hunter@intel.com>
References: <20190610072803.10456-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Factor out common sample preparation
 for re-use
Git-Commit-ID: 0dfded34a2e3b517c149ee9c7d1e5173025017b7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0dfded34a2e3b517c149ee9c7d1e5173025017b7
Gitweb:     https://git.kernel.org/tip/0dfded34a2e3b517c149ee9c7d1e5173025017b7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:27:57 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:18 -0300

perf intel-pt: Factor out common sample preparation for re-use

Factor out common sample preparation for re-use when synthesizing PEBS
samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index cc91c1413c22..a2d90b2f1f11 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1182,28 +1182,37 @@ static inline bool intel_pt_skip_event(struct intel_pt *pt)
 	       pt->num_events++ < pt->synth_opts.initial_skip;
 }
 
+static void intel_pt_prep_a_sample(struct intel_pt_queue *ptq,
+				   union perf_event *event,
+				   struct perf_sample *sample)
+{
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.size = sizeof(struct perf_event_header);
+
+	sample->pid = ptq->pid;
+	sample->tid = ptq->tid;
+	sample->cpu = ptq->cpu;
+	sample->insn_len = ptq->insn_len;
+	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
+}
+
 static void intel_pt_prep_b_sample(struct intel_pt *pt,
 				   struct intel_pt_queue *ptq,
 				   union perf_event *event,
 				   struct perf_sample *sample)
 {
+	intel_pt_prep_a_sample(ptq, event, sample);
+
 	if (!pt->timeless_decoding)
 		sample->time = tsc_to_perf_time(ptq->timestamp, &pt->tc);
 
 	sample->ip = ptq->state->from_ip;
 	sample->cpumode = intel_pt_cpumode(pt, sample->ip);
-	sample->pid = ptq->pid;
-	sample->tid = ptq->tid;
 	sample->addr = ptq->state->to_ip;
 	sample->period = 1;
-	sample->cpu = ptq->cpu;
 	sample->flags = ptq->flags;
-	sample->insn_len = ptq->insn_len;
-	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
 
-	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = sample->cpumode;
-	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
 static int intel_pt_inject_event(union perf_event *event,
