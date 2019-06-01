Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7F320C9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFAViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 17:38:12 -0400
Received: from www17.your-server.de ([213.133.104.17]:50146 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFAViM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 17:38:12 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hXBha-0007jK-AF; Sat, 01 Jun 2019 23:38:10 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hXBha-000HtO-3s; Sat, 01 Jun 2019 23:38:10 +0200
From:   Thomas Meyer <thomas@m3y3r.de>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] counter: ftm-quaddec: needs HAS_IOMEM
Date:   Sat,  1 Jun 2019 23:38:05 +0200
Message-Id: <20190601213805.32733-1-thomas@m3y3r.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25467/Sat Jun  1 10:00:07 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the driver fails for UML with:
drivers/counter/ftm-quaddec.c:301: undefined reference to `devm_ioremap'

Fix it by depending on HAS_IOMEM
---
 drivers/counter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 138ecd8a8fbd..6298344b536b 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -50,6 +50,7 @@ config STM32_LPTIMER_CNT
 	  module will be called stm32-lptimer-cnt.
 
 config FTM_QUADDEC
+	depends on HAS_IOMEM
 	tristate "Flex Timer Module Quadrature decoder driver"
 	help
 	  Select this option to enable the Flex Timer Quadrature decoder
-- 
2.21.0

