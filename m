Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA526E2F04
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409193AbfJXKbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 06:31:47 -0400
Received: from onstation.org ([52.200.56.107]:37222 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391490AbfJXKbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:31:45 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A35873F234;
        Thu, 24 Oct 2019 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1571913104;
        bh=LJ77z04oPHnTQ196HzGAyUMjxpEEXbUu/j6tV9O9FFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJqIvTxp+2Rl+TwcrLlHa0ns1XtBISRsjRB8RShqf9Z8RDuA0uwiFJMtjSuIjEQPQ
         np/0OUrTeOh/374+mpmwx8j3FI6Shh88dLnMzslzvLVX8rWrGSmVOFggHsUA48yScw
         QeYrcB/q/6XaBJ8gaAWoqhGn758xv3iKjDjZ/Fms=
From:   Brian Masney <masneyb@onstation.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 1/4] ARM: qcom_defconfig: add msm8974 interconnect support
Date:   Thu, 24 Oct 2019 06:31:37 -0400
Message-Id: <20191024103140.10077-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024103140.10077-1-masneyb@onstation.org>
References: <20191024103140.10077-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect support for msm8974-based SoCs in order to support the
GPU on this platform.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- Set CONFIG_INTERCONNECT=y since its now a bool instead of a tristate

 arch/arm/configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 9792dd0aae0c..cbe4e1d86f9a 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -252,6 +252,9 @@ CONFIG_PHY_QCOM_IPQ806X_SATA=y
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_QCOM_USB_HSIC=y
 CONFIG_QCOM_QFPROM=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_QCOM=y
+CONFIG_INTERCONNECT_QCOM_MSM8974=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-- 
2.21.0

