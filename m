Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A20FFF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 07:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfKRG7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 01:59:47 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63796 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726481AbfKRG7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:59:47 -0500
X-IronPort-AV: E=Sophos;i="5.68,319,1569254400"; 
   d="scan'208";a="78655622"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Nov 2019 14:59:43 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id BE762406AB15;
        Mon, 18 Nov 2019 14:51:30 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 18 Nov 2019 14:59:49 +0800
Received: from TSO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 18 Nov 2019 14:59:45 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>
Subject: [RESEND PATCH] x86/numa: Fix typo
Date:   Mon, 18 Nov 2019 15:00:47 +0800
Message-ID: <20191118070047.27928-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: BE762406AB15.A9FD6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

encomapssing -> encompassing.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
git client finally works after configuration update.

 arch/x86/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 4123100e0eaf..99f7a68738f0 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -699,7 +699,7 @@ static int __init dummy_numa_init(void)
  * x86_numa_init - Initialize NUMA
  *
  * Try each configured NUMA initialization method until one succeeds.  The
- * last fallback is dummy single node config encomapssing whole memory and
+ * last fallback is dummy single node config encompassing whole memory and
  * never fails.
  */
 void __init x86_numa_init(void)
-- 
2.21.0



