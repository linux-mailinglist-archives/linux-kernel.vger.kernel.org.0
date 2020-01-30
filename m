Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776D814E301
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 20:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgA3TTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 14:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbgA3TTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:19:54 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8C5206D3;
        Thu, 30 Jan 2020 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580411994;
        bh=U/nSPCPNY5aQm78EL2stSwt65JQCEiKVRGoFmok1WQA=;
        h=From:To:Cc:Subject:Date:From;
        b=whZMIlV0IT+weEuj+TdmaWizef4yp0jlCBEBa7NxnxD/Cs+Bm4Hueh69RB9JQvZMr
         MPWLl89v1/iJPAtcaRjgEX4TNxf6/11C0HFeSQXvc2kKTW1LOT+N90mYsO3ZyZjjjv
         Ojxtw8lrGeZnnFL32LjNNrvlwIbKw3aFbwGkW6Hw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
Date:   Thu, 30 Jan 2020 20:19:38 +0100
Message-Id: <20200130191938.2444-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/openrisc/configs/or1ksim_defconfig    | 1 -
 arch/openrisc/configs/simple_smp_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index d8ff4f8ffb88..75f2da324d0e 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="or1k-linux-"
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 64278992df9c..ff49d868e040 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="or1k-linux-"
 CONFIG_LOCALVERSION="-simple-smp"
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
-- 
2.17.1

