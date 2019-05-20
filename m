Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6282023940
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbfETOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:01:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32998 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbfETOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:01:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so1793154wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4tnU+N/DU1N5SPy41/fi/miGaLy6d3wjz6icgaZVuI=;
        b=0WoDOm7eSUPpLoIkMOSusIKkzLWDQndtkVtMrGv8KeIPGtwW9IqpBlwAf//CG+IO9b
         q7aVWcfLGjukA/a5dBEMZ0iwfWK22jsX7ha+nyfdiYkjP4D2eMGlGeoIGa3bQ84wsKS8
         TMAnpVntCcP2PVlcvED5ml1PjmoIkaRBsiXxHt05BNDwFma0SSCOafqRpg9eXjLBlEll
         N1J0oUsHG58CHkYHl922OZ9xuT6FSEyUr/2/6pa8v6s2R7m4xoijYYVdnJ50lx1Jetwo
         DRW724JkkmwuowaoF6lh8n70DvlR4bqUPhpAETLXkg6GfrTq9Gr7o61SKJT3nq1cM9iE
         RjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4tnU+N/DU1N5SPy41/fi/miGaLy6d3wjz6icgaZVuI=;
        b=eFeMRcv0Pt7PZHolAUuStdPBPjDMpIaa2C2VA1Y6HdM0u9fUUWttVFWs+DYzWWIwtR
         oc5/To3hl60hQtfZe9K9sbFkm/NU1l4h0ifbbZGLld3/Hv1IebvizMhQ9rYIw3THD2Ky
         NGCYWN9SuZOXrLc7slfNo3f/lKqNWGpt5HoPf4JCAfPiO+XvcZ53j+SbyjB2BNmejjJd
         2yMFfyUAEuWEiukwL6UkXDowlPub1oCo6/8UusZNHeXVMN3hcPBor+5S38VijBIMGuq9
         YjiHvFsJ1vQ/XGI1UbziOY7U0MypJhhDYbF8fViBHlAOOe4LQQlXmmoa/9ENFLZyFFfs
         jrQQ==
X-Gm-Message-State: APjAAAWn7RCPks9kLjTP+2RNcYIKSUpcUyeL5X6WJraM+BslJ2CY0v97
        fXHbZpor+fF3Q5F4k0xGxdVPLg==
X-Google-Smtp-Source: APXvYqwEEdJHWNWT9tmdPHAERp5H+E+95z5naZ9rAlFKjxLflOoHQqlwBCMhp9NAPjMi8a5idFRzog==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr26575282wrq.158.1558360897097;
        Mon, 20 May 2019 07:01:37 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f10sm24622307wrg.24.2019.05.20.07.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:01:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] i2c: i2c-meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:01:33 +0200
Message-Id: <20190520140133.29230-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/i2c/busses/i2c-meson.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 90f5d0407d73..f530d9a0450b 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * I2C bus driver for Amlogic Meson SoCs
  *
  * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/clk.h>
-- 
2.21.0

