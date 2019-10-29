Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFECEE840A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 10:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbfJ2JQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 05:16:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44417 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbfJ2JQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:16:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id q16so7020661pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVOYj/Re7UhdcN0oIEXqQ3IhVWkoZflbo7uyXKIkqvQ=;
        b=fO4EjFM1AoUHkqXxHaPt6GE4ycwJOtiU7rZwOVKyXJrTeFmg+TV84SCb3OWsULw5eu
         Kf46IN/uTbzmt3FXmdtQE6otTQvsaA7gnFHi7rw/2rszrpN1k7JUcj239soY0ZFZHR2m
         JIZrsS95wBQHSXkEPmYETOc6Gb4qN40rL53+PDm28u+/JW837RTV2NXcGju6yl5ViwwT
         HPtaHg+C0WUH5WUtyZFnxMRL3V8xw7B0GtNlNdoZL3MvIjPQ0CX6pYosbTTXZks4IsIw
         Oa7z0Mu0tLnS0MJmPniPcr9iP/ATWrckuYMFW9xL+3MxcmFsuUJj324ZwqRnoU8bWvse
         +iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVOYj/Re7UhdcN0oIEXqQ3IhVWkoZflbo7uyXKIkqvQ=;
        b=m3mEGiXX90fAxzfo72h9HmpzF7opkmWW4ugqrrhujq5Om9P8JooRkjHgMnZgINOHLu
         8zYQumtvoH0C19n+lv3KW6k1pVGLI0+uSs3IWN30eES+pQGq6Ut8KtThl8cdOFTIcJgW
         cUA+G1Js2n8/CY3EPYSTC8S3AAHyc+6HctDxbg3dyldkKwZ+enNI2cMt/RG5z2yHrIh7
         k62tgVliTYm5u2gVJznYoYJT901ifK2rhVaFnKK6XiL46fD/CuNLm55aasqMPact5cqz
         9YTXmW3Zqubl7rqYKwKI0LiI01+ADMRw8XJqa+tEFvLTXPv7+A1Pxr+4L4jEh4jWnIwb
         pLcQ==
X-Gm-Message-State: APjAAAWBw0Luj7/Rtqx7F7NhX8OQeHCS5TG5wzElGvpTGml/NMueKVtf
        U7yfSoKgl8NOKkNX0f3vrvU=
X-Google-Smtp-Source: APXvYqwELpwN4NbAHwcJx4yUEYqm+QZIdJkqGu6LVhK3QQU8ICbMUAzQFBG/v7RxzNZNWKVVw0AVGQ==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12mr2900622plb.140.1572340614402;
        Tue, 29 Oct 2019 02:16:54 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id g18sm9910556pfh.51.2019.10.29.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 02:16:53 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (Unnecessary parenthesis)
Date:   Tue, 29 Oct 2019 02:16:38 -0700
Message-Id: <20191029091638.16101-4-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029091638.16101-1-chandra627@gmail.com>
References: <20191029091638.16101-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: CHECK: Unnecessary parentheses around table[i]

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
Previous versions of these patches were not split into different 
patches, did not have different patch numbers and did not have the
keyword staging.
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 24de8d63f504..8becf972af9c 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -476,7 +476,7 @@ kp_spi_probe(struct platform_device *pldev)
 	/* register the slave boards */
 #define NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(table) \
 	for (i = 0 ; i < ARRAY_SIZE(table) ; i++) { \
-		spi_new_device(master, &(table[i])); \
+		spi_new_device(master, &table[i]); \
 	}
 
 	switch ((drvdata->card_id & 0xFFFF0000) >> 16) {
-- 
2.20.1

