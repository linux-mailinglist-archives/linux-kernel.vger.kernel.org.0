Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF779C329
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfHYMRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 08:17:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:61446 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfHYMRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:17:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46GYy30s3Vz55;
        Sun, 25 Aug 2019 14:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566735358; bh=midx80iUy3avtT/Mo/OB+mMlAmfHoL2kDdpN3DL3rD8=;
        h=Date:From:Subject:To:Cc:From;
        b=eauM8c1/MyDyDyTQkcK2LHoYBiaBO2oi7tltzy+B3oKUvTdU7jf2D3eAGtrOJgUDb
         agOVBJfxzwopF+7o3MXULCFvrXUwKhsSQCnjmn5/P+YIQZzWG3LgGV5x9Q/8TeThkt
         uRswhsbFHFStN3YzbTU4qZUnu0oLiVkv4ude3S9Yz9YZL0vAjaImIIBgvQocCsVQ5I
         cJAf0aAjFSHAoflws+z/SIOF7XHXbUenP8C8u4RqkJp2Qjxr2RWKMLD9Qc4rLqzsLZ
         3soSE+Q01tFJl4y9Hoa8ZrA61vnG+P561zUNpudqou0DPwsqYw//n/WIGE05Cbj73/
         xO1ZgVPYLvOtQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sun, 25 Aug 2019 14:17:30 +0200
Message-Id: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/4] wm8904: adapt driver for use with audio-graph-card
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Nariman Poushin <npoushin@opensource.cirrus.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nikesh Oswal <nikesh@opensource.cirrus.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Piotr Stankiewicz <piotrs@opensource.cirrus.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows to use WM8904 codec as audio-graph-card component.
It starts with rework of FLL handling in the codec's driver, and as an
example includes (untested) rework for codec with similar FLL: WM8994.

Series based on tiwai/sound/for-next tree. You can also pull from:
   https://rere.qmqm.pl/git/linux
branch:
   wm8904

(branch includes two fixes already sent to alsa-devel, but not merged yet).

Michał Mirosław (4):
  ASoC: wm_fll: extract common code for Wolfson FLLs
  ASoC: wm8904: use common FLL code
  ASoC: wm8904: automatically choose clock source
  [RFT] ASoC: wm8994: use common FLL code

 sound/soc/atmel/atmel_wm8904.c |  11 +-
 sound/soc/codecs/Kconfig       |   9 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/wm8904.c      | 516 +++++++++++---------------------
 sound/soc/codecs/wm8904.h      |   5 -
 sound/soc/codecs/wm8994.c      | 281 +++++-------------
 sound/soc/codecs/wm8994.h      |   4 +-
 sound/soc/codecs/wm_fll.c      | 518 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_fll.h      |  60 ++++
 9 files changed, 849 insertions(+), 557 deletions(-)
 create mode 100644 sound/soc/codecs/wm_fll.c
 create mode 100644 sound/soc/codecs/wm_fll.h

-- 
2.20.1

