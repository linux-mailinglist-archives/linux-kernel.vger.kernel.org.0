Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87F2467BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 20:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfFNSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 14:43:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38163 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFNSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:43:34 -0400
Received: by mail-io1-f68.google.com with SMTP id k13so7948229iop.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKO3KiNOmtvrogfrG3Ga2A0QL8IaxVgARBNmgmMqWbc=;
        b=ft6ZMiZjBwIplcyAR+g+GEB64WpoIXpj9T3gnADsfMXy4KR2J0boLvfDGXxYF4qiPj
         LH4W9w7AXIBs+77tDpLgl+tTThFHueDp8GOw8AK5bgVXjqsoYYoLqrV31og1bu65FsS9
         G7VHMBuaAnS4isoJw+Lp6GqYekNA95B+u9Anc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKO3KiNOmtvrogfrG3Ga2A0QL8IaxVgARBNmgmMqWbc=;
        b=k/UyYggJ5HU+gZGSk6H4sX3ek4IcaHnn/MWxKisgzr2cl+DJcczkVDnj9N1W1Bdcgj
         iRRWAwAsTv/D1KLWkKOO8KiYUOUsvcAM6gj9vkZKhu745kU1PsEaBLt2lz/WIp/bBs6L
         171wbSSwCGF4uXiKna4W+36XwzRhj2rOsCA21QX1Iu4qo3yqqCI7huIT3byU6WJ5bXZL
         RYxIFY8yzWFfNMvFcWpZTg+id1GDIgPcWuYDQOyyw8b8UmoWOd/Pa/w8WuXa+WFeIuVz
         B+IOKqLe3Nw6OrvIkrsnHIYFHfNYRBvXwmWo2/NoGJKjuFvjT2K/50s+f/9zp11d+rUt
         gkWQ==
X-Gm-Message-State: APjAAAWDhBDXpq7+2LEoMsxmiQ1jx27NYXOZ6aOw8OY7qN4sAXgxnKCw
        miEAH8pRkNMxriztkUDuOwJOA7csfdLzlw==
X-Google-Smtp-Source: APXvYqyADjshUqx1mOX6CwWzohHayg06LftIBPOdzuzPhD7JJhu591jYGb0mR06hhorrST0f9GKoUA==
X-Received: by 2002:a6b:14c2:: with SMTP id 185mr48082904iou.69.1560537813409;
        Fri, 14 Jun 2019 11:43:33 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id w23sm5655338ioa.51.2019.06.14.11.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 11:43:32 -0700 (PDT)
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
Subject: [PATCH v6 0/4] Fix jack detection for Chromebook Pixel
Date:   Fri, 14 Jun 2019 12:43:11 -0600
Message-Id: <20190614184315.252945-1-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

** resending due to corrupted patch **

Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.

This patch changes the irq implementation to support polarity flipping
and fixes the configuration code so that correct GPIO pins are read
from ACPI.

With this series, plugging and unplugging the headphone jack switches
between headphones and speakers automatically, and headset microphones 
are also detected.

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

Fletcher Woodruff (2):
  ASoC: rt5677: fall back to DT prop names on error
  ASoC: rt5677: move jack-detect init to i2c probe

 sound/soc/codecs/rt5677.c | 319 ++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5677.h |  13 +-
 2 files changed, 236 insertions(+), 96 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

