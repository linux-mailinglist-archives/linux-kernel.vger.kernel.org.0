Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F41ED15D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 02:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKCBhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 21:37:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727523AbfKCBg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:36:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31BCFB30D;
        Sun,  3 Nov 2019 01:36:57 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [RFC 11/11] arm64: dts: realtek: rtd129x: Extend chip-info reg with efuse
Date:   Sun,  3 Nov 2019 02:36:45 +0100
Message-Id: <20191103013645.9856-12-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103013645.9856-1-afaerber@suse.de>
References: <20191103013645.9856-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This register is needed to detect RTD1294.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index fea7c1ed7d08..670efa86f661 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -87,7 +87,8 @@
 		chip-info@9801a200 {
 			compatible = "realtek,rtd1195-chip";
 			reg = <0x9801a200 0x8>,
-			      <0x98007028 0x4>;
+			      <0x98007028 0x4>,
+			      <0x980171d8 0x4>;
 		};
 
 		uart1: serial@9801b200 {
-- 
2.16.4

