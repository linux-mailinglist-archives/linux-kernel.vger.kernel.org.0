Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA310458B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 22:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKTVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 16:14:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60993 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKTVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:14:10 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1iXXIU-0001J2-Nq; Wed, 20 Nov 2019 22:13:58 +0100
Received: from mgr by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1iXXIQ-0001XW-9i; Wed, 20 Nov 2019 22:13:54 +0100
From:   Michael Grzeschik <m.grzeschik@pengutronix.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ARM: dts: imx25: usbhost port1 improvemts
Date:   Wed, 20 Nov 2019 22:13:32 +0100
Message-Id: <20191120211334.5580-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120082955.3ovsoziurntmv7by@pengutronix.de>
References: <20191120082955.3ovsoziurntmv7by@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Grzeschik (2):
  ARM: dts: imx25: consolidate properties of usbhost1 in dtsi file
  ARM: dts: imx25: describe maximum speed of internal usbhost port1 phy

 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts | 2 --
 arch/arm/boot/dts/imx25-pdk.dts                        | 2 --
 arch/arm/boot/dts/imx25.dtsi                           | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.24.0

