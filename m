Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9B1561D1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 01:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgBHAMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 19:12:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59431 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgBHAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 19:12:38 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j0Dj4-0003zz-4A; Sat, 08 Feb 2020 00:11:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: wcd934x: remove redundant null checks on rx_chs and tx_chs
Date:   Sat,  8 Feb 2020 00:11:57 +0000
Message-Id: <20200208001157.787675-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The null checks on wcd->rx_chs and wcd->tx_chs are redundant as
these objects are arrays and not pointers and hence can never be
null. Remove the redundant null checks.

Addresses-Coverity: ("Array compared against 0")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/wcd934x.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 158e878abd6c..e780ecd554d2 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1883,20 +1883,16 @@ static int wcd934x_set_channel_map(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	if (wcd->rx_chs) {
-		wcd->num_rx_port = rx_num;
-		for (i = 0; i < rx_num; i++) {
-			wcd->rx_chs[i].ch_num = rx_slot[i];
-			INIT_LIST_HEAD(&wcd->rx_chs[i].list);
-		}
+	wcd->num_rx_port = rx_num;
+	for (i = 0; i < rx_num; i++) {
+		wcd->rx_chs[i].ch_num = rx_slot[i];
+		INIT_LIST_HEAD(&wcd->rx_chs[i].list);
 	}
 
-	if (wcd->tx_chs) {
-		wcd->num_tx_port = tx_num;
-		for (i = 0; i < tx_num; i++) {
-			wcd->tx_chs[i].ch_num = tx_slot[i];
-			INIT_LIST_HEAD(&wcd->tx_chs[i].list);
-		}
+	wcd->num_tx_port = tx_num;
+	for (i = 0; i < tx_num; i++) {
+		wcd->tx_chs[i].ch_num = tx_slot[i];
+		INIT_LIST_HEAD(&wcd->tx_chs[i].list);
 	}
 
 	return 0;
-- 
2.24.0

