Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7109C17E8E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCITne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:43:34 -0400
Received: from v6.sk ([167.172.42.174]:34638 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCITnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:33 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id B516161306;
        Mon,  9 Mar 2020 19:43:31 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 08/17] dt-bindings: marvell,mmp2: Add clock ids for MMP3 PLLs
Date:   Mon,  9 Mar 2020 20:42:45 +0100
Message-Id: <20200309194254.29009-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMP3 variant provides some more clocks. Add respective IDs.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Collected Rob's ack

 include/dt-bindings/clock/marvell,mmp2.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindings/clock/marvell,mmp2.h
index 4b1a7724f20d7..22006392b411b 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -26,6 +26,9 @@
 #define MMP2_CLK_VCTCXO_4		25
 #define MMP2_CLK_UART_PLL		26
 #define MMP2_CLK_USB_PLL		27
+#define MMP3_CLK_PLL1_P			28
+#define MMP3_CLK_PLL2_P			29
+#define MMP3_CLK_PLL3			30
 
 /* apb periphrals */
 #define MMP2_CLK_TWSI0			60
-- 
2.25.1

