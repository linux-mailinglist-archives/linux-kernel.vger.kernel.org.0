Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3710270A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfKSOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 09:41:56 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:57734 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbfKSOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:41:55 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C9CCDC04B6;
        Tue, 19 Nov 2019 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574174515; bh=G4p50MA5mFWmjXCuDGR29jySUNUSgvmL37nTesfoCHE=;
        h=From:To:Cc:Subject:Date:From;
        b=ZcPGV1yuUi+weiF9t/xM5EPXYfLagwjWjkAIv41Z/Tb9YhloRYkFVkVSN4aBJxX1L
         fKKxGwZqQ81oK7aA7+1wcFJmX1Gj80q908fv4/CXFhoA3mgnzXNt0g9kqU2D9Eh1sE
         zP13Eqh3bCqaHxMi3wEUjUQByO4Ylb9r1a5i45R7RiIMrCwMD/7hShOV/3VttUDC3z
         vuQHLbj0ldkCZDuOOryPvWlb/xbR3dzJG6xfqzSEUo+qMMtAyScWnsGVkXotopcx4E
         phr7wAJJ0fTCKqHV9NVAmVD54l9/M36we+9zdvullHtRBqnDE9Oik1qV9rEkZm/iah
         rA/cm0sZo8Njg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id DEEC8A005D;
        Tue, 19 Nov 2019 14:41:50 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/4] DRM: PGU: ARC: fixies related to framebuffer format
Date:   Tue, 19 Nov 2019 17:41:43 +0300
Message-Id: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeniy Paltsev (4):
  DRM: ARC: PGU: fix framebuffer format switching
  DRM: ARC: PGU: cleanup supported format list code
  DRM: ARC: PGU: replace unsupported by HW RGB888 format by XRGB888
  DRM: ARC: PGU: add ARGB8888 format to supported format list

 drivers/gpu/drm/arc/arcpgu_crtc.c | 36 +++++++++++++++----------------
 drivers/gpu/drm/arc/arcpgu_regs.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.21.0

