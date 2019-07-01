Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2CF2AF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 08:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfE0G6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 02:58:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:32872 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfE0G6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:58:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07612007|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.136347-0.00582676-0.857826;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Edg12hD_1558940309;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Edg12hD_1558940309)
          by smtp.aliyun-inc.com(10.147.41.120);
          Mon, 27 May 2019 14:58:29 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Mao Han <han_mao@c-sky.com>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH V2 5/5] csky: Fixup some error count in 810 & 860.
Date:   Mon, 27 May 2019 14:57:21 +0800
Message-Id: <2dfbabdcc60d4b5fa6a1595a1ca64102cfe06f05.1558939831.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558939831.git.han_mao@c-sky.com>
References: <cover.1558939831.git.han_mao@c-sky.com>
In-Reply-To: <cover.1558939831.git.han_mao@c-sky.com>
References: <cover.1558939831.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

ck810 pmu only support event with index 0-8 and 0xd; ck860 only
support event 1~4, 0xa~0x1b. So do not register unsupport event
to hardware cache event, which may leader to unknown behavior.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Mao Han <han_mao@c-sky.com>
CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
---
 arch/csky/kernel/perf_event.c | 60 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index a6a1582..bb5033f 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -735,6 +735,20 @@ static const int csky_pmu_hw_map[PERF_COUNT_HW_MAX] = {
 #define CACHE_OP_UNSUPPORTED	0xffff
 static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	[C(L1D)] = {
+#ifdef CONFIG_CPU_CK810
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x5,
+			[C(RESULT_MISS)]	= 0x6,
+		},
+#else
 		[C(OP_READ)] = {
 			[C(RESULT_ACCESS)]	= 0x14,
 			[C(RESULT_MISS)]	= 0x15,
@@ -744,9 +758,10 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 			[C(RESULT_MISS)]	= 0x17,
 		},
 		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= 0x5,
-			[C(RESULT_MISS)]	= 0x6,
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
+#endif
 	},
 	[C(L1I)] = {
 		[C(OP_READ)] = {
@@ -763,6 +778,20 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 		},
 	},
 	[C(LL)] = {
+#ifdef CONFIG_CPU_CK810
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x7,
+			[C(RESULT_MISS)]	= 0x8,
+		},
+#else
 		[C(OP_READ)] = {
 			[C(RESULT_ACCESS)]	= 0x18,
 			[C(RESULT_MISS)]	= 0x19,
@@ -772,29 +801,48 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 			[C(RESULT_MISS)]	= 0x1b,
 		},
 		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= 0x7,
-			[C(RESULT_MISS)]	= 0x8,
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
+#endif
 	},
 	[C(DTLB)] = {
+#ifdef CONFIG_CPU_CK810
 		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= 0x5,
-			[C(RESULT_MISS)]	= 0xb,
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
 		[C(OP_WRITE)] = {
 			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
 			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
+#else
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x14,
+			[C(RESULT_MISS)]	= 0xb,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x16,
+			[C(RESULT_MISS)]	= 0xb,
+		},
+#endif
 		[C(OP_PREFETCH)] = {
 			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
 			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
 	},
 	[C(ITLB)] = {
+#ifdef CONFIG_CPU_CK810
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+#else
 		[C(OP_READ)] = {
 			[C(RESULT_ACCESS)]	= 0x3,
 			[C(RESULT_MISS)]	= 0xa,
 		},
+#endif
 		[C(OP_WRITE)] = {
 			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
 			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-- 
2.7.4

