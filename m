Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A8F7927
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 17:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKKQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 11:51:11 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44264 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfKKQvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:51:10 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 48827200634;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BBCF200629;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 05A48205FE;
        Mon, 11 Nov 2019 17:51:08 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/4] staging: dpaa2-ethsw: cleanup notifier block registration
Date:   Mon, 11 Nov 2019 18:50:54 +0200
Message-Id: <1573491058-24766-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set cleans up the notifier block registration by keeping a
private notifier per dpaa2-ethsw instance. Also, convert the global
workqueue to a private one. Without this, multiple probes will lead
to a WARNING dump.

Ioana Ciornei (4):
  staging: dpaa2-ethsw: move port notifier per ethsw
  staging: dpaa2-ethsw: move port switchdev notifier per ethsw
  staging: dpaa2-ethsw: move port switchdev blocking notifier per ethsw
  staging: dpaa2-ethsw: ordered workqueue should be per ethsw

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 50 +++++++++++++++------------------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |  5 ++++
 2 files changed, 27 insertions(+), 28 deletions(-)

-- 
1.9.1

