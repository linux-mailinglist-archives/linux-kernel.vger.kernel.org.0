Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3029967A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 14:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfGMMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 08:04:00 -0400
Received: from mailoutvs17.siol.net ([185.57.226.208]:35134 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727489AbfGMMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 08:04:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 03A5D520796;
        Sat, 13 Jul 2019 14:03:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GZJ1_W8SsO1t; Sat, 13 Jul 2019 14:03:56 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id A7A2452059A;
        Sat, 13 Jul 2019 14:03:56 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id AB370520796;
        Sat, 13 Jul 2019 14:03:52 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] drm/sun4i: Add support for color encoding and range
Date:   Sat, 13 Jul 2019 14:03:43 +0200
Message-Id: <20190713120346.30349-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to correctly convert image between YUV and RGB, you have to
know color encoding and color range. This patch set adds appropriate
properties and considers them when choosing CSC conversion matrix for
DE2 and DE3.

Note that this is only the half of needed changes when using HDMI output.
DW HDMI bridge driver has to be extended to have a property to select
limited (TVs) or full (PC monitors) range. But that will be done at a
later time.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (3):
  drm/sun4i: Introduce color encoding and range properties
  drm/sun4i: sun8i_csc: Simplify register writes
  drm/sun4i: sun8i-csc: Add support for color encoding and range

 drivers/gpu/drm/sun4i/sun8i_csc.c      | 155 +++++++++++++++++++------
 drivers/gpu/drm/sun4i/sun8i_csc.h      |   6 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  21 +++-
 3 files changed, 146 insertions(+), 36 deletions(-)

--=20
2.22.0

