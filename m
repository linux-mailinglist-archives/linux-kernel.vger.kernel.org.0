Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C1878FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406628AbfHILqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 07:46:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1391 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726157AbfHILqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:46:07 -0400
X-IronPort-AV: E=Sophos;i="5.64,364,1559491200"; 
   d="scan'208";a="73306026"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Aug 2019 19:46:05 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 08F1C4CE030E;
        Fri,  9 Aug 2019 19:46:07 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 9 Aug 2019 19:46:06 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <tglx@linutronix.de>, <bp@alien8.de>, <hpa@zytor.com>,
        <mingo@redhat.com>
Subject: [PATCH] x86/fixmap: update stale comments
Date:   Fri, 9 Aug 2019 19:46:12 +0800
Message-ID: <20190809114612.2569-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 08F1C4CE030E.AC805
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/fixmap.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 9da8cccdf3fb..0c47aa82e2e2 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -42,8 +42,7 @@
  * Because of this, FIXADDR_TOP x86 integration was left as later work.
  */
 #ifdef CONFIG_X86_32
-/* used by vmalloc.c, vsyscall.lds.S.
- *
+/*
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
@@ -120,7 +119,7 @@ enum fixed_addresses {
 	 * before ioremap() is functional.
 	 *
 	 * If necessary we round it up to the next 512 pages boundary so
-	 * that we can have a single pgd entry and a single pte table:
+	 * that we can have a single pmd entry and a single pte table:
 	 */
 #define NR_FIX_BTMAPS		64
 #define FIX_BTMAPS_SLOTS	8
-- 
2.17.0



