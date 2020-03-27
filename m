Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071B7194F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 04:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgC0DEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 23:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgC0DEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:04:31 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF45C20838;
        Fri, 27 Mar 2020 03:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585278271;
        bh=8MXvUhe8inX9HXIpiLsCZJCvYdR7WItcjnns2q40lSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkwZljV1t7R9L7Sc6xPD/OcRfpXE2YAR3x1kThL+7r65ipHs2524rF7MsGmTlS+FV
         1OHJ2ABxxeJZ4x03QCXOVvGKzhbPvueq2fFEnNZvcdkljbm5ympqqkgu2ix4kBc0k4
         h7ALLNgQDqc5Sy8oEWooMJquCMkYcmbH+csZ4EDY=
Received: by wens.tw (Postfix, from userid 1000)
        id 514785FF1C; Fri, 27 Mar 2020 11:04:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: rockchip: rk3328: drop #address-cells, #size-cells from grf node
Date:   Fri, 27 Mar 2020 11:04:12 +0800
Message-Id: <20200327030414.5903-5-wens@kernel.org>
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

Since none of the grf node's direct child nodes have any reg properties,
remove the two properties from the grf node to silence the warning.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b861b4fd75e6..a4d591d91533 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -299,8 +299,6 @@ &pdmm0_sdi2_sleep
 	grf: syscon@ff100000 {
 		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff100000 0x0 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 
 		io_domains: io-domains {
 			compatible = "rockchip,rk3328-io-voltage-domain";
-- 
2.25.1

