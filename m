Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7913A15D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 08:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgANHQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 02:16:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41547 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgANHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:16:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so5959343pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgN1A3/jcSNW9U7ZQPj+hV6TF/FYO27/H6WZlglC4Rc=;
        b=L0iyokzQjznU7jd7+4yRIjZG4W+Kh/QVfHxO9R/YomTTvZh7b8xaC5TCZUUYDfVDXN
         P2IwRlrn+TbuhVEJfj6oijTp7NO3dd3UJHVeEFZdgB8J3r0aXarKK7Nsjb9D57P/urEw
         WzCncn51xRlztqYXPBSbDrfgKBb5vo2D7zGwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgN1A3/jcSNW9U7ZQPj+hV6TF/FYO27/H6WZlglC4Rc=;
        b=lOTnJ3MO5F6ZA9tO2sDOPTzfCT+rYTzex168//pMAtfn18VDDZDXNoYtjIlXgK+d+z
         u5DUNEfRlduuwCatlHVvI/oTbuXV5okukgFSFER+1suX0Vyzb5otf1eSWG1Uapd26QP5
         TbA1wiEscypD6WvENxgN7/JqPOE+zIKMbKgkJeD0HWKHZYtniJlIT81ekJnGzV1Ae22R
         HShaUI8ZEVtAqJcuU34tBb1aWM0DbguqzN7pCqEELE03AFvlc8WVeAThhwZqmRO3p4g2
         3IkwlsHPKTXeKMkX2seC30XGE3kxDWjHr0MluFKYizAjTzOCeHYY+jN4gwcuhYI5mP2A
         A0Zw==
X-Gm-Message-State: APjAAAUK609hOFAFHgc1/H/QCBz7n32m7Uu/BUdLzr755BknzaHADL0D
        DARpw4jXNJAk9n2nM0MRk/4t/g==
X-Google-Smtp-Source: APXvYqzMqBBdzwBKGKEOl+Tc4G0Gj7LZPgMyixK0fqjyI+joZwzSNKerDHvLgKupoGqp6US/0o9C2A==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr22776522pgk.99.1578986168173;
        Mon, 13 Jan 2020 23:16:08 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id b4sm17092976pfd.18.2020.01.13.23.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:16:07 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v3 0/7] Add dts for mt8183 GPU (and misc panfrost patches)
Date:   Tue, 14 Jan 2020 15:15:55 +0800
Message-Id: <20200114071602.47627-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Follow-up on the v2: https://patchwork.kernel.org/cover/11322801/ .

The main purpose of this series is to upstream the dts change and the binding
document, but I wanted to see how far I could probe the GPU, to check that the
binding is indeed correct. The rest of the patches are RFC/work-in-progress, but
I think some of them could already be picked up.

So this is tested on MT8183 with a chromeos-4.19 kernel, and a ton of
backports to get the latest panfrost driver (I should probably try on
linux-next at some point but this was the path of least resistance).

I tested it as a module as it's more challenging (originally probing would
work built-in, on boot, but not as a module, as I didn't have the power
domain changes, and all power domains are on by default during boot).

Probing logs looks like this, currently. They look sane.
[  501.319728] panfrost 13040000.gpu: clock rate = 511999970
[  501.320041] panfrost 13040000.gpu: Linked as a consumer to regulator.14
[  501.320102] panfrost 13040000.gpu: Linked as a consumer to regulator.31
[  501.320651] panfrost 13040000.gpu: Linked as a consumer to genpd:0:13040000.gpu
[  501.320954] panfrost 13040000.gpu: Linked as a consumer to genpd:1:13040000.gpu
[  501.321062] panfrost 13040000.gpu: Linked as a consumer to genpd:2:13040000.gpu
[  501.321734] panfrost 13040000.gpu: mali-g72 id 0x6221 major 0x0 minor 0x3 status 0x0
[  501.321741] panfrost 13040000.gpu: features: 00000000,13de77ff, issues: 00000000,00000400
[  501.321747] panfrost 13040000.gpu: Features: L2:0x07120206 Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
[  501.321752] panfrost 13040000.gpu: shader_present=0x7 l2_present=0x1
[  501.324951] [drm] Initialized panfrost 1.1.0 20180908 for 13040000.gpu on minor 2

Some more changes are still required to get devfreq working, and of course
I do not have a userspace driver to test this with.

Thanks!

Nicolas

v3 (see individual patches, too):
 - Match a specific mediatek,mt8183-mali instead of the generic bifrost,
   as this instance requires 2 special cases:
    - 2 regulators
    - 3 power domains

v2:
 - Use sram instead of mali_sram as SRAM supply name.
 - Rename mali@ to gpu@.
 - Add dt-bindings changes
 - Stacking patches after the device tree change that allow basic
   probing (still incomplete and broken).

Nicolas Boichat (7):
  dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
  arm64: dts: mt8183: Add node for the Mali GPU
  drm/panfrost: Improve error reporting in panfrost_gpu_power_on
  drm/panfrost: Add support for multiple regulators
  drm/panfrost: Add support for multiple power domains
  RFC: drm/panfrost: Add mt8183-mali compatible string
  RFC: drm/panfrost: devfreq: Add support for 2 regulators

 .../bindings/gpu/arm,mali-bifrost.yaml        |  18 +++
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   7 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 104 +++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  17 +++
 drivers/gpu/drm/panfrost/panfrost_device.c    | 120 +++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_device.h    |  25 +++-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  38 ++++--
 drivers/gpu/drm/panfrost/panfrost_gpu.c       |  11 +-
 8 files changed, 310 insertions(+), 30 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

