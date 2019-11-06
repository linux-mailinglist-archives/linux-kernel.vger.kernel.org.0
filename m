Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1B8F1297
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 10:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfKFJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 04:44:11 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:41341 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:44:10 -0500
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B2577240015;
        Wed,  6 Nov 2019 09:44:07 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        James Hilliard <james.hilliard1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 0/2] drm/gma500: Add page flip support on psb/cdv
Date:   Wed,  6 Nov 2019 10:43:58 +0100
Message-Id: <20191106094400.445834-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings-in the required bits to implement page flip support
on poulsbo and cedartrail. Page flip support is required to run weston
with the GMA500 driver.

This is only legacy page flip support, not a conversion of the driver to
atomic DRM.

Paul Kocialkowski (2):
  drm/gma500: Add missing call to allow enabling vblank on psb/cdv
  drm/gma500: Add page flip support on psb/cdv

 drivers/gpu/drm/gma500/cdv_intel_display.c |  1 +
 drivers/gpu/drm/gma500/gma_display.c       | 48 ++++++++++++++++++++++
 drivers/gpu/drm/gma500/gma_display.h       |  6 +++
 drivers/gpu/drm/gma500/psb_intel_display.c |  1 +
 drivers/gpu/drm/gma500/psb_intel_drv.h     |  3 ++
 drivers/gpu/drm/gma500/psb_irq.c           | 18 ++++++--
 6 files changed, 74 insertions(+), 3 deletions(-)

-- 
2.23.0

