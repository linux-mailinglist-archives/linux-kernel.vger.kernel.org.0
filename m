Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453B413BACB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 09:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgAOITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 03:19:42 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:46583 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbgAOITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:19:42 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 15 Jan
 2020 16:04:36 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 15 Jan
 2020 16:04:32 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH] x86/cpu: clear X86_BUG_SPECTRE_V2 on Zhaoxin family 7 CPUs
Date:   Wed, 15 Jan 2020 16:05:00 +0800
Message-ID: <1579075500-7065-1-git-send-email-TonyWWang-oc@zhaoxin.com>
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

These CPUs are not affected by spectre_v2, so clear spectre_v2 bug flag
in their specific initialization code.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/centaur.c | 5 +++++
 arch/x86/kernel/cpu/zhaoxin.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index b98529e..3567560 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -250,6 +250,11 @@ static void init_centaur(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_VMX))
 		centaur_detect_vmx_virtcap(c);
+
+	if (c->x86 == 7) {
+		setup_clear_cpu_cap(X86_BUG_SPECTRE_V2);
+		clear_bit(X86_BUG_SPECTRE_V2, (unsigned long *)cpu_caps_set);
+	}
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 452fd0a..ea7c52f 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -141,6 +141,11 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_VMX))
 		zhaoxin_detect_vmx_virtcap(c);
+
+	if (c->x86 == 7) {
+		setup_clear_cpu_cap(X86_BUG_SPECTRE_V2);
+		clear_bit(X86_BUG_SPECTRE_V2, (unsigned long *)cpu_caps_set);
+	}
 }
 
 #ifdef CONFIG_X86_32
-- 
2.7.4

