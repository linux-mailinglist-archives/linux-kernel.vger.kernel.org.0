Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432A7181DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgCKQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:26:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57560 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730114AbgCKQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:26:50 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8653E43B5F;
        Wed, 11 Mar 2020 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583944009; bh=YEP/pPTvBwAKKbQrP/uUGOaw5ZxOg48FIifMp+mV0zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcA0IoOrBj/wbbpHTc9VBQxa1dL4p6DPs0Bp/sDHxJ1O5Mxzgdz90yOS78S04DMl2
         MY4uzC4uMhpKd+3B/czaHx9bIXN8mLYGUzDauCOhZzgG8Fo8Z7R47cbZega+S7i2rW
         YO72BCHnx7yHt8meLCo4Wflq9WT3ahfrH0vsWBaIyUci/sLblvfJxUYJZfJeFZVAed
         z+tmqwdQ4c54JM94dpawgoq2nLt/GTkG/2vOLS+mWQ57Qiq2rOiQkFeFuxAWLus8FC
         KPn+gtuxk498NAC9Oh6L5N12sQu72k7NgEzP3KXXF1KVTwO84ewElJoCw+FWRoyl4g
         rVEi8vWDvcubw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id EF2FDA0061;
        Wed, 11 Mar 2020 16:26:47 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/2] ARC: don't align ret_from_exception function
Date:   Wed, 11 Mar 2020 19:26:44 +0300
Message-Id: <20200311162644.7667-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
References: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC have a tricky implemented ret_from_exception function.
It is written on ASM and can be called like regular function.
However it has another 'entry point' as it can be called as a
continuation of EV_Trap function.

As we declare "ret_from_exception" using ENTRY macro it may align
"ret_from_exception" by 4 bytes by adding padding before it.
"ret_from_exception" doesn't require alignment by 4 bytes
(as it doesn't go to vector table, etc...) so let's avoid aligning
it by switch from ENTRY (which is alias for SYM_FUNC_START) to
SYM_FUNC_START_NOALIGN macro.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/entry-arcv2.S | 2 +-
 arch/arc/kernel/entry.S       | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index 12d5f12d10d2..d482e1507f56 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -260,4 +260,4 @@ debug_marker_ds:
 	sr	r11, [AUX_IRQ_ACT]
 	b	.Lexcept_ret
 
-END(ret_from_exception)
+SYM_FUNC_END(ret_from_exception)
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 60406ec62eb8..79409b518a09 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -280,7 +280,7 @@ END(EV_Trap)
 ;
 ; If ret to user mode do we need to handle signals, schedule() et al.
 
-ENTRY(ret_from_exception)
+SYM_FUNC_START_NOALIGN(ret_from_exception)
 
 	; Pre-{IRQ,Trap,Exception} K/U mode from pt_regs->status32
 	ld  r8, [sp, PT_status32]   ; returning to User/Kernel Mode
@@ -373,4 +373,3 @@ resume_kernel_mode:
 	b	.Lrestore_regs
 
 ##### DONT ADD CODE HERE - .Lrestore_regs actually follows in entry-<isa>.S
-
-- 
2.21.1

