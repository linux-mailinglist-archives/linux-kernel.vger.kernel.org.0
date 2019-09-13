Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCCAB285B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 00:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404052AbfIMW1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 18:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404021AbfIMW1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:27:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2B3F30821C1;
        Fri, 13 Sep 2019 22:27:11 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE57D60C57;
        Fri, 13 Sep 2019 22:27:08 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Sean Paul" <sean@poorly.run>,
        "Maxime Ripard" <mripard@kernel.org>
Subject: [PATCH 0/3] drm/encoder: Various doc fixes
Date:   Fri, 13 Sep 2019 18:27:00 -0400
Message-Id: <20190913222704.8241-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 13 Sep 2019 22:27:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some random issues with documentation that I noticed while working on
nouveau the other day. There are no functional changes in this series.

Lyude Paul (3):
  drm/encoder: Fix possible_clones documentation
  drm/encoder: Fix possible_crtcs documentation
  drm/encoder: Don't raise voice in drm_encoder_mask() documentation

 include/drm/drm_encoder.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.21.0

