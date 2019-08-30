Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE9A35D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 13:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfH3LfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 07:35:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53680 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfH3LfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6JZ9zVy4CzgSqJ6r5Pl7nmn/QP9rfD93SSVyEhyjuBA=; b=kETRLSEsobvLH9yYw1HqEJwiu
        bTKrS7NuaStw13z67WZMPTLFyGaDLfQzX6i9l8W1jWhR+8SVZ5nWmjlTrWYmQLMDFcevp6v2ofzj2
        NkCZJ/iHBZSP2CI0/ACqEIrRDHgF8mUENVT479rqcH++W7rhuNnu2QQJWKV+LFXYEp5hE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3fBS-0006Gb-BR; Fri, 30 Aug 2019 11:35:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 612C12742B61; Fri, 30 Aug 2019 12:35:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] regulator: mt6358: Add BROKEN dependency while waiting for MFD to merge
Date:   Fri, 30 Aug 2019 12:35:10 +0100
Message-Id: <20190830113510.32287-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mt6358 driver was merged in error, it depends on an existing MFD
rather than a newly added one and needs updates to that driver.  Disable
the build until those are merged.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d6d8785630b1..3ee63531f6d5 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -621,7 +621,7 @@ config REGULATOR_MT6323
 
 config REGULATOR_MT6358
 	tristate "MediaTek MT6358 PMIC"
-	depends on MFD_MT6397
+	depends on MFD_MT6397 && BROKEN
 	help
 	  Say y here to select this option to enable the power regulator of
 	  MediaTek MT6358 PMIC.
-- 
2.20.1

