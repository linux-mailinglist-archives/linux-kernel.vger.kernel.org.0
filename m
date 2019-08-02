Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB827ED5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 09:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbfHBHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 03:24:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33506 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbfHBHYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:24:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77FFF2000B4;
        Fri,  2 Aug 2019 09:24:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 805ED200097;
        Fri,  2 Aug 2019 09:24:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5525E402C9;
        Fri,  2 Aug 2019 15:24:05 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 0/2] mailbox: imx: add support for imx v1 mu
Date:   Fri,  2 Aug 2019 15:01:38 +0800
Message-Id: <1564729300-30374-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change logs:

v3 --> v4:
  - Change "version1.0" to "version 1.0" in the commit log.
  - Update the devicetree binding document to support the imx7ulp mu.
  - Rebase the patch refer to the following bug-fixs patch-set issued
  by Daniel Baluta <daniel.baluta@gmail.com>.
  "https://patchwork.kernel.org/patch/11069479/"

v2 --> v3:
  - Format the patch-set refer to Oleksij's guidance.
  - Init the register array by a simple way recommended by Oleksij.
  - Add Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> tag.

v1 --> v2:
  - Use to have the register layout linked on probe, suggested by
  Oleksij Rempel <o.rempel@pengutronix.de>.
  - Add Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com> tag.

Richard Zhu (2):
  dt-bindings: mailbox: imx-mu: add imx7ulp MU support
  mailbox: imx: add support for imx v1 mu

 .../devicetree/bindings/mailbox/fsl,mu.txt         |  2 +
 drivers/mailbox/imx-mailbox.c                      | 55 +++++++++++++++-------
 2 files changed, 40 insertions(+), 17 deletions(-)

-- 
2.7.4

