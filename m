Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152D2D1ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 05:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbfJJDMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 23:12:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45320 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfJJDMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:12:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so1517600pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vMaj8wxxUbfc/yrivEaSPRZYRSTBiHX+PR4qx/8nUI8=;
        b=JD3xTkSTpOGVjZncVv+AdoAANO5rqnC76neIEJjCXZSp9Nva3gVJexgxGjL55RtDtA
         GIGqNB8NOPEQKEEWFVmKuEXeeldJYZClS6KTvoVu9jic4bdhORRjUiP54yhuwUiNEjoF
         Ltn2ibLy0la1LWVWi8sa2G5Bx2HnIyO4A6zZ6GF11BolIoMskDdqvi+HePQ9VdyMf15h
         ZiA32HNTEtofLVe8Vt5O+okgJcMWiZU5UtPCzfTCmv2yW31QjWvrHpFM8G/0+XM0q/vj
         nEnkogfSA8RX13eqnbeXYeue6Qo/b2Jt4ic06GaCDxSV30wYEv7fJNy/F+5FqcmzpgNH
         ONgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vMaj8wxxUbfc/yrivEaSPRZYRSTBiHX+PR4qx/8nUI8=;
        b=s+dP84TCeIiDO50+bSaKmd6H+VCTVAGH3oyDITgz1oMxfovOBVvtPFQUf0uAp3I8oL
         jQbNZ1k/1uSA9pM4jgA/nDVMH5ihKV93sybZabUgO/B99z0as9PTU9hKcT9YpawukK6K
         aPupUSuUmA014eqUhvqTR84Y7sVuD3PZHUGwCWG8+bkgQpkYXiAnlz7TpPpVdus/ZBOA
         QDH74Zp++w0TtH7GVzRt2HKHEyWfDvyw1J1VgtWD9sEbXz7ziN5Ls9EwV8JhurdJaeOO
         CjkYzYLc+GD2w7ComhKS/3DIO2ZLadSLIcFSvuhJtxuHhgm9TxZxydjxJwlG69WVH6Ae
         xNKA==
X-Gm-Message-State: APjAAAVInuBBcT2ZyOgN+DP9MljJt5i6nroHr9BqWYdSwfn5JA+SX3cO
        /t4sQ+b4KooWmqyLu4enjoU=
X-Google-Smtp-Source: APXvYqwOg9JBhlBXutBAbMvrk+ix9tYRM6/lafUtJO5EF/Lo51hRoLme+iY3UQS9G+/SMb/sLyOJjg==
X-Received: by 2002:a63:33c7:: with SMTP id z190mr7924932pgz.67.1570677153619;
        Wed, 09 Oct 2019 20:12:33 -0700 (PDT)
Received: from panther.hsd1.or.comcast.net ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id 18sm3697635pfp.100.2019.10.09.20.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 20:12:32 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, chandra627@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (misaligned brace)
Date:   Wed,  9 Oct 2019 20:12:23 -0700
Message-Id: <1570677143-4199-1-git-send-email-chandra627@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: ERROR: else should follow close brace '}'

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index ccf88b8..2082d86 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -228,8 +228,7 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if (rx) {
+	} else if (rx) {
 		for (i = 0 ; i < c ; i++) {
 			char test = 0;
 
-- 
2.7.4

