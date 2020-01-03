Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8D12F4E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 08:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgACHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 02:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgACHSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:18:51 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72899222C3;
        Fri,  3 Jan 2020 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578035930;
        bh=FV053rnnc3Ysq//ItKxgra7oEosNJ8yKfv9gjd3Akao=;
        h=From:To:Cc:Subject:Date:From;
        b=jzgTO2MqtxBwsNZQ8PN9KIeVu9nevlCM/egS/oKHH34BfyhH+O3qwNe/11pHQE+2c
         qJJnU1488/tJXT56WynIKr0FXlxgcqMFhs6cEEkYZ2X/fd7MZ2aOhnQw6wSIb/Y8bK
         QCxSt9n1aOpQLsKv6BcOS/lZhjk72rYAgLUsrZpY=
Received: by wens.tw (Postfix, from userid 1000)
        id BCD7E5FC7C; Fri,  3 Jan 2020 15:18:48 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: r40: Export MBUS clock
Date:   Fri,  3 Jan 2020 15:18:48 +0800
Message-Id: <20200103071848.3977-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The MBUS clock needs to be referenced in the MBUS device node.
Export it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 4 ----
 include/dt-bindings/clock/sun8i-r40-ccu.h | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
index a69637b6b0c1..6f7071df8e1c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
@@ -55,10 +55,6 @@
 
 /* Some more module clocks are exported */
 
-#define CLK_MBUS		155
-
-/* Another bunch of module clocks are exported */
-
 #define CLK_NUMBER		(CLK_OUTB + 1)
 
 #endif /* _CCU_SUN8I_R40_H_ */
diff --git a/include/dt-bindings/clock/sun8i-r40-ccu.h b/include/dt-bindings/clock/sun8i-r40-ccu.h
index f9e15a235626..d7337b55a4ef 100644
--- a/include/dt-bindings/clock/sun8i-r40-ccu.h
+++ b/include/dt-bindings/clock/sun8i-r40-ccu.h
@@ -176,7 +176,7 @@
 #define CLK_AVS			152
 #define CLK_HDMI		153
 #define CLK_HDMI_SLOW		154
-
+#define CLK_MBUS		155
 #define CLK_DSI_DPHY		156
 #define CLK_TVE0		157
 #define CLK_TVE1		158
-- 
2.24.1

