Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571C320B56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfEPPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 11:33:15 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:54556 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfEPPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:33:14 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 009DE3AECE2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (aaubervilliers-681-1-43-46.w90-88.abo.wanadoo.fr [90.88.161.46])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C8D2E200017;
        Thu, 16 May 2019 14:55:50 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v9 0/4] drm/vc4: Binner BO management improvements
Date:   Thu, 16 May 2019 16:55:40 +0200
Message-Id: <20190516145544.29051-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes sinve v8:
* Added collected Reviewed-by;
* Fixed up another problematic case as discussed on v8.

Changes since v7:
* Moved the used bool to vc4_v3d_bin_bo_get in order to check it locked and
  avoid a possible race condition;

Changes since v6:
* Removed vc4_v3d_bin_bo_put from error paths;
* Added WARN_ON_ONCE when no bin BO at refcount release.

Changes since v5:
* Fix more locking mistakes;
* Introduce get/put helpers;
* Grabbed a reference when submitting an exec job with a binner slot.
* Addressed misc comments.

Changes since v4:
* Used a kref on the binner bo instead of firstopen/lastclose;
* Added a mutex to prevent race conditions;
* Took care of enabling the OOM interrupt when we have a binner BO allocated.

Changes since v3:
* Split changes into more commits when possible;
* Reworked binner bo alloc condition as discussed.

Changes since v2:
* Removed deprecated sentence about fristopen;
* Added collected Reviewed-By tags.

Changes since v1:
* Squashed the two final patches into one.

Paul Kocialkowski (4):
  drm/vc4: Reformat and the binner bo allocation helper
  drm/vc4: Check for V3D before binner bo alloc
  drm/vc4: Check for the binner bo before handling OOM interrupt
  drm/vc4: Allocate binner bo when starting to use the V3D

 drivers/gpu/drm/vc4/vc4_bo.c  | 31 ++++++++++++++-
 drivers/gpu/drm/vc4/vc4_drv.c |  6 +++
 drivers/gpu/drm/vc4/vc4_drv.h | 14 +++++++
 drivers/gpu/drm/vc4/vc4_gem.c | 11 ++++++
 drivers/gpu/drm/vc4/vc4_irq.c | 20 ++++++++--
 drivers/gpu/drm/vc4/vc4_v3d.c | 72 ++++++++++++++++++++++++++---------
 6 files changed, 132 insertions(+), 22 deletions(-)

-- 
2.21.0

