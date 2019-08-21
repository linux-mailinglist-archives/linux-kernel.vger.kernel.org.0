Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A196997A54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfHUNHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 09:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfHUNG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:06:59 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8BA22DD3;
        Wed, 21 Aug 2019 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566392819;
        bh=t4sdagesTl8eI/FplVlttPAz6pa/0/Zv52KvZADKVvc=;
        h=From:To:Cc:Subject:Date:From;
        b=TfrPw7cU6UddY+1gMqkIU1J+dedALQUjwxGne7BGpISJ1DiuQTlB9ACfEsbMhDcWs
         PunVHG7n6bItBbEHz2lhJga/FeQTKyyI3X0uDyVQXZXfxYug0QVM6DttgevLa98PGr
         Rkb//EZSOWoOq6CJPCaCc+Lg+GZReyh+8brGc8z4=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ASoC: sun4i-i2s: Number of fixes and TDM Support
Date:   Wed, 21 Aug 2019 15:06:52 +0200
Message-Id: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

Hi,

This series aims at fixing a number of issues in the current i2s driver,
mostly related to the i2s master support and the A83t support. It also uses
that occasion to cleanup a few things and simplify the driver. Finally, it
builds on those fixes and cleanups to introduce TDM and DSP formats support.

Let me know what you think,
Maxime

Changes from v1:
  - Removed patches applied
  - Refactor a bit the call to sun4i_i2s_set_clk_rate
  - Fix build issue
  - Add an extra patch to cleanup sun4i_i2s_hw_params

Maxime Ripard (4):
  ASoC: sun4i-i2s: Use the physical / slot width for the clocks
  ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
  ASoC: sun4i-i2s: Replace call to params_width by local variable
  ASoC: sun4i-i2s: Add support for DSP formats

 sound/soc/sunxi/sun4i-i2s.c | 58 ++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 15 deletions(-)

base-commit: 137befe19f310400a8b20fd8a4ce8c4141aafde0
-- 
git-series 0.9.1
