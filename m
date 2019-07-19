Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 507F66EACC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfGSSqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 14:46:04 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:48270 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727618AbfGSSqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:46:04 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E7A17C0089;
        Fri, 19 Jul 2019 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563561964; bh=a1asybTUPoXPdVigAZxuS9IKo7g1CCQ4rNlJLzJjBM0=;
        h=From:To:Cc:Subject:Date:From;
        b=gwaRnNKGTHW7BxpoWauP/KRzeqsHtp/N+TBTMa5qmEcRwVsSN2b6Wae+dRkRivsPo
         4HQJn++dwgwis40Gcf+Es97IXxTQZto/KBX4GWaXafgbKDGmJauUyrWGWSLiSZb4ei
         ojP1z3xfioHv/W36iueB+kmqOpQK2jDoNhzoRZJSvRWpve1u/51VNfmj8rVEv9eQN+
         c/iHW1WyOPRy9zZGHiweyML4OtborbDla41hXIEkFHj6hyAkfye405mj8u1lhjcdi6
         u2N9f8qEuCMaACrTanTTDnWxnFegf+bTc8lDhXsGeaatoJ02rBuvo8wKTDo5Pcoldm
         QQZ0O3vbDUQDw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 333EBA0057;
        Fri, 19 Jul 2019 18:46:02 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: fix typo in setup_dma_ops log message
Date:   Fri, 19 Jul 2019 21:46:00 +0300
Message-Id: <20190719184600.23188-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 0bf1468c35a3..e9cd0a1733bf 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -158,6 +158,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (is_isa_arcv2() && ioc_enable && coherent)
 		dev->dma_coherent = true;
 
-	dev_info(dev, "use %sncoherent DMA ops\n",
+	dev_info(dev, "use %scoherent DMA ops\n",
 		 dev->dma_coherent ? "" : "non");
 }
-- 
2.21.0

