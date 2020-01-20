Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F36142B04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 13:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgATMjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 07:39:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35462 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:39:41 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 155D8292C49
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, drinkcat@chromium.org,
        Mark Brown <broonie@kernel.org>, dianders@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>, mka@chromium.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] regulator: core: Fix exported symbols to the exported GPL version
Date:   Mon, 20 Jan 2020 13:39:21 +0100
Message-Id: <20200120123921.1204339-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the exported symbols introduced by commit e9153311491da
("regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage")
from EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL(), like is used for all the core
parts.

Fixes: e9153311491da ("regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e7d167ce326c..d015d99cb59d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3470,7 +3470,7 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 out:
 	return ret;
 }
-EXPORT_SYMBOL(regulator_set_voltage_rdev);
+EXPORT_SYMBOL_GPL(regulator_set_voltage_rdev);
 
 static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 					int *current_uV, int *min_uV)
@@ -4035,7 +4035,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 		return ret;
 	return ret - rdev->constraints->uV_offset;
 }
-EXPORT_SYMBOL(regulator_get_voltage_rdev);
+EXPORT_SYMBOL_GPL(regulator_get_voltage_rdev);
 
 /**
  * regulator_get_voltage - get regulator output voltage
-- 
2.24.1

