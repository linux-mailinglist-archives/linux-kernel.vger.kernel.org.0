Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A360B750D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 10:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbfISI0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 04:26:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:11561 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfISI0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:26:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 01:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="388213508"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2019 01:26:10 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] x86/mm: fix return value of p[um]dp_set_access_flags
Date:   Thu, 19 Sep 2019 16:25:49 +0800
Message-Id: <20190919082549.3895-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function p[um]dp_set_access_flags is used with update_mmu_cache_p[um]d
and the return value from p[um]dp_set_access_flags indicates whether it
is necessary to do the cache update.

From current code logic, only when changed && dirty, related page table
entry would be updated. It is not necessary to update cache when the
real page table entry is not changed.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/pgtable.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 44816ff6411f..ba910f8ab43a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -509,9 +509,10 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 		 * #PF is architecturally guaranteed to do that and in the
 		 * worst-case we'll generate a spurious fault.
 		 */
+		return true;
 	}
 
-	return changed;
+	return false;
 }
 
 int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
@@ -529,9 +530,10 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 		 * #PF is architecturally guaranteed to do that and in the
 		 * worst-case we'll generate a spurious fault.
 		 */
+		return true;
 	}
 
-	return changed;
+	return false;
 }
 #endif
 
-- 
2.17.1

