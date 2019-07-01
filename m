Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74D34C0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfFSSgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 14:36:50 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:38324 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730283AbfFSSgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:36:48 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 45863C00ED;
        Wed, 19 Jun 2019 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560969408; bh=HFU+VROCK0C6D+QU6j2ekGDFt1Sva007823auZeHX7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=U90JMlzaF68mn6cNmL1fAgyYwzttuEXxtTYVHy6XI3r+YW2LO9ZYVgaboerGOuyNx
         hsF5QGJWI2ihFvVzwAoXhf8umkIyS3uvZg6xaxjxVkgz4JqZTI7gNAKupXX5DMTfUS
         8p8pbW7/Q3pr6Hv5S1qUIDhaF3ryI/bEqHc66HjRKzNsYqOJvBI3K3O3uThJ9gMfcM
         IIj7wmeRbjZG01/oUJwOVAAlFORC4CTtEAOvgYHhUhF1DKp9GT2n95+CDJx7boeraI
         Tc/TjzGXwWvQshIeaoaKb+4uzu3BIaz1tRqgRfy63CJktj1xXWog3S6YMf4UjPEtNy
         G+kcjVaa0w7Hg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id C7598A0231;
        Wed, 19 Jun 2019 18:36:45 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id A020A3F217;
        Wed, 19 Jun 2019 20:36:45 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-i3c@lists.infradead.org, Joao.Pinto@synopsys.com
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] i3c: add mixed limited bus mode
Date:   Wed, 19 Jun 2019 20:36:32 +0200
Message-Id: <4627348638396c6b3fbe3ee28b533ca15ea9f4fe.1560968688.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560968688.git.vitor.soares@synopsys.com>
References: <cover.1560968688.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1560968688.git.vitor.soares@synopsys.com>
References: <cover.1560968688.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i3c bus spec defines a bus configuration where i2c devices don't
have a 50ns filter but support SCL running at SDR max rate (12.5MHz).

This patch introduces the limited bus mode so that users can use
a higher speed in presence of i2c devices index 1.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
Changes in v4:
  None

Changes in v3:
  None

Changes in v2:
  Enhance commit message

 drivers/i3c/master.c       | 5 +++++
 include/linux/i3c/master.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 14980db..76549f1 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -470,6 +470,7 @@ static int i3c_bus_init(struct i3c_bus *i3cbus)
 static const char * const i3c_bus_mode_strings[] = {
 	[I3C_BUS_MODE_PURE] = "pure",
 	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
+	[I3C_BUS_MODE_MIXED_LIMITED] = "mixed-limited",
 	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
 };
 
@@ -585,6 +586,7 @@ int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
 			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
 		if (!i3cbus->scl_rate.i3c)
 			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
 		if (!i3cbus->scl_rate.i2c)
@@ -2481,6 +2483,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 				mode = I3C_BUS_MODE_MIXED_FAST;
 			break;
 		case I3C_LVR_I2C_INDEX(1):
+			if (mode < I3C_BUS_MODE_MIXED_LIMITED)
+				mode = I3C_BUS_MODE_MIXED_LIMITED;
+			break;
 		case I3C_LVR_I2C_INDEX(2):
 			if (mode < I3C_BUS_MODE_MIXED_SLOW)
 				mode = I3C_BUS_MODE_MIXED_SLOW;
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index f13fd8b..89ea461 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -250,12 +250,17 @@ struct i3c_device {
  *			     the bus. The only impact in this mode is that the
  *			     high SCL pulse has to stay below 50ns to trick I2C
  *			     devices when transmitting I3C frames
+ * @I3C_BUS_MODE_MIXED_LIMITED: I2C devices without 50ns spike filter are
+ *				present on the bus. However they allows
+ *				compliance up to the maximum SDR SCL clock
+ *				frequency.
  * @I3C_BUS_MODE_MIXED_SLOW: I2C devices without 50ns spike filter are present
  *			     on the bus
  */
 enum i3c_bus_mode {
 	I3C_BUS_MODE_PURE,
 	I3C_BUS_MODE_MIXED_FAST,
+	I3C_BUS_MODE_MIXED_LIMITED,
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
-- 
2.7.4

