Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B098618C33E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 23:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCSWse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 18:48:34 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38499 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgCSWsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:48:32 -0400
Received: by mail-pf1-f202.google.com with SMTP id f14so3056060pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p2FECenFo/SV+lvmBUFJN/N3tCfRxwr2b4eodVl25VI=;
        b=a3I+KiTG8nWWCWq5o/hbNf7tgyx9XDAThb0tz5gwUfh0lfIOPV14Y+uE5vbEhILmxN
         xkAUviA4XsZ6iaKNhkGwT+Asbp+hEu/fyIVBR8Zroy967ppdGOV9aVyvD8HVoKpZRXkI
         b7/axSYnJ87E4WNgdOeBRJS7oeBQbPBXSAijU+4JTuPtzhaKm6TifdtGeHdBKV+6nA5x
         /kfXfwsPxHTPKl28em94wM71Ug+hSPn26/Fh163ZsHYgliNWvAxA7ZIBhtp9zwBKnSuK
         k9x6fHhO8VJ7k9i159tiGWe/STUBqXq7Blv3A7H+ZZYf877JDX228pSNax2iTD2avlAW
         m57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p2FECenFo/SV+lvmBUFJN/N3tCfRxwr2b4eodVl25VI=;
        b=VUfrgI4tyHXTKD8yLokKdmHU5EcjMkQOaoWMRWiwj36NUvccg4XgrSbktvSms3mr6U
         X393vooh1ROpQal7+EsoF6cRx7z1vMwq74+1G3luaqO/lwLGw173z/j+IkRm3ZsO+2kp
         JB02PDDXgt5KxDGXzg881bjaJLFZBaz1xkhWW+7qsTHyBmPxrgqmjMZGgULkorpS52Rt
         tdkI2DGVmOB/ZLALnW7S4FRJKDJCIChUeixfvciDJO4QFqLTFsQ/+BRBOGOIcKXPvPvY
         pXRe996eazJSJqGyHhkIPgeT504msmTdXc07riPAYhJ+AyhlVlnZSVbeDvRLeg766rZJ
         NQow==
X-Gm-Message-State: ANhLgQ0uhrGFbYRSzlspfpPGQVVd2lQKA56K51FyW+jj8QA2l/Swt13t
        up3TyW24r7uAU44yW8cFB6cqhogFrw==
X-Google-Smtp-Source: ADFU+vsiwSXNqmafTIi8B+BiMHfBtFjBqB+UtENXanP1PQfB14qdA7ZVWXrhzSCXbwWiNFPLFow4n0qFDA==
X-Received: by 2002:a63:c54b:: with SMTP id g11mr5703406pgd.164.1584658111321;
 Thu, 19 Mar 2020 15:48:31 -0700 (PDT)
Date:   Thu, 19 Mar 2020 15:48:12 -0700
In-Reply-To: <20200319224812.202013-1-kunyi@google.com>
Message-Id: <20200319224812.202013-4-kunyi@google.com>
Mime-Version: 1.0
References: <20200319224812.202013-1-kunyi@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH linux hwmon-next v1 3/3] dt-bindings: (hwmon/sbtsi_tmep) Add
 SB-TSI hwmon driver bindings
From:   Kun Yi <kunyi@google.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Kun Yi <kunyi@google.com>, openbmc@lists.ozlabs.org,
        joel@jms.id.au, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for AMD SB-TSI emulated temperature
sensor.

Signed-off-by: Kun Yi <kunyi@google.com>
---
 .../devicetree/bindings/hwmon/sbtsi_temp.txt       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt

diff --git a/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt b/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
new file mode 100644
index 000000000000..4020f075699e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
@@ -0,0 +1,14 @@
+*AMD SoC SB-TSI hwmon driver.
+
+Required properties:
+- compatible: manufacturer and chip name, should be
+	"amd,sbtsi",
+
+- reg: I2C bus address of the device
+
+Example:
+
+sbtsi@4c {
+	compatible = "amd,sbtsi";
+	reg = <0x4c>;
+};
-- 
2.25.1.696.g5e7596f4ac-goog

