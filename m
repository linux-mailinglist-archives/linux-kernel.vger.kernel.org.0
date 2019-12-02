Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3C10EF1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfLBSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 13:22:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbfLBSWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E725AD75;
        Mon,  2 Dec 2019 18:22:19 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 14/14] dt-bindings: reset: rtd1295: Add SB2 reset
Date:   Mon,  2 Dec 2019 19:22:04 +0100
Message-Id: <20191202182205.14629-15-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202182205.14629-1-afaerber@suse.de>
References: <20191202182205.14629-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a constant for reset3 SB2, based on downstream crt_sys_reg.h.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 include/dt-bindings/reset/realtek,rtd1295.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/realtek,rtd1295.h b/include/dt-bindings/reset/realtek,rtd1295.h
index 2c0cb6afe816..dd89e4c80264 100644
--- a/include/dt-bindings/reset/realtek,rtd1295.h
+++ b/include/dt-bindings/reset/realtek,rtd1295.h
@@ -75,6 +75,9 @@
 #define RTD1295_RSTN_CBUS_TX		30
 #define RTD1295_RSTN_SDS_PHY		31
 
+/* soft reset 3 */
+#define RTD1295_RSTN_SB2		0
+
 /* soft reset 4 */
 #define RTD1295_RSTN_DCPHY_CRT		0
 #define RTD1295_RSTN_DCPHY_ALERT_RX	1
-- 
2.16.4

