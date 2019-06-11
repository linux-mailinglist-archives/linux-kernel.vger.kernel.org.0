Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A143C9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 13:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfFKLGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 07:06:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50092 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfFKLGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:06:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BB6Qjg115824;
        Tue, 11 Jun 2019 06:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560251186;
        bh=I9BAb2CnQkexQ6+MTbnxM1piZ7sd2DzidzQh9fUybwY=;
        h=From:To:CC:Subject:Date;
        b=KvHnPTFH6ib8h2aJrX6N93zgm8KCeqiKCuKJ0ui8eYVScBtB6P89yBniberuoiiS/
         inxXARsdvQSNM/WWzZRNhdyX3670Ew7qqH7mNJB3A9DR9zVBS2c4AAeLRco7hOIpp7
         fvZaeo7VwlOHHczRw7RNfH3xcFk9aVMnrwAO9qws=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BB6Qmk022666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 06:06:26 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 06:06:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 06:06:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BB6P5r041192;
        Tue, 11 Jun 2019 06:06:26 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-next@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: cpts: fix build failure for powerpc
Date:   Tue, 11 Jun 2019 14:06:17 +0300
Message-ID: <20190611110617.8994-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dependency to TI CPTS from Common CLK framework COMMON_CLK to fix
allyesconfig build for Powerpc:

drivers/net/ethernet/ti/cpts.c: In function 'cpts_of_mux_clk_setup':
drivers/net/ethernet/ti/cpts.c:567:2: error: implicit declaration of function 'of_clk_parent_fill'; did you mean 'of_clk_get_parent_name'? [-Werror=implicit-function-declaration]
  of_clk_parent_fill(refclk_np, parent_names, num_parents);
  ^~~~~~~~~~~~~~~~~~
  of_clk_get_parent_name

Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index bd05a977ee7e..a800d3417411 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -60,6 +60,7 @@ config TI_CPSW
 config TI_CPTS
 	bool "TI Common Platform Time Sync (CPTS) Support"
 	depends on TI_CPSW || TI_KEYSTONE_NETCP || COMPILE_TEST
+	depends on COMMON_CLK
 	depends on POSIX_TIMERS
 	---help---
 	  This driver supports the Common Platform Time Sync unit of
-- 
2.17.1

