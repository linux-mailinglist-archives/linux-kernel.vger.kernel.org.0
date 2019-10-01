Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A484C3FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 20:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfJASZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 14:25:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44641 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbfJASZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:25:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so5888392pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LzScokAJUZmfEzLyRgkBYA98Mp75br3n/i2JbQ8ioSU=;
        b=Eel1qi18Au+svdpZ7+XVj5a8bXyXORVjJPkq8MNCvHpEEiT0X2QJpv0kweG5dD01GT
         8jF1xfb3pML4lkci+3Mcza2vkDMURS9/pP2cU58heb6uUg/4zu/y8GXSNmzMXfFdp8f4
         oxBUb9ko7sRM7Sla0Mom37zphpvPzi7WrsMN68t3kNuqSBtu6BhkR1Kyzib3fILZYHAm
         I6BZSGvfJ6gJj8MER91eVYp2ty+rsdUeqYv1LEoiuoQl71QzvREzakFiQr1mwgVc2fyL
         9oYQ8mc6zZ6+SvhjeVy/wzaC7MRqeT4RvsidhvkAMDET1tVK6Y0ExYfznNAMET8JrzSD
         wbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LzScokAJUZmfEzLyRgkBYA98Mp75br3n/i2JbQ8ioSU=;
        b=KHqkFxEnoU5449qOvt1OxYVMF7Surs+XYO8n5FomZj4VLpUB2+JT/yHJ6GhA41lzdI
         LzTQBTcyEme11FDJpUnWdcd7YvvCKmn35cR8bz18GcdYG3zJBrIbeSUVpARQc3LzAV5N
         tInyjoEgmwjDobRShkIC1UcvQ2NqdUiK8NZziqmKFFUn6oAspKKoxu2iHkVDJlgMNCpu
         oLXZ+HMZQdowusFLG7G6x6xegz7dPfeRUBVPH2/9UF/d+3nZKfQbw0Gf4BCjoqjdX/wa
         BchsRUcf8NtJNIg5F8pGKVIaadqfY42PEWP+AvQf8lzBiJx++b6M/qLupejxDZjniaBv
         woag==
X-Gm-Message-State: APjAAAVUvGLU4zlGlFA+Vw5vlUvs1Fbt5mhjTBOtxjDEKgpLYaxMtf9J
        iuQenj42+rYj0XHtQHPihwBMmok/BIo=
X-Google-Smtp-Source: APXvYqy/JN5Tukl6e1s+uskah3wczLS0qKNm1HHwfv24GZ0gm9S3ONW3SZg0fKBQSIEgdXHSBoByrA==
X-Received: by 2002:a17:902:fe86:: with SMTP id x6mr27652483plm.28.1569954350285;
        Tue, 01 Oct 2019 11:25:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id e14sm3095996pjt.8.2019.10.01.11.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:25:49 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        linux-clk@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [PATCH] clk: hi6220: use CLK_OF_DECLARE_DRIVER
Date:   Tue,  1 Oct 2019 18:25:46 +0000
Message-Id: <20191001182546.70090-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Griffin <peter.griffin@linaro.org>

As now we also need to probe in the reset driver as well.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Allison Randal <allison@lohutok.net>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/clk/hisilicon/clk-hi6220.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index b2c5b6bbb1c1..63a94e1b6785 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -86,7 +86,7 @@ static void __init hi6220_clk_ao_init(struct device_node *np)
 	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
 				ARRAY_SIZE(hi6220_separated_gate_clks_ao), clk_data_ao);
 }
-CLK_OF_DECLARE(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
+CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
 
 
 /* clocks in sysctrl */
-- 
2.17.1

