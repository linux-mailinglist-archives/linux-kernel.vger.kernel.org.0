Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7382D142109
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 01:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgATARR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 19:17:17 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58201 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgATARR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 19:17:17 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EDE0E83640;
        Mon, 20 Jan 2020 13:17:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579479434;
        bh=IC6wu4MCzaEB+3dvA7FSjQ0EOg61Y7M+KvOJyeddsO0=;
        h=From:To:Cc:Subject:Date;
        b=WQkiRB6bZoRqD/PuTNv4mTbbDIzx9OsS416IpKfu/wB/FTnRXfGqagajpLBCXzOMG
         v+pbnTRc6+x/cCB7z1EBFAEehy63Qkrtjt7oU3yLcfi381AQha8FuZKIT61hmG7Yeh
         e0/awPaWNRr6RFccpmuamksssIIQLCzpAEZ5WkU2/LkVNUJXD0MLEWXPHqZbkaqah7
         MCNIqSbHLZ9kImL4v0bUz1OPbCAMbwQI7Tm+uG8MDVsWwQ/X9U7EkHHvEEmdeMt5JQ
         6KZ3tDdbhPCKZ4q4u4YS9Z8Krn+SriS8Haa/PqQArPjiVls4+338KBeySyvR0RoZaS
         4LAXfpxazKspg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e24f18a0000>; Mon, 20 Jan 2020 13:17:14 +1300
Received: from logans-dl.ws.atlnz.lc (logans-dl.ws.atlnz.lc [10.33.25.61])
        by smtp (Postfix) with ESMTP id A8ACE13EEFE;
        Mon, 20 Jan 2020 13:17:14 +1300 (NZDT)
Received: by logans-dl.ws.atlnz.lc (Postfix, from userid 1820)
        id A85F5C0448; Mon, 20 Jan 2020 13:17:14 +1300 (NZDT)
From:   Logan Shaw <logan.shaw@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: [PATCH v4 0/2] hwmon: (adt7475) Added attenuator bypass support
Date:   Mon, 20 Jan 2020 13:17:01 +1300
Message-Id: <20200120001703.9927-1-logan.shaw@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADT7473 and ADT7475 support bypassing voltage input attenuators on
voltage input 1 and the ADT7476 and ADT7490 additionally support
bypassing voltage input attenuators on voltage inputs 0, 3, and 4. This
can be useful to improve measurement resolution when measuring voltages
0 V - 2.25 V.

This patch adds 4 optional devicetree properties to the adt7475
driver, each setting the attenuator bypass (or clearing) on a
specific voltage input.

* v4
- fixed a small error in file adt7475.yaml (duplicate property names).

* v3
- removed the functionality to set the global attenuator bypass.
- added functionality to allow bypassing voltage input 1 on the
	ADT7473 and ADT7475.
- added DTS definition file adt7475.yaml and 4 new properties.
- added the previousely missing newline character to the end of
  	file adt7475.c.=20

* v2
- removed sysfs changes from patch
- removed adt7475_write macro from patch and replaced it by using
	the i2c_smbus_write_byte_data function directly in code.
- removed config4_attenuate_index function from patch and replaced it
	by modifying the function  load_individual_bypass_attenuators
	to use hard coded bit values.
- modified function load_individual_bypass_attenuators to use 4 if
	statements, one for each voltage input, replacing the for loop.
- modified function adt7475_probe to check the device is a ADT7476 or
	ADT7490 (other devices do not support bypassing all or
	individual attenuators), and only then set the relevant bits.
- added new file adt7475.txt to document the new devicetree properties.
- removed c++ style comments.=20

Logan Shaw (2):
  hwmon: (adt7475) Added attenuator bypass support
  hwmon: (adt7475) Added attenuator bypass support

 .../devicetree/bindings/hwmon/adt7475.yaml    | 90 +++++++++++++++++++
 drivers/hwmon/adt7475.c                       | 76 ++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml

--=20
2.25.0

