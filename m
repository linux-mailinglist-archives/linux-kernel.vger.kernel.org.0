Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D15EB0DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 13:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfILL2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 07:28:12 -0400
Received: from foss.arm.com ([217.140.110.172]:32770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbfILL2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:28:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3FEC28;
        Thu, 12 Sep 2019 04:28:11 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99A573F67D;
        Thu, 12 Sep 2019 04:28:10 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/panfrost: Tidy up the devfreq implementation
Date:   Thu, 12 Sep 2019 12:28:02 +0100
Message-Id: <20190912112804.10104-1-steven.price@arm.com>
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

This should be picked up along with Mark's change[1] to fix
regulator_get_optional() misuse. This also deletes the code changes from
52282163dfa6 and e21dd290881b which would otherwise need reverting, see
the previous discussion[2].

[1] https://lore.kernel.org/lkml/20190904123032.23263-1-broonie@kernel.org/
[2] https://lore.kernel.org/lkml/ccd81530-2dbd-3c02-ca0a-1085b00663b5@arm.com/

Steven Price (2):
  drm/panfrost: Use generic code for devfreq
  drm/panfrost: Simplify devfreq utilisation tracking

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 126 ++++++--------------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |   3 +-
 drivers/gpu/drm/panfrost/panfrost_device.h  |  14 +--
 drivers/gpu/drm/panfrost/panfrost_job.c     |  14 +--
 4 files changed, 48 insertions(+), 109 deletions(-)

-- 
2.20.1

