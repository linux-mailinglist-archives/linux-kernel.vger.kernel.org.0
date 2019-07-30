Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159A17A05D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfG3Fer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 01:34:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51760 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbfG3Feq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:34:46 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F8E1200588;
        Tue, 30 Jul 2019 07:34:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 96B93200576;
        Tue, 30 Jul 2019 07:34:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E9887402E0;
        Tue, 30 Jul 2019 13:34:36 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3]  mailbox: imx: add support for imx v1 mu
Date:   Tue, 30 Jul 2019 13:12:22 +0800
Message-Id: <1564463543-5611-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change logs:

v2 --> v3:
  - Format the patch-set refer to Oleksij's guidance.
  - Init the register array by a simple way recommended by Oleksij.
  - Add Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> tag.

v1 --> v2:
  - Use to have the register layout linked on probe, suggested by
  Oleksij Rempel <o.rempel@pengutronix.de>.
  - Add Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com> tag.

Richard Zhu (1):
  mailbox: imx: add support for imx v1 mu

 drivers/mailbox/imx-mailbox.c | 55 ++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 17 deletions(-)

-- 
2.7.4

