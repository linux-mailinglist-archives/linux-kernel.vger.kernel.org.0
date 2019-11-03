Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179CBED162
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 02:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKCBhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 21:37:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727476AbfKCBg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:36:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED297B248;
        Sun,  3 Nov 2019 01:36:55 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC 08/11] soc: realtek: chip: Detect RTD1293
Date:   Sun,  3 Nov 2019 02:36:42 +0100
Message-Id: <20191103013645.9856-9-afaerber@suse.de>
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

Logic self-determined by comparing DS418j and DS418 registers.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/soc/realtek/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
index ba653c097644..f4b26fb048c7 100644
--- a/drivers/soc/realtek/chip.c
+++ b/drivers/soc/realtek/chip.c
@@ -59,6 +59,8 @@ static const char *rtd1295_name(struct device *dev, const struct rtd_soc *s)
 		u32 chipinfo1 = readl_relaxed(base);
 		iounmap(base);
 		if (chipinfo1 & BIT(11)) {
+			if (chipinfo1 & BIT(4))
+				return "RTD1293";
 			return "RTD1296";
 		}
 	}
-- 
2.16.4

