Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED30850EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 16:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfFXOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 10:47:58 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44110 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:47:58 -0400
Received: by mail-wr1-f51.google.com with SMTP id r16so14194620wrl.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=dIRgQ3ynOpjhyuIVnVuPJTcE55pI12BhgO4qsYJmHWg=;
        b=1t2stW6KFcusBgmgb+vjxCC6D/mAJkeo4PWwfQTJtiO7t+wgz+REk1m6xRvG5PdvpB
         N5Cfj0WIDM23ujK4DsoZ5o1ow097YCS3oiJGmCJJLc5kPXI9NQjDO+jaevjCq4y3MDyi
         RwKqbnu2Na54f0LI1M23VY8Iq8pGBws7IXzE5sNIaK7HzGq0HBb8ZEcyorT4YW2sK18x
         cQHHT0avopamkHoV1U0VKmXeQpKbSOAQpadRqHyELQS+oT5AGEeyL05nMQWknKwiEzY7
         kaNz21h3qkJfc4TfwevGKTNdhk0RfDvec7zs18vmX6VVcVS/qiaLjeq43dtTUSp9cngj
         BBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=dIRgQ3ynOpjhyuIVnVuPJTcE55pI12BhgO4qsYJmHWg=;
        b=cuYIb9oehsxxrrYQuqB7a0gJCDKIFk4/rFEJIIqCYKLwe+M3mv6veL07U5FzIBB8ZF
         634N54yFNQN+WxmZT/jvCXpq8xZH2eG+fozVz4qgONzIQyt9yrQJv4AReK19scwTRUoK
         J+zyQjhBzaAZVrRVDIvwGCLhy7+cHf3Gli1ieKGOmx2/O4+pefo6v3SWWWwkoyaPaRr+
         ckb8BOQzypFwdCUW48V91XT0diop/MrszluatlZqgykEut7sL3lMGjJZWvT3REIywiMw
         xFJQ7iBdsDjL7vyAvx+FWY4XDq6okNg6RDYSVqgf8HDtDYWH9/7q0YMlnhWaLdBxu/jq
         fjgQ==
X-Gm-Message-State: APjAAAW6eXtS9ayVLU8F2mkOoGrX3KRq7xEOYnqn8U7MhXl7l9zqtonn
        CwOmbK8vhAM3g/G3znrsZJIjLg==
X-Google-Smtp-Source: APXvYqzAhY+ZzLqrg8P9+Gjky58V/7Mins9CYwy8HmsCLCi6hwSDb1K4orr31YS8ZR7Cuubi4to67Q==
X-Received: by 2002:a5d:4642:: with SMTP id j2mr11688565wrs.211.1561387676728;
        Mon, 24 Jun 2019 07:47:56 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u6sm13228366wml.9.2019.06.24.07.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:47:55 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: [PATCH 0/9] drm: meson: global clean-up (use proper macros, update comments ...)
Date:   Mon, 24 Jun 2019 16:20:42 +0200
Message-ID: <86zhm782g5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series aims to clean-up differents parts of the drm meson
code source.

Couple macros have been defined and used to set several registers
instead of using magic constants.

I also took the opportunity to:
- add/remove/update comments
- remove useless code
- minor fix/improvment

Julien Masson (9):
  drm: meson: mask value when writing bits relaxed
  drm: meson: crtc: use proper macros instead of magic constants
  drm: meson: drv: use macro when initializing vpu
  drm: meson: vpp: use proper macros instead of magic constants
  drm: meson: viu: use proper macros instead of magic constants
  drm: meson: venc: use proper macros instead of magic constants
  drm: meson: global clean-up
  drm: meson: add macro used to enable HDMI PLL
  drm: meson: venc: set the correct macrovision max amplitude value

 drivers/gpu/drm/meson/meson_crtc.c      |  17 ++-
 drivers/gpu/drm/meson/meson_drv.c       |  26 +++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c   |   2 +
 drivers/gpu/drm/meson/meson_dw_hdmi.h   |  12 +-
 drivers/gpu/drm/meson/meson_plane.c     |   2 +-
 drivers/gpu/drm/meson/meson_registers.h | 136 ++++++++++++++++---
 drivers/gpu/drm/meson/meson_vclk.c      |   7 +-
 drivers/gpu/drm/meson/meson_venc.c      | 169 ++++++++++++++++++------
 drivers/gpu/drm/meson/meson_venc_cvbs.c |   3 +-
 drivers/gpu/drm/meson/meson_viu.c       |  82 ++++++------
 drivers/gpu/drm/meson/meson_vpp.c       |  27 ++--
 11 files changed, 362 insertions(+), 121 deletions(-)

-- 
2.17.1

