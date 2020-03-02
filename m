Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB50E176398
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgCBTNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:13:43 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:50530 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgCBTNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:13:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6B447FB08;
        Mon,  2 Mar 2020 20:13:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lt_4OpfdEgK8; Mon,  2 Mar 2020 20:13:37 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 76A544048B; Mon,  2 Mar 2020 20:13:36 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/etnaviv: Ignore MC bit when checking for runtime suspend
Date:   Mon,  2 Mar 2020 20:13:31 +0100
Message-Id: <cover.1583176306.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least GC7000 fails to enter runtime suspend for long periods of time since
the MC becomes busy again even when the FE is idle. The rest of the series
makes detecting similar issues easier to debug in the future by checking
all known bits in debugfs and also warning in the EBUSY case.

Tested on GC7000 with a reduced runtime delay of 50ms. Patches are
against next-20200226.

Thanks to Lucas Stach for pointing me in the right direction.

Guido Günther (5):
  drm/etnaviv: Fix typo in comment
  drm/etnaviv: Update idle bits
  drm/etnaviv: Consider all kwnown idle bits in debugfs
  drm/etnaviv: Ignore MC when checking runtime suspend idleness
  drm/etnaviv: Warn when GPU doesn't idle fast enough

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 26 ++++++++++++++++++++++----
 drivers/gpu/drm/etnaviv/state_hi.xml.h |  7 +++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.23.0

