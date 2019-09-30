Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A64C26F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfI3Uni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 16:43:38 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:41304 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbfI3Ung (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:43:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7F0ACFB04;
        Mon, 30 Sep 2019 22:26:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xEgkN38k9dzS; Mon, 30 Sep 2019 22:26:02 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id E7B5448995; Mon, 30 Sep 2019 22:26:01 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regulator: bd718x7: Add MODULE_ALIAS()
Date:   Mon, 30 Sep 2019 22:26:00 +0200
Message-Id: <46ce3400e227dd88d51486c02a6152c9ec52acbb.1569875042.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <cover.1569875042.git.agx@sigxcpu.org>
References: <cover.1569875042.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes device probing when built as a module

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/regulator/bd718x7-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index bdab46a5c461..13a43eee2e46 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1293,3 +1293,4 @@ module_platform_driver(bd718xx_regulator);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD71837/BD71847 voltage regulator driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd718xx-pmic");
-- 
2.23.0.rc1

