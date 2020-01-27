Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C870014ACCF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 00:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgA0XzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 18:55:04 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41200 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA0XzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:55:04 -0500
Received: by mail-pf1-f202.google.com with SMTP id b62so6971489pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ucQuwz+ateoZojufeFLUV/0W67kgVJ9nWifeRmz8AWM=;
        b=KBKzWyUUHIv589qlPCBsMyl4G75Cdl9ZtQT2ZcSWfLN2zsnFPBiVMLhD+cIxQ0j4+7
         BWqbEh7Oc2cx2JEO9hRHO92oxhBjVRTVG87myH+hOSwgh7LBLGYnbpVrNWgMKDSd1suV
         nkdB43feEGUSaOb0bPoeIfI49WzPkBamwuOJUM8EfcC4oHnq2qHqP3ltV52xobkbemdm
         jPCywjIXMQqfjX/1Qk39lxDMAjOtZScL2N7q5fLrQwvl0ect6ZsH9tYmdaH55MpVup3v
         VLxk0r2ia9Sv77I8bAwgwo4pQd/fuObfaocRP5rEQLm7o+0Ib3mcUY6oAMOWaspYye1m
         WhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ucQuwz+ateoZojufeFLUV/0W67kgVJ9nWifeRmz8AWM=;
        b=GWgmLbawZ80pF6zpGkICgHB3QqWmZ5Gzv0t0d8RaOVixxln9xpurhCwlUKZzy5kHUa
         5D8zJnnima6yxQ2ljdPIqNVV3rHbBzKQsLwkDdkTTfgVMN4w5ONH0kV6EZ3r7hVYoaIR
         2xhpPc4s+d5DouKyMrUjExCHP8oYPyhZMy1vwJwTMBWui+4mwLE9hrgdJsQ/TivPmzk2
         Y8VSxSHrLUR36a8TphJ8OPkLRTWV6Iok0NB3k5nQA4igeZA5H5N7sGqxli39zWG03GF9
         jESwH/DUgerK3Zf9RpM8a5gIZntsAK3DQfUbJuMcw0XGMVqGS1AZkgI0OskKCMjfTNh8
         kuog==
X-Gm-Message-State: APjAAAUyOh5a3n6OISAqw6l/DzmfH5Br5xaJwdEkbB+Sj+3+OyZAdpUX
        3jCqQEQLhLja7L3NRxrMSyH1C3R6ZWvAfZmSuFmyVw==
X-Google-Smtp-Source: APXvYqzNkd8uO2qnBeczoimrL08h0KoxDWD4kdWRR2C1yxKMCQiZ3I6T3wZ3EM2PaeqKwjCpbd3NIGFQllyGGiXdm+suog==
X-Received: by 2002:a63:3191:: with SMTP id x139mr21666824pgx.368.1580169303480;
 Mon, 27 Jan 2020 15:55:03 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:53:54 -0800
In-Reply-To: <20200127235356.122031-1-brendanhiggins@google.com>
Message-Id: <20200127235356.122031-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127235356.122031-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 3/5] reset: intel: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_RESET_INTEL_GW=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

/usr/bin/ld: drivers/reset/reset-intel-gw.o: in function `intel_reset_probe':
drivers/reset/reset-intel-gw.c:185: undefined reference to `devm_platform_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index a19bd303f31a9..d9efbfd296463 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -74,7 +74,7 @@ config RESET_IMX7
 
 config RESET_INTEL_GW
 	bool "Intel Reset Controller Driver"
-	depends on OF
+	depends on OF && HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  This enables the reset controller driver for Intel Gateway SoCs.
-- 
2.25.0.341.g760bfbb309-goog

