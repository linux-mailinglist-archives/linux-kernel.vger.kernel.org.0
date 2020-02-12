Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25F15AB74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 15:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgBLO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 09:56:58 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:38050 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgBLO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:56:57 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id 1qwu2200d5USYZQ01qwuvz; Wed, 12 Feb 2020 15:56:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1tRe-0004yo-NF; Wed, 12 Feb 2020 15:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1tRe-0001DQ-Kn; Wed, 12 Feb 2020 15:56:54 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] ASoC: Fix SND_SOC_ALL_CODECS imply fallout
Date:   Wed, 12 Feb 2020 15:56:47 +0100
Message-Id: <20200212145650.4602-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Mark,

As expected[*], commit ea00d95200d02ece ("ASoC: Use imply for
SND_SOC_ALL_CODECS") introduced several build failures, due to missing
dependencies.

This patch series fixes several of them.  There are probably more.

Do we want to pursue this, or just revert instead?
Thanks!

[*] https://lore.kernel.org/alsa-devel/20200207091351.18133-1-geert@linux-m68k.org/

Geert Uytterhoeven (3):
  ASoC: Fix SND_SOC_ALL_CODECS imply SPI fallout
  ASoC: Fix SND_SOC_ALL_CODECS imply I2C fallout
  ASoC: Fix SND_SOC_ALL_CODECS imply misc fallout

 sound/soc/codecs/Kconfig | 88 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 6 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
