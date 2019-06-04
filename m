Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BB346C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfFDMb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 08:31:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58608 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfFDMb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:31:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB10F1A0F0B;
        Tue,  4 Jun 2019 14:31:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 03D561A0F07;
        Tue,  4 Jun 2019 14:31:19 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B3FD4402C7;
        Tue,  4 Jun 2019 20:31:11 +0800 (SGT)
From:   daniel.baluta@nxp.com
To:     shawnguo@kernel.org
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.felsch@pengutronix.de, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v4 0/2]  Enable wm8524 codec on i.MX8MM EVK
Date:   Tue,  4 Jun 2019 20:32:55 +0800
Message-Id: <20190604123257.2920-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch series introduces the SAI nodes on i.MX8MM EVK then
creates the wm8524 codec node and finally uses simple card machine
driver to create a sound card.

Changes since v3:
	- rebased on latest for-next branch
	- fixed encoding problems

Changes since v2:
       - place compatible strings one a single lines
       - move GPIO pinctrl in a node of its own
       - remove codec phandle

Changes since v1:
        - use "fsl,imx8mm-sai", "fsl,imx8mq-sai" compatbile strings and
          remove "fsl,imx6sx-sai" because SAI module on i.MX8M is not
          compatbile with SAI modules form i.MX6

Daniel Baluta (2):
  arm64: dts: imx8mm: Add SAI nodes
  arm64: dts: imx8mm-evk: Enable audio codec wm8524

 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 55 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi    | 66 ++++++++++++++++++++
 2 files changed, 121 insertions(+)

-- 
2.17.1

