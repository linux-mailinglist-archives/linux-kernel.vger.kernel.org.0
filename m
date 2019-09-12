Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A80B09EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfILIKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 04:10:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33904 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfILIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:10:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so7266354lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P7NzzGg11L1WgkGhr271SvCX8f/Rsb9hDudwdwT0fCA=;
        b=ajTDMmdfwn5UX+d5ejQBWK28wtYqlhBqiZBhyyo1d7EH4QnVlSGSthpPF94JG1ts1u
         4AKBxKZnZoc2yguzP8SwFqFnEf7kZThvviTT4yARFn6IW3KOoxTJIP+KBETzzcVCE20X
         lRqOilUcIEi1rbYoyMDOmpFzRW94FQd9IBGOuE2r7jeIn+yHruPy/3UDpI9iXsDRT5qs
         ojPUxfYujzU4BAdjvtfk6dXQttk6r7g8dzEDFEcUJ8bgDDBFL3v1/h1ZgFec1bp7iUvv
         JJ1LKyVMbUFXNG5piF2UMuPPEStF1dKu6KzRRISxvaIIs3cTB/UixJgrtNgWpWbmvxBk
         iFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P7NzzGg11L1WgkGhr271SvCX8f/Rsb9hDudwdwT0fCA=;
        b=fBgqLPJDf+7CX4zxWogoNPDipcmemSyHNpoh+VjJCIZ6t4akq765523xXHWjdl0QIW
         xAv4QPUKgysmi/7ZRPfLulXgYWciTS0wni7rdGEYDMUofHK0qtZuAxA8Y78W9HGEC/uW
         Krzql7+pVqfLZ8iiRzCikMuQ1CVtItcrV4E3nOsCsPnY8z6vHbG2XE0p9pcHHkvbOGJ3
         cdKHLyf3jUAJ5pm3r9bOHDLGfFCS9UrMOX4jWJaX5Jc0cOXqBX/kMOCTpCBWi2nCi81K
         oAyXoR29iWiSTLsg4S8BrgR0cj6KaehdqESVESwvPRTulUgWB7EVlp73DGtGnZeEg7SX
         7++w==
X-Gm-Message-State: APjAAAWNAkAx5DTQtLvYbcg/QmNv5EvljPT30Ksr0ebvPhrwQ4oV1JdP
        EPqAWm4UhrbwBPodrvgih4FQGvSWCnKIJzhg5n06tw==
X-Google-Smtp-Source: APXvYqwyEw+nwxXxUdrq0Oo0KcwsWs9CUJUX5FHdQpSJ5n0/6fskRV5YuggZ49ndyydr6NdwgqdefbOCuuQr3ymB+WY=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr27289496lfp.61.1568275822130;
 Thu, 12 Sep 2019 01:10:22 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 09:10:10 +0100
Message-ID: <CACRpkdbZE2dwmaE2-NF_p6XQodBb=34tOxyDgfbAWjiirTgj+Q@mail.gmail.com>
Subject: [GIT PULL] final GPIO fixes for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I don't really like to send so many fixes at the very last minute,
but the bug-sport activity is unpredictable.

Four out of three are -stable material that will go everywhere,
one is for the current cycle.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.3-6

for you to fetch changes up to 61f7f7c8f978b1c0d80e43c83b7d110ca0496eb4:

  gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot option and
blacklist (2019-09-11 10:46:54 +0100)

----------------------------------------------------------------
GPIO fixes for v5.3:
- An ACPI DSDT error fixup of the type we always see and
  Hans invariably gets to fix.
- A OF quirk fix for the current release (v5.3)
- Some consistency checks on the userspace ABI.
- A memory leak.

----------------------------------------------------------------
Dmitry Torokhov (1):
      gpiolib: of: fix fallback quirks handling

Hans de Goede (1):
      gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot option
and blacklist

Kent Gibson (2):
      gpio: fix line flag validation in linehandle_create
      gpio: fix line flag validation in lineevent_create

Linus Walleij (1):
      Merge tag 'gpio-v5.4-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes

Wei Yongjun (1):
      gpio: mockup: add missing single_release()

 drivers/gpio/gpio-mockup.c  |  1 +
 drivers/gpio/gpiolib-acpi.c | 42 ++++++++++++++++++++++++++++++++++++++----
 drivers/gpio/gpiolib-of.c   | 27 +++++++++------------------
 drivers/gpio/gpiolib.c      | 16 +++++++++++-----
 4 files changed, 59 insertions(+), 27 deletions(-)
