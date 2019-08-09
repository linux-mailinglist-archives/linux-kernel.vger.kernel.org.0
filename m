Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF2874BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 11:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406079AbfHIJCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 05:02:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405713AbfHIJCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:02:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AE418B5E505D30C5B891;
        Fri,  9 Aug 2019 17:02:05 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 17:01:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: ac97: remove unused variable 'snd_ac97_controls_master_mono'
Date:   Fri, 9 Aug 2019 17:01:13 +0800
Message-ID: <20190809090113.65728-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/pci/ac97/ac97_codec.c:599:38: warning:
 snd_ac97_controls_master_mono defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/ac97/ac97_codec.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 96b4601..66f6c3b 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -596,11 +596,6 @@ static int snd_ac97_put_volsw(struct snd_kcontrol *kcontrol,
 	return err;
 }
 
-static const struct snd_kcontrol_new snd_ac97_controls_master_mono[2] = {
-AC97_SINGLE("Master Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
-AC97_SINGLE("Master Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1)
-};
-
 static const struct snd_kcontrol_new snd_ac97_controls_tone[2] = {
 AC97_SINGLE("Tone Control - Bass", AC97_MASTER_TONE, 8, 15, 1),
 AC97_SINGLE("Tone Control - Treble", AC97_MASTER_TONE, 0, 15, 1)
-- 
2.7.4


