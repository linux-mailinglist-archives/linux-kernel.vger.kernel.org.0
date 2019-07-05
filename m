Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2B8607CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 16:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfGEO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 10:27:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50574 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGEO1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:27:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97296200769;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A83A200761;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 52226204D6;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ruxandra.radulescu@nxp.com
Subject: [PATCH v2 0/6] staging: fsl-dpaa2/ethsw: code cleanup
Date:   Fri,  5 Jul 2019 17:27:10 +0300
Message-Id: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains various small cleanup patches
for the DPAA2 ethsw driver.

Changes in v2:
 - removed patch "staging: fsl-dpaa2/ethsw: Check notification relevance"
since another patch doing the same thing was merged through net-next

Razvan Stefanescu (6):
  staging: fsl-dpaa2/ethsw: Fix setting port learning/flooding flags
  staging: fsl-dpaa2/ethsw: Add network interface statistics
  staging: fsl-dpaa2/ethsw: Remove netdevice on port probing error
  staging: fsl-dpaa2/ethsw: Add ndo_get_phys_port_name
  staging: fsl-dpaa2/ethsw: Add switch driver documentation
  staging: fsl-dpaa2/ethsw: Add comments to ETHSW_VLAN flags

 .../device_drivers/freescale/dpaa2/overview.rst    |  6 ++++
 MAINTAINERS                                        |  1 +
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            | 39 ++++++++++++++++++----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h            |  4 +++
 4 files changed, 44 insertions(+), 6 deletions(-)

-- 
1.9.1

