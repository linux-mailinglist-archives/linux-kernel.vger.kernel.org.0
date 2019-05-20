Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503EC23035
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfETJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 05:23:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41592 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfETJXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:23:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9499374;
        Mon, 20 May 2019 02:23:24 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3F0B3F575;
        Mon, 20 May 2019 02:23:21 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] drm/panfrost: drm_gem_map_offset() helper
Date:   Mon, 20 May 2019 10:23:04 +0100
Message-Id: <20190520092306.27633-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panfrost has a re-implementation of drm_gem_dumb_map_offset() with an
extra bug regarding the handling of imported buffers. However we don't
really want Panfrost calling _dumb functions because it's not a KMS
driver.

This series renames drm_gem_dumb_map_offset() to drop the '_dumb' and
updates Panfrost to use it rather than it's own implementation.

v2: https://lore.kernel.org/lkml/20190516141447.46839-1-steven.price@arm.com/
Changes since v2:
 * Drop the shmem helper

v1: https://lore.kernel.org/lkml/20190513143244.16478-1-steven.price@arm.com/
Changes since v1:
 * Rename drm_gem_dumb_map_offset to drop _dumb
 * Add a shmem helper

Steven Price (2):
  drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offset()
  drm/panfrost: Use drm_gem_shmem_map_offset()

 drivers/gpu/drm/drm_dumb_buffers.c      |  4 ++--
 drivers/gpu/drm/drm_gem.c               |  6 +++---
 drivers/gpu/drm/exynos/exynos_drm_gem.c |  3 +--
 drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++--------------
 include/drm/drm_gem.h                   |  4 ++--
 5 files changed, 10 insertions(+), 23 deletions(-)

-- 
2.20.1

