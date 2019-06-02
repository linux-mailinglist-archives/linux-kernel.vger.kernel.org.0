Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5804323C9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFBP7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 11:59:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39551 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfFBP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:59:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so6816994qta.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoiwGzojzqWS04G3Vtf6A7KlpS48j88h/ZjvUsdgYpw=;
        b=tR9j48sCzJxSI0PhXjlAQsYW+PvL/Rc1czHdQ6+7kWZVEpCAQfCujqP1Hdi1ibUKK7
         cyj2Hbc5Wia9wlPPdqlFNARCcRuoDM6wF5JoMM8nZjjhS5+0nv1MBUxXqTvibDs5Sg/X
         GxrF/9DLeRU/NJcoT8w/lYv4hnLAWCko9005beumexent1mM/ZjPHWaIonvWfULVVaLw
         gkCZJPk++9V/AFD40d9JNbwLh97gJhKcRIxWQ9XZQXa5qfErF9gawbxCRfNB/S59Q8V/
         xu10VXl30gsuboKcd26fPC5gw1BhhlbBQe+Lr16iAASQRT2OMobjTgiaDby/izR6mThC
         iKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoiwGzojzqWS04G3Vtf6A7KlpS48j88h/ZjvUsdgYpw=;
        b=bqIT7rkbSuIfgT5+Yedzg1X6xB9KgJ3YKlqRCpZ7dVZKaStKsSZkiO8aUF9qi7zVKP
         SaSuMWb7THYIjSMTYG0zQdmj0mKe+DSlmn3/Rqi24CYp3lJRkoZlv0TuFLkiKxBXPKUc
         4RqxlEuw7XXbwbJZDllucAlbGhG6rjolXf+Lzw2IMZIFX3MZFY6tdQm2PynYVurZabeq
         SFUU5aHzt0Pxo2jUHnnTji9YJMwQW/ELDj7jC7Tx4+tJzAGf7VCuAbYDC3X3O39NKDwt
         ML0LhQX+rCzE6ooX+tPP5rtGadt0JcWGoEOXtkcFDB9WikDHQ2lXRhay7sg0b1wcbZ4p
         FCng==
X-Gm-Message-State: APjAAAUL6JnXgDcIMOcQJSsehOgg+bXIwWHUpYSUBGCgrlwyaXjijrkY
        S5qyPV2PicT/OC+6nfirSgw=
X-Google-Smtp-Source: APXvYqw9J/rFcfXbdhQskuwc1AHuGE0/QpenBHvEu+OMCKRnkBFxVYSaQWtYShts/aHwF0F3L9um6A==
X-Received: by 2002:aed:38a1:: with SMTP id k30mr19835361qte.159.1559491160182;
        Sun, 02 Jun 2019 08:59:20 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n7sm7378589qkd.53.2019.06.02.08.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 08:59:19 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>, Mao Wenan <maowenan@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Geordan Neukum <gneukum1@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: kpc2000: kpc_spi: use devm_* API to manage mapped I/O space
Date:   Sun,  2 Jun 2019 15:58:37 +0000
Message-Id: <ea222a6da192a4eb0ba9c8c840843f240f414092.1559488571.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559488571.git.gneukum1@gmail.com>
References: <cover.1559488571.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc_spi driver does not unmap its I/O space upon error cases in the
probe() function or upon remove(). Make the driver clean up after itself
more maintainably by migrating to using the managed resource API.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index b513432a26ed..32d3ec532e26 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -471,7 +471,8 @@ kp_spi_probe(struct platform_device *pldev)
 		goto free_master;
 	}
 
-	kpspi->phys = (unsigned long)ioremap_nocache(r->start, resource_size(r));
+	kpspi->phys = (unsigned long)devm_ioremap_nocache(&pldev->dev, r->start,
+							  resource_size(r));
 	kpspi->base = (u64 __iomem *)kpspi->phys;
 
 	status = spi_register_master(master);
-- 
2.21.0

