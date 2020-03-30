Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9F1197E70
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgC3Od5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 10:33:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727183AbgC3Od4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:33:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BB7AD162473A5A092442;
        Mon, 30 Mar 2020 22:32:06 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 22:31:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mporter@kernel.crashing.org>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>
CC:     <alistair@popple.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] powerpc/44x: Make AKEBONO depends on NET
Date:   Mon, 30 Mar 2020 22:31:53 +0800
Message-ID: <20200330143153.32800-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Kconfig warnings:

WARNING: unmet direct dependencies detected for NETDEVICES
  Depends on [n]: NET [=n]
  Selected by [y]:
  - AKEBONO [=y] && PPC_47x [=y]

WARNING: unmet direct dependencies detected for ETHERNET
  Depends on [n]: NETDEVICES [=y] && NET [=n]
  Selected by [y]:
  - AKEBONO [=y] && PPC_47x [=y]

AKEBONO select NETDEVICES and ETHERNET unconditionally,
If NET is not set, build fails. Add this dependcy to fix this.

Fixes: 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/44x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 25ebe634a661..394f662d7df2 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -199,6 +199,7 @@ config FSP2
 config AKEBONO
 	bool "IBM Akebono (476gtr) Support"
 	depends on PPC_47x
+	depends on NET
 	select SWIOTLB
 	select 476FPE
 	select PPC4xx_PCI_EXPRESS
-- 
2.17.1


