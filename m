Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5D105626
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 16:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKUP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 10:56:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33751 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:56:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so1770530plb.0;
        Thu, 21 Nov 2019 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wh3R7tc6uYHhveBcVrPGiy9ABmvAh9kRTEG/BV4tn4w=;
        b=BScLBjTn8ukEJfUEM3qVgrctygeySIarMYyr2daXbuEOLG2zTiOKVo0OcX+o0vyL2s
         LkOcHbVBPVDft+xj/8aomYvDtz3TacGnnuDe8xvf85k1Svfba3vN5xVnMExHJvcwPW/b
         6M8kYmf7w8FqfbeWxNXG0JTYSXtI9EwWxc9+e1mrIFv6CP6WxOlZIPPiC9KcxXlAxsPf
         iXfBsZV1DZYoc5VNR1vYwxN9kECbT+PWbyF6UYxjmbre4j3GJD6zQ9SG93xQDl8Rcw6Y
         PO2zX7+U9v/U3I4zN5IdZiQFI9H1dpVlKNIy6rWIvrQWgp1r4V4rsRMXOdpbmTOBQhV/
         Vm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wh3R7tc6uYHhveBcVrPGiy9ABmvAh9kRTEG/BV4tn4w=;
        b=KFxgjKpgMSRT4T0JO8bH6PKGWevaTxaKcaDxKqMRO7r1TuAO4haEW97Jg0bQTeB7HU
         CAQ59Sv3c5duCAMxWgjVqcgF04/dE02d7fm8yk2V66f9RKvsFADeRnrSDuF7Orj51jFZ
         iZxrB+VkzOUVTAVDe4W0NvM7uhU5YtOJBs0maY1USzj96/rr/7pyDVK97+qo+mcQMrUQ
         gVbFYFKxD1mjXWqCZJmUCEYqwqQa55s73ghVlIOAwV8D0dRGY8cey3d4J8bo6piXh1ST
         L2eF5S22wpOOmkeRnvJ679ksLr8OeC8hd83qa4DY32zUTaFGoGl28j9s3FVS4Wdtm5nS
         Yt/Q==
X-Gm-Message-State: APjAAAVK9lFwY0ZAWTF48BEWEl3zQtKiZ8uca7k7rhzZjJPyaREKTWKG
        i+OHac3X1eg8q8pxmTaJxX+YuGGp
X-Google-Smtp-Source: APXvYqwGMNA2OgxoM44llql268s5VDUmJi/9i2LNRH9SkFEA+fq20x4tS4Giytv9T7C2Ls6XJg5ZVQ==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr9232305plp.336.1574351764961;
        Thu, 21 Nov 2019 07:56:04 -0800 (PST)
Received: from localhost.hsd1.wa.comcast.net ([2601:602:847f:811f:babe:8e8d:b27e:e6d7])
        by smtp.gmail.com with ESMTPSA id e8sm3709212pga.17.2019.11.21.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 07:56:03 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v4 0/6] enable CAAM's HWRNG as default
Date:   Thu, 21 Nov 2019 07:55:48 -0800
Message-Id: <20191121155554.1227-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series is a continuation of original [discussion]. I don't know
if what's in the series is enough to use CAAMs HWRNG system wide, but
I am hoping that with enough iterations and feedback it will be.

Changes since [v1]:

    - Original hw_random replaced with the one using output of TRNG directly

    - SEC4 DRNG IP block exposed via crypto API

    - Small fix regarding use of GFP_DMA added to the series

Chagnes since [v2]:

    - msleep in polling loop to avoid wasting CPU cycles

    - caam_trng_read() bails out early if 'wait' is set to 'false'

    - fixed typo in ZII's name

Changes since [v3]:

    - DRNG's .cra_name is now "stdrng"

    - collected Reviewd-by tag from Lucas

    - typo fixes in commit messages of the series

Feedback is welcome!

Thanks,
Andrey Smirnov

[discussion] https://patchwork.kernel.org/patch/9850669/
[v1] https://lore.kernel.org/lkml/20191029162916.26579-1-andrew.smirnov@gmail.com
[v2] https://lore.kernel.org/lkml/20191118153843.28136-1-andrew.smirnov@gmail.com
[v3] https://lore.kernel.org/lkml/20191120165341.32669-1-andrew.smirnov@gmail.com

Andrey Smirnov (6):
  crypto: caam - RNG4 TRNG errata
  crypto: caam - enable prediction resistance in HRWNG
  crypto: caam - allocate RNG instantiation descriptor with GFP_DMA
  crypto: caam - move RNG presence check into a shared function
  crypto: caam - replace DRNG with TRNG for use with hw_random
  crypto: caam - expose SEC4 DRNG via crypto RNG API

 drivers/crypto/caam/Kconfig   |  15 +-
 drivers/crypto/caam/Makefile  |   3 +-
 drivers/crypto/caam/caamrng.c | 358 ----------------------------------
 drivers/crypto/caam/ctrl.c    |  29 ++-
 drivers/crypto/caam/desc.h    |   2 +
 drivers/crypto/caam/drng.c    | 175 +++++++++++++++++
 drivers/crypto/caam/intern.h  |  32 ++-
 drivers/crypto/caam/jr.c      |   3 +-
 drivers/crypto/caam/regs.h    |  14 +-
 drivers/crypto/caam/trng.c    |  89 +++++++++
 10 files changed, 338 insertions(+), 382 deletions(-)
 delete mode 100644 drivers/crypto/caam/caamrng.c
 create mode 100644 drivers/crypto/caam/drng.c
 create mode 100644 drivers/crypto/caam/trng.c

-- 
2.21.0

