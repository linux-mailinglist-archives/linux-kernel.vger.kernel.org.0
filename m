Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97439140288
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 04:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgAQDvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 22:51:04 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56323 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgAQDvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:51:04 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0C336891AE;
        Fri, 17 Jan 2020 16:51:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579233062;
        bh=IZF+L2Q5FLkUfOp7nAfJ6fRYNZITWKpUJNg/rlmCm7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ayEEvxq9AChPPU/CLMd6gpiEgUqjt0ios2mOV+TKeB+DC+i0nN3VM1YzZHN4W/Hv+
         yyaSz5iRltAiAQTtitAHP2i6B2JBvQW2PTPs4K/jgoGheLIFd9CplCT0219o4IX2aa
         jYVdiNIEq4QMPqJRQw9kgkbMPOlqkXMR2IdHyir5B+HW+qOPl0uf/QesgqxYOx4p+n
         1YNEs4qKJW1PmOB5/iYbesxBbQNCXuhVZCsRFRHXoqaHAMf1x1Q3F6GA948BL5pkZL
         aUHvwXROGH1rI4mLNKkjKd8dMy4x8JrPbnWS3frNBeTzCRrMn96bTfjON6xlYkZqX0
         PJdrtK0sWUYhQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e212f260000>; Fri, 17 Jan 2020 16:51:02 +1300
Received: from logans-dl.ws.atlnz.lc (logans-dl.ws.atlnz.lc [10.33.25.61])
        by smtp (Postfix) with ESMTP id 552A213EEFE;
        Fri, 17 Jan 2020 16:51:01 +1300 (NZDT)
Received: by logans-dl.ws.atlnz.lc (Postfix, from userid 1820)
        id C93E5C1A8B; Fri, 17 Jan 2020 16:51:01 +1300 (NZDT)
From:   Logan Shaw <logan.shaw@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: [PATCH v3 1/2] hwmon: (adt7475) Added attenuator bypass support
Date:   Fri, 17 Jan 2020 16:50:17 +1300
Message-Id: <20200117035018.11985-2-logan.shaw@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117035018.11985-1-logan.shaw@alliedtelesis.co.nz>
References: <20200117035018.11985-1-logan.shaw@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for reading DTS properties to set attenuators on
device probe for the ADT7473, ADT7475, ADT7476, and ADT7490.

Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
---
---
 drivers/hwmon/adt7475.c | 76 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6c64d50c9aae..2bb787acb363 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
+#include <linux/of.h>
 #include <linux/util_macros.h>
=20
 /* Indexes for the sysfs hooks */
@@ -1457,6 +1458,76 @@ static int adt7475_update_limits(struct i2c_client=
 *client)
 	return 0;
 }
=20
+/**
+ * Attempts to read a u32 property from the DTS, if there is no error an=
d
+ * the properties value is zero then the bit given by parameter bit_inde=
x
+ * is cleared in the parameter config. If the value is non-zero then the=
 bit
+ * is set.
+ *=20
+ * If reading the dts property returned an error code then it is returne=
d and
+ * the config parameter is not modified.
+ */
+static int modify_config_from_dts_prop(const struct i2c_client *client,
+								char *dts_property, u8 *config, u8 bit_index) {
+	u32 is_attenuator_bypassed =3D 0;
+	int ret =3D of_property_read_u32(client->dev.of_node, dts_property,
+									&is_attenuator_bypassed);
+
+	if (! ret) {
+			if (is_attenuator_bypassed)
+		*config |=3D (1 << bit_index);
+	else
+		*config &=3D ~(1 << bit_index);
+	}
+
+	return ret;
+}
+
+/**
+ * Reads all individual voltage input bypass attenuator properties from =
the
+ * DTS, and if the property is present the corresponding bit is set in t=
he
+ * register.
+
+ * Properties are in the form of "bypass-attenuator-inx", where x is an
+ * integer from the set {0, 1, 3, 4} (can not bypass in2 attenuator).
+.*=20
+ * The adt7473 and adt7475 only support bypassing in1.
+ *=20
+ * Returns a negative error code if there was an error writing to the re=
gister.
+ */
+static int load_all_bypass_attenuators(const struct i2c_client *client,=20
+					      int chip, u8 *config2, u8 *config4)
+{
+	u8 config2_copy =3D *config2;
+	u8 config4_copy =3D *config4;
+
+	if (chip =3D=3D adt7476 || chip =3D=3D adt7490) {
+		modify_config_from_dts_prop(client, "bypass-attenuator-in0",
+									&config4_copy, 4);
+		modify_config_from_dts_prop(client, "bypass-attenuator-in1",
+									&config4_copy, 5);
+		modify_config_from_dts_prop(client, "bypass-attenuator-in3",
+									&config4_copy, 6);
+		modify_config_from_dts_prop(client, "bypass-attenuator-in4",
+									&config4_copy, 7);
+
+		if (i2c_smbus_write_byte_data(client, REG_CONFIG4, config4_copy) < 0)
+			return -EREMOTEIO;
+
+		*config4 =3D config4_copy;
+	} else if (chip =3D=3D adt7473 || chip =3D=3D adt7475) {
+		modify_config_from_dts_prop(client, "bypass-attenuator-in1",
+									&config2_copy, 5);
+
+		if (i2c_smbus_write_byte_data(client, REG_CONFIG2, config2_copy) < 0)
+			return -EREMOTEIO;
+
+		*config2 =3D config2_copy;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1546,6 +1617,11 @@ static int adt7475_probe(struct i2c_client *client=
,
=20
 	/* Voltage attenuators can be bypassed, globally or individually */
 	config2 =3D adt7475_read(REG_CONFIG2);
+	if (load_all_bypass_attenuators(client, chip,
+						&config2, &(data->config4)) < 0)
+		dev_warn(&client->dev,
+			 "Error setting bypass attenuator bits\n");
+
 	if (config2 & CONFIG2_ATTN) {
 		data->bypass_attn =3D (0x3 << 3) | 0x3;
 	} else {
--=20
2.25.0

