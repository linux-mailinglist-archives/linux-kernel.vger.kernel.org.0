Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A51938DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 07:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCZGtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 02:49:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37572 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgCZGtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:49:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id d1so5742120wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=m/woP8JE+Q/g0ZO0DRvUNOSB5SWwhTVz0tFdoKMPxxo=;
        b=H2n3m3sRF0tHj/MR1yFPyawxFUsyiDdjYI76xB/dYLngYzS5i9nRuIe6/TKuYr9K3b
         9XSVkH0w1gt5DG4rjqA7+RLeLVQO7jNxj6vCMLCFjjKy8E7CFj6W8kZKHkYqc7e8gM2i
         +SVTaotuowDSxAaMHR26QnJ+MFR8PwkRSQuxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m/woP8JE+Q/g0ZO0DRvUNOSB5SWwhTVz0tFdoKMPxxo=;
        b=UU9vqCokmCjG1vg1eSRzvcx2GI88P1HLom8ydXgMtUObVobJoghNl7KjhJRn7d1qXM
         KVta803udZuUxwBenBxpZ6aiqjg+sZlLx/gDN9O7OnYao5I2p+Qv/eJ/xImxz22ZdY7I
         TeZH46r4R1urH31VxaNQWSSJsA9bpSHZkiQhbIJ96E2uEwLVuGkg4Skq/xp+Nkczg0Uf
         osxJTAZjGtnqEdfP1IYCSx/2072COZM4hM1BWmRQs/StgYDPpcN8LpXWhd7pc8x5LeJb
         iTTrh4iELcgw2CqLvdTOCYs05btdMJRd0ZI/FIhpLYJt3sugujUwQwi84mCUi2+Af+d0
         KdhQ==
X-Gm-Message-State: ANhLgQ2oMyFtbXm1rh6JfXDvb441963Sa2npJzCUxE9XfO56xIIhJJNX
        dcZTK8KFGFpAYHn6boIPBinUEw==
X-Google-Smtp-Source: ADFU+vvHarE2WZIQBKwJVOAl77q3js1Qw/P3PaTTHhN6tLddp/9YVShnhfUTAlEsbjewgdKGGOeB2Q==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr1490010wmb.124.1585205354813;
        Wed, 25 Mar 2020 23:49:14 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v21sm2069137wmj.8.2020.03.25.23.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 23:49:13 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 0/6] PAXB INTx support with proper model
Date:   Thu, 26 Mar 2020 12:18:40 +0530
Message-Id: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PCIe legacy interrupt (INTx) support to the iProc
PCIe driver by modeling it with its own IRQ domain. All 4 interrupts INTA,
INTB, INTC, INTD share the same interrupt line connected to the GIC
in the system. This is now modeled by using its own IRQ domain.

Also update all relevant devicetree files to adapt to the new model.

This patch set is based on Linux-5.5-rc1.

Changes from v4:
  - Addressed Lorenzo's comments
    - Add iProc irq chip descriptor in the place of dummy irq chip to
      provide mask/un-mask and enable/disable handlers to configure
      individual INTx.

Changes from v3:
  - Addressed Andrew Murray's comments
  - Add change to dispose VIRQ when disabling INTx

Changes from v2:
  - Addressed Lorenzo's comments
    - Corrected INTx to PIN mapping.

Changes from v1:
  - Addressed Rob, Lorenzo, Arnd's comments
    - Used child node for interrupt controller.
  - Addressed Andy Shevchenko's comments
    - Replaced while loop with do-while.

Ray Jui (6):
  dt-bindings: pci: Update iProc PCI binding for INTx support
  PCI: iproc: Add INTx support with better modeling
  arm: dts: Change PCIe INTx mapping for Cygnus
  arm: dts: Change PCIe INTx mapping for NSP
  arm: dts: Change PCIe INTx mapping for HR2
  arm64: dts: Change PCIe INTx mapping for NS2

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  48 ++++++-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  30 ++++-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |  30 ++++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  45 ++++++-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  28 +++-
 drivers/pci/controller/pcie-iproc.c                | 147 ++++++++++++++++++++-
 drivers/pci/controller/pcie-iproc.h                |   8 ++
 7 files changed, 309 insertions(+), 27 deletions(-)

-- 
2.7.4

