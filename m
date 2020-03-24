Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78E190B80
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 11:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCXKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 06:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgCXKwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:52:51 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ABE1208CA;
        Tue, 24 Mar 2020 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585047170;
        bh=28FajiIpTyOHoigH0+DT2DHz/lzMkgmR1Jc1TPsX4sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhEapYe0aCKi6JizZ1IklX+bhS+HoZkqodOna/Qaj6x3D3IrunRq97Hj4wBF8yZjg
         I2+cT3X7WOnClu4OzWb98T6d70hYsP2fq/8R72vswpKGQY0Z/Ku/NweoCdA21zPAni
         0s83c/7g0V7V7QJUSZPEGJ7nw3+a0B5PVd1HEa/Q=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        sparclinux@vger.kernel.org
Subject: [PATCH 1/4] sparc32: mm: Fix argument checking in __srmmu_get_nocache()
Date:   Tue, 24 Mar 2020 10:40:02 +0000
Message-Id: <20200324104005.11279-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324104005.11279-1-will@kernel.org>
References: <20200324104005.11279-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'size' argument to __srmmu_get_nocache() is a number of bytes not
a shift value, so fix up the sanity checking to treat it properly.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/mm/srmmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index f56c3c9a9793..a19863cac0c4 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -175,18 +175,18 @@ pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
  */
 static void *__srmmu_get_nocache(int size, int align)
 {
-	int offset;
+	int offset, minsz = 1 << SRMMU_NOCACHE_BITMAP_SHIFT;
 	unsigned long addr;
 
-	if (size < SRMMU_NOCACHE_BITMAP_SHIFT) {
+	if (size < minsz) {
 		printk(KERN_ERR "Size 0x%x too small for nocache request\n",
 		       size);
-		size = SRMMU_NOCACHE_BITMAP_SHIFT;
+		size = minsz;
 	}
-	if (size & (SRMMU_NOCACHE_BITMAP_SHIFT - 1)) {
-		printk(KERN_ERR "Size 0x%x unaligned int nocache request\n",
+	if (size & (minsz - 1)) {
+		printk(KERN_ERR "Size 0x%x unaligned in nocache request\n",
 		       size);
-		size += SRMMU_NOCACHE_BITMAP_SHIFT - 1;
+		size += minsz - 1;
 	}
 	BUG_ON(align > SRMMU_NOCACHE_ALIGN_MAX);
 
-- 
2.20.1

