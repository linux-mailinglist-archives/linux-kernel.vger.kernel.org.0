Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BF6796B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfGMJH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 05:07:27 -0400
Received: from mailoutvs27.siol.net ([185.57.226.218]:37198 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726421AbfGMJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 05:07:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 9AC04521342;
        Sat, 13 Jul 2019 11:07:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m-6CwcbiJgKp; Sat, 13 Jul 2019 11:07:24 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 5C9CD521385;
        Sat, 13 Jul 2019 11:07:24 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id BE1CF521342;
        Sat, 13 Jul 2019 11:07:23 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     broonie@kernel.org, wens@csie.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 0/2] regulator: axp20x: Fix bugs for AXP803/6
Date:   Sat, 13 Jul 2019 11:07:15 +0200
Message-Id: <20190713090717.347-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver refactoring caused few bugs and most of them are already fixed.
However, some are still present, namely in AXP806 and AXP803 regulator
definitions.

This short patch series fix them.

Please take a look.

Best regards,
Jernej

Changes from v1:
- Expanded commit message
- Added fix for AXP803 DCDC5

Jernej Skrabec (2):
  regulator: axp20x: fix DCDCA and DCDCD for AXP806
  regulator: axp20x: fix DCDC5 and DCDC6 for AXP803

 drivers/regulator/axp20x-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--=20
2.22.0

