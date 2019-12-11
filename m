Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9845E11BCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 20:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfLKT2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 14:28:18 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34020 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfLKT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:28:16 -0500
Received: by mail-pf1-f201.google.com with SMTP id q5so2722748pfh.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BQ5LiziZTeureblMPRNhovCXqRNggUJSXGHiPxM/c88=;
        b=StcCt920kwcBiRwjrKhZVZfcXqvWzoL3r1mwj2A85X1Yzs5qM8b3iyK84qRp1Xs7T8
         nonSRsmF7cm63RO7uct7RtsbWnUsWtpfdrSHZzQ5zS4F6ADqcm1oFinW9wAv5SasTErQ
         MbFuILnpIJvsikvuajGp2juGxrDNIc6Y9702aa9/ARewgVsP/aeyorCc5ciRsoVa+P+S
         jgzoQubZJPDR6o9WZ7klrN/MziCbEzYK3VfkZ6aZIz/KmnfZMnp48dBZHtQd4Io2p8H2
         A+irmwTtNlu7mnTiIFdtxGrws8OgfJF8cloRZedpWGR4jWGaDBnpNtYboiUcc2WnzzjQ
         fJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BQ5LiziZTeureblMPRNhovCXqRNggUJSXGHiPxM/c88=;
        b=uTqo2cZ5tlYZhA9wYQ+22COcvyKjVJeyxYsbxGwTq0gc2u+3t4dGjCADlaCGK6IsfC
         A2gAcoaeeqichj+x8kzL9TXM6gEvXrnmXsUbVIdz6OE+Lxdw0gFYHT86JqdAClFaytK2
         g36MHEepYltQyfj0F89AEVh6FD5L8ti4bvaWhLSpDH+wDWkiY1MKKpuCBmueznMePxqQ
         q3gUbdo89ft26cTZAGwSZy/NK73/RtzJ3yAR3spCGyAu1m7w88ge273E1MHweCN0QW2D
         TXmzK44HdWVtpVirULKjDR1iFefWMqNzX7Sk9lmcUu+blROkno1ym1Qab5qV03i/dmkc
         ROqw==
X-Gm-Message-State: APjAAAUkl/TPfIV99TeXyyo5scwDkqb2PgC+cXUXgHxoHUPgMThwNQza
        5Ermk3Ss9j8xMikT2/21t77RIIdRtnZ1p1Kr9Ba5Uw==
X-Google-Smtp-Source: APXvYqwHq1wPbJfX1P3di6U0QGKesenIIwA8rNjsA9QoHqtRWhSBzb50nACoOAVrlh871zgnanIejWFROnewubWK71T6wg==
X-Received: by 2002:a63:1756:: with SMTP id 22mr6056384pgx.109.1576092495090;
 Wed, 11 Dec 2019 11:28:15 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:27:39 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1 4/7] crypto: inside-secure: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_CRYPTO_DEV_SAFEXCEL=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/crypto/inside-secure/safexcel.o: in function `safexcel_probe':
drivers/crypto/inside-secure/safexcel.c:1692: undefined reference to `devm_platform_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 91eb768d4221a..0a73bebd04e5d 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -716,7 +716,7 @@ source "drivers/crypto/stm32/Kconfig"
 
 config CRYPTO_DEV_SAFEXCEL
 	tristate "Inside Secure's SafeXcel cryptographic engine driver"
-	depends on OF || PCI || COMPILE_TEST
+	depends on (OF || PCI || COMPILE_TEST) && HAS_IOMEM
 	select CRYPTO_LIB_AES
 	select CRYPTO_AUTHENC
 	select CRYPTO_SKCIPHER
-- 
2.24.0.525.g8f36a354ae-goog

