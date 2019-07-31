Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3B7BA75
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfGaHPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 03:15:16 -0400
Received: from olimex.com ([184.105.72.32]:46116 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfGaHPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:15:15 -0400
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 00:15:12 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 1/1] nvmem: sunxi_sid: fix A64 SID controller support
Date:   Wed, 31 Jul 2019 10:14:47 +0300
Message-Id: <20190731071447.9019-2-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731071447.9019-1-stefan@olimex.com>
References: <20190731071447.9019-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like in H3, A64 SID controller doesn't return correct data
when using direct access. It appears that on A64, SID needs
8 bytes of word_size.

Workaround is to enable read by registers.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/nvmem/sunxi_sid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a079a80ddf2c..e26ef1bbf198 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -186,6 +186,7 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.value_offset = 0x200,
 	.size = 0x100,
+	.need_register_readout = true,
 };
 
 static const struct sunxi_sid_cfg sun50i_h6_cfg = {
-- 
2.17.1

