Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00198976C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfHLGzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 02:55:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfHLGzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JIXHQp9s2CVKIRUydQ4Mw0MR2l1VaY1/v2KS1Lf2mlI=; b=AmB2oLLkWobqAZTUGGzUVYYcsW
        AyKI21+qdSeWWM6l/MjdX574V7uUIZCnoTByOZ00FtFd/hBPT+c6YoGs/8U9JClmhDluYoMwYRDwX
        kfDQfbufZ7msUl5mNu1xJk1VBbqWKHL2FoQI0WO2R/YgByxXIFODsZX5b15SnCmdPqOiVSZP/nMZZ
        Fd/iFub55uJZecnjyyG9KLsBUUgCzKKZrHMVK2qzW051bXB+7Q9egGvFy9wT9eqc0x9zZ5LM6iFw0
        bcxuLGomxWkFu69/gdj9EqP0PC0BBB75w2jZUqXzMREpEBXtQZ+JKpEeIO91CCzuJRN5HlHUiWK00
        UQH6UetA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hx4F0-0000G5-8k; Mon, 12 Aug 2019 06:55:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] kernel: only define task_struct_whitelist conditionally
Date:   Mon, 12 Aug 2019 08:55:24 +0200
Message-Id: <20190812065524.19959-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812065524.19959-1-hch@lst.de>
References: <20190812065524.19959-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ARCH_TASK_STRUCT_ALLOCATOR is set task_struct_whitelist is
never called, and thus generates a compiler warning.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e76ea3..f79e3da0caaf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -768,6 +768,7 @@ static void set_max_threads(unsigned int max_threads_suggested)
 int arch_task_struct_size __read_mostly;
 #endif
 
+#ifndef CONFIG_ARCH_TASK_STRUCT_ALLOCATOR
 static void task_struct_whitelist(unsigned long *offset, unsigned long *size)
 {
 	/* Fetch thread_struct whitelist for the architecture. */
@@ -782,6 +783,7 @@ static void task_struct_whitelist(unsigned long *offset, unsigned long *size)
 	else
 		*offset += offsetof(struct task_struct, thread);
 }
+#endif /* CONFIG_ARCH_TASK_STRUCT_ALLOCATOR */
 
 void __init fork_init(void)
 {
-- 
2.20.1

