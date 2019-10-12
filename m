Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB75ED51BB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfJLStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 14:49:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41080 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbfJLStB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:49:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id q9so15251534wrm.8;
        Sat, 12 Oct 2019 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHmZ3uVIQl1nvwGBNhAHxx/afaDHfmZCLHq24Dj1FMI=;
        b=q+Ha2zc+dWj+dyzbrh3ZNn1S+Bzn1xBq2dQzR3LCeh7MYXCZ4IFdppgnp6Wg/6w9Rg
         Vmyv7xd7xbLmPYLCMpnBnsx2+UgB2fiZQxKDTpl9kuZcfOcxFt/lOm+4QGVn1zStLSJG
         S/eoaVnaDDHrzYOIxStNfytJfsmztaB0vR9bWPPTo3jxct8fncUfaUpHnuaaDo7UZKle
         +e+QnAcWbX8VtW0gg0Pdo14r1Un9fv+UnBwyx9Tl7cPfQO2/mG1+n6EBQmcnhjDXAm7a
         Xu1KQKlZ51z0ncJI5QDaLmRs2/vlxJWPxmI5mL77uv6jjkyiC0k3bwlczGEX0kFW6OzI
         Ujpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHmZ3uVIQl1nvwGBNhAHxx/afaDHfmZCLHq24Dj1FMI=;
        b=rc55dCWpXvj5aB0fZHDCdIfIBf8SleL/dYCOrc06yaGTAfZMzjapwVbx2y7KWOaYxp
         j1OBMUNoXuVEgfncaKXC/PcH3MP58LKVd7/Cjqn9hEFgDYs7+8XMb1EKRrD3xcMQyCOl
         p3QUpKto849h3uNgGvvrI1IN3HdrOGCIKnlV+JOAi9APy6b6lsw3IP19G8ZBq+HcSz3p
         YIzWijRbJs5vYtX/1unXperixfmiXQcwIgESLUDZAVJNTF20wAnV+u2w3b7sw50x5KEF
         tKE4EFiKvx7pyf7QwgAH325hPxrDZYrCoqhCGI/chCe21DTIkKnjWVTvFc8CtR364PU/
         krMA==
X-Gm-Message-State: APjAAAU8Yk8+yoWaYIxn1YMCRPXuYY8+v1eLAxJW+Q+dyvATFn0bKThM
        5oAG1JCllCeP34j/81bxeoI=
X-Google-Smtp-Source: APXvYqwnVp1c9C0rNWKN0cNV/Ida3rboGEScQOkBtQkk8V3Zds5+oSLMnivS1fle7h5/sTJfT3lBVg==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr19206357wrr.356.1570906136564;
        Sat, 12 Oct 2019 11:48:56 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id a13sm33670580wrf.73.2019.10.12.11.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 11:48:55 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v4 00/11] crypto: add sun8i-ce driver for Allwinner crypto engine
Date:   Sat, 12 Oct 2019 20:48:41 +0200
Message-Id: <20191012184852.28329-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patch serie adds support for the Allwinner crypto engine.
The Crypto Engine is the third generation of Allwinner cryptogaphic offloader.
The first generation is the Security System already handled by the
sun4i-ss driver.
The second is named also Security System and is present on A80 and A83T
SoCs, originaly this driver supported it also, but supporting both IP bringing
too much complexity and another driver (sun8i-ss) will came for it.

For the moment, the driver support only DES3/AES in ECB/CBC mode.
Patchs for CTR/CTS/XTS, RSA and RNGs will came later.

This serie is tested with CRYPTO_MANAGER_EXTRA_TESTS
and tested on:
sun50i-a64-bananapi-m64
sun50i-a64-pine64-plus
sun50i-h5-libretech-all-h3-cc
sun50i-h6-pine-h64
sun8i-h2-plus-libretech-all-h3-cc
sun8i-h2-plus-orangepi-r1
sun8i-h2-plus-orangepi-zero
sun8i-h3-libretech-all-h3-cc
sun8i-h3-orangepi-pc
sun8i-r40-bananapi-m2-ultra

