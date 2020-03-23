Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2418FCEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 19:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCWSpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 14:45:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41254 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgCWSpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:45:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so18426565wrc.8;
        Mon, 23 Mar 2020 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LCaz4zZs1aCSOHSQ8R4NAVFFxp0HA9sa68+Q6bJNoEg=;
        b=Z2L0NHm0/DP66X60AMkTybtIvDblGHTTE+O/O3GWrMWgq9KHUQg9aw2nYX4rbUuK0C
         ZWQb+9CWIfE/IkSDHHXb/uWNgctO93j/x77wbuhMlXxtX9r3xu9PAyskYU4ejiI+TBs8
         oj2uKOjUelFpifS/emDmr/+LKjJSoLjosqEnGBac4ps9U6RPrs5gy91i0yujS3tvRjD5
         ntn0Si4VEbBPXf71n1KVdY5IKUI/G0w8e89lwEOwqACzz2TKS8bO+MRt/spbnbWIizkD
         T3n21W7em2wXGSPWlyv8NpFZcSmKfH29kzDrPV3Gno0DvF1Cpyv7GaEm+6wU4jty7qio
         jNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LCaz4zZs1aCSOHSQ8R4NAVFFxp0HA9sa68+Q6bJNoEg=;
        b=YuisvLHYbQ2maucHslaTosEEqPjovGRKIYgSdaPGC56iM+G2vfC2EmLR5tKXJAipyt
         2dVsXLcJRTtbg/r2uA2qlywgSDXWvVYSBw9p1cq0ZRlrYiNkruEdyqkHm+X5rxSdBaA9
         tpRqSSllNcaAm6Vvr43hElRaMLuTjZGOGAZkPmTLtTeGbhRX/QDAZtRLspW60viU2FvT
         M6da/yUBTlk0E8v4KPnALhSCs3pDl30M99R0YyJlcqKVmjaVI0xB2+cVouxKsUqbCH/O
         REJN1J33uu6W53JG9ZrsKo2OvLhrzXD+Oqtqfy5EFasqec+XVfcqxgIkrUKVnNlCqdUR
         PsWw==
X-Gm-Message-State: ANhLgQ0ofvjney9+1fH6tpcVFhTqjGir8x2QfcohxiiAw7sqCNy15vGE
        zKpt924KZbVSxPx1eCZP99s=
X-Google-Smtp-Source: ADFU+vuW4HLuD0FDasodB1FXs8xARXjsr4HrDo5pYrVBJfdjyyLH327SzcH+ukRJyO07PQOXdNMtNw==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr16928921wrp.176.1584989112212;
        Mon, 23 Mar 2020 11:45:12 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2df6:1a00:4528:2a39:b5c4:c34d])
        by smtp.gmail.com with ESMTPSA id 195sm633235wmb.8.2020.03.23.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 11:45:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entry to ICST clocks YAML schema creation
Date:   Mon, 23 Mar 2020 19:45:01 +0100
Message-Id: <20200323184501.5756-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 78c7d8f96b6f ("dt-bindings: clock: Create YAML schema for ICST
clocks") transformed arm-integrator.txt into arm,syscon-icst.yaml, but did
not adjust the reference to that file in the ARM INTEGRATOR, VERSATILE AND
REALVIEW SUPPORT entry in MAINTAINERS.

Hence, since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches \
  F: Documentation/devicetree/bindings/clock/arm-integrator.txt

Update the file entry in MAINTAINERS to the new transformed yaml file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20200323

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07888a277f6f..69e94d712e8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1297,7 +1297,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/arm-boards
 F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
-F:	Documentation/devicetree/bindings/clock/arm-integrator.txt
+F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
 F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
-- 
2.17.1

