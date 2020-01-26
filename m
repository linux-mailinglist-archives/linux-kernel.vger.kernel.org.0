Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D83149CA5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgAZUAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 15:00:25 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:32574 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAZUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:00:25 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyPQjcv7w="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.7 DYNA|AUTH)
        with ESMTPSA id k0645aw0QK0EF2E
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 26 Jan 2020 21:00:14 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: [PATCH v3 0/2] wl1251: remove ti,power-gpio for sdio mode
Date:   Sun, 26 Jan 2020 21:00:12 +0100
Message-Id: <cover.1580068813.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* rebased on wireless-drivers-next-2020-01-26

PATCH V2 2019-12-17 19:07:02:
* use just "wl1251: " as title prefix - by Kalle Valo <kvalo@codeaurora.org>
* fix error handling: we still have to check for wl->irq returning -EPROBE_DEFER

PATCH V1 2019-11-24 11:35:48:
The driver has been updated to use the mmc/sdio core
which does full power control. So we do no longer need
the power control gipo.

Note that it is still needed for the SPI based interface
(N900).

Suggested by: Ulf Hansson <ulf.hansson@linaro.org>
Tested by: H. Nikolaus Schaller <hns@goldelico.com> # OpenPandora 600MHz

H. Nikolaus Schaller (2):
  DTS: bindings: wl1251: mark ti,power-gpio as optional
  wl1251: remove ti,power-gpio for SDIO mode

 .../bindings/net/wireless/ti,wl1251.txt       |  3 +-
 drivers/net/wireless/ti/wl1251/sdio.c         | 32 ++-----------------
 2 files changed, 4 insertions(+), 31 deletions(-)

-- 
2.23.0

