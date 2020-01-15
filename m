Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDDB13CD45
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 20:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgAOTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 14:42:28 -0500
Received: from mailoutvs44.siol.net ([185.57.226.235]:43686 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgAOTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:42:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E70415225A4;
        Wed, 15 Jan 2020 20:42:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id quCGKKoRs-as; Wed, 15 Jan 2020 20:42:25 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A2FFC5228C8;
        Wed, 15 Jan 2020 20:42:25 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 455C75225A4;
        Wed, 15 Jan 2020 20:42:25 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: allwinner: h6: Introduce OrangePi 3 eMMC board
Date:   Wed, 15 Jan 2020 20:42:14 +0100
Message-Id: <20200115194216.173117-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi 3 board has multiple variants. Two of them come with 8 GiB eMMC
soldered on them.

This series introduces new DT file for OrangePi 3 with eMMC.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (2):
  dt-bindings: arm: sunxi: add OrangePi 3 with eMMC
  arm64: dts: allwinner: h6: Introduce OrangePi 3 eMMC variant

 .../devicetree/bindings/arm/sunxi.yaml        |  5 +++++
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-orangepi-3-emmc.dts   | 22 +++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3-em=
mc.dts

--=20
2.24.1

