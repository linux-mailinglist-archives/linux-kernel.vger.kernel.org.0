Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB58B8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfHMMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 08:43:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59802 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHMMnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:43:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C6D5E1A0234;
        Tue, 13 Aug 2019 14:43:11 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB48B1A0132;
        Tue, 13 Aug 2019 14:43:11 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 651B22060E;
        Tue, 13 Aug 2019 14:43:11 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 00/10] staging: fsl-dpaa2/ethsw: code cleanup
Date:   Tue, 13 Aug 2019 15:42:57 +0300
Message-Id: <1565700187-16048-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set addresses some of the feedback received on the dpaa2-ethsw
driver: https://lore.kernel.org/patchwork/patch/1113335/.

There are no functional changes but rather just code cleanup.

Changes in v2:
 - added Reported-by and Suggested-by tags
Changes in v3:
 - fix error path in patch 10/10

Ioana Ciornei (10):
  staging: fsl-dpaa2/ethsw: remove IGMP default address
  staging: fsl-dpaa2/ethsw: enable switch ports only on dev_open
  staging: fsl-dpaa2/ethsw: add line terminator to all formats
  staging: fsl-dpaa2/ethsw: remove debug message
  staging: fsl-dpaa2/ethsw: use bool when encoding learning/flooding
    state
  staging: fsl-dpaa2/ethsw: remove unnecessary memset
  staging: fsl-dpaa2/ethsw: remove redundant VLAN check
  staging: fsl-dpaa2/ethsw: reword error message
  staging: fsl-dpaa2/ethsw: register_netdev only when ready
  staging: fsl-dpaa2/ethsw: do not force user to bring interface down

 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  44 +++++-----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         | 110 ++++++------------------
 2 files changed, 50 insertions(+), 104 deletions(-)

-- 
1.9.1

