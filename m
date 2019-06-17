Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02548D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfFQTBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:01:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:01:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ1HSS3554565
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:01:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ1HSS3554565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798077;
        bh=jxWByRX3Ss6TGK3xmsPvWZ2PdNFy3FTjs5EFjDVIhFc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ov7YIzupa0MVEG1hLP2rNrOjFqmBbT1FtlR860IMMhUAhnbKV+4aFE7sgYJLTnRLK
         hJp0jIXe9VdZequgz1GRt8hNTY4gkmplEyGYMtSIWNu4Q8njXmmLuYA7ciIt60JBM6
         2BQEWlHkD/fYIkHxoufHpVBhLfYG657XgGJ2DOuWwi+LJ54s3wMJ2te1Lfs07mx7YM
         QK6ku5O42uX6HvE3MWdkvtL4SQ0QHyyhDvUg3DB5qhOcIrhsC4CG3SofUU5w8x94NO
         muMMpHYpzZs6D7HjOKeD5oOAIIdzcVFHyWJQbSYmZ/eRzfsurX8LkMPuvkYMxMOJ1/
         0cRqD2kkpwVjg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ1GhM3554562;
        Mon, 17 Jun 2019 12:01:16 -0700
Date:   Mon, 17 Jun 2019 12:01:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5b1dc0fd1da06d6e89f1ca8736cfe0ee84e34cc7@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        jolsa@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, adrian.hunter@intel.com,
          jolsa@redhat.com, hpa@zytor.com
In-Reply-To: <20190520113728.14389-8-adrian.hunter@intel.com>
References: <20190520113728.14389-8-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add support for samples to contain
 IPC ratio
Git-Commit-ID: 5b1dc0fd1da06d6e89f1ca8736cfe0ee84e34cc7
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

Commit-ID:  5b1dc0fd1da06d6e89f1ca8736cfe0ee84e34cc7
Gitweb:     https://git.kernel.org/tip/5b1dc0fd1da06d6e89f1ca8736cfe0ee84e34cc7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:13 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:56 -0300

perf intel-pt: Add support for samples to contain IPC ratio

Copy the incremental instruction count and cycle count onto 'instructions'
and 'branches' samples.

Because Intel PT does not update the cycle count on every branch or
instruction, the incremental values will often be zero.

When there are values, they will be the number of instructions and
number of cycles since the last update, and thus represent the average
IPC since the last IPC value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 7a70693c1b91..3cff8fe2eaa0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -157,6 +157,12 @@ struct intel_pt_queue {
 	u32 flags;
 	u16 insn_len;
 	u64 last_insn_cnt;
+	u64 ipc_insn_cnt;
+	u64 ipc_cyc_cnt;
+	u64 last_in_insn_cnt;
+	u64 last_in_cyc_cnt;
+	u64 last_br_insn_cnt;
+	u64 last_br_cyc_cnt;
 	char insn[INTEL_PT_INSN_BUF_SZ];
 };
 
@@ -1162,6 +1168,13 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 		sample.branch_stack = (struct branch_stack *)&dummy_bs;
 	}
 
+	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_br_cyc_cnt;
+	if (sample.cyc_cnt) {
+		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_br_insn_cnt;
+		ptq->last_br_insn_cnt = ptq->ipc_insn_cnt;
+		ptq->last_br_cyc_cnt = ptq->ipc_cyc_cnt;
+	}
+
 	return intel_pt_deliver_synth_b_event(pt, event, &sample,
 					      pt->branches_sample_type);
 }
@@ -1217,6 +1230,13 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 	sample.stream_id = ptq->pt->instructions_id;
 	sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
 
+	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
+	if (sample.cyc_cnt) {
+		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
+		ptq->last_in_insn_cnt = ptq->ipc_insn_cnt;
+		ptq->last_in_cyc_cnt = ptq->ipc_cyc_cnt;
+	}
+
 	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
 
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
@@ -1488,6 +1508,15 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	ptq->have_sample = false;
 
+	if (ptq->state->tot_cyc_cnt > ptq->ipc_cyc_cnt) {
+		/*
+		 * Cycle count and instruction count only go together to create
+		 * a valid IPC ratio when the cycle count changes.
+		 */
+		ptq->ipc_insn_cnt = ptq->state->tot_insn_cnt;
+		ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
+	}
+
 	if (pt->sample_pwr_events && (state->type & INTEL_PT_PWR_EVT)) {
 		if (state->type & INTEL_PT_CBR_CHG) {
 			err = intel_pt_synth_cbr_sample(ptq);
