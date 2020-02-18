Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9501623AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBRJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 04:43:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35514 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgBRJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:43:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so23056088wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MJmrjeXUpfCiiOVSBqadBTktKzyE5G5Pyo6uC9T7RU=;
        b=TzKXLeGu7pUlbkJo/BBjLI/htilSMruo+BGbf2KDoYmGc2caA0R9BhtCS0AjsGBbL9
         7HFh0IGlGw4FRWn6UL+PQHGTp/HPi+TlJALCD9LEa9HQYmKkDAtApUCk5GjvKVWqI1ku
         5VNgNDl3FwpEhGce2/wrDilo5ZilFtQa5kwxtgAq8SsSbVY3wujJLi2C4WgS3Jkv1ogr
         P6Rc0lebaUROIFEjnkLeKSsBCJ1m091XNtAWGI5TCnr7XTWZNHaBY1C8OntkNFZBBHFs
         yI7n39OQHiK5r4oGJK486YNkIx80zhm/FkRQMT2nfW2AperE0TjHGA4hheWndPF8D4Tr
         D4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MJmrjeXUpfCiiOVSBqadBTktKzyE5G5Pyo6uC9T7RU=;
        b=tzUxecksWM3e6vJH6qQZk6YEQsENTbViqzjvVBy9Ww/hcEv0dA5WQgyjKXs8nYCNFK
         j1Qu+uicvLOo5ract/JJ11TtqCuBKGwguhcRdxGTrCnZ0oaMueEz3jUNuhQ6ImD5m6cs
         weV0vmrOT/2WdMflsc1Qnm2LdhJOpTOUDIfYkjAf1XIAWivEWC30xV8ejxhs/lMnsZK+
         DsmpCGPGNld9Z0R58e9Y7UkT5kpegIhPOFkchy8z9MwQSb1JwEjZ25Q6fxe6WEwgSOzB
         vUvuWJTOCxtJOnQ4n1jFhD355cz/eeQnU+kDCeBF1NJWgsPjyYEUZkDu3JQds8+2uM8n
         b3Jw==
X-Gm-Message-State: APjAAAXEnGKhN/Df6ogRhve7Lt3dKjyt5FFGAiJofaS3+nXboNs8txLW
        zm1pwPt1ym4AJX1KotCj7/JT/Q==
X-Google-Smtp-Source: APXvYqxJxka8qW+23GIFUP2hwrsAgK1suuyCEm3x4wMXUCnUkHAttDdt6PVQ/NuJFexYVJ8g1lMy9Q==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr27386377wrf.174.1582018983376;
        Tue, 18 Feb 2020 01:43:03 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id s23sm5351095wra.15.2020.02.18.01.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:43:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 6/7] nvmem: remove a stray newline in nvmem_register()
Date:   Tue, 18 Feb 2020 10:42:33 +0100
Message-Id: <20200218094234.23896-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218094234.23896-1-brgl@bgdev.pl>
References: <20200218094234.23896-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Two newlines are unnecessary - remove one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e47152e9db34..5e7d46eccaf6 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -354,7 +354,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (IS_ERR(nvmem->wp_gpio))
 		goto err_ida_remove;
 
-
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
 
-- 
2.25.0

