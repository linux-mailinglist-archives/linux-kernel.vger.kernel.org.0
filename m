Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5B354E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 03:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFEBKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 21:10:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38367 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfFEBKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:10:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so4150453qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUAORMOMPQGdOfHz8+spizROCY8nNkClMWjc/Ifypm4=;
        b=EW8J92jGarCGX577jjHg1ZidvKNvysp4g04Q6fRzBe/P6iD2iaBfUN3Ts3UTHkiDtK
         ZSHxD8i8csvwBO9lj6crTuKbeRYjKZzyJ9kY784G46rpvaDK5AuOiaWyjKozatzvmQ1q
         WtrA+pVCuZpaTA59BzD2dybw5cYu7t8d7jhlqdDS4J/KWzeQB/WcTQgDv5jHYRMBXuOF
         dW/6QOMa1yFE9NEIhURXse2EWj3F/ADgRG9V4dpNhgYLC1v6WpRmdmDQXCi7CDcRPHJp
         OJWx1a7v2ZHwlwNcF+cwiq5hDAQOob4tqyHgRWwVRK0IsUjO0kLxExlYWl+UTMImMx87
         qElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUAORMOMPQGdOfHz8+spizROCY8nNkClMWjc/Ifypm4=;
        b=ZJvrbBin7x2AKa2reyTGG+M5/J3DBbgF4QJWW3ug1a4Fmbzx1utE7y9u1is8MbTzhr
         oANO4ilyUOCcw4icWxiB2zKSxa9h4ImOdlyu5QGKKowQf6wIkMFsUXPF8f3Ky0J5i/MN
         ZeTDQLdABM1ienS8GByVkDAn4CqdBXnHohKnaCADnv9ohXsyRJ2JaKkCQ1LMG0lomeEQ
         grZT9kglLdnppXv6wiAPjyulxMRVZZI4JE1uI6AFNvhDwezlRWPdt9MK6KAU89UuRh1N
         JIKXzQQV653uLyFPTuX1Sn89bFwXUKfp917A52sewIgn8tyb9sNQCX99AEP1SqDja/Xt
         JjnQ==
X-Gm-Message-State: APjAAAVKslgrZKEV4wNdaVyU3AKWPTcEJgyPjVzhiiNCN+uP/fFKsrBa
        cUnnbIpkG77Uhty7tlke9fE=
X-Google-Smtp-Source: APXvYqyjEjn6Q7TMSa3v2zJc8CFZWsAQ1wflnszCtTP1sQVyz8SuBFFbv4nkH0dun/PTRKE5UUWPYg==
X-Received: by 2002:a37:6b87:: with SMTP id g129mr21736018qkc.305.1559697006664;
        Tue, 04 Jun 2019 18:10:06 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id v41sm7169401qta.78.2019.06.04.18.10.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 18:10:06 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        Mao Wenan <maowenan@huawei.com>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: kpc2000: kpc_spi: remove unnecessary struct member pin_dir
Date:   Wed,  5 Jun 2019 01:09:09 +0000
Message-Id: <d3f48293a099af312ecb5682cc367e0e9b98e9a1.1559696611.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559696611.git.gneukum1@gmail.com>
References: <cover.1559696611.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure kpc_spi, defined in in the kpc2000_spi driver, contains
a member named pin_dir which is never used after initialization.
Therefore, it should be removed for simplicity's sake.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 20c396bcd904..1d89cb3b861f 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -105,7 +105,6 @@ struct kp_spi {
 	u64 __iomem        *base;
 	unsigned long       phys;
 	struct device      *dev;
-	unsigned int        pin_dir:1;
 };
 
 struct kp_spi_controller_state {
@@ -460,7 +459,6 @@ kp_spi_probe(struct platform_device *pldev)
 	if (pldev->id != -1) {
 		master->bus_num = pldev->id;
 	}
-	kpspi->pin_dir = 0;
 
 	r = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
-- 
2.21.0

