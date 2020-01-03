Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3971D12FAD3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 17:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgACQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 11:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgACQwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:52:16 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2449921734;
        Fri,  3 Jan 2020 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578070335;
        bh=GNr6Irv4ZHYaD0lADq4BHgVbO6AWrFxItDdiA1EIOyQ=;
        h=From:To:Subject:Date:From;
        b=hIYXmzwQSe0GJcYL5eJfh7B+W5SoNxd3n78lFtGRppNmkQbh4juqaawFJCNwACN31
         cqU8MaAIJvTtaEzbAvzIQ6RU+/dc0Z2tid7Fy0xzv5CsXtW5tU8uCD5Q9inVGV2MFc
         5B5nFs7Ges1vAFv5GQmDBQp8OMxXy2Ohp8MHRZic=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: exynos: Correct the help text for platform Kconfig option
Date:   Fri,  3 Jan 2020 17:52:08 +0100
Message-Id: <20200103165208.8287-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_EXYNOS option is used for entire ARMv7 Exynos family, including
also Exynos3 SoCs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-exynos/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 4ef56571145b..9fb045ab80e4 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -41,7 +41,7 @@ menuconfig ARCH_EXYNOS
 	select POWER_RESET_SYSCON
 	select POWER_RESET_SYSCON_POWEROFF
 	help
-	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
+	  Support for SAMSUNG EXYNOS SoCs
 
 if ARCH_EXYNOS
 
-- 
2.17.1

