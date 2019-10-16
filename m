Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E103D8A36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391351AbfJPHtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:49:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43775 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391302AbfJPHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:49:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so10861772plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVOYj/Re7UhdcN0oIEXqQ3IhVWkoZflbo7uyXKIkqvQ=;
        b=kzag0KZSyiLX53Ov+HKOMerf8wmhmV7RvNdjh7Z3wK9k+y5eP2DRWD3eNeQfi59yIY
         3GQ2+rGmEAw85UShHP/w8mXxD1zC6s7SJ53zNFQu4Zigrb3n7cVguPz7xshFYyQ9sgxc
         Lr6KtM/W5nANRAMJ6corxdhprzQqEjPFp5jkb6qhZKWetrMQF6g5B4o4eJLaihQlYSKC
         lS6/uMQpeF7fzM4GrBVqOzbZXAmGuMTvtAjTgyrz0SZDRWZ366AWj8rJ89hMZvoF+Wuu
         iIvaw8855QDIoFLQmN4Ke5yvHseFQOG8QBdNpuv0XxcHdprkIQE/u2iPVuh/Q2tD7mMF
         F4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVOYj/Re7UhdcN0oIEXqQ3IhVWkoZflbo7uyXKIkqvQ=;
        b=k0cYkFaaRlu9zz0S0VEryi7DqGOMF2suEdshQHf0FvlAtpGlA6deOLM72mrjuJ91HU
         OWjnVwmLQfE1EUeQItBwlIywjT0pSjFm3f6y69XonaG9dxvdgWSfUbIaT81Yr5lvZdfY
         zrFJYFxWfk6higUKWHgjWup7z5c3BYzlx92NHFsTBr3vUIF8pyEmk5s0qIh3b45G9QkY
         L31XsrO/pqo8i8/8uY52RH5dk+PElPldhWH7BFUCTTLwOknxT9EzXoQwfEgm4FDuzei5
         qxXCoimwMf179VBBlGXWqe9rXdw7W10mEM70N7xvzmX/0WYAUPUJZoE59jB3fu4HSJ/F
         y2cw==
X-Gm-Message-State: APjAAAVA1nhaRdIY6SmUXtZC9oOldcuhKsnWwDebfY3v79NONMXNuqGp
        +2+NRuIa6+dyT2wvnze1QiI=
X-Google-Smtp-Source: APXvYqzJb4X0OYeJAduEFOae7Gy3vFiHhuOFfj8yAKi2YmXFJUC6mnybVaqcdj1MkyzT5Ghsj0B0LA==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr38983505plv.331.1571212191868;
        Wed, 16 Oct 2019 00:49:51 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id d1sm25185522pfc.98.2019.10.16.00.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:49:51 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (Unnecessary parenthesis)
Date:   Wed, 16 Oct 2019 00:49:27 -0700
Message-Id: <20191016074927.20056-4-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016074927.20056-1-chandra627@gmail.com>
References: <20191016074927.20056-1-chandra627@gmail.com>
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

