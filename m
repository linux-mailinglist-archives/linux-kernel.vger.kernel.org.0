Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0990417D818
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 03:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCICSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 22:18:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41554 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCICSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 22:18:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so3344196plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WLxH7ad0XRd0xt+wbIowBUivNdpU+jvJokFmcSJMpU8=;
        b=ZU5fwAZKIgqaNdwVLrK/Xjt8rxOeawd5ZJVwsFEs+For+lnZYeVydn5MuI74RojCIv
         2UEb/lsPJ4kGmLqJAAPzr1qxL/MdU0UOSdqHs4Lc4MDOK7mPSBYW8gDX1ZQcElM7a4Ap
         Ku2EQpa1/3bevO11AmrDR5Vm78HEZyNfQ5loyg00hCFbI+wqwkapz0jaTyxu9yKsYFHs
         cRT9B5UGzfi4NoR2R0gB6qUafL5rdD/fsqjSw+ijJX3GLgX9vJnbX9w9BIRsSCMLEK0h
         aC7GMkmCIvR01htkt2hvt3i4oYqkqwryP66mWg9ETxIM5gyzLjzrdHAzH6RawjO2LTZL
         fY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WLxH7ad0XRd0xt+wbIowBUivNdpU+jvJokFmcSJMpU8=;
        b=Pm7AlLzN54YWKX0MlAHzwr9LfH30muRkv27ztmeTepD1UsT/SCGLmEPKtlqzxIJmBG
         6qqGiIxnkt9C8B8xr76N0vzGyZEaUkWaYuOVIGzbkks/WUftRUjy+qnOgZbzHBO2PMas
         c8KzqEnA/Q6Q7o5ToNv4fiD1dZRDuKOFU807VFHcZvxbx3RO+tHg8oX3rIE9qV1mZt9P
         iV6vpW+UVIjpBq7IRw+HC6i5Uol/yXB2Rv997y4CMY7yCOlsErTVkxisr+XNlty6dORO
         sph1dC8Vk5Bh/KEVBWoFGv73KIVFHb2xLultHQCZgCFAb0BFUXpbel5d9tt1YIgEOzig
         lZIg==
X-Gm-Message-State: ANhLgQ0MzPRx6PUKxrGSNtgqLqcb4efj5VtCGtshYB2tGyYwWTGhthp6
        9dsObZdHxV95Cx2+A80c4ieIFmpD
X-Google-Smtp-Source: ADFU+vtYEnqD78gBY+v9SfpDf7+QJlaYwfrB0bMuvj/AA3A6369f6DjMWKw8apOPoJXzS4tCsh4ktQ==
X-Received: by 2002:a17:902:760a:: with SMTP id k10mr13733390pll.306.1583720288242;
        Sun, 08 Mar 2020 19:18:08 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id r12sm42394043pgu.93.2020.03.08.19.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 19:18:07 -0700 (PDT)
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
Subject: [PATCH RFC 0/3] clean up misc device minor numbers
Date:   Mon,  9 Mar 2020 10:17:44 +0800
Message-Id: <20200309021747.626-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some the misc device minor numbers definitions spread in different
local c files, specially some are duplicate number with different
name, some are same name with conflict numbers, some prefer dynamic
minors.

This patchset try to address all of them.

To be honest, I didn't try build on arm or sparc arch which some
drivers depend on as I have little experience on cross-compile.
But I still checked the patch carefully to ensure it builds
in theory. Appreciate if anyone willing to test build on those arch.

Zhenzhong Duan (3):
  misc: cleanup minor number definitions in c file into miscdevice.h
  misc: move FLASH_MINOR into miscdevice.h and fix conflicts
  speakup: misc: Use dynamic minor numbers for speakup devices

 arch/arm/include/asm/nwflash.h         |  1 -
 arch/um/drivers/random.c               |  4 +---
 drivers/auxdisplay/charlcd.c           |  2 --
 drivers/auxdisplay/panel.c             |  2 --
 drivers/char/applicom.c                |  1 -
 drivers/char/hw_random/core.c          |  2 +-
 drivers/char/nwbutton.h                |  1 -
 drivers/char/nwflash.c                 |  2 +-
 drivers/char/toshiba.c                 |  2 --
 drivers/macintosh/ans-lcd.c            |  2 +-
 drivers/macintosh/ans-lcd.h            |  2 --
 drivers/macintosh/via-pmu.c            |  3 ---
 drivers/sbus/char/envctrl.c            |  2 --
 drivers/sbus/char/flash.c              |  4 +---
 drivers/sbus/char/uctrl.c              |  2 --
 drivers/staging/speakup/devsynth.c     | 10 +++-------
 drivers/staging/speakup/speakup_soft.c | 14 +++++++-------
 drivers/video/fbdev/pxa3xx-gcu.c       |  7 +++----
 include/linux/miscdevice.h             | 14 +++++++++++++-
 kernel/power/user.c                    |  2 --
 20 files changed, 31 insertions(+), 48 deletions(-)

-- 
1.8.3.1

