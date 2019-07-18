Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4E6CCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbfGRKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 06:25:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40524 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfGRKZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:25:23 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E1A41A0047;
        Thu, 18 Jul 2019 12:25:22 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 121221A0009;
        Thu, 18 Jul 2019 12:25:22 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CCC9205C7;
        Thu, 18 Jul 2019 12:25:21 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, =kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, paul.olaru@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/3] Add power domain range for MU13 side b / IRQSTR_DSP
Date:   Thu, 18 Jul 2019 13:25:16 +0300
Message-Id: <20190718102519.31855-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds power domain range for MU13 side b and irqsteer in
preparation for adding support for DSP <-> AP IPC communication.

Changes since v1:
	- fixed typo in patch 1/3 commit message
	- enhance commit message for patch 2/3 as per Aisheng's comments
	- only add PD range for mu 13 side B
	
Daniel Baluta (3):
  firmware: imx: scu-pd: Rename mu PD range to mu_a
  firmware: imx: scu-pd: Add mu13 b side PD range
  firmware: imx: scu-pd: Add IRQSTR_DSP PD range

 drivers/firmware/imx/scu-pd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1

