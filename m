Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D64C194F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 04:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgC0DEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 23:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgC0DEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:04:34 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8583220857;
        Fri, 27 Mar 2020 03:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585278273;
        bh=2uJLg57w9K3mdmYUt+UHszaAmzyB1xXlE3THzJt2TCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EP0qvsoVxqsCUwMTr7AtDaBjvzY0UObeTlo/fKBJOi35vEjgzdsYhv7XEVEPzke2K
         2206sFq6nv6RCrfbFQqU37cxvzOBfoVgE+wz5fJjtrVC63g/v7mRHuLhLbFTwfC54P
         UamtERLfiEId5jImBWYSwIv9VIKJYZ7bLJdUP0i0=
Received: by wens.tw (Postfix, from userid 1000)
        id 5AC2C60013; Fri, 27 Mar 2020 11:04:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: rockchip: rk3399: drop #address-cells, #size-cells from pmugrf node
Date:   Fri, 27 Mar 2020 11:04:13 +0800
Message-Id: <20200327030414.5903-6-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327030414.5903-1-wens@kernel.org>
References: <20200327030414.5903-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The device tree compiler gives the following warning:

    /syscon@ff100000: unnecessary #address-cells/#size-cells without
    "ranges" or child "reg" property

Since the pmygrf node only has an io-domains child node that has no
reg property, remove the two properties from the pmugrf node to silence
the warning.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 74f2c3d49095..3499d1497127 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1124,8 +1124,6 @@ pd_vopl@RK3399_PD_VOPL {
 	pmugrf: syscon@ff320000 {
 		compatible = "rockchip,rk3399-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff320000 0x0 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 
 		pmu_io_domains: io-domains {
 			compatible = "rockchip,rk3399-pmu-io-voltage-domain";
-- 
2.25.1

