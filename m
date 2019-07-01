Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56A50CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfFXNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 09:55:46 -0400
Received: from smtp.asem.it ([151.1.184.197]:65078 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfFXNzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:55:46 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003966016.MSG 
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:55:42 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Mon, 24
 Jun 2019 15:55:42 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Mon, 24 Jun 2019 15:55:42 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Russell King <linux@armlinux.org.uk>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] ARM: mm: print L310 cache controller version
Date:   Mon, 24 Jun 2019 15:54:49 +0200
Message-ID: <1561384489-29906-1-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0202.5D10D65F.0004,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The knowledge of the cache controller version
is very useful during the comparison of the performances
of similar boards, with similar CPU but different versions
of the L310 controller.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm/mm/cache-l2x0.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5b251c8..e5ac670 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -590,6 +590,34 @@ static void l2c310_configure(void __iomem *base)
 	if (revision >= L310_CACHE_ID_RTL_R3P0)
 		l2c_write_sec(l2x0_saved_regs.pwr_ctrl, base,
 			      L310_POWER_CTRL);
+
+	/* Display L310 cache controller version */
+	switch (revision) {
+	case L310_CACHE_ID_RTL_R0P0:
+		pr_info("L2C-310 revision: r0p0\n");
+		break;
+	case L310_CACHE_ID_RTL_R1P0:
+		pr_info("L2C-310 revision: r1p0\n");
+		break;
+	case L310_CACHE_ID_RTL_R2P0:
+		pr_info("L2C-310 revision: r2p0\n");
+		break;
+	case L310_CACHE_ID_RTL_R3P0:
+		pr_info("L2C-310 revision: r3p0\n");
+		break;
+	case L310_CACHE_ID_RTL_R3P1:
+		pr_info("L2C-310 revision: r3p1\n");
+		break;
+	case L310_CACHE_ID_RTL_R3P1_50REL0:
+		pr_info("L2C-310 revision: r3p1 50 rel0\n");
+		break;
+	case L310_CACHE_ID_RTL_R3P2:
+		pr_info("L2C-310 revision: r3p2\n");
+		break;
+	case L310_CACHE_ID_RTL_R3P3:
+		pr_info("L2C-310 revision: r3p3\n");
+		break;
+	}
 }
 
 static int l2c310_starting_cpu(unsigned int cpu)
-- 
2.7.4

