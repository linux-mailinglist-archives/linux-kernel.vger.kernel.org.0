Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15CC17D0F9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 04:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgCHDOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 22:14:37 -0500
Received: from mail.manjaro.org ([176.9.38.148]:57762 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCHDOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 22:14:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 1B65E39611CC;
        Sun,  8 Mar 2020 04:14:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tbktZ9oDShq1; Sun,  8 Mar 2020 04:14:33 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [RFC PATCH 1/1] ASoC: jack: use gpiolib inversion flag for inverted gpios
Date:   Sun,  8 Mar 2020 04:13:55 +0100
Message-Id: <20200308031355.1149173-2-t.schramm@manjaro.org>
In-Reply-To: <20200308031355.1149173-1-t.schramm@manjaro.org>
References: <20200308031355.1149173-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit changes the handling of jack gpios with ACTIVE_LOW logic.
The inversion flag is now passed down and transparently handled by the
legacy gpiolib.

Previously the level of a gpio was inverted manually inside
snd_soc_jack_gpio_detect and gpiolib ACTIVE_LOW flag was not set on the
gpio. This resulted in erroneous output in /dev/class/gpio/gpio*/active_low
and debug interfaces like /sys/kernel/debug/gpio where the gpio was
still listed as active high while jack status for that gpio actually
followed an active low logic.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 sound/soc/soc-jack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index b5748dcd490f..8c17cfdbb883 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -254,8 +254,6 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 	int report;
 
 	enable = gpiod_get_value_cansleep(gpio->desc);
-	if (gpio->invert)
-		enable = !enable;
 
 	if (enable)
 		report = gpio->report;
@@ -385,6 +383,10 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			}
 		} else {
 			/* legacy GPIO number */
+			int flags = GPIOF_IN;
+
+			if (gpios[i].invert)
+				flags |= GPIOF_ACTIVE_LOW;
 			if (!gpio_is_valid(gpios[i].gpio)) {
 				dev_err(jack->card->dev,
 					"ASoC: Invalid gpio %d\n",
@@ -393,7 +395,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 				goto undo;
 			}
 
-			ret = gpio_request_one(gpios[i].gpio, GPIOF_IN,
+			ret = gpio_request_one(gpios[i].gpio, flags,
 					       gpios[i].name);
 			if (ret)
 				goto undo;
-- 
2.24.1

