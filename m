Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3ADAB42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 13:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406031AbfJQLcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 07:32:45 -0400
Received: from mx60.baidu.com ([61.135.168.60]:18542 "EHLO
        tc-sys-mailedm04.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388727AbfJQLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:32:45 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm04.tc.baidu.com (Postfix) with ESMTP id F2163236C006;
        Thu, 17 Oct 2019 19:32:30 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove VM_ACCT(PAGE_SIZE) when charge and uncharge
Date:   Thu, 17 Oct 2019 19:32:31 +0800
Message-Id: <1571311951-8524-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM_ACCT(PAGE_SIZE) is one, and it is unnecessary to multiply by it

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 mm/shmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index cd570cc79c76..f01df46ef2ff 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -202,14 +202,13 @@ static inline int shmem_acct_block(unsigned long flags, long pages)
 	if (!(flags & VM_NORESERVE))
 		return 0;
 
-	return security_vm_enough_memory_mm(current->mm,
-			pages * VM_ACCT(PAGE_SIZE));
+	return security_vm_enough_memory_mm(current->mm, pages);
 }
 
 static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 {
 	if (flags & VM_NORESERVE)
-		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
+		vm_unacct_memory(pages);
 }
 
 static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
-- 
2.16.2

