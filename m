Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6604AED4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 01:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfFRXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 19:46:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38178 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRXqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:46:10 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so4296039ioa.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6OiHApPpuHFcXqpPL0yqvZnshiOzXZvGcLbs7dM2ic=;
        b=Fw5Pyth5dnuVNp0vDCXr26K5dYvEdk35TgTo4Kp3aiX5j8Icz85fstmHGai3mKRtb3
         8jR57qQM62+JFhSKNzwtWC5BN59Evz5Hr4HHXePpBZUIp7icD/N6vFwbKN96uYLhCRbu
         jcjA5hmiE3S/1RzV2Jhl0fyk5yRgUyeP26RrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6OiHApPpuHFcXqpPL0yqvZnshiOzXZvGcLbs7dM2ic=;
        b=uCCIrLxQ75RcoSnzmZyHHTVEnlQhb9ILpnzBmHLMarMLdzEmQgFwlDczkMY4QasiUH
         3C4VZ1PkyCV9Z3rHjXkGmg3giaYxuWgBNMSpXEJ5nqUNNJArc/RKneoZyCQzw7TuMN/U
         hrtf+gAZNV4RDYEnW/lLCVFb0iuh4q5h+6pcPwkqTowRszaM2dSPafIYAveNWhDffoy9
         GdksdsRerxUobLXaCSIOpYI4mO6C9FYjefoHT8t5q20SFCqH4ETQr+nGkqkgCe9iE/Dd
         GestNDTDqnHN3FNh/aLBxPz3zCvoWVmRz4Ma2wtAbr9G+g7VEG3b3Av4Q6Te2AfGkDLN
         iQWg==
X-Gm-Message-State: APjAAAUb41+bR2HNEK9uN1QjW66qb3xCg14Ev5RkzRxs0fdCceZfgDUg
        UJfl0nZ4DpferJgISsA0p+o7oPXER8lxAA==
X-Google-Smtp-Source: APXvYqx0XYE1ACE0khO5y6o8MbcH4AOi8bn5I0VI230YUYijlmFsiPNXdCuhPosL71GP7ed8k2DOgA==
X-Received: by 2002:a5d:94d7:: with SMTP id y23mr5967649ior.296.1560901569308;
        Tue, 18 Jun 2019 16:46:09 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id y20sm15562673iol.34.2019.06.18.16.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 16:46:08 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH v8 0/2] Fix jack detection for Chromebook Pixel
Date:   Tue, 18 Jun 2019 17:45:53 -0600
Message-Id: <20190618234555.188955-1-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.

These patches change the irq implementation to support polarity flipping.
With this series, plugging and unplugging the headphone jack switches
between headphones and speakers automatically, and headset microphones
are also detected.

v8:
  - Remove first two patches since they've been merged
  - Add pointer to i2c->dev in rt5677_priv for use in dev_err functions
  - Convert pr_err to dev_err in irq function

v7:
  - Rebase onto for-next branch of broonie/sound.git

v6:
  - Move refactoring into its own patch
  - Reorder patches so that DT property names patch is first
  - Clarify commit message for patch which implements irq handler
  - Remove unused work struct
  - Make IRQ function return IRQ_HANDLED only if IRQs actually fire

v5:
  - Fix void* parameter to devm_request_threaded_irq

v4:
  - Fix incorrect void* cast in rt5677_irq()

v3:
  - Update commit message for patch 1/3 to clarify why we implement
    our own irq_chip.

v2:
  - Split IRQ change into two patches: adding and fixing potential race
  - Change config reading code to try both DT and ACPI style names

Ben Zhang (2):
  ASoC: rt5677: clear interrupts by polarity flip
  ASoC: rt5677: handle concurrent interrupts

 sound/soc/codecs/rt5677.c | 192 +++++++++++++++++++++++++++++++-------
 sound/soc/codecs/rt5677.h |   8 +-
 2 files changed, 164 insertions(+), 36 deletions(-)

--
2.22.0.410.gd8fdbe21b5-goog

