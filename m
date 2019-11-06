Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3EF1A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbfKFPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 10:52:49 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33408 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfKFPwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:52:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D8F342001D2;
        Wed,  6 Nov 2019 16:52:47 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CBD1F2000DA;
        Wed,  6 Nov 2019 16:52:47 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E5D8205EB;
        Wed,  6 Nov 2019 16:52:47 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/2] arm64: dts: lx2160a: add EMDIO1 and phy nodes
Date:   Wed,  6 Nov 2019 17:52:14 +0200
Message-Id: <1573055536-21786-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds the External MDIO1 node and the two
RGMII PHYs connected to it.

Ioana Ciornei (2):
  arm64: dts: lx2160a: add emdio1 node
  arm64: dts: lx2160a: add RGMII phy nodes

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 27 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 11 +++++++++
 2 files changed, 38 insertions(+)

-- 
1.9.1

