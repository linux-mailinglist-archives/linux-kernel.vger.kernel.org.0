Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8E95ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 14:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfHTMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 08:36:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfHTMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:35:59 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkYoK-1igE8J2vvC-00m1Xj; Tue, 20 Aug 2019 14:35:49 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 1/9] drivers: ata: ahci_octeon: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:40 +0200
Message-Id: <1566304548-19972-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:19J2XSPCk+I/viSh5iyQa/yxyvInlBQRvuSLFAGqJIGLIQ5m7JT
 w92Df6oXLjJ1wIZGi6PVbYdoG114M6ozQvNXvi5fnevA881eYYtaTrB9PuKgtzx/s9jl32c
 I+hxBr0HSCaKKba/8P8WLWqjajf2WVwX7SND09cfYPQjM3jNnBxjUn4dNABjwzv6fHYLSG3
 NNAAMXn2rAK5zH68gCcNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1v9EQ0hAFo=:OdvgjeT4RSR+MmWeET+OXc
 e1FxY4T3UBE8o1xfMkTh9sI4/YvR9px1fFxQftfC2L9QeNFkhOvhtMlgko38BzK9QW1SiB+Xz
 I0K+RfAHkBOSsxdQe/cIjZrphVQQQprvCHw7Bp8Rs680Cd0s7wQG6JqxJZ5IwSkFuQ4aumccS
 vkBGe2gwjXtxwGdSU6cqxgz/1k477E5ojt114G0+S0TP/aimgWbvJKUUZuLtKnzuQ6t6s9ZbC
 1yufO5bBupeyK6/GI22xLC0+PbXmXS58eV/UToL8NEC5FXpWLILnvDBPOpgYHwbJMuLM+rY7V
 nCvHCyDyb2BIOD5Sv78+Oybln8hjjarsEQ7R4X17F2zVDUoxP6BuDfuJIl16y3X9CUOFehKL1
 +cEU4X30KIBpeH3bvN4K9boAf6fqBlZtEsTfnk53CjEWo560oIUI7Mps3jloPXKWQtFlIgqDn
 5P6syF+6kIn20rWgZdnctSQxka6CkRdiL8LuutJ01Spa5lI58KwSOfAYcixRktYU3GcL9oub3
 W+0SBQnc8+JtuDgZrFcjNsZS3i0ZPonmJyOBB2wLZ9weBwG9Yx4WTaicC2QefpmjpKMYmjRTE
 jWQNX2NQJFXL17o4DkopvZ3Ar41VIeBujlyeBohWnOmh+a8LZZWLi2XAkXInftOF+Ymmlt59N
 suv4mpHBUvugeNf5k7SD8r0PZobWRBdEDBWOIbkbc+H21tRiB91PStjl9X6vr1vRMIZeUFABu
 Wy4yxhzpggeZMvAWp03P7gWh1BD+4OjYPW7O4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/ahci_octeon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
index 5a44e08..2280180 100644
--- a/drivers/ata/ahci_octeon.c
+++ b/drivers/ata/ahci_octeon.c
@@ -32,13 +32,11 @@ static int ahci_octeon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct resource *res;
 	void __iomem *base;
 	u64 cfg;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
1.9.1

