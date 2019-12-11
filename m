Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02F511AA28
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfLKLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 06:46:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40598 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:46:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so3982490lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 03:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mU5uShffkkUuqjaXRfA5AyLsxcErVHsMKowOFfb75hQ=;
        b=zcHHeaTLvHfHpCWJyg3PhVsxOXpKeAB0hFltPzOamTwKIdlKvokdjC6vkLZwbtkx6h
         b6l7MSjQM+DsflXK0Ig9WrATipwkVXF16mUAZGzOxvyfhQqwhhXGgVcdhNkhTm9UbcSN
         yHUSpPgrQw6Onv/y9OM7udR1LqBvBwFxkjFW5LZUvY/oUfgCVJ/TCFZ+cYy8bT7skhxc
         uN+Uvy5UdXU4a0FycFFTdH2A0ApI+WrVjUNI2FfE1kbVBEKNGg3JxbV9/B9P7mw+6Snn
         H1tfKWFJtY8BLqwGVnw7K+6Yd97MAeX7bVWczb/W1nUImod1Zu/4XYKU9VKRBL2JrOsH
         VTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mU5uShffkkUuqjaXRfA5AyLsxcErVHsMKowOFfb75hQ=;
        b=RVsGIKp3DInGiFd7zwY08clSF0tXvn/dH/H8UigbqHShxgHZT80qtvMUDyIjLwSyiM
         hLxO7BdFi/jMNdF2XSbRi12IzYfkpHSdytqnek+4015u/ZicZAGxhbUA6JjWqJA5Yxp/
         zbqzZ7vW36wILz2gRE9O7cvvgGZhY0d9z1AiJ+zJtTRRbHMvBs+p3gJsIbMDQZT6LVqf
         DDdBNrMHc7F45ebd9w6b5gHpHxYh/XlQWyV2QMbkApuZhjw3n/cvePZAODFtpG6z6n9y
         kmFQaHKoY5N7Bum9guwBuNrUeA4Oyaa0h4THWlg9QslkdDas5ionkbK5zafd06BFCpb4
         jl4g==
X-Gm-Message-State: APjAAAUPEVnDVEbpy/kuJd6kG9JDHJLeTwfWuqcux5Yc4wYlFsV0uG0+
        j0p44Fqudk43MTyAko4H1ZrWiA==
X-Google-Smtp-Source: APXvYqyq2xHKfwdPFg2pgKMjnqroaBqDcyYOnY/IyUdDNfLIXDcetPW5zcDVr3bBa5hSQvk6TpOz3A==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr1897305lfy.11.1576064803523;
        Wed, 11 Dec 2019 03:46:43 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id y72sm1073719lfa.12.2019.12.11.03.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 03:46:42 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] mfd: ab8500: Fix ab8500-clk typo
Date:   Wed, 11 Dec 2019 12:46:39 +0100
Message-Id: <20191211114639.748463-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
has a typo error renaming "ab8500-clk" to "abx500-clk"
with the result att ALSA SoC audio broke as the clock
driver was not probing anymore. Fixed it up.

Cc: Stephan Gerhold <stephan@gerhold.net>
Fixes: f4d41ad84433 ("mfd: ab8500: Example using new OF_MFD_CELL MACRO")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/ab8500-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index bafc729fc434..3c6fda68e6bc 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -631,8 +631,8 @@ static const struct mfd_cell ab8500_devs[] = {
 		    NULL, NULL, 0, 0, "stericsson,ab8500-ext-regulator"),
 	OF_MFD_CELL("ab8500-regulator",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-regulator"),
-	OF_MFD_CELL("abx500-clk",
-		    NULL, NULL, 0, 0, "stericsson,abx500-clk"),
+	OF_MFD_CELL("ab8500-clk",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-clk"),
 	OF_MFD_CELL("ab8500-gpadc",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-gpadc"),
 	OF_MFD_CELL("ab8500-rtc",
-- 
2.23.0

