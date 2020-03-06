Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71117BA90
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCFKj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 05:39:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:44042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgCFKjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5A3BADE8;
        Fri,  6 Mar 2020 10:39:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        f.fainelli@gmail.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Raspberry Pi vmmc regulator support
Date:   Fri,  6 Mar 2020 11:38:45 +0100
Message-Id: <20200306103857.23962-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series snowballed into adding a new quirk, as I reliased
sdhci-iproc's behaviour is not that uncommon.

Based on Phil Elwell's work in the downstream Raspberry Pi kernel.

---

Nicolas Saenz Julienne (10):
  mmc: sdhci: Add quirk SDHCI_QUIRK2_SET_BUS_VOLTAGE
  mmc: sdhci: milbeaut: Use quirk instead of custom set_power()
  mmc: sdhci: arsan: Use quirk instead of custom set_power()
  mmc: sdhci: at-91: Use quirk instead of custom set_power()
  mmc: sdhci: pxav3: Use quirk instead of custom set_power()
  mmc: sdhci: xenon: Use quirk instead of custom set_power()
  mmc: sdhci: am654: Use quirk instead of custom set_power()
  mmc: sdhci: Unexport sdhci_set_power_noreg()
  mmc: sdhci: iproc: Use SDHCI_QUIRK2_SET_BUS_VOLTAGE on bcm2711
  ARM: dts: bcm2711: Add sd_vcc regulator to emmc2

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++
 drivers/mmc/host/sdhci-iproc.c        |  1 +
 drivers/mmc/host/sdhci-milbeaut.c     | 15 ++----------
 drivers/mmc/host/sdhci-of-arasan.c    | 22 +++++------------
 drivers/mmc/host/sdhci-of-at91.c      | 18 +-------------
 drivers/mmc/host/sdhci-pxav3.c        | 20 +---------------
 drivers/mmc/host/sdhci-xenon.c        | 20 +---------------
 drivers/mmc/host/sdhci.c              | 34 +++++++++++++++------------
 drivers/mmc/host/sdhci.h              |  4 ++--
 drivers/mmc/host/sdhci_am654.c        | 23 +++++-------------
 10 files changed, 50 insertions(+), 118 deletions(-)

-- 
2.25.1

