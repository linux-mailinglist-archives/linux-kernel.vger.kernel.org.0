Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAB3B596D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 03:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfIRBto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 21:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfIRBto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:49:44 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFCF4206C2;
        Wed, 18 Sep 2019 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568771384;
        bh=1pAv96NFGm8gZDp9S4+nLH8j6jWk8PocjMG/QGURbqY=;
        h=From:To:Cc:Subject:Date:From;
        b=a5S93t0/6DYLKSAgEshtfsPzGNzhmfU6ISFvLeY0vqgnC8h8RmTtF0hGsUrTU5Q+A
         csaJoo60NKjX2LFL+htbne6aaO7Vbc0HHewiRme4TSye6ViBwQBQO49zxGRPq9iWqn
         JgY+n2LqbcS00SxHuZr6Hh968wgWCg0R4Zl4EDqI=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, p.zabel@pengutronix.de
Subject: [PATCH] reset: build simple reset controller driver for Agilex
Date:   Tue, 17 Sep 2019 20:49:39 -0500
Message-Id: <20190918014939.16519-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel SoCFPGA Agilex platform shares the same reset controller that
is on the Stratix10.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 21efb7d39d62..280e69fbf86d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -118,7 +118,7 @@ config RESET_QCOM_PDC
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN
+	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_AGILEX
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
-- 
2.20.0

