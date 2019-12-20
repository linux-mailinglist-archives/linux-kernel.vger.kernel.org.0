Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A9C12780B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 10:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfLTJZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 04:25:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36419 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfLTJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:25:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so6492180lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 01:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8RYmTZNu6rNeDCUWAArKbe+fNhpEJmiH0HpAnftlJGU=;
        b=mJFoF0RhvcTnmkupuC8BugsKKrvKQBa1pHKpnAVVtOh/rpmOuxa0vv3w5O+XbKTsSy
         MS7gJgdvkowex4puWMRrrKNvWnqjRgGVAxsx8elstfhOCNS6Wo7mu+ShxCqDrvwjjZpz
         HxnNF4XNjyftY8DGSL5hPm2E1WES1AvS8Zgbt7nRL+L/f8KVCcVUTM/ZkyVz8u4Eu6Sv
         +rC5OmtwjiUzyFeFuagEfYNRyUul7JYpAT8GsRF1/A4ZhspxBjeDbxSUx+A9iK7tp1Lc
         Diloz4UFAN6bcdlVxcGB18xOk7FtTAsiA+ReDpH0bxaqOF+sK8S4tSMvFYVu8XHsDXx3
         wl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8RYmTZNu6rNeDCUWAArKbe+fNhpEJmiH0HpAnftlJGU=;
        b=Y6lrlKSnltVn98ZSPUWelKvU4nMhUg97REBJwKQw2S2CNh6BwcYTF1n0DYBI0jA0V6
         ggGxuAaakq54viLGoE8w0Qn1X46o2v/FS7QzJOiC+BhXk6TrPS17wIJJVaS4ncxILTcL
         Wd3TAFwX/kvxXPMFmIcExX//lgqBkZMyW/NPzObbOOmaH2oWi8EtRlO5323dLJ+3/Aaa
         FUXx3lSg+CJ5IVTR0fw9mv7/JkIA0ZNDNJZhkzJvuDtVM4DwI33tzL/1q4nkfoOSR328
         RDSpDHuBjHTho/hD4pqsNcLmTfl7Vvk7B22bIJpq+wwjc3WAkbMiRHjMMaW5MgGuwbR7
         49qA==
X-Gm-Message-State: APjAAAWjgtHpH2zYGoE5tS3RGW01DcE3mocC5IS6udutlIGD7ZfwAAkf
        QJEAiykIo90VsjtFj5+8Kft86g==
X-Google-Smtp-Source: APXvYqzp+lBQ7NR4W6yIoa3rTpBdjv43+fxD0xtOaURkt0k4igr6KCtDWtj2ciDIYhZK/aovbH/kFA==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr8382472lfn.113.1576833905658;
        Fri, 20 Dec 2019 01:25:05 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n5sm3927465ljh.86.2019.12.20.01.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 01:25:04 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.5-rc3
Date:   Fri, 20 Dec 2019 10:25:03 +0100
Message-Id: <20191220092503.22211-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.5-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5-rc2

for you to fetch changes up to f667216c5c7c967c3e568cdddefb51fe606bfe26:

  mmc: sdhci-of-esdhc: re-implement erratum A-009204 workaround (2019-12-19 08:13:43 +0100)

----------------------------------------------------------------
MMC host:
 - mtk-sd: Fix tuning for MT8173 HS200/HS400 mode
 - sdhci: Revert a fix for incorrect switch to HS mode
 - sdhci-msm: Fixup accesses to the DDR_CONFIG register
 - sdhci-of-esdhc: Revert a bad fix for erratum A-009204
 - sdhci-of-esdhc: Re-implement fix for erratum A-009204
 - sdhci-of-esdhc: Fixup P2020 errata handling
 - sdhci-pci: Disable broken CMDQ on Intel GLK based Lenovo systems

----------------------------------------------------------------
Adrian Hunter (2):
      mmc: sdhci: Workaround broken command queuing on Intel GLK
      mmc: sdhci: Add a quirk for broken command queuing

Chaotian Jing (1):
      mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400 mode

Faiz Abbas (2):
      Revert "mmc: sdhci: Fix incorrect switch to HS mode"
      mmc: sdhci: Update the tuning failed messages to pr_debug level

Rasmus Villemoes (1):
      mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add erratum A-009204 support"

Veerabhadrarao Badiganti (1):
      mmc: sdhci-msm: Correct the offset and value for DDR_CONFIG register

Yangbo Lu (2):
      mmc: sdhci-of-esdhc: fix P2020 errata handling
      mmc: sdhci-of-esdhc: re-implement erratum A-009204 workaround

 drivers/mmc/host/mtk-sd.c         |  2 ++
 drivers/mmc/host/sdhci-msm.c      | 28 +++++++++++++++++++---------
 drivers/mmc/host/sdhci-of-esdhc.c | 17 ++++++++++++-----
 drivers/mmc/host/sdhci-pci-core.c | 10 +++++++++-
 drivers/mmc/host/sdhci.c          | 11 ++++++-----
 drivers/mmc/host/sdhci.h          |  2 ++
 6 files changed, 50 insertions(+), 20 deletions(-)
