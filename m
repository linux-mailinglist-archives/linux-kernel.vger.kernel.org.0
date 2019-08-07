Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B3E84D43
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388687AbfHGNcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 09:32:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388624AbfHGNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=35Wov8xFMRqPypDnINHOhGjn1zV2YlFcYXBEGdDF8FY=; b=iktkWZBftFPXxZN/7ldq5hE/qV
        E0Rbym/X2WX9V6GD5EAtbpEdvQF11ZNdEYRys+YvlZQBXfIaj1ZiFItw7jC4w7B/mBHkwxLsJs1dy
        HEFVTMnGDHX2SS+tsE/B93SRKovsYB7sBZV6ahCXLh3+xb1bpASFNIajfmBhPkVvH5k40kpdBI/Hy
        64VrphCH5E6blhKL7JnV72/xRoT+hgEG7HphfX15vQJGQ242OU4ctWBT5iVJJJO0+W37XFZnf7rUf
        skhlJbhZidxFk04DfbZGtPkpA7XTWXQD60gbOF7Dd5qefd6SchPe/ynMoqhY1yAnBJBrGjnUxj/g3
        JtlShwvg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvM3B-0008GR-Au; Wed, 07 Aug 2019 13:32:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/29] genirq: remove the is_affinity_mask_valid hook
Date:   Wed,  7 Aug 2019 16:30:49 +0300
Message-Id: <20190807133049.20893-30-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807133049.20893-1-hch@lst.de>
References: <20190807133049.20893-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This override was only used by the ia64 SGI SN2 platform, which is
gone now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/irq/proc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index da9addb8d655..cfc4f088a0e7 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -100,10 +100,6 @@ static int irq_affinity_hint_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-#ifndef is_affinity_mask_valid
-#define is_affinity_mask_valid(val) 1
-#endif
-
 int no_irq_affinity;
 static int irq_affinity_proc_show(struct seq_file *m, void *v)
 {
@@ -136,11 +132,6 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	if (err)
 		goto free_cpumask;
 
-	if (!is_affinity_mask_valid(new_value)) {
-		err = -EINVAL;
-		goto free_cpumask;
-	}
-
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
 	 * way to make the system unusable accidentally :-) At least
@@ -232,11 +223,6 @@ static ssize_t default_affinity_write(struct file *file,
 	if (err)
 		goto out;
 
-	if (!is_affinity_mask_valid(new_value)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
 	 * way to make the system unusable accidentally :-) At least
-- 
2.20.1

