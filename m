Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF344189526
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 06:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCRFWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 01:22:43 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:35382 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRFWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:22:43 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id E5CB2261414;
        Wed, 18 Mar 2020 13:22:33 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, kernel@vivo.com,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] mm: clarify a confusing comment for vm_iomap_memory
Date:   Tue, 17 Mar 2020 22:22:06 -0700
Message-Id: <20200318052206.105104-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVPSEpCQkJNQ0hIQ0tKSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Okk6ERw5TjgyTzQtPTwXCRwK
        AhoKFE1VSlVKTkNPTktDQk5NT05LVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUpMSUk3Bg++
X-HM-Tid: 0a70ec17e6e69375kuwse5cb2261414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The param "start" actually referes to the physical memory start,
which is to be mapped into virtual area vma. And it is the field
vma->vm_start which stands for the start of the area.

Most of the time, we do not read through whole implementation
of a function but only the definition and essential comments.
Accurate comments are definitely the base stone.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 583f84519870..5c356a57b892 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2009,7 +2009,7 @@ EXPORT_SYMBOL(remap_pfn_range);
 /**
  * vm_iomap_memory - remap memory to userspace
  * @vma: user vma to map to
- * @start: start of area
+ * @start: start of the physical memory to be mapped
  * @len: size of area
  *
  * This is a simplified io_remap_pfn_range() for common driver use. The
-- 
2.17.1

