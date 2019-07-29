Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C346F78497
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfG2FwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 01:52:00 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37082 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfG2Fv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:51:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 106C6201429;
        Mon, 29 Jul 2019 07:51:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 092C020141C;
        Mon, 29 Jul 2019 07:51:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3C848402E0;
        Mon, 29 Jul 2019 13:51:50 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2] mailbox: imx: add support for imx v1 mu
Date:   Mon, 29 Jul 2019 13:29:39 +0800
Message-Id: <1564378180-27395-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
v1 --> v2:
  - Use to have the register layout linked on probe, suggested by
  Oleksij Rempel <o.rempel@pengutronix.de>.
  - Add the Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com> tag.

[v2] mailbox: imx: add support for imx v1 mu
---
 drivers/mailbox/imx-mailbox.c | 67 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 17 deletions(-)
