Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5645E73A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfGCO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:56:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54530 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCO4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:56:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D5CFB1A0DCA;
        Wed,  3 Jul 2019 16:56:47 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C97AF1A03A1;
        Wed,  3 Jul 2019 16:56:47 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F434205F0;
        Wed,  3 Jul 2019 16:56:47 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, Roy.Pledge@nxp.com,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] soc: fsl: dpio: small fixes
Date:   Wed,  3 Jul 2019 17:56:37 +0300
Message-Id: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains a couple of fixes that concern the dpio driver and
the fsl-mc bus.  The first two patches are adapting the usage of device
links to match newer developments in the area.  The third patch fixes the
Kconfig of FSL_MC_DPIO by selecting directly FSL_GUTS instead of SOC_BUS.

Ioana Ciornei (3):
  bus: fsl-mc: remove explicit device_link_del
  soc: fsl: dpio: remove explicit device_link_remove
  soc: fsl: FSL_MC_DPIO selects directly FSL_GUTS

 drivers/bus/fsl-mc/fsl-mc-allocator.c | 1 -
 drivers/bus/fsl-mc/mc-io.c            | 1 -
 drivers/soc/fsl/Kconfig               | 2 +-
 drivers/soc/fsl/dpio/dpio-service.c   | 2 --
 4 files changed, 1 insertion(+), 5 deletions(-)

-- 
1.9.1

