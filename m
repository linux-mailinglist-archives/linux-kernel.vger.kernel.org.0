Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F214E114988
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 23:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfLEWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 17:54:36 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37790 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfLEWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:54:36 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EEEBA891AC;
        Fri,  6 Dec 2019 11:54:33 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1575586473;
        bh=qYgExmNdCtwcDRSQc66QwJiOOORpb2mDrAtzNfPON4A=;
        h=From:To:Cc:Subject:Date;
        b=Pv0tEj3LeqkBz1P2Cd8eeBjVBIAeTTvCqn+1pL8nR2OxR3Xxk7LoKZuviVf1jCmnA
         gU9U9nd2Dw9EKQwzvb0r/GbW2YSi7WjZjD3cQrOAGGE3JJ2y5ae9Ho+wg71zh8bs/2
         4EDmJBnA4aFoK4v6ZzYg1WtEux1tl5BZYuV8WcJY8OkDesXqqQT4r4SP9qsND9+VEm
         Bu+7pBzMixuMX8lSGZxVSqXSQliMAKTWAvj4S9mbngbTg2meTlvfTrVl4g0aB6AziU
         H+P6VyK5SWZqyg/bgIpkV/NxCYa8+7pXRbCFg25xnPtXi/ZCNDgxKZaNFkRpdb/YuT
         86XWUJzqJBDfA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5de98aa50000>; Fri, 06 Dec 2019 11:54:33 +1300
Received: from luukp-dl.ws.atlnz.lc (luukp-dl.ws.atlnz.lc [10.33.25.31])
        by smtp (Postfix) with ESMTP id 1BD2413EED2;
        Fri,  6 Dec 2019 11:54:29 +1300 (NZDT)
Received: by luukp-dl.ws.atlnz.lc (Postfix, from userid 1137)
        id 3910426187A; Fri,  6 Dec 2019 11:54:30 +1300 (NZDT)
From:   Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (adt7475) Make volt2reg return same reg as reg2volt input
Date:   Fri,  6 Dec 2019 11:54:30 +1300
Message-Id: <20191205225430.14959-1-luuk.paulussen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg2volt returns the voltage that matches a given register value.
Converting this back the other way with volt2reg didn't return the same
register value because it used truncation instead of rounding.

This meant that values read from sysfs could not be written back to sysfs
to set back the same register value.

With this change, volt2reg will return the same value for every voltage
previously returned by reg2volt (for the set of possible input values)

Signed-off-by: Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7475.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6c64d50c9aae..5eed7dd2f16d 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -294,9 +294,10 @@ static inline u16 volt2reg(int channel, long volt, u=
8 bypass_attn)
 	long reg;
=20
 	if (bypass_attn & (1 << channel))
-		reg =3D (volt * 1024) / 2250;
+		reg =3D DIV_ROUND_CLOSEST((volt * 1024), 2250);
 	else
-		reg =3D (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
+		reg =3D DIV_ROUND_CLOSEST((volt * r[1] * 1024),
+					((r[0] + r[1]) * 2250));
 	return clamp_val(reg, 0, 1023) & (0xff << 2);
 }
=20
--=20
2.24.0

