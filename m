Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3040023957
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfETOE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:04:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54527 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbfETOE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:04:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so13463004wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txk5DrZL33dHOyu6S/hwbHrXibD4nPtpq1m/2A+Wxoo=;
        b=t73dgU0Gc247WTF7B1Vk9vORzWG22PieCyt/1IhbX0ojd/0VrZw4VEQEr7Rfcjh6/l
         ZD0G2DsREEckY4mBG0ythw/g61R1AK4iLUKci+a0R2JU8eaaEf4bGNyDtqYbtfmrRnop
         pBbxVtrzMZeoIHuBPDOqAu4qp0dBncZztbNkwLQnxhu3S59r4/V7nehwMmMJJ/JNgd1K
         8UfjICYJRWEr+I0zKj2VuNujr9ioMZSMSqudF5Of41Wp/Cd42cdFDib4qAoCc2xZbbSy
         6psPlnUKIMz0Pimomwu/DK/tMqUHFvQUKy8xKGwl3sEaSl/bKoldGbQPJ4xAwM0RCW9j
         KSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txk5DrZL33dHOyu6S/hwbHrXibD4nPtpq1m/2A+Wxoo=;
        b=c7kBTazJ8nuQEFmmPMDouRZVmpPCF5dbnAv20NxLtYzMAT15twa0PaRQx3gp95YaY6
         AnkzKPK6P6GyT5L01zhT6LlN4bb1WMuQT1bsLaasjR5Y2k1lbccN/fDnFQ3Zd9pFPJLM
         pQ0Mp142YcPFcQFok6Jbu3PBgSjBL94Qhv8GDbW8EaX2LWQWVV5wrLjOOxjatKqHdNs5
         nJvRIBKKvwx81n9RXPjo1nafcm/ii8mW4azLic4AZL7BB5HKxrxNrnGGMcvjwturvyQM
         N4/I8DODdfiLbIYOGVMun2qyPgKfXaAVQmkVd8eNg89rblkug/2PJ8vlxPPpWLui9hE+
         6P8Q==
X-Gm-Message-State: APjAAAVbeK5gdHw8wzti/nXV6OCqlNNmDOCwcLFU4MH8ao90mPS9vV3G
        sjbfPIHtqpnEIuQLOOKcn99V3Q==
X-Google-Smtp-Source: APXvYqwT6uVZjGxR/n5pqIYoJJgpdt5n9FK1oWxNGhWKEAx/4tWR4B+kGZw3mByDDBsWKa9cNp/B1g==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr12089515wml.108.1558361095088;
        Mon, 20 May 2019 07:04:55 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w18sm13731201wru.15.2019.05.20.07.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:04:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] spi: spi-meson-spifc: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:04:52 +0200
Message-Id: <20190520140452.30167-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spifc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 616566e793c6..20413def4cfb 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Driver for Amlogic Meson SPI flash controller (SPIFC)
  *
  * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
-- 
2.21.0

