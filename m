Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA3F0081
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbfKEO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:58:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388842AbfKEO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:58:54 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iS0I9-0002nP-Av; Tue, 05 Nov 2019 14:58:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: allwinner: fix spelling mistake "recommandation" -> "recommendation"
Date:   Tue,  5 Nov 2019 14:58:45 +0000
Message-Id: <20191105145845.60786-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in dev_warn messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 8e4eddbcc814..bc7ee265c51f 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -469,7 +469,7 @@ static int sun8i_ce_get_clks(struct sun8i_ce_dev *ce)
 		}
 		if (ce->variant->ce_clks[i].max_freq > 0 &&
 		    cr > ce->variant->ce_clks[i].max_freq)
-			dev_warn(ce->dev, "Frequency for %s (%lu hz) is higher than datasheet's recommandation (%lu hz)",
+			dev_warn(ce->dev, "Frequency for %s (%lu hz) is higher than datasheet's recommendation (%lu hz)",
 				 ce->variant->ce_clks[i].name, cr,
 				 ce->variant->ce_clks[i].max_freq);
 	}
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index e58407ac256b..04b5b90ba965 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -502,7 +502,7 @@ static int sun8i_ss_get_clks(struct sun8i_ss_dev *ss)
 		}
 		if (ss->variant->ss_clks[i].max_freq > 0 &&
 		    cr > ss->variant->ss_clks[i].max_freq)
-			dev_warn(ss->dev, "Frequency for %s (%lu hz) is higher than datasheet's recommandation (%lu hz)",
+			dev_warn(ss->dev, "Frequency for %s (%lu hz) is higher than datasheet's recommendation (%lu hz)",
 				 ss->variant->ss_clks[i].name, cr,
 				 ss->variant->ss_clks[i].max_freq);
 	}
-- 
2.20.1

