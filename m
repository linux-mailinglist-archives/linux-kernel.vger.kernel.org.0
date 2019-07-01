Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4801E641
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 02:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEOAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 20:30:25 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:38628 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbfEOAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:23 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 622BBC125A;
        Wed, 15 May 2019 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557880228; bh=BbOArzhCYfXqLI1L+PWNkHvNIYDOVRl28L7WeykEn0k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=cvsuWs6C3nQmf2EnZKnLLueUjqsQMWTVettJFq+6AhkpWX10HAxgVupEuHll2KTxr
         JFN1Fq4xkyPx7T1qYP7mbNWcO+A6gReec8fdsCHFXd7CG45wj/aPI2KIGNTr34eq2H
         MlJ++0FI57ROZz4bFPjGrIEl95+t+RQHH+Y2YfrYLVVRR8vOxDfhoY0hgICHrEMu/Y
         BObWS/2EoGA6Lh19saBMNmWNxIn4r3SDDfeG4w0hEK/rCUcosflQ3t0bYExWIc/Cc5
         4+pwIYLo9zbpzGGJ2hyBXCXVvKRu7M/7j5J/chC1JHvMJCLrvmffJVuvIxyv27AdtX
         7eQlxpUj/WeVQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3DA49A023C;
        Wed, 15 May 2019 00:30:18 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 May 2019 17:30:01 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 05:59:57 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:09 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <paltsev@snyopsys.com>, <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 2/9] ARC: mm: do_page_fault refactor #1: remove label @good_area
Date:   Tue, 14 May 2019 17:29:29 -0700
Message-ID: <1557880176-24964-3-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.182.230]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert the condition for stack expansion.
No functional change

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/fault.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 6836095251ed..94d242740ac5 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -100,21 +100,19 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		flags |= FAULT_FLAG_USER;
 retry:
 	down_read(&mm->mmap_sem);
+
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+	if (unlikely(address < vma->vm_start)) {
+		if (!(vma->vm_flags & VM_GROWSDOWN) || expand_stack(vma, address))
+			goto bad_area;
+	}
 
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
-good_area:
 	si_code = SEGV_ACCERR;
 
 	/* Handle protection violation, execute on heap or stack */
-- 
2.7.4

