Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84578726F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 06:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfGXEum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 00:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfGXEuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:50:40 -0400
Received: from localhost.localdomain (unknown [171.76.105.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AED0218D4;
        Wed, 24 Jul 2019 04:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563943839;
        bh=hlM1s4FLsbIjVC/9yzo2YVwU4cWO7KsWH8fsbzhpJpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5mvUkHHHy7zeCF5Sg8O441OsavKgFCOVC9ygfi7YvtMln4SorItjrfovCn7Y/YGZ
         gZMs1A/+cI/rLnO1HPWifmo/JF3u6U/sssBEzUXtysSane+tjOk2sUDFt1jP3rhGl3
         FW8kmOHrqCAsvVYV8i6s7gtYk8bvkN/v2kRMpmfQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v2 2/5] arm64: dts: qcom: sdm845: remove unnecessary properties for dsi nodes
Date:   Wed, 24 Jul 2019 10:19:03 +0530
Message-Id: <20190724044906.12007-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724044906.12007-1-vkoul@kernel.org>
References: <20190724044906.12007-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning about unnecessary properties of

arch/arm64/boot/dts/qcom/sdm845.dtsi:2211.22-2257.6: Warning (avoid_unnecessary_addr_size): /soc/mdss@ae00000/dsi@ae94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm64/boot/dts/qcom/sdm845.dtsi:2278.22-2324.6: Warning (avoid_unnecessary_addr_size): /soc/mdss@ae00000/dsi@ae96000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

So, remove these properties

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e81f4a6d08ce..2985df032179 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2234,9 +2234,6 @@
 
 				status = "disabled";
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -2301,9 +2298,6 @@
 
 				status = "disabled";
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.20.1

