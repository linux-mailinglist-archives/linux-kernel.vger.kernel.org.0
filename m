Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0EA917D931
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 07:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCIGGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 02:06:54 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:52880 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbgCIGGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 02:06:54 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 9 Mar
 2020 14:06:36 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.44) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 9 Mar
 2020 14:06:34 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>
Subject: [PATCH] x86/Kconfig: make X86_UMIP to cover any X86 CPU
Date:   Mon, 9 Mar 2020 14:06:30 +0800
Message-ID: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.44]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the UMIP (User-Mode Instruction Prevention) is a generic X86 CPU
feature, there is no need to tie X86_UMIP only to Intel and AMD.

So remove that dependency from the Kconfig rules.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad3957..ca16b762 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1871,7 +1871,6 @@ config X86_SMAP
 
 config X86_UMIP
 	def_bool y
-	depends on CPU_SUP_INTEL || CPU_SUP_AMD
 	prompt "User Mode Instruction Prevention" if EXPERT
 	---help---
 	  User Mode Instruction Prevention (UMIP) is a security feature in
-- 
2.7.4

