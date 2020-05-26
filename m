Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E500119BDAE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbgDBIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 04:41:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36719 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDBIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:41:18 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jJvPZ-0007o3-Mw; Thu, 02 Apr 2020 10:41:17 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jJvPZ-0000We-By; Thu, 02 Apr 2020 10:41:17 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] regmap: add reg_sequence helpers
Date:   Thu,  2 Apr 2020 10:41:11 +0200
Message-Id: <20200402084111.30123-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper to make it easier to define a reg_sequence array.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 include/linux/regmap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f0a092a1a96d..050a5aba4056 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -71,6 +71,13 @@ struct reg_sequence {
 	unsigned int delay_us;
 };
 
+#define REG_SEQ(_reg, _def, _delay_us) {		\
+				.reg = _reg,		\
+				.def = _def,		\
+				.delay_us = _delay_us,	\
+				}
+#define REG_SEQ0(_reg, _def)	REG_SEQ(_reg, _def, 0)
+
 #define	regmap_update_bits(map, reg, mask, val) \
 	regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
 #define	regmap_update_bits_async(map, reg, mask, val)\
-- 
2.20.1

