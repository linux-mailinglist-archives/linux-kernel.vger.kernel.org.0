Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB769185992
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 04:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgCODGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 23:06:44 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:19957 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCODGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:06:44 -0400
X-Greylist: delayed 3598 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Mar 2020 23:06:43 EDT
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02EENc8g044943;
        Sat, 14 Mar 2020 23:23:38 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Sat, 14 Mar 2020 23:23:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02EENYJY044932
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 14 Mar 2020 23:23:37 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] ARM: dts: rockchip: use DMA channels for UARTs of TinkerBoard
Date:   Sat, 14 Mar 2020 23:23:27 +0900
Message-Id: <20200314142327.25568-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables to use DMAC for all UARTs that are connected to
dmac_peri core for TinkerBoard.

Only uart2 is connected different DMAC (dmac_bus_s) so keep current
settings on this patch.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 312582c1bd37..6efabeaf3c6d 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -491,10 +491,14 @@ &tsadc {
 };
 
 &uart0 {
+	dmas = <&dmac_peri 1>, <&dmac_peri 2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
 &uart1 {
+	dmas = <&dmac_peri 3>, <&dmac_peri 4>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
@@ -503,10 +507,14 @@ &uart2 {
 };
 
 &uart3 {
+	dmas = <&dmac_peri 7>, <&dmac_peri 8>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
 &uart4 {
+	dmas = <&dmac_peri 9>, <&dmac_peri 10>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
-- 
2.25.1

