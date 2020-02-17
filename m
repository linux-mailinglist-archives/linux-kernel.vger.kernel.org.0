Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BE816183F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 17:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgBQQuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 11:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgBQQuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:50:55 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C61C215A4;
        Mon, 17 Feb 2020 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581958255;
        bh=fr+r1JFKwTNHUZAlTHUgAmBUgo5GF6Vj/doAxVu5rqg=;
        h=From:To:Subject:Date:From;
        b=nK9E7Rxj5yPNP6R7FG6IbW2+e1iFivVEUBbGTo8Mz3g2Cv2zpQINtnTBIKJNhlb2a
         kNaoYPOuxo0FaDQxeFXBg1bw5ml+McZhycFtzuEtSFdba6biseOfl13H/V7ksNa8+7
         u2g9uVLQi/4LN3rIbw6Xqm7ip5r2SoovsG8TOjcM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] um: configs: Cleanup CONFIG_IOSCHED_CFQ
Date:   Mon, 17 Feb 2020 17:50:48 +0100
Message-Id: <20200217165048.4711-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IOSCHED_CFQ is since commit f382fb0bcef4 ("block: remove legacy
IO schedulers").

The IOSCHED_BFQ seems to replace IOSCHED_CFQ so select it in configs
previously choosing the latter.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/um/configs/i386_defconfig   | 2 +-
 arch/um/configs/x86_64_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index 73e98bb57bf5..fb51bd206dbe 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -26,7 +26,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_IOSCHED_CFQ=m
+CONFIG_IOSCHED_BFQ=m
 CONFIG_SSL=y
 CONFIG_NULL_CHAN=y
 CONFIG_PORT_CHAN=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 3281d7600225..477b87317424 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -24,7 +24,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_IOSCHED_CFQ=m
+CONFIG_IOSCHED_BFQ=m
 CONFIG_SSL=y
 CONFIG_NULL_CHAN=y
 CONFIG_PORT_CHAN=y
-- 
2.17.1

