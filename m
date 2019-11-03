Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9BED15B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 02:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKCBg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 21:36:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727503AbfKCBg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:36:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B597CB30C;
        Sun,  3 Nov 2019 01:36:56 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC 10/11] soc: realtek: chip: Detect RTD1294
Date:   Sun,  3 Nov 2019 02:36:44 +0100
Message-Id: <20191103013645.9856-11-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103013645.9856-1-afaerber@suse.de>
References: <20191103013645.9856-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detection logic from downstream include/soc/realtek/rtd129x_cpu.h.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/soc/realtek/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
index f4b26fb048c7..e13339a4ca2e 100644
--- a/drivers/soc/realtek/chip.c
+++ b/drivers/soc/realtek/chip.c
@@ -54,6 +54,14 @@ static const char *rtd1295_name(struct device *dev, const struct rtd_soc *s)
 {
 	void __iomem *base;
 
+	base = of_iomap(dev->of_node, 2);
+	if (base) {
+		u32 efuse = readl_relaxed(base);
+		iounmap(base);
+		if ((efuse & 0x3) == 0x1)
+			return "RTD1294";
+	}
+
 	base = of_iomap(dev->of_node, 1);
 	if (base) {
 		u32 chipinfo1 = readl_relaxed(base);
-- 
2.16.4