Regards

Changes since v3:
- removed need of reset-names
- switched from optional reset to mandatory

Changes since v2:
- changed additionalproperties
- splited fallbacks functions out of sun8i_ce_cipher()
- changed variant "model" to "has_t_dlen_in_bytes"
- splited sun8i_ce_register_algs/sun8i_ce_get_clks out of sun8i_ce_probe()

Changes since v1:
- Add sun4i-ss to allwinner directory
- Cleaned variant structure
- Renamed clock name from ahb to bus (and mbus to ram)
- Fixed DT bindings problem reported by mripard
- Cleaned unneeded status = ""  in R40 DT
- Removed old unnecessary interrupt_names in A64 DT
- Added arm64 defconfig
- Added support for PM functions
- Splitted probe functions
- Reworked clock settings
- made reset mandatory

Corentin Labbe (11):
  crypto: Add allwinner subdirectory
  crypto: Add Allwinner sun8i-ce Crypto Engine
  dt-bindings: crypto: Add DT bindings documentation for sun8i-ce Crypto
    Engine
  ARM: dts: sun8i: R40: add crypto engine node
  ARM: dts: sun8i: H3: Add Crypto Engine node
  ARM64: dts: allwinner: sun50i: Add Crypto Engine node on A64
  ARM64: dts: allwinner: sun50i: Add crypto engine node on H5
  ARM64: dts: allwinner: sun50i: Add Crypto Engine node on H6
  sunxi_defconfig: add new Allwinner crypto options
  arm64: defconfig: add new Allwinner crypto options
  crypto: sun4i-ss: Move to Allwinner directory

 .../bindings/crypto/allwinner,sun8i-ce.yaml   |  88 +++
 MAINTAINERS                                   |   4 +-
 arch/arm/boot/dts/sun8i-h3.dtsi               |   9 +
 arch/arm/boot/dts/sun8i-r40.dtsi              |   9 +
 arch/arm/configs/sunxi_defconfig              |   2 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   9 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |   9 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   9 +
 arch/arm64/configs/defconfig                  |   2 +
 drivers/crypto/Kconfig                        |  28 +-
 drivers/crypto/Makefile                       |   2 +-
 drivers/crypto/allwinner/Kconfig              |  60 ++
 drivers/crypto/allwinner/Makefile             |   2 +
 .../{sunxi-ss => allwinner/sun4i-ss}/Makefile |   0
 .../sun4i-ss}/sun4i-ss-cipher.c               |   0
 .../sun4i-ss}/sun4i-ss-core.c                 |   0
 .../sun4i-ss}/sun4i-ss-hash.c                 |   0
 .../sun4i-ss}/sun4i-ss-prng.c                 |   0
 .../sun4i-ss}/sun4i-ss.h                      |   0
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   2 +
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 434 +++++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 677 ++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 254 +++++++
 23 files changed, 1571 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
 create mode 100644 drivers/crypto/allwinner/Kconfig
 create mode 100644 drivers/crypto/allwinner/Makefile
 rename drivers/crypto/{sunxi-ss => allwinner/sun4i-ss}/Makefile (100%)
 rename drivers/crypto/{sunxi-ss => allwinner/sun4i-ss}/sun4i-ss-cipher.c (100%)
 rename drivers/crypto/{sunxi-ss => allwinner/sun4i-ss}/sun4i-ss-core.c (100%)
 rename drivers/crypto/{sunxi-ss => allwinner/sun4i-ss}/sun4i-ss-hash.c (100%)
 rename drivers/crypto/{sunxi-ss => allwinner/sun4i-ss}/sun4i-ss-prng.c (100%)
 rename drivers/crypto/{sunxi-ss => allwinner/sun4i-ss}/sun4i-ss.h (100%)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/Makefile
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h

-- 
2.21.0

