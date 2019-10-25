Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC209E4C75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504817AbfJYNly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 09:41:54 -0400
Received: from foss.arm.com ([217.140.110.172]:40830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502142AbfJYNlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:41:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37AFF28;
        Fri, 25 Oct 2019 06:41:53 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15533F71A;
        Fri, 25 Oct 2019 06:41:51 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/panfrost: Tidy up the devfreq implementation
Date:   Fri, 25 Oct 2019 14:41:41 +0100
Message-Id: <20191025134143.14324-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq implementation in panfrost is unnecessarily open coded. It
also tracks utilisation metrics per slot which isn't very useful. Let's
tidy it up!

Changes since v1:
 http://lkml.kernel.org/r/20190912112804.10104-1-steven.price%40arm.com
 * Rebased onto latest drm-misc-next, specifically after
   d18a96620411 ("drm/panfrost: Remove NULL checks for regulator")
 * Added tags

Steven Price (2):
  drm/panfrost: Use generic code for devfreq
  drm/panfrost: Simplify devfreq utilisation tracking

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 124 ++++++--------------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |   3 +-
 drivers/gpu/drm/panfrost/panfrost_device.h  |  14 +--
 drivers/gpu/drm/panfrost/panfrost_job.c     |  15 ++-
 4 files changed, 48 insertions(+), 108 deletions(-)

-- 
2.20.1

