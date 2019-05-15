Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E81F547
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfEONRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 09:17:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33189 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfEONRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:17:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so4693413wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBIWbSPpc7j2EgIiZbpjBgwSCzEoaoZA6IHHGeyqm0k=;
        b=MHYcqecCUI/xmN0B4JbfnX7hMUbiXLCSV1mF6rl8tZ2E/n8Dqwl7RFPMQb7BsxJ6Xr
         kXLbgqR52m/LoSaW6Wmuv+5/eAqFgWZF1kMc/Rd4879C6I95vL8neWipC4GRZqAVr3Pj
         zYUjZ/FA2xA7QVXfrgynvf+6HEClV+jOcEuav7LiVpqlKa+HNg2QYp5mSpeYRYzqB6lo
         yuR09cbQFJx5C6/7VhsCQ34CfnrVtre6Nc5j/ou1EZdnJfE9mmq7obbZ0chFH6D/rSp1
         81DX849ZUfUsN9Q+u0yj2LzxxfQCcM83++Pl3VJOh1S1BaUxAGliBMtJo+5pFLceJ/fR
         ZMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBIWbSPpc7j2EgIiZbpjBgwSCzEoaoZA6IHHGeyqm0k=;
        b=mXascriIHjpjR3uKbaVMJQx1UclSz9gk9JvDZU0rbKTlepMEB3sJWXgLxgYEwavF4b
         SCnG5iwLjJ+zssbouKTnwOYtXpfKscRTIZfwsF0UoS9CPMMXLB8I5f+9hIVsNtkUeZDA
         nJkcJI6ZSpW7MQCIvB0CWwYBYGangl7Pj2tmK8diXPY0FLdmuME+b+oGtU1BUZlsncPo
         nTrLqIIHEGlwDEesSiSE3ALcTMGoDicL2B7P/A93+UwFMustGYloRiDcG33mFAYuoYrP
         SVYZa9nVCScr9KxkREtFAMSdTcIr+yVpyfa7imLfE26BWF+h22PRfIAcyXI+7oqabfHG
         Mr2Q==
X-Gm-Message-State: APjAAAVTJMM9P0OqzmYpsB09yEiokQaaeUeG0ZUIVKIpCj2vNhggBTPg
        3FB0IwiFbTGsDajqbiLBwo9VBA==
X-Google-Smtp-Source: APXvYqztV9ij0IVX8p1xv1SzUN1LERXsJ9a/GZbNdSp+jRn1j2plcZZjBsrB44VGoOhLMEphD5XOIQ==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr21232039wmd.43.1557926264158;
        Wed, 15 May 2019 06:17:44 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-11-31.w90-86.abo.wanadoo.fr. [90.86.214.31])
        by smtp.gmail.com with ESMTPSA id f10sm3268583wrg.24.2019.05.15.06.17.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 06:17:43 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v3 0/5] mt6392: Add support for MediaTek MT6392 PMIC
Date:   Wed, 15 May 2019 15:17:36 +0200
Message-Id: <20190515131741.17294-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims at bringing support for the MediaTek MT6392 PMIC. This
PMIC is used on the MT8516 Pumpkin board.

This patch series adds support for the following features:
 * PMIC keys
 * regulator
 * RTC

Fabien Parent (5):
  dt-bindings: regulator: add support for MT6392
  regulator: mt6392: Add support for MT6392 regulator
  dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
  mfd: mt6397: Add support for MT6392 pmic
  arm64: dts: mt6392: Add PMIC mt6392 dtsi

 .../devicetree/bindings/mfd/mt6397.txt        |  12 +-
 .../bindings/regulator/mt6392-regulator.txt   | 220 ++++++++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 208 ++++++++
 drivers/mfd/mt6397-core.c                     |  55 ++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 490 ++++++++++++++++++
 include/linux/mfd/mt6392/core.h               |  42 ++
 include/linux/mfd/mt6392/registers.h          | 487 +++++++++++++++++
 include/linux/regulator/mt6392-regulator.h    |  40 ++
 10 files changed, 1562 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.20.1

