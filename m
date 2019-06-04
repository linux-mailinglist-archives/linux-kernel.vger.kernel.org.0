Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C60334AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfFDOrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 10:47:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43888 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfFDOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:47:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id r18so7134261wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yt/EFsCTs+eDRjlI5s+86AEQql4J6OURFSWUEUgIwAY=;
        b=baN6M5vHHdMEdDHA0nFhNKLj1v4lrLz/nftyieuU/YsutbB14+ZqYNEpKCERpyYdyY
         KfEROAB6KrYiQaz93M0J8PVgz13m3NGtdNqWJ1xTE5o2foyUiaCSXV1JL/NRcBmGMvii
         Igmta3mK59BorfpKlfs37UGYDEGK5rp0n81uMXCIiOgan1fD60rzo4kR5YisoxmAWia6
         vzGYjx+CQtuzF1TmS9ujEEMpgUpHBYYjhhhq1ssiw9JXBe4+LuEAHms+mXr6Dm/R/pVW
         vXIpo/MBppn4+0+HVYXy4hCWQl4om89a3HrTgOGakjpMG6DfKaviPoF+h4o3KgzIkCQc
         FgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yt/EFsCTs+eDRjlI5s+86AEQql4J6OURFSWUEUgIwAY=;
        b=AiFpxkb6eHRFm+bbZIc4e0SeQBoFSvFQb5cSBGTqam1MVH7N6SADXPHPKUUmrN9Pm8
         Q4hWZZ5RDXUmxcZUCLpp6/tCOH59vilKfQECmc9mGJDnFJARj7T9Ww6nq9NjC0uE1OCe
         +iZpld/SvMeGxII1AiQSnSY66RMNWi0GwWR/zK6+sIAmlGAHoLU5gy8yZ8rRxt2HfuIi
         3p2ZmmqEi+BvnEGDiSW6avwTrAKuMMNn19h4gPtpO+GDRkstVD38Ya26WS0nX1mLivdQ
         nio6U8mR9hL/aYdrXvEGZPWpYcACQ7cY8IZP5uIAK+yliVZ0ry5eMk/BQanlXeJl67Dr
         5mbw==
X-Gm-Message-State: APjAAAXfVEMGJPL6gbGo+Bo3L95XRtArDY62y3sx++xShcZtu3bAKqy4
        Yi7Jj/fxQRW1uX7LNp/WABrtqA==
X-Google-Smtp-Source: APXvYqyK0vyzpLP2eyzKVrPgI3zNMenfqmRUVBELbtN9DV8WNr9ZkE1mQYmA68w6uUDtIpRGyxFb0w==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr6899078wra.132.1559659636696;
        Tue, 04 Jun 2019 07:47:16 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v184sm3649639wme.10.2019.06.04.07.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:47:15 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jic23@kernel.org, khilman@baylibre.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3]  Add support of New Amlogic temperature sensor for G12A SoCs
Date:   Tue,  4 Jun 2019 16:47:11 +0200
Message-Id: <20190604144714.2009-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor.
This driver is based on IIO frameworks.
formulas and calibration values come from amlogic.

Dependencies :
- patch 2: temperature sensor clock are needed [1]

[1] https://lkml.kernel.org/r/20190412100221.26740-1-glaroque@baylibre.com

Guillaume La Roque (3):
  Documentation: dt-bindings: add the Amlogic Meson Temperature Sensor
  arm64: dts: meson: g12a: add temperature sensor node
  iio: temperature: add a driver for the temperature sensor found in
    Amlogic Meson G12 SoCs

 .../iio/temperature/amlogic,meson-tsensor.txt |  31 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  22 +
 drivers/iio/temperature/Kconfig               |  11 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/meson_tsensor.c       | 416 ++++++++++++++++++
 5 files changed, 481 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
 create mode 100644 drivers/iio/temperature/meson_tsensor.c

-- 
2.17.1

