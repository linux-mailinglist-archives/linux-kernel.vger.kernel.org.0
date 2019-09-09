Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B53AD6E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 12:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfIIKet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 06:34:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58210 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbfIIKet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:34:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 80DC51A03CC;
        Mon,  9 Sep 2019 12:34:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 886501A0178;
        Mon,  9 Sep 2019 12:34:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 27428402E3;
        Mon,  9 Sep 2019 18:34:36 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] update supported sample format
Date:   Mon,  9 Sep 2019 18:33:18 -0400
Message-Id: <cover.1568025083.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update supported sample format

Shengjiu Wang (3):
  ASoC: fsl_asrc: Use in(out)put_format instead of in(out)put_word_width
  ASoC: fsl_asrc: update supported sample format
  ASoC: fsl_asrc: Fix error with S24_3LE format bitstream in i.MX8

 sound/soc/fsl/fsl_asrc.c     | 65 ++++++++++++++++---------
 sound/soc/fsl/fsl_asrc.h     |  7 ++-
 sound/soc/fsl/fsl_asrc_dma.c | 93 +++++++++++++++++++++++++++++++++---
 3 files changed, 135 insertions(+), 30 deletions(-)

-- 
2.21.0

