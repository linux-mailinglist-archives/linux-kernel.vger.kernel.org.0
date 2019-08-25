Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D5B9C17A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 06:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfHYECW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 00:02:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41811 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfHYECV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 00:02:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so12100056wrr.8;
        Sat, 24 Aug 2019 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nWmRqjrC+TU28eDb3UcDIF7I87vLorA/ZMl1z/jnRWg=;
        b=NvpEkAddyUAnizZzJTz3P6sWKPGBsBTDPTnWKQ484X6BBjODpQL5c00mdXFJmw6q8a
         eba+zk4zJx2Mi2VV3QrELx59CX9y89QXI5dn8NuhinT/TIaKrl/7piYUI3pKSfjVtIaG
         N02e/uQkZ2T1go8wZvX2oSbhs/BBUPnhxtkJtEcFt1mbA0qU+3SJ9tv6G0PWDQr0n6xp
         nAS7EuCZC/YUHpK8A0hLD679Jt9kvLOs6TxwFGkRf47NXbSmRGZZ4TwSkXnECkkPMS4Y
         JnnCmTLXdIv0VOIRpW0efZNpSSUOJMpDVnxtdt+naAC7vGYDkPuiaInwWEEDKXzvwIcs
         bUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nWmRqjrC+TU28eDb3UcDIF7I87vLorA/ZMl1z/jnRWg=;
        b=cyHV0kou4gOjc5gPgkWZSU97tNqttgttcJPy0MmijZe9aewGhACaCUQkYH1zLHsnay
         +rEfc1ebKfU2JEKRobgxSfScMw8oeP1ndCd4dYNuQndbwQsiTTK8YilvACLp49NclpzV
         qe6oc6BsAN+LnuupIjVhbYD3lFnAdVC2MPdGesL38u6ubEEXEH0v2lrhL1IrBFsV1wxk
         fGPOBGkiix2zlORNKq40grGx2I+I4MJmnc0QqoykO9y1TxsS1neSduEchKwHed9LpBlU
         DNN95twmPriyAjXFaZQhkhPw/KVy8aUm54aWytLIP4Nzx1rEkn+hHJU6vOO1/S+zngMK
         pJGA==
X-Gm-Message-State: APjAAAVTAcbPGSfxDWXDQIBGegs/euCoU2+SGGRA8+KJmkqj0DzD3hEN
        zrhZb/gKp5A5/gVshUHrXYA=
X-Google-Smtp-Source: APXvYqyyGTaMrndxI5ko5zR9b9GuYjLRGxkOVAdm1bHns/2lhqPy7lRlR8gHlGgioXmGtodHRAs/2g==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr14839913wrq.63.1566705739289;
        Sat, 24 Aug 2019 21:02:19 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a6sm6820985wmj.15.2019.08.24.21.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 21:02:18 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/7] arm64: dts: meson: ir keymap updates
Date:   Sun, 25 Aug 2019 08:01:21 +0400
Message-Id: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds keymaps for several box/board vendor IR remote devices
to respective device-tree files. The keymaps were submitted in [0] and
have been queued for inclusion in Linux 5.4.

The Khadas remote change swaps the rc-geekbox keymap for rc-khadas. The
Geekbox branded remote was only sold for a brief period when VIM(1) was
a new device. The Khadas branded remote that replaced it exchanged the
Geekbox full-screen key for an Android mouse button using a different IR
keycode. The rc-khadas keymap supports the mouse button keycode and maps
it to KEY_MUTE.

[0] https://patchwork.kernel.org/project/linux-media/list/?series=160309

Christian Hewitt (7):
  arm64: dts: meson-g12b-odroid-n2: add rc-odroid keymap
  arm64: dts: meson-g12a-x96-max: add rc-x96max keymap
  arm64: dts: meson-gxbb-wetek-hub: add rc-wetek-hub keymap
  arm64: dts: meson-gxbb-wetek-play2: add rc-wetek-play2 keymap
  arm64: dts: meson-gxl-s905x-khadas-vim: use rc-khadas keymap
  arm64: dts: meson-gxl-s905w-tx3-mini: add rc-tx3mini keymap
  arm64: dts: meson-gxm-khadas-vim2: use rc-khadas keymap

 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts         | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts       | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts       | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts     | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts      | 2 +-
 7 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.7.4

