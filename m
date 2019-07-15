Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31737687A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 13:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfGOLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 07:02:30 -0400
Received: from 8bytes.org ([81.169.241.247]:35330 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbfGOLCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:02:30 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 48BD0133; Mon, 15 Jul 2019 13:02:22 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/3] x86/mm: Check for pfn instead of page in vmalloc_sync_one()
Date:   Mon, 15 Jul 2019 13:02:10 +0200
Message-Id: <20190715110212.18617-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715110212.18617-1-joro@8bytes.org>
References: <20190715110212.18617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Do not require a struct page for the mapped memory location
because it might not exist. This can happen when an
ioremapped region is mapped with 2MB pages.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 794f364cb882..4a4049f6d458 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -200,7 +200,7 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	if (!pmd_present(*pmd))
 		set_pmd(pmd, *pmd_k);
 	else
-		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
 
 	return pmd_k;
 }
-- 
2.17.1

