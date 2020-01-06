Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0CE130BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 02:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAFBsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 20:48:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46228 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgAFBst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:48:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so46875636ljc.13;
        Sun, 05 Jan 2020 17:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEBeBtX3D+FecxXDkPEiiIV4CkPQmZtOza+gbuFwJ6Q=;
        b=nWysjDEFnf1ZW1KuOOtMZR3c8DXFeGoQ7Pkf0QqGQyTgGE4bUjSsvLIglzOM/Embgd
         +G/Wy46pZx7Mh4lJuIHmrT7Yr/AiDzSHQDCLmJpFSasUdy0CEB8/PDY714n2OX2aP0Jk
         TBjnXkgFulCTksMF+sROlNYzGwjAChVcXgLAsAHgIPR0p1fjlSOtnvsf0JynHxVR9lqU
         zUbb7fGzTbZcchQ4XvAn+5JE+v1ffZ/QuhG6Qfec7SmR99EZs4oT8Fcne5abr6jGWham
         H2pG9P92gUI3yDMgt5GUJWxbYH8BMMZCJHo1vZPgZ5727Sjc6Kw7VuMDwPrsq86VyNNd
         FIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEBeBtX3D+FecxXDkPEiiIV4CkPQmZtOza+gbuFwJ6Q=;
        b=lLDb2aUb/Y2ejlZNGVgK9gK5Xf2NKgfA0biexoC04TjiEeBYtNeIn89KXSm/IFojvX
         7vAnWYxUXmQw4fZFmOQ3YpW3O4AaG/kq3jop3Afv0t0fYILFuTI53U1GAtlaY6a+ViEB
         mGIwoklCBmvSyvQb0okDvbtFXemfH66eVqqAlzokmuxGo6FPyW9GpuJzQ58lV9LWA6Qc
         svwtqx2fJwFGAjp9oatEcat37uvdylXD/KrJqsG8LBKnke5BqewQpcTB9U5WgR3ynUUn
         GWCv3DWQ34C1RXUNZEMa45MgsWcwB1fDaqyPKVujrHf13qy9psir8VwTC/SJu+r3Er3v
         mVJQ==
X-Gm-Message-State: APjAAAWFhEGtMhmrD1yqjXYGVfTb6FGXrYCt7biIZm4NvfecqUU/rXXk
        B5R0Qobgn6NGgHPGcbVnheA=
X-Google-Smtp-Source: APXvYqwDJIKUFFtDFfKjMDK2pI9tL+4EGshl7DCfCiqzjicOIBaD27gA1g1LXj+YNFMyhi1mP5VFYg==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr56311153lji.247.1578275327908;
        Sun, 05 Jan 2020 17:48:47 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id e17sm28369857ljg.101.2020.01.05.17.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:48:47 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: rt5640: Fix NULL dereference on module unload
Date:   Mon,  6 Jan 2020 04:47:07 +0300
Message-Id: <20200106014707.11378-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5640->jack is NULL if jack is already disabled at the time of
driver's module unloading.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Addressed review comment from Takashi Iwai by making patch's diff a
      bit cleaner and simpler.

    - Addressed review comment from Mark Brown by removing noisy backtrace
      from the commit's message and moving it after --- in order to keep it
      discoverable in the ML archive.

Backtrace:

 Unable to handle kernel NULL pointer dereference at virtual address 00000024
 ...
 (rt5640_set_jack [snd_soc_rt5640])
 (snd_soc_component_set_jack [snd_soc_core])
 (soc_remove_component [snd_soc_core])
 (soc_cleanup_card_resources [snd_soc_core])
 (snd_soc_unregister_card [snd_soc_core])
 (tegra_rt5640_remove [snd_soc_tegra_rt5640])
 (platform_drv_remove)
 (device_release_driver_internal)
 (driver_detach)
 (bus_remove_driver)
 (tegra_rt5640_driver_exit
 (sys_delete_module)

 sound/soc/codecs/rt5640.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index adbae1f36a8a..747ca248bf10 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2432,6 +2432,13 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
 {
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
+	/*
+	 * soc_remove_component() force-disables jack and thus rt5640->jack
+	 * could be NULL at the time of driver's module unloading.
+	 */
+	if (!rt5640->jack)
+		return;
+
 	disable_irq(rt5640->irq);
 	rt5640_cancel_work(rt5640);
 
-- 
2.24.0

