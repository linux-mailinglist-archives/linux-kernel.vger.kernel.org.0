Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6311975814
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfGYTkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 15:40:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfGYTkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2257D85550;
        Thu, 25 Jul 2019 19:40:13 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 076836012D;
        Thu, 25 Jul 2019 19:40:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 0/2] drm/nouveau: i2c over DP AUX fixes
Date:   Thu, 25 Jul 2019 15:39:59 -0400
Message-Id: <20190725194005.16572-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 25 Jul 2019 19:40:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another attempt at fixing an issue with

yes | sensors-detect

Causing some machines with nouveau loaded to hang if certain kinds of
displays are attached. I've also included one minor fix that I found
along the way of troubleshooting this issue.

Lyude Paul (2):
  drm/nouveau: Fix missing elses in g94_i2c_aux_xfer
  drm/nouveau: Don't retry infinitely when receiving no data on i2c over
    AUX

 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c | 24 +++++++++++++------
 .../gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c  |  4 ++--
 2 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.21.0

