Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA968222B6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfERJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:33:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:33:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9XL3X1742464
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:33:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9XL3X1742464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558172001;
        bh=EG0zO34Rf1Pe8dhEwiqKXXzhF5ZHRk69kHsrW0bv7As=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YkGCNJXPOhhB/GTLWq6O11qdYk1uIdZ6M/OfAcW+9qj2KxZe4OFbshV6Lv/sa1pXF
         oEmvoHtmNaWW9bcxqyrrEuHz0PAjcqKmN2uZL3XAQ4+Ku70XpPd2HMgipc5mzprIkl
         nrmFxZ4rdMnHw2+82HcSNF7XvjZdIQhmZj45a/lkwPCWMDx5LbyaKHTvytRMU0Q1x7
         BQ3vfYX/59mEFDBvAfv6HJbTzNeotHxJ6j38ljjnt6pg8FPF/ziJnjbnHFJ/N8qUG7
         DkS7jAwatvOejjqz8QvLHACwWttu2cOGx+794QNzgbeAmqmTbV8tlhiJTt4dUIm/DH
         ihi1wbV+FlNxQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9XKLF1742459;
        Sat, 18 May 2019 02:33:20 -0700
Date:   Sat, 18 May 2019 02:33:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-61b6e08dc8e3ea80b7485c9b3f875ddd45c8466b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
        mingo@kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190510124143.27054-3-adrian.hunter@intel.com>
References: <20190510124143.27054-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Fix improved sample timestamp
Git-Commit-ID: 61b6e08dc8e3ea80b7485c9b3f875ddd45c8466b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  61b6e08dc8e3ea80b7485c9b3f875ddd45c8466b
Gitweb:     https://git.kernel.org/tip/61b6e08dc8e3ea80b7485c9b3f875ddd45c8466b
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 10 May 2019 15:41:42 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:23 -0300

perf intel-pt: Fix improved sample timestamp

The decoder uses its current timestamp in samples. Usually that is a
timestamp that has already passed, but in some cases it is a timestamp
for a branch that the decoder is walking towards, and consequently
hasn't reached.

The intel_pt_sample_time() function decides which is which, but was not
handling TNT packets exactly correctly.

In the case of TNT, the timestamp applies to the first branch, so the
decoder must first walk to that branch.

That means intel_pt_sample_time() should return true for TNT, and this
patch makes that change. However, if the first branch is a non-taken
branch (i.e. a 'N'), then intel_pt_sample_time() needs to return false
for subsequent taken branches in the same TNT packet.

To handle that, introduce a new state INTEL_PT_STATE_TNT_CONT to
distinguish the cases.

Note that commit 3f04d98e972b5 ("perf intel-pt: Improve sample
timestamp") was also a stable fix and appears, for example, in v4.4
stable tree as commit a4ebb58fd124 ("perf intel-pt: Improve sample
timestamp").

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org # v4.4+
Fixes: 3f04d98e972b5 ("perf intel-pt: Improve sample timestamp")
Link: http://lkml.kernel.org/r/20190510124143.27054-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 26dbf11e071a..9cbd587489bf 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -58,6 +58,7 @@ enum intel_pt_pkt_state {
 	INTEL_PT_STATE_NO_IP,
 	INTEL_PT_STATE_ERR_RESYNC,
 	INTEL_PT_STATE_IN_SYNC,
+	INTEL_PT_STATE_TNT_CONT,
 	INTEL_PT_STATE_TNT,
 	INTEL_PT_STATE_TIP,
 	INTEL_PT_STATE_TIP_PGD,
@@ -72,8 +73,9 @@ static inline bool intel_pt_sample_time(enum intel_pt_pkt_state pkt_state)
 	case INTEL_PT_STATE_NO_IP:
 	case INTEL_PT_STATE_ERR_RESYNC:
 	case INTEL_PT_STATE_IN_SYNC:
-	case INTEL_PT_STATE_TNT:
+	case INTEL_PT_STATE_TNT_CONT:
 		return true;
+	case INTEL_PT_STATE_TNT:
 	case INTEL_PT_STATE_TIP:
 	case INTEL_PT_STATE_TIP_PGD:
 	case INTEL_PT_STATE_FUP:
@@ -1261,7 +1263,9 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 				return -ENOENT;
 			}
 			decoder->tnt.count -= 1;
-			if (!decoder->tnt.count)
+			if (decoder->tnt.count)
+				decoder->pkt_state = INTEL_PT_STATE_TNT_CONT;
+			else
 				decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			decoder->tnt.payload <<= 1;
 			decoder->state.from_ip = decoder->ip;
@@ -1292,7 +1296,9 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 
 		if (intel_pt_insn.branch == INTEL_PT_BR_CONDITIONAL) {
 			decoder->tnt.count -= 1;
-			if (!decoder->tnt.count)
+			if (decoder->tnt.count)
+				decoder->pkt_state = INTEL_PT_STATE_TNT_CONT;
+			else
 				decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			if (decoder->tnt.payload & BIT63) {
 				decoder->tnt.payload <<= 1;
@@ -2372,6 +2378,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			err = intel_pt_walk_trace(decoder);
 			break;
 		case INTEL_PT_STATE_TNT:
+		case INTEL_PT_STATE_TNT_CONT:
 			err = intel_pt_walk_tnt(decoder);
 			if (err == -EAGAIN)
 				err = intel_pt_walk_trace(decoder);
