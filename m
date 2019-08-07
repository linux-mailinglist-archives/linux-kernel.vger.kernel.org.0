Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF08432A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 06:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfHGENH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 00:13:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32890 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfHGENG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 00:13:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 17DC41A01FB;
        Wed,  7 Aug 2019 06:13:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9412C1A02B9;
        Wed,  7 Aug 2019 06:12:59 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8D7F240296;
        Wed,  7 Aug 2019 12:12:52 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     srinivas.kandagatla@linaro.org
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, fugang.duan@nxp.com, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH nvmem v2 0/2] nvmem: imx: add i.MX8QM platform support
Date:   Wed,  7 Aug 2019 12:03:18 +0800
Message-Id: <20190807040320.1760-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

The patch set is to add i.MX8QM platform support for i.MX8 SCU
OCOTP driver due to i.MX8QM efuse table has some difference with
i.MX8QXP platform.

V2:
- Add dt-bindings for the new compatible string support.

Fugang Duan (2):
  nvmem: imx: add i.MX8QM platform support
  dt-bindings: fsl: scu: add new compatible string for ocotp

 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
 drivers/nvmem/imx-ocotp-scu.c                               | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.7.4

