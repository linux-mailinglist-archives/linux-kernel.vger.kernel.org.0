Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8520418119B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgCKHRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:17:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44792 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgCKHRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:17:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so649836plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=squBFUjN3FHwduE2kZhvBbwfKol4LXAfrZYrdHNYjik=;
        b=K5VX87u4t54A+svwF9a/rHW7ErlPK7KdQ4IdOs39W5GpUTjd2Fx2fg9ehpzTzIZpXY
         MSvVfbZzx9lmj5dy/gGe3tj7jTwC+pbLhMaf8SdaLyQHs3F89ccZXR57D6XVv6hmexGF
         I/6BsEnALel6CV7MPCsNk7ANfDfZg+nffvunnr1Ya1mpsLK0XeL8Qg/8/1W86hPwBPe8
         GTb+Ikxw3QkV8K3n40BFuBCek7sRLYfZ28DMDUpJMVVbXtu+St1Syh6suGUhnQoIC7aG
         OjWI3rbyknp8mXahTQYkxvOo4Z0iqH2nbg02tdlhHcH1WLwAsKXqHm0aUAULt2vM7cqB
         w/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=squBFUjN3FHwduE2kZhvBbwfKol4LXAfrZYrdHNYjik=;
        b=OnrRqBwCMBCcLlhkBZ36/7I0mjzIOrhFfGmK2WLpOJwB1a0Mzfb717QNwN5BXDhVRS
         PoUjsCXdGFWEfNDX3Q2I483idi2suBj826deZGjQAWENwDwmEyKS/0r+XV8SyFsMKcuj
         qCdbjRNbuLV7ltpPnTrvTu/UENQI4QZMyL94zZqkR1iLXXr969q8TDcTJPQilbJvPsdJ
         tMOfuQI35UCSMNnFFbySebYQ7GVdsi3OzjfZJRA0J0NWapu2pMkLDDWvN96xglSu0z/Q
         3Zm8macbx/OKH/Q51lZXStP6JyZnqYggPHMDbnhzKF9TtPuzRu8OwWKWNDarf7mT5dJk
         n3/Q==
X-Gm-Message-State: ANhLgQ0xUkJt2NKmVoKrElYOkYCltpnt91jkjbCcVwUmwWhcK9QKGMJM
        PsE5fqmtSyxmuR72Eltbxl5aL+ce
X-Google-Smtp-Source: ADFU+vtRqXgD4C6vYsYMSW754u7UjRetxGpaRvgJ9CARDbqc+FdqKioHUdtnXpgQ2Jblj4UIW99cgA==
X-Received: by 2002:a17:902:7c0d:: with SMTP id x13mr1803377pll.93.1583911056029;
        Wed, 11 Mar 2020 00:17:36 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id g18sm4352904pfh.174.2020.03.11.00.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 00:17:35 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        miguel.ojeda.sandonis@gmail.com, willy@haproxy.com,
        ksenija.stanojevic@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, jonathan@buzzard.org.uk,
        benh@kernel.crashing.org, davem@davemloft.net,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH v2 0/2] clean up misc device minor numbers
Date:   Wed, 11 Mar 2020 15:16:52 +0800
Message-Id: <20200311071654.335-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the misc device minor numbers definitions spread in different
local c files, specially some are duplicate number with different
name, some are same name with conflict numbers, some prefer dynamic
minors.

This patchset try to address all of them.

Thanks Willy and Miguel help building test on ARM arch, no new change
on ARM part in v2 so it should pass build on ARM obviously.

PATCH3 "speakup: misc: Use dynamic minor numbers for speakup devices"
is dropped in v2, will process it separately if there is response from
maintainer later.

v2:
PATCH1: keep HWRNG_MINOR name and fix RNG_MISCDEV_MINOR per Herbert.
PATCH2: fix typo error with PXA3XX_GCU_MINOR per Arnd.

Zhenzhong Duan (2):
  misc: cleanup minor number definitions in c file into miscdevice.h
  misc: move FLASH_MINOR into miscdevice.h and fix conflicts

 arch/arm/include/asm/nwflash.h   |  1 -
 arch/um/drivers/random.c         |  4 +---
 drivers/auxdisplay/charlcd.c     |  2 --
 drivers/auxdisplay/panel.c       |  2 --
 drivers/char/applicom.c          |  1 -
 drivers/char/nwbutton.h          |  1 -
 drivers/char/nwflash.c           |  2 +-
 drivers/char/toshiba.c           |  2 --
 drivers/macintosh/ans-lcd.c      |  2 +-
 drivers/macintosh/ans-lcd.h      |  2 --
 drivers/macintosh/via-pmu.c      |  3 ---
 drivers/sbus/char/envctrl.c      |  2 --
 drivers/sbus/char/flash.c        |  4 +---
 drivers/sbus/char/uctrl.c        |  2 --
 drivers/video/fbdev/pxa3xx-gcu.c |  7 +++----
 include/linux/miscdevice.h       | 12 ++++++++++++
 kernel/power/user.c              |  2 --
 17 files changed, 19 insertions(+), 32 deletions(-)

-- 
1.8.3.1

