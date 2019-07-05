Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D210607CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGEO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 10:27:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50646 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfGEO1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:27:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 76229200E88;
        Fri,  5 Jul 2019 16:27:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69A27200769;
        Fri,  5 Jul 2019 16:27:19 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 29AE4204D6;
        Fri,  5 Jul 2019 16:27:19 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ruxandra.radulescu@nxp.com,
        Razvan Stefanescu <razvan.stefanescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 5/6] staging: fsl-dpaa2/ethsw: Add switch driver documentation
Date:   Fri,  5 Jul 2019 17:27:15 +0300
Message-Id: <1562336836-17119-6-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
References: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@nxp.com>

Add a switch driver entry in the dpaa2 overview documentation.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none

 .../networking/device_drivers/freescale/dpaa2/overview.rst          | 6 ++++++
 MAINTAINERS                                                         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst b/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
index d638b5a8aadd..7b7f35908890 100644
--- a/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
+++ b/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
@@ -393,6 +393,12 @@ interfaces needed to connect the DPAA2 network interface to
 the network stack.
 Each DPNI corresponds to a Linux network interface.
 
+Ethernet L2 Switch driver
+-------------------------
+The Ethernet L2 Switch driver is bound to a DPSW and makes use of the
+switchdev support in kernel.
+Each switch port has a corresponding Linux network interface.
+
 MAC driver
 ----------
 An Ethernet PHY is an off-chip, board specific component and is managed
diff --git a/MAINTAINERS b/MAINTAINERS
index c0a02dccc869..5c51be8e281c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4938,6 +4938,7 @@ M:	Ioana Ciornei <ioana.ciornei@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethsw
+F:	Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
 
 DPAA2 PTP CLOCK DRIVER
 M:	Yangbo Lu <yangbo.lu@nxp.com>
-- 
1.9.1

