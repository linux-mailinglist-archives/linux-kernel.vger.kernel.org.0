Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F5D3E27
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfJKLSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 07:18:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34382 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfJKLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:18:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 30AD3290DC9
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/2] AFBC for Rockchip
Date:   Fri, 11 Oct 2019 13:18:09 +0200
Message-Id: <20191011111813.20851-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds AFBC support for Rockchip.
It is inspired by:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/factory-gru-9017.B-chromeos-4.4/drivers/gpu/drm/rockchip/rockchip_drm_vop.c

The first patch factors out some afbc helper functions from malidp,
as they are useful in general. The second patch adds implementation proper
of AFBC support for Rockchip.

Andrzej Pietrasiewicz (2):
  drm/arm: Factor out generic afbc helpers
  drm/rockchip: Add support for afbc

 drivers/gpu/drm/Kconfig                     |   4 +
 drivers/gpu/drm/Makefile                    |   1 +
 drivers/gpu/drm/arm/Kconfig                 |   1 +
 drivers/gpu/drm/arm/malidp_drv.c            |  58 +-------
 drivers/gpu/drm/drm_afbc.c                  | 114 ++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig            |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  43 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 140 +++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  12 ++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  86 +++++++++++-
 include/drm/drm_afbc.h                      |  25 ++++
 11 files changed, 427 insertions(+), 58 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_afbc.c
 create mode 100644 include/drm/drm_afbc.h

-- 
2.17.1

