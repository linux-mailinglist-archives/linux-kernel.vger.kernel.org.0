Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856D7A2CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 04:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfH3CUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 22:20:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41335 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfH3CUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:20:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so2663199pgg.8;
        Thu, 29 Aug 2019 19:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRHcnIepKK5U2wNfUCScZ2wTbvSrlBuU+oVE4yt3loQ=;
        b=j37L7Al5CTzS+uEeWPzG2no8G3GAm82pD6DnC65KkfBWv5UCKc3ENxVPfnx6NE2nRp
         VkpT1IFhadWb6iQ33X3JNpeqk5kHDhzElJrwOM2rLFit00Iq9oEljm/GHeIm9dFSZc0f
         WJBrJx8zmiEY29bfQ+iOriHew+ACzyDJqtMsT8OagSkrG5gVHbJ5yXYeGk6cWxMdA7Tt
         gnlNAvleoZUXm80Ylbaf/KyXZFmVJhNBIbsnYPtJCNoefKGLl2eXY/7+tjM2i4oF//yf
         dJ8qMMhcoYiYz5NJt29AY+bQnRm7lG47ddugbr05HFShK60EmXa9DaxS0NPXevd8Li4Z
         tliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRHcnIepKK5U2wNfUCScZ2wTbvSrlBuU+oVE4yt3loQ=;
        b=eqjp57+t2sjJBZzL+12qozNxqrEIWN0zCuM8m/2GUBh6YNaEV5Y8C4cReThekvvXlp
         blNCXETledy9jSmYOBiXkyDCET0/z2xWyn468IeFkd5tL0AtvvTfsGESwKF0vZ/kYhiS
         RUbJnohI86m1WFWXwFycbSZoDXo0aqd+EqjK+MbrFaKP5b4V3nfe6nUf9S73GiCaTaW8
         /y/Ao0yBwGr72gu53bH7pIN5EiQX0eIs9JLnU80E8cUzXs8gEXy92du9+aVCFrbpM6mT
         9gHm0uu4yr3TWblxLO4wtp/qexQRpDx6mnWYjwQIqSXpqHzT74qJBgrulDTcGwMp0UaN
         9aNw==
X-Gm-Message-State: APjAAAXKTYZ30dy8KjWXgVr3raDkjSf//fH7sua87AeUEIL0T+vsNFoK
        B13OP+/YR3JCKDzDNND3HzI=
X-Google-Smtp-Source: APXvYqyRQP2+H5hOEHYHiDdlJiEP9CNZ/q0q1WYaIpeXgasDhwLdBANWFCseWJcs8sXVL97EjQYI1w==
X-Received: by 2002:a62:3046:: with SMTP id w67mr9486666pfw.5.1567131642214;
        Thu, 29 Aug 2019 19:20:42 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id u16sm3104843pgm.83.2019.08.29.19.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 19:20:41 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V7 0/5] Add Genesys Logic GL975x support
Date:   Fri, 30 Aug 2019 10:20:39 +0800
Message-Id: <20190830022039.8210-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The patches modify internal clock setup to match SD Host Controller
Simplified Specifications 4.20 and support Genesys Logic GL9750/GL9755 chipsets.

v7:
 - remove condition define CONFIG_MMC_SDHCI_IO_ACCESSORS from sdhci-pci-gli.c
 - making the accessors(MMC_SDHCI_IO_ACCESSORS) always available when selecting
   MMC_SDHCI_PCI in Kconfig

V6:
 - export sdhci_abot_tuning() function symbol
 - use C-style comments
 - use BIT, FIELD_{GET,PREP} and GENMASK to define bit fields of register
 - use host->ops->platform_execute_tuning instead of mmc->ops->execute_tuning
 - call sdhci_reset() instead of duplicating the code in sdhci_gl9750_reset
 - remove .hw_reset 
 - use condition define CONFIG_MMC_SDHCI_IO_ACCESSORS for read_l

V5:
 - add "change timeout of loop .." to a patch
 - fix typo "verndor" to "vendor"

V4:
 - change name from sdhci_gli_reset to sdhci_gl9750_reset
 - fix sdhci_reset to sdhci_gl9750_reset in sdhci_gl9750_ops
 - fix sdhci_gli_reset to sdhci_reset in sdhci_gl9755_ops
 
V3:
 - change usleep_range to udelay
 - add Genesys Logic PCI Vendor ID to a patch
 - separate the Genesys Logic specific part to a patch

V2:
 - change udelay to usleep_range

Ben Chuang (5):
  mmc: sdhci: Change timeout of loop for checking internal clock stable
  mmc: sdhci: Add PLL Enable support to internal clock setup
  PCI: Add Genesys Logic, Inc. Vendor ID
  mmc: sdhci: Export sdhci_abort_tuning function symbol
  mmc: host: sdhci-pci: Add Genesys Logic GL975x support

 drivers/mmc/host/Kconfig          |   1 +
 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 350 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 drivers/mmc/host/sdhci.c          |  30 ++-
 drivers/mmc/host/sdhci.h          |   2 +
 include/linux/pci_ids.h           |   2 +
 8 files changed, 390 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c

-- 
2.22.1

