Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF69060FC2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfGFKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 06:06:00 -0400
Received: from mailoutvs16.siol.net ([185.57.226.207]:33704 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725988AbfGFKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:06:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 54332521F8D;
        Sat,  6 Jul 2019 12:05:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YchohIpvYd1s; Sat,  6 Jul 2019 12:05:56 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1F8515211EF;
        Sat,  6 Jul 2019 12:05:55 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 78FC3521F78;
        Sat,  6 Jul 2019 12:05:53 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     wens@csie.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] regulator: axp20x: Fix bugs for AXP803/6
Date:   Sat,  6 Jul 2019 12:05:43 +0200
Message-Id: <20190706100545.22759-1-jernej.skrabec@siol.net>
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

Jernej Skrabec (2):
  regulator: axp20x: fix DCDCA and DCDCD for AXP806
  regulator: axp20x: fix DCDC6 for AXP803

 drivers/regulator/axp20x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--=20
2.22.0

