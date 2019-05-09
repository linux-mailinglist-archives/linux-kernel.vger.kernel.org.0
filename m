Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BCB188B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEILLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 07:11:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41008 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfEILLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id d12so2449334wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qVGkTtEbJGXMDq9yfYbvGEhm0nTx4/Q5KKy9E6G6Uls=;
        b=Q14zEwAVJ9z1gCyDh7Pvv/+JbG3ARRqKDiD3F+DXQx18zoM6hirJXgkqL3Rz14N6Pk
         jqPs9miT3a4rOXazdPQRMH/N9XjuF7ir7durm/GwimyvozKXr0rn5XtxS3FsxXcEJzdb
         o3UflAShf1SFKF3ROszcWoh+Jh5Y3rFcn6BW3Dyj9oHMBSi9ijUGtjKiWFaDrGpbVJcI
         cxMXl3DKWTIxRGNR7KdaoHTcUYor2syu8T+Kus0ipxh6r1XhGogSgQzSMGmdzzz3DvE2
         zqlBQ8Rw518/FbDSB2migS9IDBFyJFzASEpS0LA24IulsYf3lWUN4lS2G8W6C9tUCdOs
         qxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qVGkTtEbJGXMDq9yfYbvGEhm0nTx4/Q5KKy9E6G6Uls=;
        b=mwB8xJqs8r040fPkGp1ia3Vnin7jbV0pMHtc5EOeCgmzMhqFOLaucp3qXsy6mM6FPj
         IAaPHbPa0AQFyzW7IZFVzUXZrE5EYS8T/GXSqHTDq4POvB2e3X6B03qy6CeLaFRraLyS
         S+5Ld9xEDfdVJC7z//dXQCa+OaSrCJz926WK19GOL7fqlu07k8jLZ9DSrXADbrRMMrO1
         cFz2qmugXME7JJdWlN4FHgcLpmY1vbpbZhYSdjImh/RgS8Qaghdq51/uExbDZMBs0Tlw
         sOkRNtLb77fgpplKAR2WJQ4f8zNBan0VDzzTeNqSjCrkufcUA9ex9V57hxXDoiE5Blt/
         TDqQ==
X-Gm-Message-State: APjAAAWN+ABT7b3q8pPkQdFKfQ7w1dsqPjCvwBqc4AoH4WP2lV+3TrSQ
        1WChmH3wtPao6WEwt21ZBA0LYQ==
X-Google-Smtp-Source: APXvYqxmNseiHG6j6CHViU7MdKt23CuoxFMo6eV7NmQGqMcSLVJs7hdMitKEmQksaHnD5UVv3l6ckw==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr2738284wrq.158.1557400306306;
        Thu, 09 May 2019 04:11:46 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP TIMER
        COUNTER (TC) AND CLOCKSOURCE DR...)
Subject: [PATCH 15/15] misc: atmel_tclib: Do not probe already used TCBs
Date:   Thu,  9 May 2019 13:10:48 +0200
Message-Id: <20190509111048.11151-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The TCBs that have children are using the proper DT bindings and don't need
to be handled by tclib.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/misc/atmel_tclib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index 194f774ab3a1..2c6850ef0e9c 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -111,6 +111,9 @@ static int __init tc_probe(struct platform_device *pdev)
 	struct resource	*r;
 	unsigned int	i;
 
+	if (of_get_child_count(pdev->dev.of_node))
+		return -EBUSY;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
-- 
2.17.1

