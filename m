Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E6BFCD0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 03:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfI0BsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 21:48:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58926 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfI0BsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 21:48:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9024200603;
        Fri, 27 Sep 2019 03:48:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 683B6200125;
        Fri, 27 Sep 2019 03:47:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 45175402CB;
        Fri, 27 Sep 2019 09:47:47 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: [PATCH V6 0/4] update supported sample format
Date:   Fri, 27 Sep 2019 09:46:08 +0800
Message-Id: <cover.1569493933.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serial is to update the supported format for fsl_asrc
and fix some format issue

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

changes in v5
- free asrc pair when error happens in patch 4/4

changes in v6
- ignore return value of snd_soc_set_runtime_hwparams in patch 4/4

 include/sound/dmaengine_pcm.h         |  5 ++
 sound/core/pcm_dmaengine.c            | 83 +++++++++++++++++++++++++++
 sound/soc/fsl/fsl_asrc.c              | 65 ++++++++++++++-------
 sound/soc/fsl/fsl_asrc.h              |  7 ++-
 sound/soc/fsl/fsl_asrc_dma.c          | 64 ++++++++++++++++++---
 sound/soc/soc-generic-dmaengine-pcm.c | 61 ++------------------
 6 files changed, 199 insertions(+), 86 deletions(-)

-- 
2.21.0

