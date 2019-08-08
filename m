Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4A9861F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfHHMhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 08:37:09 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48216 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfHHMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:37:09 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 136CF5C0B09;
        Thu,  8 Aug 2019 14:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1565267827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=wtFe+lHH5wgW8y/mXg/CY0VkdqJZERhAhmOoK1c4XW0=;
        b=qJLZxufy6ebIcIQeo0NH8stt2lYEQJkO0N9X1O+7FewYQ0bhsOhsmJvyDc4Gy3qZQBEpRL
        9Z57C/em5CQK0zDHn0xW0LCttjt1WRiJPBM1x4LAQoZ5cUqPWLCOc7aRhIykPMyBrZ0+F2
        y+7iV8Pu+34fux8y/dUCwKzx1anKrzs=
From:   Stefan Agner <stefan@agner.ch>
To:     perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date:   Thu,  8 Aug 2019 14:36:55 +0200
Message-Id: <20190808123655.31520-1-stefan@agner.ch>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Deferred probes shouldn't cause error messages in the boot log. Avoid
printing with dev_err() in case EPROBE_DEFER is the return value.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
---
 sound/soc/soc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fd6eaae6c0ed..98e1e80b5493 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1985,9 +1985,11 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	mutex_lock(&client_mutex);
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = soc_init_dai_link(card, dai_link);
-		if (ret) {
+		if (ret && ret != -EPROBE_DEFER) {
 			dev_err(card->dev, "ASoC: failed to init link %s: %d\n",
 				dai_link->name, ret);
+		}
+		if (ret) {
 			mutex_unlock(&client_mutex);
 			return ret;
 		}
-- 
2.22.0

