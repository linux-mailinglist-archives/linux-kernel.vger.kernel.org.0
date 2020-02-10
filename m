Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00601158579
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 23:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBJW2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 17:28:19 -0500
Received: from mailoutvs43.siol.net ([185.57.226.234]:33662 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727254AbgBJW2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:28:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id EE8795222B4;
        Mon, 10 Feb 2020 23:28:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gTivMyQ3DMx5; Mon, 10 Feb 2020 23:28:16 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 9DF585221F6;
        Mon, 10 Feb 2020 23:28:16 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 1CEF3521B7E;
        Mon, 10 Feb 2020 23:28:16 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] clk: sunxi-ng: sun8i-de2: Multiple fixes
Date:   Mon, 10 Feb 2020 23:28:00 +0100
Message-Id: <20200210222807.206426-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current sun8i-de2 clock driver, rotation core related clocks and
reset weren't considered properly. All SoC which have that core don't
have those definitions. Even worse, the only SoC which have rotation
core related definitions doesn't have that core at all.

This series fixes this mess.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (7):
  clk: sunxi-ng: sun8i-de2: Sort structures
  clk: sunxi-ng: sun8i-de2: Split out H5 definitions
  clk: sunxi-ng: sun8i-de2: Add rotation core clocks and reset for A64
  clk: sunxi-ng: sun8i-de2: H6 doesn't have rotate core
  clk: sunxi-ng: sun8i-de2: Don't reuse A83T resets
  clk: sunxi-ng: sun8i-de2: Add rotation core clocks and reset for A83T
  clk: sunxi-ng: sun8i-de2: Add R40 specific quirks

 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 131 +++++++++++++++++----------
 1 file changed, 82 insertions(+), 49 deletions(-)

--=20
2.25.0

