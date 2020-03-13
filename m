Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B16183A89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 21:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCLUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 16:25:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59968 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLUZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:25:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 194F4200F30;
        Thu, 12 Mar 2020 21:25:26 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D5BD1200F1F;
        Thu, 12 Mar 2020 21:25:25 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 574D540AB2;
        Thu, 12 Mar 2020 13:25:25 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] fixes to soc/fsl drivers for v5.6
Date:   Thu, 12 Mar 2020 15:25:25 -0500
Message-Id: <20200312202525.16708-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please help to merge the following fix for soc/fsl drivers.

Thanks,
Leo

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v5.6

for you to fetch changes up to fe8fe7723a3a824790bda681b40efd767e2251a7:

  soc: fsl: dpio: register dpio irq handlers after dpio create (2020-03-10 15:28:47 -0500)

----------------------------------------------------------------
NXP/FSL soc driver fixes for v5.6

DPAA2 DPIO
- Fix a kernel hang caused by irq requested before creating dpio

----------------------------------------------------------------
Grigore Popescu (1):
      soc: fsl: dpio: register dpio irq handlers after dpio create

 drivers/soc/fsl/dpio/dpio-driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
