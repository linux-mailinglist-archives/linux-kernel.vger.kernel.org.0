Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEE12F2C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgACBud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:50:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43031 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgACBud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:50:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so22727978pga.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 17:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFTLxb+41MiC6n43bMNpqAO7uKgmJzv0ZXWHejH9m18=;
        b=YSfQMQ/7HsvcZuI9w3YxL0DB09qW6t/OjZDQNJZIen6innJmL4MxOUs4PgU+ocq129
         n4fW7DsI5CDnlPI2L0nmRVwm08tq/uxZM91HkVK6qySZ5HpUljW07ZAoQsrDgveAhT0I
         Gt29Z9I9segAMg3662EoldgBLZxMqmtKXCk0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFTLxb+41MiC6n43bMNpqAO7uKgmJzv0ZXWHejH9m18=;
        b=Urkc9/AWmeMTSvt7TuC9B8T4xgPuQ4m7arnt0ZQkDgOS4vFvWUNKTv+WITh8gJZ1t8
         n00at5f+cezGn/ZUFdsnv13oCFgABgeGqNG9QXObjcOuowLEMjU3ITrl71Y7gITFw7SU
         jcqhZwCYC2jZAJgF85xeb/tvVyqgRM0drp8O+aQLnN3Mi6CIH5gTKpKMHlOu+5ighOom
         rHAUGvKRE+52bD/rIJlHGkwspmFf+Jy/HRTFI7p7aTNWg+UHQ7v+1JPBn07kexGTWbXz
         DqGlev0VYqseGLoFyF3uChNxsPkJTx/YyyCCun5MYTW63XSE0ozSyZueU4z+hD0gVL4I
         0U/w==
X-Gm-Message-State: APjAAAWEl3q2qji3/ylZ2ludy6WmG2Fy2T2BZyoF2StnxzWjkbC4dogD
        l3eq67C0foU6j4diak1v3aVuggZ9anM=
X-Google-Smtp-Source: APXvYqzqhwYcattRFHjc9PGKGA3bAJNMmQMLDOfPym+ZWDgsx0Z+n70qiCu1VTKmC/+wwGjAlvGSgw==
X-Received: by 2002:aa7:940e:: with SMTP id x14mr73933464pfo.42.1578016232045;
        Thu, 02 Jan 2020 17:50:32 -0800 (PST)
Received: from localhost ([2401:fa00:9:15:c479:b58e:61d1:15d5])
        by smtp.gmail.com with ESMTPSA id z4sm12377658pjn.29.2020.01.02.17.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 17:50:31 -0800 (PST)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sam McNally <sammc@chromium.org>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Xun Zhang <xun2.zhang@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Subject: [PATCH v3] ASoC: Intel: sof_rt5682: Ignore the speaker amp when there isn't one.
Date:   Fri,  3 Jan 2020 12:50:19 +1100
Message-Id: <20200103124921.v3.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some members of the Google_Hatch family include a rt5682 jack codec, but
no speaker amplifier. This uses the same driver (sof_rt5682) as a
combination of rt5682 jack codec and max98357a speaker amplifier. Within
the sof_rt5682 driver, these cases are not currently distinguishable,
relying on a DMI quirk to decide the configuration. This causes an
incorrect configuration when only the rt5682 is present on a
Google_Hatch device.

For CML, the jack codec is used as the primary key when matching,
with a possible speaker amplifier described in quirk_data. The two cases
of interest are the second and third 10EC5682 entries in
snd_soc_acpi_intel_cml_machines[]. The second entry matches the
combination of rt5682 and max98357a, resulting in the quirk_data field
in the snd_soc_acpi_mach being non-null, pointing at
max98357a_spk_codecs, the snd_soc_acpi_codecs for the matched speaker
amplifier. The third entry matches just the rt5682, resulting in a null
quirk_data.

The sof_rt5682 driver's DMI data matching identifies that a speaker
amplifier is present for all Google_Hatch family devices. Detect cases
where there is no speaker amplifier by checking for a null quirk_data in
the snd_soc_acpi_mach and remove the speaker amplifier bit in that case.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

Changes in v3:
- Rewrote commit message to refer to correct
  snd_soc_acpi_intel_cml_machines[] entries and better describe the
  change

Changes in v2:
- Added details about the relevant ACPI matches to the description

 sound/soc/intel/boards/sof_rt5682.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index ad8a2b4bc709..8a13231dee15 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -603,6 +603,14 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	dmi_check_system(sof_rt5682_quirk_table);
 
+	mach = (&pdev->dev)->platform_data;
+
+	/* A speaker amp might not be present when the quirk claims one is.
+	 * Detect this via whether the machine driver match includes quirk_data.
+	 */
+	if ((sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT) && !mach->quirk_data)
+		sof_rt5682_quirk &= ~SOF_SPEAKER_AMP_PRESENT;
+
 	if (soc_intel_is_byt() || soc_intel_is_cht()) {
 		is_legacy_cpu = 1;
 		dmic_be_num = 0;
@@ -663,7 +671,6 @@ static int sof_audio_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
 	sof_audio_card_rt5682.dev = &pdev->dev;
-	mach = (&pdev->dev)->platform_data;
 
 	/* set platform name for each dailink */
 	ret = snd_soc_fixup_dai_links_platform_name(&sof_audio_card_rt5682,
-- 
2.24.1.735.g03f4e72817-goog

