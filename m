Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5CB119D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEBNMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 09:12:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36950 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBNMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:12:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id y5so2587789wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eKIBFVCyfU3z9K0Nkrbe4x8CjJi0tFioNqDYhFc5R0=;
        b=dr5NFFsHzVONa3dE3FwJEUNK3jJWutA5uirz+FdNEsOKyW9jtLLjOprjU7P5Dd/0rg
         2eWQ1QAm/Edl/2pyCcl5BwSZvKFykMHnrZlBmf58HKiOVkhrGLrubYLoZlHrnkWRQBgQ
         8CE2/0KNaS4NvFw8Fw3kypj1SKzhH8ilkPjtYzjiUsYZ9GIA08s4+U8kkP3LJGdcFxCc
         DfNYfE6omUGxYetreHAXNTxWjIGfvwdjqaxBmPS9txbdThNiFnKk/Z69050gYJcAIYda
         jWXPINAK5gn7kg4xzcbEHfmz0UWNK61kgKVY03AgBUMFosoIu8AMxw1VRicxiuNfPoUM
         AEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eKIBFVCyfU3z9K0Nkrbe4x8CjJi0tFioNqDYhFc5R0=;
        b=NkBEzGU6Ul3mibrSt70gW791HsW3WFci/6oVNEJBCBHiTsgQRxmWpbu2bbd7HfGk0m
         Z40ZGJ+oKwgfRx1fxY8b5ICA8h4oILV8dd7tc8xNMvErM8W3Dws/2Xnni2I3t29/lBFs
         CzKBB5hgs4RI9I/2nBlJFEms3px69i4m1XdN5mBlYuMA+frf+Ox23oWiQiD6QZpvPhdy
         3aoSEBUC5U0tp7lvDaO1uqK9+4oUDynhvakc0ERbhnliqHlbRFJviMgPvR9a7VKskx5k
         xeI2e6cXhVLVy4xutG8fkrUJVtr7cgvA0mx7dInahCAa9Oqj7W337aMdfSCLc/AGTmJq
         25AA==
X-Gm-Message-State: APjAAAUeu4yw2BRTuJPGS2FZVfhOzP75uYCdxNorywkw6LKdwbzAtijm
        XqaBjJ+3wWlC+A2SaU/x7j5k/A==
X-Google-Smtp-Source: APXvYqzZgK/pMDB9Xf3fEjr0tmm3/b9kba6qmyNpc31/HAcsxLdTuDfW/bsw/tKB5/jGsEYL+pWpdw==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr2286133wmb.110.1556802737876;
        Thu, 02 May 2019 06:12:17 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-8-187.w90-86.abo.wanadoo.fr. [90.86.125.187])
        by smtp.gmail.com with ESMTPSA id n6sm8713956wmn.48.2019.05.02.06.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 06:12:17 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2] ASoC: mediatek: mt8516: register ADDA DAI
Date:   Thu,  2 May 2019 15:12:14 +0200
Message-Id: <20190502131214.24009-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the ADDA DAI driver into the MT8516 PCM driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

This patch depends on patch serie:
	[PATCH 0/5] ASoC: mediatek: Add basic PCM driver for MT8516

v2:
	* Register ADDA before memif to fix ordering issue.

---
 sound/soc/mediatek/mt8516/mt8516-afe-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt8516/mt8516-afe-pcm.c b/sound/soc/mediatek/mt8516/mt8516-afe-pcm.c
index 84fbb5dbbd14..dea9221c67aa 100644
--- a/sound/soc/mediatek/mt8516/mt8516-afe-pcm.c
+++ b/sound/soc/mediatek/mt8516/mt8516-afe-pcm.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 
+#include "mt8516-afe-common.h"
 #include "mt8516-afe-regs.h"
 
 #include "../common/mtk-afe-platform-driver.h"
@@ -669,6 +670,7 @@ static int mt8516_dai_memif_register(struct mtk_base_afe *afe)
 
 typedef int (*dai_register_cb)(struct mtk_base_afe *);
 static const dai_register_cb dai_register_cbs[] = {
+	mt8516_dai_adda_register,
 	mt8516_dai_memif_register,
 };
 
-- 
2.20.1

