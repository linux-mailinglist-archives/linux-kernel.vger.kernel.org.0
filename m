Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985F4B9E90
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 17:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438187AbfIUPS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 11:18:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438051AbfIUPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:18:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so5390282wmd.3;
        Sat, 21 Sep 2019 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sYgvwAlg3z2NoNGVW6A6jmGOMPpzZ3tKhXpaeUm/O6Q=;
        b=CcvR8pSUPE/CqoIlscC6HHjjbhJBRA6cR9rHqe2tXclN/aDu6ORrc9GbOHt2shnNDw
         X8o92SZ279Ko7roD9VfxYfLnfiCRmnOclYH1rCYuz74nLUNWoJoLp05p1mNvOxcPzDus
         nUThR2EC83Mg0L2YYSGgRhE9T9JUP9ck2uOXjklXYVCi7I3WbJ+gr7bFDkYk5DZ9Am6M
         tHm/tBRkGjF5twCXQrVrrROqe0gSvW7V5JGfUnBQZGe8qW4DIID7y6NoLFBifg3U8wHh
         GjW5SsOvTiB4h7M4mds6WpQcuhvm1Yro3evPpjFzRh+/rY2Ja3XXIW19MiBtB46s2PIv
         UJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sYgvwAlg3z2NoNGVW6A6jmGOMPpzZ3tKhXpaeUm/O6Q=;
        b=hY5fHDowI/mk8Ov1G1x0fEyKId42qvYxwAXT6HGEARSR1MViJ05gPUhOeJqO0ZLf3t
         G+kcOycLwPR8i0QCAMyR18jL4ZRkG6zEeBs0buWfvwmdrxbb/Mf/y0E3fy0isY023Mx/
         E4R0icxH94xdajyN29uUvPArGqpNP1qLHVQIgGN4SIHBdluyDp5bXpRyaFHOfkUtIYaa
         AdEGbtc5f/c5PaHggMMvRYLE9EriXv9xlejbvkulP1aKu9VtVRuISpHiKXuOR0T0YLkd
         IrB354wZcoxY7J2X+c3gRU0jrA6mx/PYu2Kzoj70WOkzvxnx5BZXc8TErK90tHBzjd1E
         dctQ==
X-Gm-Message-State: APjAAAUTQDtSB2rmssSrE+UBFLbM72HVAvL29Tqo45mJyWZr/ioKAQWN
        qy5hOeRAlVL2Hx+NGYmxZdc=
X-Google-Smtp-Source: APXvYqy+KMsgdqfL9HstYrcK547RRLoZc2AyZT4uPxQ821/58EolgipnHxjUr/qst/LC5Kh4PrlJzg==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr7303964wmj.159.1569079131119;
        Sat, 21 Sep 2019 08:18:51 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id c6sm6003120wrb.60.2019.09.21.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:18:50 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/6] clk: meson: meson8b: use of_clk_hw_register to register the clocks
Date:   Sat, 21 Sep 2019 17:18:32 +0200
Message-Id: <20190921151835.770263-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from clk_hw_register to of_clk_hw_register so we can use
clk_parent_data.fw_name. This will be used to get the "xtal", "ddr_pll"
and possibly others from the .dtb.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 15ec14fde2a0..fefb4b7185d0 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3696,7 +3696,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 		if (!clk_hw_onecell_data->hws[i])
 			continue;
 
-		ret = clk_hw_register(NULL, clk_hw_onecell_data->hws[i]);
+		ret = of_clk_hw_register(np, clk_hw_onecell_data->hws[i]);
 		if (ret)
 			return;
 	}
-- 
2.23.0

