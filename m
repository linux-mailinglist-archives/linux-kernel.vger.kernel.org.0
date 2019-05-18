Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C927822577
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2019 00:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfERWop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 18:44:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40383 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfERWop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 18:44:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id k24so12185921qtq.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3ucxkelR/HQP9bUpvsE26VSnR/v3o3kZTaDa44EE1c=;
        b=NSLlyVD+sot79DZNAp+7bapx2pe7mQWtHWl2n7rYW0aNAulOevYUObNVSK/WIj69Wm
         zvmy7eIdht+lswEINUDsOO8tgn1xSCWaRIcrBpyHxEcAikmye973KYkoO8zj/c7RRNLA
         kenAJ44zOX7+0ut94DG+/TfbhhC6hijbZxkh0PfwIkRtJ4mWwlD3W1D7HbDCl02592DO
         PW/lPwKpFHfhzQFcgRqcxdi/bqBq97suuh2xWsjn0RBOxnqfXhBrpSEoiaFKCbQ8VMNv
         frXCkj4ROZSBPRPgx+FMl4alrxTcI/iq8WP5jFrM36PZZz2VWkS85c1iBb6HLC28aV5l
         XcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3ucxkelR/HQP9bUpvsE26VSnR/v3o3kZTaDa44EE1c=;
        b=qH4tQCoUE8bKs2VC5jqHLp8Rt2efB0VlcPh/Sms6JpVZv/+HNwBegcRiqubps3xLjv
         LMQwd2gdi5l0PFM0+vyiP3XZk9idb3RObjhG7AuabkQByJcao/BUrCL7iltArA6FmsM1
         pbuO4YbchK+fRGi7QcvnXOOAQQAxGzSwTmX2MDmzSnFds6TJpya4ShdCnL0yYD/H6p3q
         +BcWvUgpEagiCm0LOjUvhmPFxApLpgkXmlJyIZaGrNa1FHLyxdRPpfUy0dMKFgleMvbe
         Ng/ibocvT4G6Tqi41+ObVm2/K0Y6GGUoVfVMK6GU6QfPeLyC7M+t7MTIYEUh/ZzhWITR
         y+dA==
X-Gm-Message-State: APjAAAVg8qsVkMzChgONRKTt6Gk+9yJ+5NvAiuOKF6dmvIPkRnd8gjwd
        utBitPe/nmhvCJpyBMrmstkvbA==
X-Google-Smtp-Source: APXvYqyD+ao6l0Q3bobEplwWIc3zM/JALZvdkkwNOg8qh0e27mVn+AOrOUl2njaNZVt4DsBDeCcYnw==
X-Received: by 2002:a0c:986e:: with SMTP id e43mr41615006qvd.78.1558219484113;
        Sat, 18 May 2019 15:44:44 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g15sm7225889qta.31.2019.05.18.15.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:44:43 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [RESEND PATCH] staging: iio: ad7192: create of_device_id array
Date:   Sat, 18 May 2019 19:44:35 -0300
Message-Id: <20190518224435.18266-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create list of compatible device ids to be matched with those stated in
the device tree.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/adc/ad7192.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 3d74da9d37e7..cc886f944dbf 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -810,11 +810,23 @@ static const struct spi_device_id ad7192_id[] = {
 	{"ad7195", ID_AD7195},
 	{}
 };
+
+static const struct of_device_id ad7192_of_spi_match[] = {
+	{ .compatible = "adi,ad7190" },
+	{ .compatible = "adi,ad7192" },
+	{ .compatible = "adi,ad7193" },
+	{ .compatible = "adi,ad7195" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ad7192_of_spi_match);
+
 MODULE_DEVICE_TABLE(spi, ad7192_id);
 
 static struct spi_driver ad7192_driver = {
 	.driver = {
 		.name	= "ad7192",
+		.of_match_table = ad7192_of_spi_match,
 	},
 	.probe		= ad7192_probe,
 	.remove		= ad7192_remove,
-- 
2.22.0.rc0.1.g337bb99195.dirty

