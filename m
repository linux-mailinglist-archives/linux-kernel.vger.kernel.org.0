Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB4DA4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 07:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbfJQFGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 01:06:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36413 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfJQFGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 01:06:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so1011014wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 22:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vc5hMa73OPr/x/aEf805fVYp+2tYvgPjEPvMghKb2Zw=;
        b=zh64szI5/P7kHr7xGyuurhRKHjg1Pn1Q28ubOkmOzG3Stwaf4WlQppsxqn+dNutVpv
         Yp9ECpelYfZLjI25E2yFrf5j4gxK5YunYg3Br2IVSqkK/4jF77prXesnCIAaRvYrU06q
         516AdjPwzMZ+S7nTMrdAZq6HlkPzGFMYWUmQhouxL0xUsRS+9Ct91pLNxgnjDTpcvU0+
         Z60oaEnCXX2Aa9eKW0lvTSpWGEuZLmL31s+hPdJUAe0wFgCg+CbW3KqndIWiAaOKVKjD
         3oFcBNzJVMivg8nPMQ95fwkpuydWpLCKG/B9xbbinhjU3YbV/0M3rzGTb3iA8yggNAYl
         ZAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vc5hMa73OPr/x/aEf805fVYp+2tYvgPjEPvMghKb2Zw=;
        b=O8w+ICwaY047kQnZivaATVh0VAkWnKhbqqPe6UQenetS+9PxOdG/tePVFQZbFRW1Wt
         CuvKb4tPJ+A8vKWovcV3H63976TXBSrE9NNOoGIXb1T1aUL63jkk9MyiDu4sK7AxhkkV
         kflfVnbwAqd8GxIAVnampaT0TVvsi4ARmqFNEqDCunLpyXRNHH7d4ppECCiDywu46YtY
         2OYcOKblxuM/6RTF6Xq8b+Mj6iKakYAkONi0gbJXj/XNctI6BqqgeJVrAK7K/pbvVbDH
         PggIESTlpWfgGpRmCmDSW6VNSdBOybx6o/xTL2P5nJmBO6ZG+Y4amaTm5WQZaG/WGKpO
         hGMQ==
X-Gm-Message-State: APjAAAX9u+NeH01TaFoDwWZ+LGf3jGE+UpPUV3AUK3Fz62efccKL2xys
        x16RIqWtpZ9jsO4Wi1RBRH5sUg==
X-Google-Smtp-Source: APXvYqw07wwT75FOoNWJyD/an/XIle9yHvlb7113NxzJZiEpvXnUsfMUBXr2Xe/6iQ8HyyjCXNyUPQ==
X-Received: by 2002:a05:600c:143:: with SMTP id w3mr1048902wmm.17.1571288802451;
        Wed, 16 Oct 2019 22:06:42 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b5sm1010762wmj.18.2019.10.16.22.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 22:06:41 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 0/4] crypto: add amlogic crypto offloader driver
Date:   Thu, 17 Oct 2019 05:06:22 +0000
Message-Id: <1571288786-34601-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This serie adds support for the crypto offloader present on amlogic GXL
SoCs.

Tested on meson-gxl-s905x-khadas-vim and meson-gxl-s905x-libretech-cc

Regards

Changes since v2:
- fixed some spelling in kconfig
- Use devm_platform_ioremap_resource

Changes since v1:
- renamed files and algo with gxl
- removed unused reset handlings
- splited the probe functions
- splited meson_cipher fallback in need_fallback() and do_fallback()


Corentin Labbe (4):
  dt-bindings: crypto: Add DT bindings documentation for amlogic-crypto
  MAINTAINERS: Add myself as maintainer of amlogic crypto
  crypto: amlogic: Add crypto accelerator for amlogic GXL
  ARM64: dts: amlogic: adds crypto hardware node

 .../bindings/crypto/amlogic,gxl-crypto.yaml   |  52 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  10 +
 drivers/crypto/Kconfig                        |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/amlogic/Kconfig                |  24 ++
 drivers/crypto/amlogic/Makefile               |   2 +
 drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 381 ++++++++++++++++++
 drivers/crypto/amlogic/amlogic-gxl-core.c     | 331 +++++++++++++++
 drivers/crypto/amlogic/amlogic-gxl.h          | 170 ++++++++
 10 files changed, 980 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
 create mode 100644 drivers/crypto/amlogic/Kconfig
 create mode 100644 drivers/crypto/amlogic/Makefile
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl-cipher.c
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl-core.c
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl.h

-- 
2.21.0

