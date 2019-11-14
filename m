Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8774FC9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 16:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 10:33:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:37154 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfKNPdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:33:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 07:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="405008904"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2019 07:33:09 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iVH7N-0003cb-Er; Thu, 14 Nov 2019 23:33:09 +0800
Date:   Thu, 14 Nov 2019 23:33:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ben Zhang <benzh@chromium.org>
Cc:     kbuild-all@lists.01.org, Mark Brown <broonie@kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] ASoC: rt5677: rt5677_check_hotword() can be
 static
Message-ID: <20191114153304.n4pyix7qadu76tx4@4978f4969bb8>
References: <201911142322.pHmcOJHb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911142322.pHmcOJHb%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 21c00e5df439 ("ASoC: rt5677: Enable jack detect while DSP is running")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 rt5677.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 48955b22262fa..cd01a3a8daa82 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5243,7 +5243,7 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
 	},
 };
 
-bool rt5677_check_hotword(struct rt5677_priv *rt5677)
+static bool rt5677_check_hotword(struct rt5677_priv *rt5677)
 {
 	int reg_gpio;
 
