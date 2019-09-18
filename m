Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CFCB5F15
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfIRIZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 04:25:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45952 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfIRIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:25:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so64421pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKl0NI5uuTzXRMlZIfLK2DJ9dA76CcXi+wvYjjhfeJ4=;
        b=QjtMNatKQcwth+X0GKHkr+Z2zJz6zbi9oKCgR26mEnXpfoUjWiImm9bASZSwNJTdA7
         2sYwbfAxoZKJIti+khkPv+rHKQ/aqRnzVaaVyCAV9sxHcFnNpVTLVkNumDYo8RwYrBU6
         qQ5EfggIIMUwE/rxyvwKGoh69y/Hl9FmhmtWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKl0NI5uuTzXRMlZIfLK2DJ9dA76CcXi+wvYjjhfeJ4=;
        b=K3EENuEdvMvjXwJAPzxXu4zNANpzDF45+FGqG1NWziIJs8WUiGMK+RY/omzBpNUyua
         Ax68RWaQIKspNLQCPjh9eNFs58hVdy2Co4YwD6vdZo5cLDoPVYW0kOxoBTyJfhmptMro
         +i7gn4JOiDHl/HIG5iJzIHXCozIlysS85h2otSWNeu5WLAcaFOSvAaP2U95BGAart4PO
         s2nhbCnrm69PpZCWP3kX0HvrNNX8GcazZy5PwxTwrVVYnwUih1uqU3LupkMrmPK2XHiU
         5ulRRRfTx9tTB38Vk0HJwnWSUMyjYS6MPCxgcIvioSOhcq/OLqeSXYMxabiyp45sU+lN
         txQg==
X-Gm-Message-State: APjAAAUCBr1FmWPmzZBgWaQLZoJNQi+/tMdHaO6VbxzaNqyvvEOiItjt
        gmWLbDFCayaIrEINoaSXyxdiirnOOt4=
X-Google-Smtp-Source: APXvYqzayEko5q8A495MmFMU31IxcUPuZcsYT8Q3ERIy5jSSRpRvbSnJkE1FFghYilaSJdpwBGfTCA==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21mr3061713pls.80.1568795114731;
        Wed, 18 Sep 2019 01:25:14 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id y28sm8689470pfq.48.2019.09.18.01.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 01:25:13 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v6 0/4] Add HDMI jack support on RK3288
Date:   Wed, 18 Sep 2019 16:24:56 +0800
Message-Id: <20190918082500.209281-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series supports HDMI jack reporting on RK3288, which uses
DRM dw-hdmi driver and hdmi-codec codec driver.

The previous discussion about reporting jack status using hdmi-notifier
and drm_audio_component is at

https://lore.kernel.org/patchwork/patch/1083027/

The new approach is to use a callback mechanism that is
specific to hdmi-codec.

The dependent change on hdmi-codec.c

https://patchwork.kernel.org/patch/11047447

has been picked up by Mark Brown in ASoC tree for-5.4 branch.

Changes from v5 to v6:

1. Remove the patch for sound/soc/codecs/hdmi-codec.c because it is accepted.
2. Rebase the rest of patches based on drm-misc-next tree.

Cheng-Yi Chiang (4):
  drm: bridge: dw-hdmi: Report connector status using callback
  drm: dw-hdmi-i2s: Use fixed id for codec device
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  13 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  41 ++++++-
 include/drm/bridge/dw_hdmi.h                  |   4 +
 sound/soc/rockchip/Kconfig                    |   3 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c       |   3 +-
 sound/soc/rockchip/rockchip_max98090.c        | 116 ++++++++++++++----
 6 files changed, 153 insertions(+), 27 deletions(-)

-- 
2.23.0.237.gc6a4ce50a0-goog

