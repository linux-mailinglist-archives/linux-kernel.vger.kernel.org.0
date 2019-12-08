Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB011634B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 19:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLHSFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 13:05:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43489 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:05:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so13428716wre.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrbyKEPUyhJODwpL6MZk6uOXEO7AfKjtrzxgQThGJVE=;
        b=tOtvps2xdgPd/1jyKlCLBio5DsXVEy3vnppk0Yv/f9a3OJdDHkwvYpDVY5qbjyvXVl
         ZYvaKRXUqKo5flNBkkKapRk46BE25YUTqqqwoh/s8Ax+2iJjbyoOQ/aXwKCFiuGUZvUs
         VDjSZfIJI+ndzu6URsxwSuNzc7nmD6Cy6Hw/77UV0OTpKVMy10Kx/3qn7e83fIt8v9jm
         1j6aJURXBrU0Wi0kP5I81DZ4Qk2g/Gwreb1Tgm4putx11K8ElxKiftuFRuCpUsorAduP
         dFZjdyw01P4z/hG+iC/jCQAgGyeRIdTBLlQmQ9+hDEdN9G4gYmQLkwq3RngID9NkuybZ
         GxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrbyKEPUyhJODwpL6MZk6uOXEO7AfKjtrzxgQThGJVE=;
        b=QhefrZoQ2L4MzKT/EABRAeAZQ0LESPooaO9ghbl4A8PyYu23yCNRFeCfbGEtNTIPPv
         MHC8s776+PrKh15efX+SAb2RzYm1paJB/C0Y7SuEZxNIsFm2HsfcW2PQq9w+Mp56/6ZF
         r3Bd3O9VPN9b/N/0iV86f6YCwGqbpt/qkRGJ1YNUYC7SxCs1yA4Mzypnd0DBwyXDM9ij
         rB0O4ewSEcTBPv5coRLm3abV36QT8hBTxvHrR1ZWcCVZ7V67cE9tIWGqeHNwL7xPVKcE
         uqzkmqZyBWw1ZyfGCS3Q07g4ygkr46Mv0T0WLmqW04HXDcptsw5koHxV9VbmlKFd1VBW
         ej1Q==
X-Gm-Message-State: APjAAAVeSMVnel2y9vAEysj3mjrrDe8rF0u4fbeY93D0Gp36b5pg4NnM
        STiLrePy/BFXSrTTUvpsfy3emzda
X-Google-Smtp-Source: APXvYqz9wd7kfXtCdLV1zh29Di2rYYLEmHEcb9PsQ0KjiqQTKyoqQa9+1756o6yKsX1N8clbMXTGtA==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr28615833wrr.266.1575828341552;
        Sun, 08 Dec 2019 10:05:41 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a64sm11797687wmc.18.2019.12.08.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 10:05:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] ARM: dts: meson: clock updates
Date:   Sun,  8 Dec 2019 19:05:22 +0100
Message-Id: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the XTAL clock out of the main (HHI) clock controller
because it's an actual dedicated crystal on the PCBs.

The last two patches add the DDR clock controller whose output is used
as input for some of the audio clocks.


Dependencies:
- patch #1 has a runtime dependency on my other series:
  "provide the XTAL clock via OF on Meson8/8b/8m2" [0]
  Jerome has already queued this for v5.6
- patches #2 and #3 have a compile time dependency on my other series:
  "add the DDR clock controller on Meson8 and Meson8b" [1]
  Jerome has already queued this for v5.6, but you need an immutable
  tag for the dt-bindings


Jerome: can you please rebase the v5.6/dt branch tomorrow on top of
v5.6-rc1 and provide a tag so Kevin can apply this series?


[0] https://patchwork.kernel.org/cover/11248377/
[1] https://patchwork.kernel.org/cover/11248423/


Martin Blumenstingl (3):
  ARM: dts: meson: provide the XTAL clock using a fixed-clock
  ARM: dts: meson8: add the DDR clock controller
  ARM: dts: meson8b: add the DDR clock controller

 arch/arm/boot/dts/meson.dtsi           |  7 +++++++
 arch/arm/boot/dts/meson6.dtsi          |  7 -------
 arch/arm/boot/dts/meson8.dtsi          | 24 +++++++++++++++++-------
 arch/arm/boot/dts/meson8b-ec100.dts    |  2 +-
 arch/arm/boot/dts/meson8b-mxq.dts      |  2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts |  2 +-
 arch/arm/boot/dts/meson8b.dtsi         | 24 +++++++++++++++++-------
 7 files changed, 44 insertions(+), 24 deletions(-)

-- 
2.24.0

