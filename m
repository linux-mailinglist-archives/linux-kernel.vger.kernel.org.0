Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C611510D50B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfK2LkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 06:40:14 -0500
Received: from olimex.com ([184.105.72.32]:33569 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfK2LkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:40:06 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 03:39:54 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 0/3] arm64: dts: allwinner: a64: olinuxino: Update regulators
Date:   Fri, 29 Nov 2019 13:39:38 +0200
Message-Id: <20191129113941.20170-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie updates bank regulators for A64-OLinuXino and 
A64-OLinuXino-eMMC.

Also, eMMC supply is changed to ELDO1, which is the actual one. The same is
done for the SDIO card - ALDO2 is changed to DCDC1.

Changes for v2:
 - Restore the original eMMC vmmc-supply property
 - Add fixes and kernel tags

Stefan Mavrodiev (3):
  arm64: dts: allwinner: a64: olinuxino: Fix eMMC supply regulator
  arm64: dts: allwinner: a64: olinuxino: Add bank supply regulators
  arm64: dts: allwinner: a64: olinuxino: Fix SDIO supply regulator

 .../allwinner/sun50i-a64-olinuxino-emmc.dts    |  6 +++++-
 .../dts/allwinner/sun50i-a64-olinuxino.dts     | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.17.1
