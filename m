Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA216BCDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgBYJAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 04:00:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33517 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgBYJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:00:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id m10so1728014wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 01:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vn4rZGzk+IAH+nxFswZJCGBxbGSA0YI3EXXacsRbD08=;
        b=lQKlfzSBMr6+Iyq1U8QB2M4CNB9uvrNtci+HBZTL/I4Qo5menq2+zDW4TqHl+cCY0w
         54CAtPTyp7TR3wF8P++z1IuSs/tnTuKvLgn70iWfxef1owUQQepqcJOx4zNTwe3jWdK0
         OzZ+M5wZOReDYecL9wivW1Tin+NDEI1Z6IlXimgglU9IInF6Ebq0wRekEPMu04dgy3Vk
         V/2RTYH2Qs1W4tMcx401cHUxJ2E11fUelpmH69e6+ZKfskNyocFde7WA7WiaqNmW1sdw
         KtHPUTeRHCg8t4hSVA55LfZdTBayB+aA8QGwpCucpRRBZ0JhRJiU1P0M/uV5h2gBvBK5
         s5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vn4rZGzk+IAH+nxFswZJCGBxbGSA0YI3EXXacsRbD08=;
        b=eTh5QikRbrL1NqgQ+UnN3NDXg0zV34HfTCrMWdfq16bWXz0rpOzo6BvBVwQKttgR7A
         bLRhGv/eqNX7N1fM3h6wmoa9qNtrTeO195dEaVQpWCXSXl5sKcb9p//PeungBYwmx4Lo
         PxLsx5wPVWf5NQUKao4vGr/UURVuiGR466TS4nRuIlCvjshDPdEm409lU+O59lu4o8e/
         zDUAWs8cL8QkCETrkct9mZPHkCLksZVfr0c3cUDulOTpY1khQoZJl6MoecVr8zKhIEJ1
         3iqm1uCx/hgykadwHibWHY6ZHO/s/pSmnQyg2Uia9pzEf5vkjLpdM/Q3LUS/GnOvC92R
         H9pQ==
X-Gm-Message-State: APjAAAXrTdjZTRID4Hrkw0GdvugU/GWxLT5/F3dTgEQQAOiATSBesxYM
        9qQuwvJfYZ73BoRu5T0tJWOVLA==
X-Google-Smtp-Source: APXvYqwnbRU6uWCX1oIuC5o2BD9NzbI9iIQCmIV4naL5tZmKiHJH+4Za2QhGieEJuOCl5HIpwSNrhQ==
X-Received: by 2002:a1c:3906:: with SMTP id g6mr4241872wma.49.1582621232288;
        Tue, 25 Feb 2020 01:00:32 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x10sm22346431wrv.60.2020.02.25.01.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2020 01:00:31 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Durga Challa <vnsl.durga.challa@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: zynqmp: Fix GIC compatible property
Date:   Tue, 25 Feb 2020 10:00:26 +0100
Message-Id: <a50412fbb520954e4602f274f19a7ffbd1154ead.1582621224.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtbs_check is showing warning around GIC compatible property as
interrupt-controller@f9010000: compatible: ['arm,gic-400', 'arm,cortex-a15-gic']
is not valid under any of the given schemas

Similar change has been done also by commit 5400cdc1410b
("ARM: dts: sunxi: Fix GIC compatible")

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 1ebb540624de..cde6025b7e24 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -233,7 +233,7 @@ amba_apu: amba-apu@0 {
 		ranges = <0 0 0 0 0xffffffff>;
 
 		gic: interrupt-controller@f9010000 {
-			compatible = "arm,gic-400", "arm,cortex-a15-gic";
+			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
 			reg = <0x0 0xf9010000 0x10000>,
 			      <0x0 0xf9020000 0x20000>,
-- 
2.25.1

