Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C650C12646
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 04:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfECCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 22:06:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42614 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECCGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 22:06:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so4167691eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 19:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0/yRu5j7ZF+Lt95v7/Jvim+tVtOqpccPGnEgakBwiE=;
        b=W9pt7WysYY0LTFMVa1ci+xiQOenUtRkjaPN+HVX35M9KHtJk2vXpm34vOX0gPmT4Rn
         OQ6VUhZKylZmluqTqeg7qW/78VjsllbdWrBIT2Kr+G2q0eYYIcfMLYUY69ajn1j2QkHV
         wxBhfvo1/hjCiUuHTQDiJtx3WFLbK9PZb6SUUdQ4jwzm0f1OqSZKCymZFdz9Sje/hwGD
         9Zalij6DZdr2S3WUrhPTQ5c24JfhKOEkl6Aqwt2QHvSdqtT7K1xpWQplooxclWO5zDEY
         cEQx1dwfMO2mYaOq+gSzRN+Z9CTgEvcgodnzwa20HrOXsP3wRp/f767FHDc6aUYLGM5l
         9KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0/yRu5j7ZF+Lt95v7/Jvim+tVtOqpccPGnEgakBwiE=;
        b=Jd/S74rD7+Y/2HPxSenn4mP0pHC/J7GwIZdCC0s1jOODCylEHn3FHRZWjVYmtgEiYu
         E4ZdPwAoA7DOJL7oxACJEOynxacjYE6Nxq25BHAcnxLAyJ+zFtV+W7VSRuv42jgIStAG
         uNhChmrqf1Z4wkl/wEhrjnsL81u+UjgSCBVv6K2CbCJf2KcraXo4jOtj2reEgKTGftC/
         +DGGjruqBsy98IjBiHdhUSZqyAOG38TXhP9SeRan++/0yyL11xyoZ97J7LPIExtHsXJQ
         AmvtqoOateTNDOxJq1aZ6NbyGnSUv/UoIcdohgZ9PobM/7KuIQwc6C/JkC2oA4bGHMK7
         2ORQ==
X-Gm-Message-State: APjAAAU/HOVJyxFJVEM3vmQg0RMqiEbWrzE0YkkjHaw1aJO2wJEIms9O
        1hMf7pXM5Yb1Dr6n/V2lyuY=
X-Google-Smtp-Source: APXvYqyciZpEt8Qjy/TiE4NZyY4Tjnxc7zQviLNLZrWEDn623WwdLU+P7QldPPXuPhzGlsSsbz6x1w==
X-Received: by 2002:a17:906:4f18:: with SMTP id t24mr3816584eju.43.1556849204342;
        Thu, 02 May 2019 19:06:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id j55sm226417ede.27.2019.05.02.19.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 19:06:43 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: kpc2000: kpc_spi: Fix build error for {read,write}q
Date:   Thu,  2 May 2019 19:06:30 -0700
Message-Id: <20190503020630.15778-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/kpc2000/kpc_spi/spi_driver.c:158:11: error: implicit
declaration of function 'readq' [-Werror,-Wimplicit-function-declaration]
drivers/staging/kpc2000/kpc_spi/spi_driver.c:167:5: error: implicit
declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]

Same as commit 91b6cb7216cd ("staging: kpc2000: fix up build problems
with readq()").

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/kpc2000/kpc_spi/spi_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/kpc_spi/spi_driver.c b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
index 074a578153d0..3ace4e5c1284 100644
--- a/drivers/staging/kpc2000/kpc_spi/spi_driver.c
+++ b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/delay.h>
-- 
2.21.0

