Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185F6F00A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbfKEPEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 10:04:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49943 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbfKEPEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:04:07 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iS0ND-0003AZ-ML; Tue, 05 Nov 2019 15:03:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] crypto: allwinner: fix some spelling mistakes
Date:   Tue,  5 Nov 2019 15:03:59 +0000
Message-Id: <20191105150359.61379-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in dev_warn and dev_err messages. Fix these.
Change "recommandation" to "recommendation" and "tryed" to "tried".

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Fix "tryed"

---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 4 ++--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 8e4eddbcc814..73a7649f915d 100644
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
@@ -513,7 +513,7 @@ static int sun8i_ce_register_algs(struct sun8i_ce_dev *ce)
 			break;
 		default:
 			ce_algs[i].ce = NULL;
-			dev_err(ce->dev, "ERROR: tryed to register an unknown algo\n");
+			dev_err(ce->dev, "ERROR: tried to register an unknown algo\n");
 		}
 	}
 	return 0;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index e58407ac256b..b90c2e6c1393 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -446,7 +446,7 @@ static int sun8i_ss_register_algs(struct sun8i_ss_dev *ss)
 			break;
 		default:
 			ss_algs[i].ss = NULL;
-			dev_err(ss->dev, "ERROR: tryed to register an unknown algo\n");
+			dev_err(ss->dev, "ERROR: tried to register an unknown algo\n");
 		}
 	}
 	return 0;
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

