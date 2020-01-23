Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C1147249
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAWUDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 15:03:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46022 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgAWUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:03:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id j26so5035810ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 12:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE81ES9colZ9LJcYyttHbY8aVJS9UvEcbtX66gtyy2E=;
        b=GpKn2eY5BAIsAhvRiSFxr/3nfax0j9bVKB9I5iWZy7ejFawDE1lemjHYj3JnD4AYF7
         WpUf6HzI+kP7xUVkxHwTcBwQWMZ42MGNXd39pry40m8itYHdFFUdzB4XpzZ78vZxlne5
         pDoqfnWIUXoRXCypX6sLCxKnebUGKNET0TXzl+40ocecSorkdDvQG8iqQS1M6KcDadc1
         MNG2xHgQ2gxTm8X8fUa/xF5WSPF5UoEB9GnGGRn4QqFgiituOdzWzlgN6bcGGKN9o4dv
         5QNnhyuvO4ULL+Adw713vc60Z8aKMjIzmOXmrPnlUYTu4/6m3Nj24X10lbLBGzSLawSb
         +KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE81ES9colZ9LJcYyttHbY8aVJS9UvEcbtX66gtyy2E=;
        b=m1aUM0GcQNUVBYZdh7ere1lC+EfNuHhP5li417Ocj64vVmRqA25ojKvNPQ8Fg1CZmG
         jKYgxKr4X/Go031dOcNv0FCSEwUgMr5kXqzwOgLiqlgOF6/Se/6oXTSF4oENKrjjpN2G
         /uZ6sYWEHkrXW8RCv32ksBSkQpyxiwqDfM124NYEtfCdfsqLkD7p1hHZlKJGDx6+rqIs
         0spHj5msE58csimvcGOutgYgpTkndodDCwVI2otvDaRyxl+ZQjp/fv17OJgieFvBD+Ws
         fPEdwBaFf9byEeokg5BWP+RUl6tkKa0pBR9gROYCkJRTdKnIN1/YG9R67qdqzaI+tyQ4
         CkHg==
X-Gm-Message-State: APjAAAULcoY/mz4sfh40HHiisQCpDoAoEamDNq85y37er5nyHjkkIhZB
        +73ke0IYQY4aY40tHUFnIEIIng==
X-Google-Smtp-Source: APXvYqxDTc65ooMHbFqtuMAsz5UFQtlLj/mJDMkAbA2hWYv59r7jxMC2Jq1ezf/icxiqcyjcqWBU1Q==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr32501ljg.250.1579809779317;
        Thu, 23 Jan 2020 12:02:59 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id e8sm2112163ljb.45.2020.01.23.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:02:58 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.5-rc8
Date:   Thu, 23 Jan 2020 21:02:57 +0100
Message-Id: <20200123200257.17258-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.5-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f667216c5c7c967c3e568cdddefb51fe606bfe26:

  mmc: sdhci-of-esdhc: re-implement erratum A-009204 workaround (2019-12-19 08:13:43 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5-rc2-2

for you to fetch changes up to 2a187d03352086e300daa2044051db00044cd171:

  mmc: sdhci: fix minimum clock rate for v3 controller (2020-01-20 10:36:27 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix minimum clock rate for v3 controllers
 - sdhci-tegra: Fix SDR50 tuning override
 - sdhci_am654: Fixup tuning issues and support for CQHCI
 - sdhci_am654: Remove wrong write protect flag

----------------------------------------------------------------
Faiz Abbas (3):
      mmc: sdhci_am654: Remove Inverted Write Protect flag
      mmc: sdhci_am654: Reset Command and Data line after tuning
      mmc: sdhci_am654: Fix Command Queuing in AM65x

Michał Mirosław (2):
      mmc: tegra: fix SDR50 tuning override
      mmc: sdhci: fix minimum clock rate for v3 controller

 drivers/mmc/host/sdhci-tegra.c |  2 +-
 drivers/mmc/host/sdhci.c       | 10 ++++----
 drivers/mmc/host/sdhci_am654.c | 54 +++++++++++++++++++++++++++---------------
 3 files changed, 42 insertions(+), 24 deletions(-)
