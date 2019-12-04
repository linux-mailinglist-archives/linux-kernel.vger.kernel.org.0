Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6B112E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfLDP3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 10:29:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34703 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfLDP3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:29:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so8623274ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXuW32MEVpBGX+oYxjJlbOSqN8m13R4+8nxsyFB6KSo=;
        b=NzzfLl3Ft2yWy0eGxjDMMRdiFd9HpDaDtBPQfI86Ry+T74t9MJJzS/nEUjgdDWH+Ns
         l5vCfZPTel14OWP7F4RgXtKZ2zcVC/WkIJrrR5/y2iP5Z59vNoyKfiNMHsYMYn+0a15s
         svTEJ7nYtBcG1pazF6M7+QWi49eVyFJbT/gSY3vzZRpipA9dPG3Cr25byAsuUX9m295C
         CG2HjYw45+R+1Ev/YiQ6pwGOQLvypadluuGeWp/CTlcUd6xP56SQ9EY59CPIQXbZLhWv
         AyYEHBYvLW5GjHaXQhvFWFcKRyl0jkKUlqXg8LGEAHbmyedWQ8ga7zTeo8rF/hP1yzRL
         8X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXuW32MEVpBGX+oYxjJlbOSqN8m13R4+8nxsyFB6KSo=;
        b=DQp7tuZXn9RvT7xMfPej3qj84fMuNRQz/fbr9ePpWIUIXhBz9VPGYqHYVzOf2qWStP
         Hvx+9NGfybmHRR73sAWVMHTBRz0WJx0O9oHVlOEZrj63OV+BhclUOUHY2iDijJqP5IS2
         RTp+4SMRNCQTZcKlZRPmoJkl99RiX5lZype1Wss7HSl24u6AgZLCh5d7lcePDrbnhWtx
         fMBgEQEYrRy/3mV5+H7GgOSxGOZs6oybsgEzFlO4uWR4k3Cm3br8vuWjwNfvuDg61Bwa
         2eSIoOc8bgxZBpMmPN8QBcnZqihdO23Z7ezLHOPRfiM/4hZ2P2Twf8StG03DVV/rVZp7
         B73g==
X-Gm-Message-State: APjAAAWduIMkXYsJFSXqo9eZqv90dy5LUl+wJF4jheLbB3mIK0a2BUQN
        q8wxVKPoUzbzGNe8xkFXq+YLEcQv7Ay0nA==
X-Google-Smtp-Source: APXvYqyWK4G41MaUOKkT9fJC8zvVih/07GuHxet3dUH/XaSUTa7hbcaHBPLzkHpRlp5QcLkBwkbNQA==
X-Received: by 2002:a2e:294e:: with SMTP id u75mr2399912lje.173.1575473359152;
        Wed, 04 Dec 2019 07:29:19 -0800 (PST)
Received: from localhost.localdomain (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id n11sm3266870ljg.15.2019.12.04.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:29:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] mfd: mc13xxx-spi: Do not hardcode SPI mode flags
Date:   Wed,  4 Dec 2019 16:27:15 +0100
Message-Id: <20191204152715.12553-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current use of mode flags to us SPI_MODE_0 and
SPI_CS_HIGH is fragile: it overwrites anything already
assigned by the SPI core. Change it thusly:

- Just |= the SPI_MODE_0 so we keep other flags
- Assign ^= SPI_CS_HIGH since we might be active high
  already, and that is usually the case with GPIOs used
  for chip select, even if they are in practice active low.

Add a comment clarifying why ^= SPI_CS_HIGH is the right
choice here.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/mc13xxx-spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 286ddcf5ddc6..9885e5f8210a 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -134,7 +134,13 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 
 	dev_set_drvdata(&spi->dev, mc13xxx);
 
-	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
+	spi->mode |= SPI_MODE_0;
+	/*
+	 * We want the inverse of what is set in the SPI core, if this
+	 * is accomplished with a GPIO line then inversion semantics may
+	 * be handled in the GPIO library.
+	 */
+	spi->mode ^= SPI_CS_HIGH;
 
 	mc13xxx->irq = spi->irq;
 
-- 
2.23.0

