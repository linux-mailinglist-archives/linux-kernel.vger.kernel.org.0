Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0510BE469E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438249AbfJYJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 05:06:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438227AbfJYJGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:06:19 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0DBD0E9698D9CBE4C967;
        Fri, 25 Oct 2019 17:06:18 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 17:06:09 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <jpoimboe@redhat.com>, <peterz@infradead.org>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <hewenliang4@huawei.com>
Subject: [PATCH] objtool: Fix memory leakage in special_get_alts
Date:   Fri, 25 Oct 2019 05:06:08 -0400
Message-ID: <20191025090608.30582-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

special_get_alts just returns without releasing the memory which is
pointed by alt When get_alt_entry returns -1. It will cause the leakage
of memory. We should free the memory before special_get_alts returns
because of error.

Fixes: 442f04c34a1a ("objtool: Add tool to perform compile-time stack metadata validation")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/objtool/special.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index fdbaa611146d..019ce8ecc101 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -188,8 +188,10 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			memset(alt, 0, sizeof(*alt));
 
 			ret = get_alt_entry(elf, entry, sec, idx, alt);
-			if (ret)
+			if (ret) {
+				free(alt);
 				return ret;
+			}
 
 			list_add_tail(&alt->list, alts);
 		}
-- 
2.19.1

