Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8742BC5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394674AbfIXKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 06:54:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41506 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438798AbfIXKyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:54:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4CB771A0192;
        Tue, 24 Sep 2019 12:54:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B31481A00DE;
        Tue, 24 Sep 2019 12:54:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C906D4029F;
        Tue, 24 Sep 2019 18:54:01 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: [PATCH V4 0/4] update supported sample format
Date:   Tue, 24 Sep 2019 18:52:31 +0800
Message-Id: <cover.1569296075.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serial is to update the supported format for fsl_asrc
and fix some format issue.

Shengjiu Wang (4):
  ASoC: fsl_asrc: Use in(out)put_format instead of in(out)put_word_width
  ASoC: fsl_asrc: update supported sample format
  ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams
  ASoC: fsl_asrc: Fix error with S24_3LE format bitstream in i.MX8

changes in v2
- extract snd_dmaengine_pcm_set_runtime_hwparams in one
  separate path.
- 4th patch depends on 3rd patch

changes in v3
- Fix build report by kbuild test robot <lkp@intel.com>
- change snd_dmaengine_pcm_set_runtime_hwparams to
  snd_dmaengine_pcm_refine_runtime_hwparams

changes in v4
- update according to Nicolin's comments.

 include/sound/dmaengine_pcm.h         |  5 ++
 sound/core/pcm_dmaengine.c            | 83 +++++++++++++++++++++++++++
 sound/soc/fsl/fsl_asrc.c              | 65 ++++++++++++++-------
 sound/soc/fsl/fsl_asrc.h              |  7 ++-
 sound/soc/fsl/fsl_asrc_dma.c          | 59 ++++++++++++++++---
 sound/soc/soc-generic-dmaengine-pcm.c | 61 ++------------------
 6 files changed, 193 insertions(+), 87 deletions(-)

-- 
2.21.0

