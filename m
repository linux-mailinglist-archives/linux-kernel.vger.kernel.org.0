Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC656333E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfFCPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:51:17 -0400
Received: from foss.arm.com ([217.140.101.70]:53608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfFCPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 823DD15AB;
        Mon,  3 Jun 2019 08:51:12 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CEC803F246;
        Mon,  3 Jun 2019 08:51:10 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Heiko Stuebner <heiko@sntech.de>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org
Subject: [RFC PATCH 09/57] drivers: sound: rockchip: rk3399: Use bus_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:49:35 +0100
Message-Id: <1559577023-558-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_of_node helper

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3d0cc6e..677c92c 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -405,11 +405,6 @@ static const struct dailink_match_data dailink_match[] = {
 	},
 };
 
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int rockchip_sound_codec_node_match(struct device_node *np_codec)
 {
 	struct device *dev;
@@ -421,8 +416,8 @@ static int rockchip_sound_codec_node_match(struct device_node *np_codec)
 			continue;
 
 		if (dailink_match[i].bus_type) {
-			dev = bus_find_device(dailink_match[i].bus_type, NULL,
-					      np_codec, of_dev_node_match);
+			dev = bus_find_device_by_of_node(dailink_match[i].bus_type,
+							 NULL, np_codec);
 			if (!dev)
 				continue;
 			put_device(dev);
-- 
2.7.4

