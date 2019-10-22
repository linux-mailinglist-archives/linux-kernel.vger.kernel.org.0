Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6BE0019
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfJVI5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 04:57:23 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41247 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbfJVI5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:57:23 -0400
Received: by mail-vs1-f65.google.com with SMTP id l2so10795054vsr.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=s2KncmuUuzkST0SJuWXi9nSQahdWQWGnhsFKkDCrbOE=;
        b=ZrQZqDM/6uZMqHcq6Jrzk84v460OZuoA+j4yg8KVF6g/cXJcgjoYKx/7xef20uUG54
         7//Jf2Ktq7F+0oZtpKtYBt6cmcqVLI+7hs/yeZaQ7WcgKdUb197M9iI4ns0Ay2TNYTdT
         dHsxxSaPnTCBiEzwyZp3bHA2BifEMBUI79j+OudQvANNBIf1K+LWUKKT8kk3hTcKfsW5
         wPgt8Tq1dPpJcpU6ESeV5d0/9w2z7weVeiPdU3b/q7kbVEGjBpLmEjiXur42+2TQ1SDS
         ssmsWzEzKz1kQI92m00QnfDoVm2W0R1SK5ytDmyi+N4cjp9weAITISRGbDdw1PeQJhrf
         NnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=s2KncmuUuzkST0SJuWXi9nSQahdWQWGnhsFKkDCrbOE=;
        b=kl6/S20n+xgFZEeO6m12WzrFsM52TGGyn+8LV4dPPYQU3GQyDnYUa61mOV+V8MD04s
         8II/FsccY8QKi49H4FGnu/cJH+DxqzPixHlSej7NIZ91wPyURwIoPqNrYuKg2vHeNltS
         QG1+k78N/neUnZBCKtIEGxK7ZyNLf9BFK7ECD2I4NV90m0dMA8TpxWCPNhfWFwcSFQjS
         ULNtRRQhcXWUtVhs8W/fIPwLyMKzN2V/8T82693bYiuie39qXE758IPiwu9k1mJb0ta7
         iYAYMD6xU5vu5ttnUavvnU7cyGPJC79ZcxVGZvhZnJXaYgxFqqvNmaN3l7StaP9OTeQZ
         r9+A==
X-Gm-Message-State: APjAAAVn0dXVeKKXmblvKF8JtJJEvBUFyrJZvSt8lO/EZI+RwJ8W2l4s
        74Cjeq6CNf+gpG9U3ZCuswlB5CFdxq9EG3SMWKrJgQ==
X-Google-Smtp-Source: APXvYqzk7Pu2o3BNiXte2DnyH90EBqmbScr/BAoGu0ZdVKx0CGqv6wIpK1d1V0WaZS2dbFQWEpVLG/sVjbCZ2UBxVJg=
X-Received: by 2002:a67:d113:: with SMTP id u19mr1088796vsi.93.1571734642189;
 Tue, 22 Oct 2019 01:57:22 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Oct 2019 10:57:10 +0200
Message-ID: <CACRpkdbiyY9AT5Y8OwMmFgwgvn_DGUFrJVHWbZwyAxnK_bA7HQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a bunch of pin control fixes. I was lagging behind
on this one, some fixes should have come in earlier,
sorry about that.

Anyways here it is, pretty straight-forward fixes, the Strago
fix stand out as something serious affecting a lot of
machines.

Yours,
Linus Walleij

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.4-2

for you to fetch changes up to d6e7a1a5119c4e719b0d63651f09762d7384bfed:

  pinctrl: aspeed-g6: Rename SD3 to EMMC and rework pin groups
(2019-10-16 15:58:27 +0200)

----------------------------------------------------------------
Pin control fixes for v5.4:

- Handle multiple instances of Intel chips without complaining.
- Restore the Intel Strago DMI workaround
- Make the Armada 37xx handle pins over 32
- Fix the polarity of the LED group on Armada 37xx
- Fix an off-by-one bug in the NS2 driver
- Fix error path for iproc's platform_get_irq()
- Fix error path on the STMFX driver
- Fix a typo in the Berlin AS370 driver
- Fix up misc errors in the Aspeed 2600 BMC support
- Fix a stray SPDX tag

----------------------------------------------------------------
Amelie Delaunay (1):
      pinctrl: stmfx: fix null pointer on remove

Andrew Jeffery (4):
      dt-bindings: pinctrl: aspeed-g6: Rework SD3 function and groups
      pinctrl: aspeed-g6: Sort pins for sanity
      pinctrl: aspeed-g6: Fix I2C14 SDA description
      pinctrl: aspeed-g6: Make SIG_DESC_CLEAR() behave intuitively

Andy Shevchenko (1):
      pinctrl: intel: Allocate IRQ chip dynamic

Chris Packham (1):
      pinctrl: iproc: allow for error from platform_get_irq()

Dan Carpenter (1):
      pinctrl: ns2: Fix off by one bugs in ns2_pinmux_enable()

Dmitry Torokhov (1):
      pinctrl: cherryview: restore Strago DMI workaround for all versions

Jisheng Zhang (1):
      pinctrl: berlin: as370: fix a typo s/spififib/spdifib

Johnny Huang (3):
      pinctrl: aspeed-g6: Fix I3C3/I3C4 pinmux configuration
      pinctrl: aspeed-g6: Fix UART13 group pinmux
      pinctrl: aspeed-g6: Rename SD3 to EMMC and rework pin groups

Linus Walleij (2):
      pinctrl: bcm-iproc: Use SPDX header
      Merge tag 'intel-pinctrl-fixes-v5.4' of
git://git.kernel.org/.../pinctrl/intel into fixes

Patrick Williams (2):
      pinctrl: armada-37xx: fix control of pins 32 and up
      pinctrl: armada-37xx: swap polarity on LED group

 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |  86 +++++++-------
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c         | 124 +++++++++------------
 drivers/pinctrl/aspeed/pinmux-aspeed.h             |   3 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |  12 +-
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c              |   4 +-
 drivers/pinctrl/berlin/pinctrl-as370.c             |   2 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   4 -
 drivers/pinctrl/intel/pinctrl-intel.c              |  27 ++---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |  26 ++---
 drivers/pinctrl/pinctrl-stmfx.c                    |   2 +-
 10 files changed, 131 insertions(+), 159 deletions(-)
