Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD9161AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 08:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfGHGsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 02:48:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54786 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbfGHGsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:48:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A2E1A2000D7;
        Mon,  8 Jul 2019 08:48:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 465A7200026;
        Mon,  8 Jul 2019 08:48:12 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 943A4402AE;
        Mon,  8 Jul 2019 14:48:06 +0800 (SGT)
From:   shengjiu.wang@nxp.com
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/2] recover the channel swap after xrun
Date:   Mon,  8 Jul 2019 14:38:50 +0800
Message-Id: <cover.1562566531.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

recover the channel swap after xrun

Shengjiu Wang (2):
  ASoC: fsl_esai: Wrap some operations to be functions
  ASoC: fsl_esai: recover the channel swap after xrun

 sound/soc/fsl/fsl_esai.c | 270 ++++++++++++++++++++++++++++-----------
 1 file changed, 197 insertions(+), 73 deletions(-)

Changes in V3
- update code sytle.

Changes in v2
- add one patch for wrap operations to functions.
- fix some coding style issue

-- 
2.21.0

