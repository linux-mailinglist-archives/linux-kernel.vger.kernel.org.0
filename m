Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE410937E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 19:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfKYS1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 13:27:21 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34954 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727717AbfKYS1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:27:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tj5E22R_1574706428;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tj5E22R_1574706428)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Nov 2019 02:27:15 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     songliubraving@fb.com, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: khugepaged: add trace status description for SCAN_PAGE_HAS_PRIVATE
Date:   Tue, 26 Nov 2019 02:27:08 +0800
Message-Id: <1574706428-36212-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 99cb0dbd47a15d395bf3faa78dc122bc5efe3fc0 ("mm,thp: add
read-only THP support for (non-shmem) FS") instroduced a new khugepaged
scan result: SCAN_PAGE_HAS_PRIVATE, but the corresponding description
for trance events were not added.

Cc: Song Liu <songliubraving@fb.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/trace/events/huge_memory.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index dd4db33..d49fbce 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -31,7 +31,8 @@
 	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
 	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
 	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
-	EMe(SCAN_TRUNCATED,		"truncated")			\
+	EM( SCAN_TRUNCATED,		"truncated")			\
+	EMe(SCAN_PAGE_HAS_PRIVATE,	"has_private")			\
 
 #undef EM
 #undef EMe
-- 
1.8.3.1

