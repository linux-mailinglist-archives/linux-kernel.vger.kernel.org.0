Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4929FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 22:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404154AbfEXUTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 16:19:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:42796 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403760AbfEXUTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:19:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1635B9A9;
        Fri, 24 May 2019 20:19:34 +0000 (UTC)
Date:   Fri, 24 May 2019 14:19:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Generic radix trees: fix kerneldoc comment
Message-ID: <20190524141933.74ae9050@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DOC comment block section in include/linux/generic-radix-tree.h
contained a spurious colon, causing this warning in the documentation
build:

  ./include/linux/generic-radix-tree.h:1: warning: no structured comments found

Remove the colon and make the docs build happy.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/generic-radix-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 3a91130a4fbd..02393c0c98f9 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -2,7 +2,7 @@
 #define _LINUX_GENERIC_RADIX_TREE_H
 
 /**
- * DOC: Generic radix trees/sparse arrays:
+ * DOC: Generic radix trees/sparse arrays
  *
  * Very simple and minimalistic, supporting arbitrary size entries up to
  * PAGE_SIZE.
-- 
2.21.0

