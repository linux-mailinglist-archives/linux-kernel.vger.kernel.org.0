Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B47D9289
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405400AbfJPNdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 09:33:53 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54520 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405388AbfJPNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:33:52 -0400
Received: by mail-wm1-f44.google.com with SMTP id p7so2943152wmp.4;
        Wed, 16 Oct 2019 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFXJh5YwdqvqkTvI55Rp72RJZ5nJ2dgoIfxiju6Kc5s=;
        b=LbcP6M3awlWA/xKI7gZTJ93F41yKo1zgsEX8wdkvb5OapDjr2THcmnkGmwQ5khfy0b
         m44DA08Ov5qA8YP7ZiTD0f50WTv0CXtHhFXs5uDjNuio5m7NPhVcRwJXZTAznjwHyTcx
         1T2mKL5Q11EU07B8ciu3B9WFV8cquhx7F6CelJ9hltIHQSp3mZkNz2uMc0j5OUnIfxQo
         Vy3Hmh/ZyY3Z+SYMe2eV7hoHHIKcbwyBg1jGo+kSLDSH4knMK8vPyXvTeWuE2oi/c8XE
         emK/3omGGUYa97U9WgfBfEx5HGsYBfi/k/Hf00HG5bUss2yCWmfLbaGsQYOV6+Psjrx+
         mAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFXJh5YwdqvqkTvI55Rp72RJZ5nJ2dgoIfxiju6Kc5s=;
        b=L7a5kU1bQekN6zvaF2vdqDFxkCgKK9N7/hpfFjjzgX5tFxh7FDKGfQDj6dTtNLtVl9
         lzPgZjPPic3KMHGRgAms/HH2vN33djkWdxDR/iZ4HN9CLQx+RM9kFEFTUwwniuER6j+M
         eSJxKRxMgTFt3vEeTdH+8VwxTAIarkyQJs0dB5Pi2z/ggYdGyyqVHxzco4p4iGIjM4wu
         3McXunDl6M+NYqkd3jNJHh7NvqBqDYY8GNn7yRiwYTlXMknWQnRoQnCVcfA0R2uQzAv6
         bEoxP1kAsiYdmaiMRdc3IajcX+XvvzSKJFanimKsIQ2faDe7YmTvRzsNcT6w2gLErUUF
         Q9fw==
X-Gm-Message-State: APjAAAX/uTE/DopNwM6csZDjCMK3+TTX5KQtrcJUezDtzNGntkT2qJYj
        aYa6DyumHf5fOdEIzCCq3Ko=
X-Google-Smtp-Source: APXvYqxSO35Wwnr4fa2v5+O2FpqGRKcz3QzjOWm+Jz0C/0YUoZHznBT0G3al+EcSCbjzWVXvfBo9pw==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr3458368wmh.40.1571232829451;
        Wed, 16 Oct 2019 06:33:49 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id h17sm3139998wme.6.2019.10.16.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:33:48 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 0/4] crypto: add sun8i-ss driver for Allwinner Security System
Date:   Wed, 16 Oct 2019 15:33:41 +0200
Message-Id: <20191016133345.9076-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patch serie adds support for the second version of Allwinner Security System.
The first generation of the Security System is already handled by the sun4i-ss driver.
Due to major change, the first driver cannot handle the second one.
This new Security System is present on A80 and A83T SoCs.

For the moment, the driver support only DES3/AES in ECB/CBC mode.
Patchs for CTR/CTS, RSA and RNGs will came later.

This serie is tested with CRYPTO_MANAGER_EXTRA_TESTS
and tested on:
sun8i-a83t-bananapi-m3
sun9i-a80-cubieboard4

This serie is based on top of the "crypto: add sun8i-ce driver for
Allwinner crypto engine" serie.

Regards

Corentin Labbe (4):
  crypto: Add Allwinner sun8i-ss cryptographic offloader
  dt-bindings: crypto: Add DT bindings documentation for sun8i-ss
    Security System
  ARM: dts: sun8i: a83t: Add Security System node
  ARM: dts: sun9i: a80: Add Security System node

 .../bindings/crypto/allwinner,sun8i-ss.yaml   |  64 ++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
 arch/arm/boot/dts/sun9i-a80.dtsi              |  10 +
 drivers/crypto/allwinner/Kconfig              |  28 +
 drivers/crypto/allwinner/Makefile             |   1 +
 drivers/crypto/allwinner/sun8i-ss/Makefile    |   2 +
 .../allwinner/sun8i-ss/sun8i-ss-cipher.c      | 438 ++++++++++++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 641 ++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  | 218 ++++++
 9 files changed, 1412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/allwinner,sun8i-ss.yaml
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/Makefile
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h

-- 
2.21.0

