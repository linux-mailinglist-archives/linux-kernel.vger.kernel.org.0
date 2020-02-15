Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C593115FCA4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 06:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgBOFVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 00:21:42 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48782 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgBOFVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 00:21:42 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 214871A6BF1;
        Sat, 15 Feb 2020 06:21:40 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F49A1A6BC8;
        Sat, 15 Feb 2020 06:21:34 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 49A2440297;
        Sat, 15 Feb 2020 13:21:27 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 0/7] Add missing UART DCE/DTE pins macro defines
Date:   Sat, 15 Feb 2020 13:15:51 +0800
Message-Id: <1581743758-4475-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set is to add missing UART DCE/DTE pins, because of previous
UART pins macro defines do NOT contain DCE/DTE, per the advice from
Uwe in V1 patch comment, to better distinguish the DCE/DTE functions,
I change the existing UART pins to contain the DCE/DTE, then add the
missing UART pins, meanwhile, keep the old macro definis there for some time
in order to make it backward compatible, and then, switch the existing
consumer DTs to use new UART pins macro defines with DCE/DTE inside.

As the changes in V2 is significant compared to V1, so I did NOT put
a change log in each patch, you can treat each patch as new patch, thanks.

Anson Huang (7):
  ARM: dts: imx6sx: Improve UART pins macro defines
  ARM: dts: imx6sx: Add missing UART RTS/CTS pins mux
  ARM: dts: imx6sx-nitrogen6sx: Use new pin names with DCE/DTE for UART
    pins
  ARM: dts: imx6sx-sabreauto: Use new pin names with DCE/DTE for UART
    pins
  ARM: dts: imx6sx-sdb: Use new pin names with DCE/DTE for UART pins
  ARM: dts: imx6sx-softing-vining-2000: Use new pin names with DCE/DTE
    for UART pins
  ARM: dts: imx6sx-udoo-neo: Use new pin names with DCE/DTE for UART
    pins

 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts         |  20 +-
 arch/arm/boot/dts/imx6sx-pinfunc.h               | 288 ++++++++++++++++-------
 arch/arm/boot/dts/imx6sx-sabreauto.dts           |   4 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                |  12 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts |   8 +-
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi           |  28 +--
 6 files changed, 237 insertions(+), 123 deletions(-)

-- 
2.7.4

