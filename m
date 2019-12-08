Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC9311627B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 15:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLHOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 09:55:28 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33340 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfLHOz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:55:28 -0500
Received: from muedsl-82-207-238-043.citykom.de ([82.207.238.43] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1idxy1-00043q-L8; Sun, 08 Dec 2019 15:55:25 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: enable the gpu on px30-evb
Date:   Sun,  8 Dec 2019 15:55:08 +0100
Message-Id: <20191208145508.3124-3-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191208145508.3124-1-heiko@sntech.de>
References: <20191208145508.3124-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The px30 has a Mali Bifrost gpu, so enable it on the evb board
and connect it with its supplying regulator.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index f2fcca21c04d..180995a590c1 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -132,6 +132,11 @@ &gmac {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_log>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.24.0

