Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD30FDA59A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392664AbfJQG3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 02:29:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:63590 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390993AbfJQG3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:29:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 23:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,306,1566889200"; 
   d="scan'208";a="226051846"
Received: from unknown (HELO ubuntu.localdomain) ([10.226.250.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2019 23:29:07 -0700
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Ong Hean Loong <hean.loong.ong@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>
Subject: [PATCHv2] arm64: defconfig: add JFFS FS support in defconfig
Date:   Wed, 16 Oct 2019 23:28:52 -0700
Message-Id: <1571293732-13667-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds JFFS2 FS support and remove QSPI Sector 4K size force in
the default defconfig

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
v2: disable CONFIG_MTD_SPI_NOR_USE_4K_SECTORS using the correct syntax
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9adae4..6080c6e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -860,3 +860,5 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
+CONFIG_JFFS2_FS=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-- 
1.9.1

