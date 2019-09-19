Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA0B716B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 04:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbfISCJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 22:09:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:4977 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfISCJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:09:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 19:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="387108079"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2019 19:09:16 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/2] x86/mm: replace a goto by merging two if clause
Date:   Thu, 19 Sep 2019 10:08:44 +0800
Message-Id: <20190919020844.27461-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919020844.27461-1-richardw.yang@linux.intel.com>
References: <20190919020844.27461-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one place to use good_area jump, which could be reduced by
merging the following two if clause.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/fault.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9d18b73b5f77..72ce6c69e195 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1390,18 +1390,17 @@ void do_user_addr_fault(struct pt_regs *regs,
 	vma = find_vma(mm, address);
 	if (unlikely(!vma))
 		goto bad_area;
-	if (likely(vma->vm_start <= address))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
-		goto bad_area;
-	if (unlikely(expand_stack(vma, address)))
+	if (likely(vma->vm_start <= address)) {
+		/* good area, do nothing */
+	} else if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)) ||
+		   unlikely(expand_stack(vma, address))) {
 		goto bad_area;
+	}
 
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
-good_area:
 	if (unlikely(access_error(hw_error_code, vma))) {
 		bad_area_access_error(regs, hw_error_code, address, vma);
 		return;
-- 
2.17.1

