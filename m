Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1015B73120
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbfGXOIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:08:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfGXOIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:08:01 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3FD101BF82E4CB908D9F;
        Wed, 24 Jul 2019 22:07:59 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 22:07:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>,
        <mhocko@suse.com>, <vbabka@suse.cz>, <yang.shi@linux.alibaba.com>,
        <jannh@google.com>, <walken@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] mm/mmap.c: silence variable 'new_start' set but not used
Date:   Wed, 24 Jul 2019 22:07:39 +0800
Message-ID: <20190724140739.59532-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'new_start' is used in is_hugepage_only_range(),
which do nothing in some arch. gcc will warning:

mm/mmap.c: In function acct_stack_growth:
mm/mmap.c:2311:16: warning: variable new_start set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e2dbed3..56c2a92 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2308,7 +2308,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 			     unsigned long size, unsigned long grow)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long new_start;
+	unsigned long __maybe_unused new_start;
 
 	/* address space limit tests */
 	if (!may_expand_vm(mm, vma->vm_flags, grow))
-- 
2.7.4


