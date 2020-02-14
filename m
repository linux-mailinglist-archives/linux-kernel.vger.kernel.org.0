Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A115715F52B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 19:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405575AbgBNSYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 13:24:46 -0500
Received: from foss.arm.com ([217.140.110.172]:43218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405528AbgBNSYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:24:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D89B6328;
        Fri, 14 Feb 2020 10:24:36 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A05C3F68E;
        Fri, 14 Feb 2020 10:24:35 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 01/10] x86/resctrl: Nothing uses struct mbm_state chunks_bw
Date:   Fri, 14 Feb 2020 18:23:52 +0000
Message-Id: <20200214182401.39008-2-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214182401.39008-1-james.morse@arm.com>
References: <20200214182401.39008-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing reads struct mbm_states's chunks_bw value, its a copy of
chunks. Remove it.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 --
 arch/x86/kernel/cpu/resctrl/monitor.c  | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 181c992f448c..90ca6a090c77 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -275,7 +275,6 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
- * @chunks_bw	Total local data moved. Used for bandwidth calculation
  * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
  * @prev_bw	The most recent bandwidth in MBps
  * @delta_bw	Difference between the current and previous bandwidth
@@ -284,7 +283,6 @@ struct rftype {
 struct mbm_state {
 	u64	chunks;
 	u64	prev_msr;
-	u64	chunks_bw;
 	u64	prev_bw_msr;
 	u32	prev_bw;
 	u32	delta_bw;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 773124b0e18a..af549df38ec6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -279,8 +279,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 		return;
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval);
-	m->chunks_bw += chunks;
-	m->chunks = m->chunks_bw;
+	m->chunks += chunks;
 	cur_bw = (chunks * r->mon_scale) >> 20;
 
 	if (m->delta_comp)
-- 
2.24.1

