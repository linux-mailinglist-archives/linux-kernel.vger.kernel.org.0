Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B77A4139098
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 13:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgAMMCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 07:02:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33717 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:02:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so3762531plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DYs+syI7/SggFEh/rAHZyuN4ISx5HPKZ5OTLtFoRYs=;
        b=KcWq76VlIz07Cnlns+46LgH7VBnlI1yDBotQcnPtxI1GBCjIocVo25k4wWZGx2EzLa
         YMvTvvTlRwWjpekoek5PXcC98/cCZ8ouBGninGg6KsT3/PCFpY7fhIdD3wGPJnTurSlc
         4eaMK0rZPGeZxSlq7eENPexztJaQjvg75QR6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DYs+syI7/SggFEh/rAHZyuN4ISx5HPKZ5OTLtFoRYs=;
        b=d6Gb+Xq5qjrsawnyZXm2YYxx1xr7UZy1W+2fRmMS0VVmPcPwzVqnECbPftu81KpdYS
         ZnZ7TQ0OO0mnS0pyfChzAblGxCH1RE1L1P743QkLv7szcmBQu7EL6EpDo/bOJAM8Su4e
         VDovQ/DhHJVHQl1jf1/KKNQlBkTHq2cTWn8CMKoJuq/aH66uPzxDoHwIFkodtEECe3g+
         3fOs93dQ7dwH4VnROoDZ3denHwNIizad2mr8V4jgaxk6j1hnG3ACZGdeccz+zI/AoKPc
         O5oUPoaNjwUBSV+MpiCv5y6GdKunFFjw/jLw9wQs2luu/DI6ti380MPZAamfA4mcclBG
         eA7g==
X-Gm-Message-State: APjAAAWbnZLS5Fl1rjQRc3Vv32MwHMu5W1QPf9H0BHRn2c9EI+Th1zDk
        rb7ODztlEWlxn31cGAhfkKLHSg==
X-Google-Smtp-Source: APXvYqy7pmry9RsP8XAqY5kEvYUHMGwzm4kIyR45xsEkgvdDZY8HBJYpRBum/S5Wc0HRKCvcN5i5vA==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr22276280pjr.74.1578916937710;
        Mon, 13 Jan 2020 04:02:17 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id z64sm14435324pfz.23.2020.01.13.04.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 04:02:17 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3 0/3] support hotplug CPUs before reboot
Date:   Mon, 13 Jan 2020 20:01:54 +0800
Message-Id: <20200113120157.85798-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a config REBOOT_HOTPLUG_CPU which would hotplug CPUs
before reboot. Architecture code (smp_send_stop) currently would loop
through online secondary CPUs and some may call ipi functions to them.
With this config enabled, ideally we don't need smp_send_stop. But we
keep the code for those don't enable this config and as a backup if
some CPU fails to go offline before reboot.

Also enable this config for arm64 and x86 defconfig as an example.

Change from v2:
* Add another config instead of configed by CONFIG_HOTPLUG_CPU

Hsin-Yi Wang (3):
  reboot: support hotplug CPUs before reboot
  arm64: defconfig: enable REBOOT_HOTPLUG_CPU
  x86: defconfig: enable REBOOT_HOTPLUG_CPU

 arch/Kconfig                      |  6 ++++++
 arch/arm64/configs/defconfig      |  1 +
 arch/x86/configs/i386_defconfig   |  1 +
 arch/x86/configs/x86_64_defconfig |  1 +
 include/linux/cpu.h               |  3 +++
 kernel/cpu.c                      | 19 +++++++++++++++++++
 kernel/reboot.c                   |  8 ++++++++
 7 files changed, 39 insertions(+)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

