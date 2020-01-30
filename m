Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C214E312
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgA3TWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 14:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgA3TWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:22:32 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D26205F4;
        Thu, 30 Jan 2020 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412151;
        bh=fr+r1JFKwTNHUZAlTHUgAmBUgo5GF6Vj/doAxVu5rqg=;
        h=From:To:Cc:Subject:Date:From;
        b=JbYeKvXcGD1dWDYC/V36ABinagP1DJ+J9e9MclGDhtvsSB7JfsdTGMv7jW+RKkN7p
         gaamCRKnr1suSZkgVZFouBNW6d+fGDVvSmCt3hkv0uUJzMO1+eQIhdndiqkuYEatx6
         XMhDWjAUxOmUdzhTOrKE3R+Hx/r5TJlrWzReBInA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] um: configs: Cleanup CONFIG_IOSCHED_CFQ
Date:   Thu, 30 Jan 2020 20:22:26 +0100
Message-Id: <20200130192226.2776-1-krzk@kernel.org>
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

