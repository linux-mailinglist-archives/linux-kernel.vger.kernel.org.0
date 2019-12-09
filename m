Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8858116D52
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 13:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfLIMw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 07:52:59 -0500
Received: from foss.arm.com ([217.140.110.172]:59466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfLIMw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:52:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F4081328;
        Mon,  9 Dec 2019 04:52:58 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A46B3F718;
        Mon,  9 Dec 2019 04:52:58 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com
Subject: [PATCH] regulator: core: avoid unneeded .list_voltage calls
Date:   Mon,  9 Dec 2019 12:52:39 +0000
Message-Id: <20191209125239.46054-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside machine_constraints_voltage() a loop is in charge of verifying that
each of the defined voltages are within the configured constraints and
that those constraints are in fact compatible with the available voltages'
list.

When the registered regulator happens to be defined with a wide range of
possible voltages the above O(n) loop can be costly.
Moreover since this behaviour is triggered during the registration process,
it means also that it can be easily triggered at probe time, slowing down
considerably some module loading.

On the other side if such wide range of voltage values happens to be also
continuous and without discontinuity of any kind, the above potentially
cumbersome operation is also useless.

For these reasons, avoid such .list_voltage poll loop when regulator is
described as 'continuous_voltage_range' as is, indeed, similarly already
done inside regulator_is_supported_voltage().

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/regulator/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 679ad3d2ed23..580fbdd3c97e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1198,6 +1198,10 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 			return -EINVAL;
 		}
 
+		/* no need to loop voltages if range is continuous */
+		if (rdev->desc->continuous_voltage_range)
+			return 0;
+
 		/* initial: [cmin..cmax] valid, [min_uV..max_uV] not */
 		for (i = 0; i < count; i++) {
 			int	value;
-- 
2.17.1

