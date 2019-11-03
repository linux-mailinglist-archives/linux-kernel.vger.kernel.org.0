Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78F4ED327
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 12:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKCLkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 06:40:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfKCLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xB56QOFXMB7/GEsT5PtYQijX3jcE5vIgtO8nEiAckIU=; b=aL37phAdv4YF+oXutPl/u5jKOp
        wLyx4rh/cEYHUcGjY+rpYPjdvH5wQhUZ2+XahG2V3/75OIRF96O+ffQ9rEIyC1AB4HvLKn81PufHF
        DRYVWuBaXnLu5lUmEQTnDIZbCDvGlb+12WdaRCM/wJx17iaFqPzXR9LIkXBFSLaua4X/+8uLoQxy5
        JEEFVjie+UNN8a6GDH5PIFmid6v0WWtBGbOXQ3vRZgKiobGozHxWdj01ZSXcU7UV7b1m4hol+Iogx
        8Q9j2zGrRPavPXDWlenqnxjKNXPXekTZ5Mu+A9z2m833DWDSRDCKlQd7MwCOnwJDCmQdBy2R7dfKv
        z6QL0ZMg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iREEz-0007qX-QM; Sun, 03 Nov 2019 11:40:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 5/5] idr: Fix idr_alloc_u32 on 32-bit systems
Date:   Sun,  3 Nov 2019 03:40:12 -0800
Message-Id: <20191103114012.30027-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191103114012.30027-1-willy@infradead.org>
References: <20191103114012.30027-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Attempting to allocate an entry at 0xffffffff when one is already
present would succeed in allocating one at 2^32, which would confuse
everything.  Return -ENOSPC in this case, as expected.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/radix-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 18c1dfbb1765..c8fa1d274530 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1529,7 +1529,7 @@ void __rcu **idr_get_free(struct radix_tree_root *root,
 			offset = radix_tree_find_next_bit(node, IDR_FREE,
 							offset + 1);
 			start = next_index(start, node, offset);
-			if (start > max)
+			if (start > max || start == 0)
 				return ERR_PTR(-ENOSPC);
 			while (offset == RADIX_TREE_MAP_SIZE) {
 				offset = node->offset + 1;
-- 
2.24.0.rc1

