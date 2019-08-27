Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14D9EA86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfH0OND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 10:13:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:10800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfH0ONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:13:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 07:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="264282427"
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2019 07:12:57 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@intel.com>
Subject: [PATCH 3/6] ASoC: dapm: Expose snd_soc_dapm_new_control_unlocked properly
Date:   Tue, 27 Aug 2019 16:17:09 +0200
Message-Id: <20190827141712.21015-4-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>

We use snd_soc_dapm_new_control_unlocked for topology and have local
declaration, instead declare it properly in header like already declared
snd_soc_dapm_new_control.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
---
 include/sound/soc-dapm.h | 3 +++
 sound/soc/soc-topology.c | 6 ------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2aa73d6dd7be..30d8d0410952 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -404,6 +404,9 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 struct snd_soc_dapm_widget *snd_soc_dapm_new_control(
 		struct snd_soc_dapm_context *dapm,
 		const struct snd_soc_dapm_widget *widget);
+struct snd_soc_dapm_widget *snd_soc_dapm_new_control_unlocked(
+		struct snd_soc_dapm_context *dapm,
+		const struct snd_soc_dapm_widget *widget);
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b8690715abb5..aa9a1fca46fa 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -80,12 +80,6 @@ struct soc_tplg {
 
 static int soc_tplg_process_headers(struct soc_tplg *tplg);
 static void soc_tplg_complete(struct soc_tplg *tplg);
-struct snd_soc_dapm_widget *
-snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
-			 const struct snd_soc_dapm_widget *widget);
-struct snd_soc_dapm_widget *
-snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
-			 const struct snd_soc_dapm_widget *widget);
 static void soc_tplg_denum_remove_texts(struct soc_enum *se);
 static void soc_tplg_denum_remove_values(struct soc_enum *se);
 
-- 
2.17.1

