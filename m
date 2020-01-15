Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5218A13BAC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 09:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgAOIPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 03:15:40 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:30187 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgAOIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:15:40 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 15 Jan
 2020 16:00:30 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 15 Jan
 2020 16:00:28 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH] x86/cpu: remove redundant cpu_detect_cache_sizes
Date:   Wed, 15 Jan 2020 16:00:57 +0800
Message-ID: <1579075257-6985-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.11]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before call cpu_detect_cache_sizes get l2size from CPUID.80000006,
these CPUs have called init_intel_cacheinfo get l2size/l3size from
CPUID.4.

So remove the redundant function to simplify the code.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/centaur.c | 2 --
 arch/x86/kernel/cpu/zhaoxin.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 14433ff..b98529e 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -71,8 +71,6 @@ static void init_c3(struct cpuinfo_x86 *c)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 	}
-
-	cpu_detect_cache_sizes(c);
 }
 
 enum {
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 8e6f2f4..452fd0a 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -58,8 +58,6 @@ static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
 
 	if (c->x86 >= 0x6)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
-
-	cpu_detect_cache_sizes(c);
 }
 
 static void early_init_zhaoxin(struct cpuinfo_x86 *c)
-- 
2.7.4

