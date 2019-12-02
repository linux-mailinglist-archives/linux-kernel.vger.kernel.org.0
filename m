Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE92A10F2A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 23:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLBWFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 17:05:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:49170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfLBWFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:05:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9523AB2F1;
        Mon,  2 Dec 2019 22:05:46 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     Cheng-Yu Lee <cylee12@realtek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [RFC 4/5] arm64: dts: realtek: rtd129x: Add SB2 sem nodes
Date:   Mon,  2 Dec 2019 23:05:34 +0100
Message-Id: <20191202220535.6208-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202220535.6208-1-afaerber@suse.de>
References: <20191202220535.6208-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes to SB2 for hardware sempaphores in RTD1295 SoC family.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 39aefe66a794..93ab6fdd03d4 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -193,3 +193,17 @@
 		status = "disabled";
 	};
 };
+
+&sb2 {
+	sb2_hd_sem: hwspinlock@0 {
+		compatible = "realtek,rtd1195-sb2-sem";
+		reg = <0x0 0x4>;
+		#hwlock-cells = <0>;
+	};
+
+	sb2_hd_sem_new: hwspinlock@620 {
+		compatible = "realtek,rtd1195-sb2-sem";
+		reg = <0x620 0x20>;
+		#hwlock-cells = <1>;
+	};
+};
-- 
2.16.4

