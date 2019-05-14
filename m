Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9011C3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 09:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfENHNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 03:13:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46801 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfENHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:13:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4E7D1nM3904743
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 14 May 2019 00:13:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4E7D1nM3904743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557817982;
        bh=xQjJyNqXazPOXIYLNRb/BA2jAUGCULfn5jnQCl9oViA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EnlwuG8CUQcOn0wPoE1sdwn0kaBlNKhOWN6w8dmXsCqZyr+3osw7sK1Ah76t4EyVi
         QtKTHl9iu5vk3RfQNdiZl+ieceE0+FLGb4iIlXhecNTM6Ly2XOPbur01T05GpmczH9
         vg0Yr+Y0wFg4Ldf1d/Tdqt/jIbf2IbrFrET0cimfITZ7WYjyF/VRPsQCZ1xtVAIMqa
         6i1H3yCwLJ5XQ6ojZ5p2qPTIVsofnYJiq1nS3a/g8mwA77CUz5TIB/Dy5viBYmpFSh
         eys8UKnZ/UmEDSgl4BVVdBJiS+V3JltJ8az+APLHIAolvR/6rnifhdg1sFO0aTqYfK
         cDg28NF9nc52w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4E7D1Rr3904740;
        Tue, 14 May 2019 00:13:01 -0700
Date:   Tue, 14 May 2019 00:13:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-c7a286577d7592720c2f179aadfb325a1ff48c95@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, eranian@google.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, eranian@google.com
In-Reply-To: <20190514003400.224340-1-eranian@google.com>
References: <20190514003400.224340-1-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Allow PEBS multi-entry in
 watermark mode
Git-Commit-ID: c7a286577d7592720c2f179aadfb325a1ff48c95
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

Commit-ID:  c7a286577d7592720c2f179aadfb325a1ff48c95
Gitweb:     https://git.kernel.org/tip/c7a286577d7592720c2f179aadfb325a1ff48c95
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Mon, 13 May 2019 17:34:00 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 14 May 2019 09:07:58 +0200

perf/x86/intel: Allow PEBS multi-entry in watermark mode

This patch fixes a restriction/bug introduced by:

   583feb08e7f7 ("perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS")

The original patch prevented using multi-entry PEBS when wakeup_events != 0.
However given that wakeup_events is part of a union with wakeup_watermark, it
means that in watermark mode, PEBS multi-entry is also disabled which is not the
intent. This patch fixes this by checking is watermark mode is enabled.

Signed-off-by: Stephane Eranian <eranian@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jolsa@redhat.com
Cc: kan.liang@intel.com
Cc: vincent.weaver@maine.edu
Fixes: 583feb08e7f7 ("perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS")
Link: http://lkml.kernel.org/r/20190514003400.224340-1-eranian@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ef763f535e3a..12ec402f4114 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3265,7 +3265,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!(event->attr.freq || event->attr.wakeup_events)) {
+		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_large_pebs_flags(event)))
