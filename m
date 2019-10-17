Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43636DB81A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 22:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395051AbfJQUCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 16:02:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:57457 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393263AbfJQUCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:02:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 13:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="202489732"
Received: from marshy.an.intel.com ([10.122.105.159])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2019 13:02:23 -0700
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        olof@lixom.net, mripard@kernel.org, bjorn.andersson@linaro.org,
        arnd@arndb.de, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv1] arm64: defconfig: enable rsu driver
Date:   Thu, 17 Oct 2019 15:15:51 -0500
Message-Id: <1571343351-25788-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Enable Intel Stratix10 Remote System Update (RSU) driver

The Intel Remote System Update (RSU) driver provides a way for customers
to update the boot configuration of a Intel Stratix 10 SoC device with
significantly reduced risk of corrupting the bitstream storage and
bricking the system.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9adae4..0b626b2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -90,6 +90,7 @@ CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
+CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
-- 
2.7.4

