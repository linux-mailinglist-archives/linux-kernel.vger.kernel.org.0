Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775EC8EF68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 17:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfHOPeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 11:34:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38874 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfHOPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:34:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so2591094wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cItIjPaZNW0gDFR2/8t+2jjgRX6wobUwIJOP4x+pnhk=;
        b=Lkdny2521+c84pQQGWqqj0XX2HECgnYwJZxQ5A1qAO5pth/PKS8sjH9+X5wS/uxmPR
         1UDjYqdEiMNNQxxFVI5Mh8kXGxL7sFN3R+aQB/fIL3j66Y+slqC/1kc1I3+OgX6ZFsIQ
         yWG3S44jbT79v9SdCH/B8wfUeJnu/YhmQRYqtl9xyBg9sqD4MH25341N+T41KUgj3Bws
         7DDt2B5e2KaSW8PBGGE6daFOjg2eguRsFS1D4vz52z5ENRiHygMMGDJS4fbtUQK41Wxj
         U5UEjwraeteD1Cq2YJLzN8g8vk76EAohXdQt4ZezCzef3eRI+qRImxrhDdOA57Gy2dQg
         8bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cItIjPaZNW0gDFR2/8t+2jjgRX6wobUwIJOP4x+pnhk=;
        b=N/5CEqUjM1ElnQpgYbwvUHYuy4D8HZ/8bQCl9vFH5lEiwIy/YPR8ulNumJ2zd34lns
         FjjlhUEmHkwwuQdY27e5ch52CPmDNh0PRaSS79povUUlhXrc7HPx+h7yqGUrWupxl/xO
         VQRHJncsZiHVsxaJfJXIp6q05d+6ryASzrpkMOBbo0WOW3cIKQqXWfCJSS0rHjCdGFWm
         eNV8g2Zqu22Yzy08cmt0hxKTcB+lrA/a7L0D8awJu6n2yEjkh5Zw9ykM7Pf7oIlYjcd3
         X6O6HPcSIrX0cp2n7WbJGrYHDEaQ/+i+ZfBa273MP3Ycf1dIIzFz+mbsl3MlB3IxeOCG
         3qLQ==
X-Gm-Message-State: APjAAAVR4gUmxLAMc2VZS1SaXL8n5WalmUl/Dt9lgjSSipH+QAEo2qxZ
        WX/ZGFPNDjp54KfV0K2Ifp8=
X-Google-Smtp-Source: APXvYqx8TEvvd2kToStAl2/G5h/i/bhwculFy4DWx4KSvuVNYvwcXTNGplwbIH22cYHPGaaekwWkrQ==
X-Received: by 2002:a05:6000:1284:: with SMTP id f4mr6312213wrx.89.1565883246514;
        Thu, 15 Aug 2019 08:34:06 -0700 (PDT)
Received: from gmail.com (82.159.32.155.dyn.user.ono.com. [82.159.32.155])
        by smtp.gmail.com with ESMTPSA id k9sm2518281wrq.15.2019.08.15.08.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 08:34:06 -0700 (PDT)
Date:   Thu, 15 Aug 2019 17:34:03 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masanari Iida <standby24x7@gmail.com>,
        Mans Rullgard <mans@mansr.com>,
        zhengbin <zhengbin13@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.3-rc5
Message-ID: <20190815153403.GA27385@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these few fixes for auxdisplay for this cycle.

Cheers,
Miguel

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.3-rc5

for you to fetch changes up to 6c4d6bc5486466e3a67cc47270001d0b4a26eed4:

  auxdisplay: Fix a typo in cfag12864b-example.c (2019-08-08 20:00:18 +0200)

----------------------------------------------------------------
A few minor auxdisplay improvements:

  - A couple of small header cleanups for charlcd
    From Masahiro Yamada

  - A trivial typo fix for the sampels of cfag12864b
    From Masahiro Yamada

  - An Kconfig help text improvement for charlcd
    From Mans Rullgard

  - An error path fix for panel
    From zhengbin

----------------------------------------------------------------
Mans Rullgard (1):
      auxdisplay: charlcd: add help text for backlight initial state

Masahiro Yamada (2):
      auxdisplay: charlcd: move charlcd.h to drivers/auxdisplay
      auxdisplay: charlcd: add include guard to charlcd.h

Masanari Iida (1):
      auxdisplay: Fix a typo in cfag12864b-example.c

zhengbin (1):
      auxdisplay: panel: need to delete scan_timer when misc_register fails in panel_attach

 drivers/auxdisplay/Kconfig                     | 5 +++++
 drivers/auxdisplay/charlcd.c                   | 2 +-
 {include/misc => drivers/auxdisplay}/charlcd.h | 5 +++++
 drivers/auxdisplay/hd44780.c                   | 3 +--
 drivers/auxdisplay/panel.c                     | 4 +++-
 samples/auxdisplay/cfag12864b-example.c        | 2 +-
 6 files changed, 16 insertions(+), 5 deletions(-)
 rename {include/misc => drivers/auxdisplay}/charlcd.h (94%)
