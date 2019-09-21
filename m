Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6161FB9E49
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394271AbfIUPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 11:04:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34208 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394261AbfIUPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:04:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so11620319wmc.1;
        Sat, 21 Sep 2019 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGv9DZLsLql8R0RI6uFoY3WPJO94bAE/bq+K0Di3JjU=;
        b=U4wBRIWkDsI4icvUsrtiriqteXBT0yMa+Xqw/3INETjgirlcoMtLUbdTCSP/DZ1ZQ5
         21NjqIWk1uACxeE90JxDe/JQtX/5AJS2ZBTdwW3Hh2d1YyXU37iLuTPWkHV/wW2yxqN8
         SuKZ2PkqY6F97Z0iSvzZRzGLw4aBw+f6y1ndSn6NHGGEmy59WJqlmOE84SXbrgFZKjOL
         WKi5zMpjOjVQJA6pwb6INga0YJ1/wIhO8Vu88eNkS4mB6LZZd1CiqWWxOav2KD2rHvx3
         V+GroTZC78nbo6KpCUinANLvJ0Gih6krhAtwkot15FwCBluKGKarVySBPS762dMsV6KA
         Uh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGv9DZLsLql8R0RI6uFoY3WPJO94bAE/bq+K0Di3JjU=;
        b=UI5JILsZS0b2W2FN8zgihEJOlR8WhWpLnUB1F2LHBAPtLY1+Dlq8zoXi5L1KB+9AyA
         Ei3/c1GCB8kp1qIQSQFZxdIWSuF4bRpBC+zh2KGFxWLxH+NOQBlEbKhEvBILK2KQ591m
         v2hoBogaAziFM/xsKE7WvUHhBb/xDA+UueBQn7ytniQPnH5T0VTj5W9kqTUAHyGONv7w
         XxHZgRNOgd6/izUfeyHGLIIlbRqZmmWkEJdU4xLeC85wUxSvhd3ejnw6fVBkAZTRD9M3
         NYvPLtmoIeEHSW910mUD2cMoy0g+sAjRqTj0IXFHhNOq0HZsFSyNbrbkKOEPt7lKFInl
         3OgQ==
X-Gm-Message-State: APjAAAXcUyvlQKDOBLDqw5Bwhzl3THAAfBjnjZZkCJSrj2Cx3aAW1alr
        9yWEDTrZgd3CK7XeUps/S8k=
X-Google-Smtp-Source: APXvYqynjJRqs2bHOp/DdMfbh05bDAD/XBKHx85KCLbrsN0bIXyPSuRIggxSw4x+yHMqdHzbOENSfw==
X-Received: by 2002:a1c:c789:: with SMTP id x131mr7235719wmf.20.1569078272512;
        Sat, 21 Sep 2019 08:04:32 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id r20sm10987422wrg.61.2019.09.21.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:04:31 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] clk: meson: gxbb: let sar_adc_clk_div set the parent clock rate
Date:   Sat, 21 Sep 2019 17:04:11 +0200
Message-Id: <20190921150411.767290-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson-saradc driver manually sets the input clock for
sar_adc_clk_sel. Update the GXBB clock driver (which is used on GXBB,
GXL and GXM) so the rate settings on sar_adc_clk_div are propagated up
to sar_adc_clk_sel which will let the common clock framework select the
best matching parent clock if we want that.

This makes sar_adc_clk_div consistent with the axg-aoclk and g12a-aoclk
drivers, which both also specify CLK_SET_RATE_PARENT.

Fixes: 33d0fcdfe0e870 ("clk: gxbb: add the SAR ADC clocks and expose them")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
This is a small consistency fix which I found while debugging an
unrelated problem.

 drivers/clk/meson/gxbb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 7cfb998eeb3e..1f9c056e684c 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -935,6 +935,7 @@ static struct clk_regmap gxbb_sar_adc_clk_div = {
 			&gxbb_sar_adc_clk_sel.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.23.0

