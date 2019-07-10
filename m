Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BD640BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 07:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGJFde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 01:33:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42379 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGJFdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:33:33 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hl5EQ-0001zL-HT; Wed, 10 Jul 2019 05:33:31 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     eric.piel@tremplin-utc.net, dvhart@infradead.org,
        andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] platform/x86: hp_accel: Add support for HP ZBook 17 G5
Date:   Wed, 10 Jul 2019 13:33:26 +0800
Message-Id: <20190710053326.26247-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP ZBook 17 G5 needs a non-standard mapping, x_inverted.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/platform/x86/hp_accel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index f61b8a176e20..cfc0e36a7a5e 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -239,6 +239,7 @@ static const struct dmi_system_id lis3lv02d_dmi_ids[] = {
 	AXIS_DMI_MATCH("HPB64xx", "HP EliteBook 84", xy_swap),
 	AXIS_DMI_MATCH("HPB65xx", "HP ProBook 65", x_inverted),
 	AXIS_DMI_MATCH("HPZBook15", "HP ZBook 15", x_inverted),
+	AXIS_DMI_MATCH("HPZBook17G5", "HP ZBook 17 G5", x_inverted),
 	AXIS_DMI_MATCH("HPZBook17", "HP ZBook 17", xy_swap_yz_inverted),
 	{ NULL, }
 /* Laptop models without axis info (yet):
-- 
2.17.1

