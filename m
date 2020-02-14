Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6340915F84B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 21:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbgBNU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 15:56:42 -0500
Received: from foss.arm.com ([217.140.110.172]:45032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbgBNU4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:56:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE26D30E;
        Fri, 14 Feb 2020 12:56:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 624433F68F;
        Fri, 14 Feb 2020 12:56:40 -0800 (PST)
Date:   Fri, 14 Feb 2020 20:56:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: ensure component names are unique" to the asoc tree
In-Reply-To:  <20200214134704.342501-1-jbrunet@baylibre.com>
Message-Id:  <applied-20200214134704.342501-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: ensure component names are unique

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b2354e4009a773c00054b964d937e1b81cb92078 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 14 Feb 2020 14:47:04 +0100
Subject: [PATCH] ASoC: core: ensure component names are unique

Make sure each ASoC component is registered with a unique name.
The component is derived from the device name. If a device registers more
than one component, the component names will be the same.

This usually brings up a warning about the debugfs directory creation of
the component since directory already exists.

In such case, start numbering the component of the device so the names
don't collide anymore.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200214134704.342501-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 03b87427faa7..6a58a8f6e3c4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2446,6 +2446,33 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 	return ret;
 }
 
+static char *snd_soc_component_unique_name(struct device *dev,
+					   struct snd_soc_component *component)
+{
+	struct snd_soc_component *pos;
+	int count = 0;
+	char *name, *unique;
+
+	name = fmt_single_name(dev, &component->id);
+	if (!name)
+		return name;
+
+	/* Count the number of components registred by the device */
+	for_each_component(pos) {
+		if (dev == pos->dev)
+			count++;
+	}
+
+	/* Keep naming as it is for the 1st component */
+	if (!count)
+		return name;
+
+	unique = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", name, count);
+	devm_kfree(dev, name);
+
+	return unique;
+}
+
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -2454,7 +2481,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->card_list);
 	mutex_init(&component->io_mutex);
 
-	component->name = fmt_single_name(dev, &component->id);
+	component->name = snd_soc_component_unique_name(dev, component);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.20.1

