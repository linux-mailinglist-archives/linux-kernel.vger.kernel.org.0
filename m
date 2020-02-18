Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC5161E06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 00:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgBQXrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 18:47:09 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48808 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgBQXrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:47:05 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B5564891AB;
        Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581983220;
        bh=cMwWq/fB5TqLaO7gJKiv9RZZ9K3gkV2WtovJnrZdpXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VrgopT2S8vUgdhN/m2G1B3sDNdHrEA3jqzsldNwSZx0TM3sbjuq7drEPUWKUGX2uI
         z6Tbyv/5/uvpg9FHHy2uA0RIdjnQjBMWSRE2fL/tA7mcTQ8Zd85H5rarhMB0NUHLLI
         Ak/RzTeizRr/f1cA3bM8dNn/VbMAsvZ9b6ivehWpFtYuOhj6uRR65EOiPAy+UWncup
         m9ZshVDCNXzwHGmxfr8hfqkIY2GJyxnkDtR38FVfU7H7rla7V52ooBlBvqYTenaDqf
         WJI+u9Z1/Strwn8AFxVFje/AAK39xJGD8ljnnhqcd1QPgaf0wvs1Phc4lHO5mW1OjO
         k2K4ID+QWgU6Q==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4b25f40000>; Tue, 18 Feb 2020 12:47:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id EE01513EED4;
        Tue, 18 Feb 2020 12:46:59 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 6A15F28006C; Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 4/5] hwmon: (adt7475) Add attenuator bypass support
Date:   Tue, 18 Feb 2020 12:46:56 +1300
Message-Id: <20200217234657.9413-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>

Added support for reading DTS properties to set attenuators on
device probe for the ADT7473, ADT7475, ADT7476, and ADT7490.

Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7475.c | 61 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 01c2eeb02aa9..4a62d633a2f5 100644
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
@@ -193,6 +194,7 @@ struct adt7475_data {
 	unsigned long measure_updated;
 	bool valid;
=20
+	u8 config2;
 	u8 config4;
 	u8 config5;
 	u8 has_voltage;
@@ -1458,6 +1460,55 @@ static int adt7475_update_limits(struct i2c_client=
 *client)
 	return 0;
 }
=20
+static int set_property_bit(const struct i2c_client *client, char *prope=
rty,
+			  u8 *config, u8 bit_index)
+{
+	u32 prop_value =3D 0;
+	int ret =3D of_property_read_u32(client->dev.of_node, property,
+					&prop_value);
+
+	if (!ret) {
+		if (prop_value)
+			*config |=3D (1 << bit_index);
+		else
+			*config &=3D ~(1 << bit_index);
+	}
+
+	return ret;
+}
+
+static int load_attenuators(const struct i2c_client *client, int chip,
+			    struct adt7475_data *data)
+{
+	int ret;
+
+	if (chip =3D=3D adt7476 || chip =3D=3D adt7490) {
+		set_property_bit(client, "bypass-attenuator-in0",
+				 &data->config4, 4);
+		set_property_bit(client, "bypass-attenuator-in1",
+				 &data->config4, 5);
+		set_property_bit(client, "bypass-attenuator-in3",
+				 &data->config4, 6);
+		set_property_bit(client, "bypass-attenuator-in4",
+				 &data->config4, 7);
+
+		ret =3D i2c_smbus_write_byte_data(client, REG_CONFIG4,
+						data->config4);
+		if (ret < 0)
+			return ret;
+	} else if (chip =3D=3D adt7473 || chip =3D=3D adt7475) {
+		set_property_bit(client, "bypass-attenuator-in1",
+				 &data->config2, 5);
+
+		ret =3D i2c_smbus_write_byte_data(client, REG_CONFIG2,
+						data->config2);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1472,7 +1523,7 @@ static int adt7475_probe(struct i2c_client *client,
 	struct adt7475_data *data;
 	struct device *hwmon_dev;
 	int i, ret =3D 0, revision, group_num =3D 0;
-	u8 config2, config3;
+	u8 config3;
=20
 	data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (data =3D=3D NULL)
@@ -1546,8 +1597,12 @@ static int adt7475_probe(struct i2c_client *client=
,
 	}
=20
 	/* Voltage attenuators can be bypassed, globally or individually */
-	config2 =3D adt7475_read(REG_CONFIG2);
-	if (config2 & CONFIG2_ATTN) {
+	data->config2 =3D adt7475_read(REG_CONFIG2);
+	ret =3D load_attenuators(client, chip, data);
+	if (ret)
+		dev_err(&client->dev, "Error configuring attenuator bypass\n");
+
+	if (data->config2 & CONFIG2_ATTN) {
 		data->bypass_attn =3D (0x3 << 3) | 0x3;
 	} else {
 		data->bypass_attn =3D ((data->config4 & CONFIG4_ATTN_IN10) >> 4) |
--=20
2.25.0

