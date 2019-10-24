Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9305E3113
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439136AbfJXLo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 07:44:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35924 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfJXLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:44:57 -0400
Received: from [114.245.47.48] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1iNbXt-0003cb-GY; Thu, 24 Oct 2019 11:44:50 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        hui.wang@canonical.com, alsa-devel@alsa-project.org,
        aaron.ma@canonical.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ALSA: hda/realtek - Fix 2 front mics of codec 0x623
Date:   Thu, 24 Oct 2019 19:44:39 +0800
Message-Id: <20191024114439.31522-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022153855.14368-1-aaron.ma@canonical.com>
References: <20191022153855.14368-1-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 ThinkCentres installed a new realtek codec ID 0x623,
it has 2 front mics with the same location on pin 0x18 and 0x19.

Apply fixup ALC283_FIXUP_HEADSET_MIC to change 1 front mic
location to right, then pulseaudio can handle them.
One "Front Mic" and one "Mic" will be shown, and audio output works
fine.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a0c237cc13d4..80f66ba85f87 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7221,6 +7221,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x312f, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3151, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x3176, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
-- 
2.17.1

