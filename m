Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A873C4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404187AbfFKHUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 03:20:10 -0400
Received: from shell.v3.sk ([90.176.6.54]:60804 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403936AbfFKHUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:20:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7DFCC104F6A;
        Tue, 11 Jun 2019 09:20:06 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 11G1JtyAYuv1; Tue, 11 Jun 2019 09:19:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 19825104F6E;
        Tue, 11 Jun 2019 09:19:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z5BQMuJOd3nx; Tue, 11 Jun 2019 09:19:58 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D6796104F6A;
        Tue, 11 Jun 2019 09:19:57 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Paul Thomas <pthomas8589@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] hwmon: (ads7871) Switch to SPDX header
Date:   Tue, 11 Jun 2019 09:19:48 +0200
Message-Id: <20190611071948.2978150-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original license text had a typo ("publishhed") which would be
likely to confuse automated licensing auditing tools. Let's just switch
to SPDX instead of fixing the wording.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/hwmon/ads7871.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index cd14c1501508..7ccc79f77f95 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  ads7871 - driver for TI ADS7871 A/D converter
  *
  *  Copyright (c) 2010 Paul Thomas <pthomas8589@gmail.com>
  *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- *  GNU General Public License for more details.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 or
- *  later as publishhed by the Free Software Foundation.
- *
  *	You need to have something like this in struct spi_board_info
  *	{
  *		.modalias	=3D "ads7871",
--=20
2.21.0

