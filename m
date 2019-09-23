Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFFFBB5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437469AbfIWN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 09:58:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33700 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408325AbfIWN6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:58:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so15071050wme.0;
        Mon, 23 Sep 2019 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZSlSPovVH1C68HHuoR4mSQt38eq8rnNz8O+7+IIEJig=;
        b=QPSSJfL1aOg0nq6EnFGDAX7XlU42tnIVmczj8rIsX5h7ye7qZAzW8HgeCcRbIaYivD
         leHtKefJX9inNLpsg29zoSbZUAsu1Ztb/Te8kGNOMzUVGx5DuI01caxEPmBZsw4MStt4
         Sy+SzOMjP64BXgLzwKjbpoji3L4ERPu+ZcP/+5NJkfJ8iL+lxhStreaTfWYJlYCx/lYo
         ZLv3U2z9hxt/CJHrJeixWhrIBR5l5Lluf4qYKIS/D96ewEHBNARanlno6tQtkieattru
         mOklnv3Twz5Xx4lN1XAyRKm1f2PZihr7o3ELGBtHmD8As09NSWZEW79Y6UGGyX8T8X+f
         XeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZSlSPovVH1C68HHuoR4mSQt38eq8rnNz8O+7+IIEJig=;
        b=VmFV4tiLHRH49XLV4wiEinLU0b5/b2iL+H1EcTx7mNztP7EhS3GNHTBO+7VICBwOH8
         SX9xZqZDc1AbO5QTwylelPd7ZH0l8ZRobC6HolOK8ChiXugwb4vxn+hBdXYzP/LgONta
         2OoMmh/VAgi2/+LFvLodofj6qZ0XS+XDe05NAudNmHK/nioKbZ0HO3l0ScCLCizBMS0A
         aimBwe4yiXzkHM38zuVJH4LtgbK8hi1YyacouAGwAl4lYrX6dUY9GEQRqFDrymvsP5u2
         EVndoSTWXm0tl35OrJ5mX6WTVcaNEKCBYmcF5ulaXaC9o/pYvoNexQvD7th67M8whvUX
         qZ/w==
X-Gm-Message-State: APjAAAVY+zE4WDMiWHe4ZU0Ctg7XN8pAosAZSlCDHnOsipbVGinlcYpX
        9LMbiQWU2wE79Ft9sEbcQeo=
X-Google-Smtp-Source: APXvYqx354pK1bP9ANp8dSug8kkg4bI3GeLLbi+p/0E/n8GXT82lX6mUk9A81nyGuEqzAyLDF194Zg==
X-Received: by 2002:a1c:b745:: with SMTP id h66mr13360541wmf.70.1569247128568;
        Mon, 23 Sep 2019 06:58:48 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id h17sm25266184wme.6.2019.09.23.06.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 06:58:47 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleg Ivanov <balbes-150@yandex.ru>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 0/3] arm64: meson-g12b: Add support for the Ugoos AM6
Date:   Mon, 23 Sep 2019 17:57:54 +0400
Message-Id: <1569247077-5212-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Ugoos AM6, an Android STB based on
the Amlogic W400 reference design with the S922X chipset.

v2: correction of minor nits

v3: address regulator and GPIO corrections from Neil Armstrong (using
schematic excerpts from Ugoos) and related v2 comments from Martin
Blumenstingle. Add acks on patches 1/2 from Rob Herring.

v4: address nits from Martin except for the vcc_3v3 node as it's not
known how to handle the vcc_3v3 regulator managed by ATF firmware, so
it remains untouched/undeclared like other g12a/g12b/sm1 boards.

Christian Hewitt (3):
  dt-bindings: Add vendor prefix for Ugoos
  dt-bindings: arm: amlogic: Add support for the Ugoos AM6
  arm64: dts: meson-g12b-ugoos-am6: add initial device-tree

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      | 557 +++++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts

-- 
2.7.4

