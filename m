Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C762176D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 04:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCCDRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 22:17:16 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7361 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgCCDRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:17:15 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e5dcc185cb-c2027; Tue, 03 Mar 2020 11:16:40 +0800 (CST)
X-RM-TRANSID: 2ee65e5dcc185cb-c2027
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.8.194])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e5dcc1237d-b51a3;
        Tue, 03 Mar 2020 11:16:40 +0800 (CST)
X-RM-TRANSID: 2ee25e5dcc1237d-b51a3
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     jun.nie@linaro.org
Cc:     shawnguo@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] =?UTF-8?q?ARM:mach-zx=EF=BC=9Aremove=20duplicate=20debug?= =?UTF-8?q?=20message?=
Date:   Tue,  3 Mar 2020 11:17:25 +0800
Message-Id: <20200303031725.14560-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove duplicate dev_err message, because of
devm_ioremap_resource, which has already contains.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 arch/arm/mach-zx/zx296702-pm-domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
index 7a08bf9dd..ac44ea8e6 100644
--- a/arch/arm/mach-zx/zx296702-pm-domain.c
+++ b/arch/arm/mach-zx/zx296702-pm-domain.c
@@ -169,10 +169,8 @@ static int zx296702_pd_probe(struct platform_device *pdev)
 	}
 
 	pcubase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pcubase)) {
-		dev_err(&pdev->dev, "ioremap fail.\n");
+	if (IS_ERR(pcubase))
 		return -EIO;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
 		pm_genpd_init(zx296702_pm_domains[i], NULL, false);
-- 
2.20.1.windows.1



