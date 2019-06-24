Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0350B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfFXMqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 08:46:24 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:44050 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:46:23 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id UcmM2000b3XaVaC01cmM4B; Mon, 24 Jun 2019 14:46:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOMX-0003m4-KW; Mon, 24 Jun 2019 14:46:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOMX-0005j6-II; Mon, 24 Jun 2019 14:46:21 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of/platform: Drop superfluous cast in of_device_make_bus_id()
Date:   Mon, 24 Jun 2019 14:46:20 +0200
Message-Id: <20190624124620.21891-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to cast "u64" to "unsigned long long" before printing
it, as both types have been made identical on all architectures many
years ago.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312fd85b9a2a..efbff44581b3ee2a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -92,8 +92,7 @@ static void of_device_make_bus_id(struct device *dev)
 		reg = of_get_property(node, "reg", NULL);
 		if (reg && (addr = of_translate_address(node, reg)) != OF_BAD_ADDR) {
 			dev_set_name(dev, dev_name(dev) ? "%llx.%pOFn:%s" : "%llx.%pOFn",
-				     (unsigned long long)addr, node,
-				     dev_name(dev));
+				     addr, node, dev_name(dev));
 			return;
 		}
 
-- 
2.17.1

