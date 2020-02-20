Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0DC166297
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgBTQ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 11:28:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46643 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgBTQ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:28:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so5270283wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/W/WULs8OI1+LT5F6Ejcu59t+gn7dwmZWLBfEBVa/AA=;
        b=Ki8TO+R1Ufjb7jalo1huQgpue5758cyY8Zwk5y9wOIeItwXUaBr42/7r8SKvEYL50p
         qyocx9jn3Dwse6xZR8YBghMwUPE1qNxgmjKeJ0oqritkzbLG0IUqrshZqJgAtUOi98Hm
         vY1PS/ZEHMkUdeCeFk1VGApHCSrqszN8/MIvwVS/mr0TEErx/FHuTiK9B+O945rK0DOP
         vWX7qJ+NPQornMF1lq5pPG7y4bsb8d6KsmwFyREyZA2QVh4NwXYzay+MsisIf4SJ6nIa
         2j63XKthnerd6Q2bj9qRouIsaO8+TY6MBS4gCpDYtofLCSQwCfUJHYGG4ZsF3fsLSrdV
         yqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/W/WULs8OI1+LT5F6Ejcu59t+gn7dwmZWLBfEBVa/AA=;
        b=fHzHQ5K6fxkEraLO1scHp4p8eLp9/aMFb6G6CvlptRvNCEeerUoTpjv3vNCOJclyZh
         t5geODQ2c4h07gmRnIIQi+ejK31QI5eK2IsAEwhVLaUg4tZRsQ5Gx581zSYTDaJ6Bgry
         +5vw0b40WKIr+yrsmP30+kAE/s0/qehPZSNu8ke2D31gqYPSw5aYupK5WMWJ+FxkxGei
         DomKGWLiS5mGQcMA1UkMxX4UayWpaF1bORBNlvm7vHWKBxYXttpnd4eKQJ9qguFkc+KA
         cR+nL6HiRjZ1YWPx0tfVtu0njrLxk+QqanKVYme83ehtm2G3bdBUbklim/6HlFaNCAXo
         EFDw==
X-Gm-Message-State: APjAAAXxicvOOcogI3g/4epb3MNy6eOEadg6YPMAyPsnWGgDPTmqHFlv
        6e6WvQ9qh3+y6HpQERTtXhX9hxIqNdVmLA==
X-Google-Smtp-Source: APXvYqyun6Vj13OSNRZfblgv2ImbhuZ2CW3Kldm+31er91Z03BoaDcDWBFqxC1LOvntcbE4lSN4Kpw==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr46166367wrr.340.1582216080316;
        Thu, 20 Feb 2020 08:28:00 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c15sm104164wrt.1.2020.02.20.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:27:59 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/meson: add support for Amlogic Video FBC
Date:   Thu, 20 Feb 2020 17:27:54 +0100
Message-Id: <20200220162758.13524-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic uses a proprietary lossless image compression protocol and format
for their hardware video codec accelerators, either video decoders or
video input encoders.

It considerably reduces memory bandwidth while writing and reading
frames in memory.

The underlying storage is considered to be 3 components, 8bit or 10-bit
per component, YCbCr 420, single plane :
- DRM_FORMAT_YUV420_8BIT
- DRM_FORMAT_YUV420_10BIT

This modifier will be notably added to DMA-BUF frames imported from the V4L2
Amlogic VDEC decoder.

At least two options are supported :
- Scatter mode: the buffer is filled with a IOMMU scatter table referring
  to the encoder current memory layout. This mode if more efficient in terms
  of memory allocation but frames are not dumpable and only valid during until
  the buffer is freed and back in control of the encoder
- Memory saving: when the pixel bpp is 8b, the size of the superblock can
  be reduced, thus saving memory.

This serie adds the missing register, updated the FBC decoder registers
content to be committed by the crtc code.

The Amlogic FBC has been tested with compressed content from the Amlogic
HW VP9 decoder on S905X (GXL), S905D2 (G12A) and S905X3 (SM1) in 8bit
(Scatter+Mem Saving on G12A/SM1, Mem Saving on GXL) and 10bit
(Scatter on G12A/SM1, default on GXL).

It's expected to work as-is on GXM and G12B SoCs.

Neil Armstrong (4):
  drm/fourcc: Add modifier definitions for describing Amlogic Video
    Framebuffer Compression
  drm/meson: add Amlogic Video FBC registers
  drm/meson: overlay: setup overlay for Amlogic FBC
  drm/meson: crtc: handle commit of Amlogic FBC frames

 drivers/gpu/drm/meson/meson_crtc.c      | 118 ++++++++---
 drivers/gpu/drm/meson/meson_drv.h       |  16 ++
 drivers/gpu/drm/meson/meson_overlay.c   | 257 +++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_registers.h |  22 ++
 include/uapi/drm/drm_fourcc.h           |  56 ++++++
 5 files changed, 431 insertions(+), 38 deletions(-)

-- 
2.22.0

