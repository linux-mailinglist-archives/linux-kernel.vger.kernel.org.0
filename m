Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C111BCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 20:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfLKT2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 14:28:21 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:52180 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfLKT2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:28:18 -0500
Received: by mail-pl1-f202.google.com with SMTP id d24so2227434plr.18
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+AvX3U8tZ4b8BiNANQzx7evp/O/27ZLdKyQrn0pJXbo=;
        b=DtM9qYehCfFNg/2rDxI9xbbVLYFNzd7QNXDoduc3ewRCMVgsIBSrgdNK5ptL+U4f+2
         r67/3YrnkoLP7Kqiaz+JAnGYBbYp91kDvxX0ElG4278lRGtqmi82fxSlS+/E0HJKlCJ2
         Pxf8r+Wx2vW2j1NVRovGNlQ6d9dl9a+90t/5GtKZELnNvodiQsb9QM9G4+kICCGyWT34
         BikGd90MK2nF5sFfrxHGijgzYzgkkuRp93o8jjSmRsAr4wlMv9uTK1Col8Wpaoq82MTI
         uxNScY05gmd/DRSdPfpQ9UdSWG4SUXok6uU6aqu5cBqV2PCE4FKZHWP0rt3hpdxJsCFA
         xi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+AvX3U8tZ4b8BiNANQzx7evp/O/27ZLdKyQrn0pJXbo=;
        b=g6Ej2QOPqnVymmaQbCNMkN87pcv6DQUzZFqdfU+EDQIpmfWo6hwnMKReV3XyvVF1Az
         tTN6TiGXPLFvf58KcYjAbfNE4Sljpe5/wn5yO77XWW3o+4PJ+156OMtLrfke4lxnPXw0
         6xnzUh+54IW1+zP5LBft0qPrFXTONdjpcAASBWkV5cyK3J+s63C8j/CWOcDUDyeQQMfr
         uRhzsUXXagLLiGUZ5dSC3+2COtLQR2AnBoNf5jVXX0h8CfuTxXqUm+e66HUsLp/EPd8X
         vOlViS/u2qWWCUGS9MOKyYybrpP72BUXCWdITkxAmzk8pqFwHdpRVYsoTlesSuvWlJcF
         2lDA==
X-Gm-Message-State: APjAAAXsc0RvvEMsIye5UDxJcKu0XH/Ss1pAI7m0lJT0xeogX37B7erJ
        Pk2ODWmSclw8COwH7OZo0w4IIXcAF9qtYs7cg1/PEQ==
X-Google-Smtp-Source: APXvYqzo2ljEGvchzRcyIbUEZT9wdgSNT2CgcXIYDlIj+7NoyR/2724Q+hSDkumLb2AjZxDXvEVS1q4vfz+to4FDTj4n7g==
X-Received: by 2002:a63:d642:: with SMTP id d2mr5757128pgj.205.1576092497512;
 Wed, 11 Dec 2019 11:28:17 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:27:40 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1 5/7] crypto: amlogic: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/crypto/amlogic/amlogic-gxl-core.o: in function `meson_crypto_probe':
drivers/crypto/amlogic/amlogic-gxl-core.c:240: undefined reference to `devm_platform_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/crypto/amlogic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/amlogic/Kconfig b/drivers/crypto/amlogic/Kconfig
index b90850d18965f..cf95476026708 100644
--- a/drivers/crypto/amlogic/Kconfig
+++ b/drivers/crypto/amlogic/Kconfig
@@ -1,5 +1,6 @@
 config CRYPTO_DEV_AMLOGIC_GXL
 	tristate "Support for amlogic cryptographic offloader"
+	depends on HAS_IOMEM
 	default y if ARCH_MESON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ENGINE
-- 
2.24.0.525.g8f36a354ae-goog

