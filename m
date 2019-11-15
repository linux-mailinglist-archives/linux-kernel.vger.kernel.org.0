Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51CFE274
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfKOQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 11:16:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35492 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:16:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so11613648wrw.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4luxsISSnCBqbzNTIVaYf8SLEEQ3p09RVfNsyHSAmEQ=;
        b=JAd4UxKPFZPCjgRodJj4niKQ8jsOZobx9jfLQUg9CVwzDrQWRSnWts4bZfE97FudZR
         xIInMWMrOROwc5Ccpngr7MKtFMGcBvwl2VOyaB/l586VL2oUg+F+BAJABgcmE3K6boGe
         6X1b+F2mrJRB4IUEyXM+PDjY2dEZBoAqgYliu/0Pe72ora0F+CVG16T1nPpDGBeU3u5S
         SogqlDTN7wo/wben8inQ7N2kRzFPREaNCx7Gi7radMtCuXaspUkCvVopUfKRTvs5P9La
         wKrrvna+HomAFvN5ozoO12Vg1o97WXwPfg5tKLAAb7hII5bCWvHdRZP7KQ9oOiAuN99F
         /mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4luxsISSnCBqbzNTIVaYf8SLEEQ3p09RVfNsyHSAmEQ=;
        b=UUTpd7N4dWvkt3C+ND97nFtGAliI54E/Wx7wFg0yE2SWB8OX3KrPL0mk7+v3ok65hj
         A/YdKkUQPV4o4zlCccBIt7KNi4ODnZk6oYvL7fHUD1AFzrIb8j60NcZdHBDA96z7ucHO
         Z60ketaWIGW5fKf3nQUBnRwq0GkIB3usSkXnFEP7ATX52NppY9ZJls8ycE+1tcnScSkT
         cTHzFzR0aaJuQ5Q40a7tYIBDMpRlXBJkpZxbRHUDaivjdU8cbn7Lus3HlARVn0sytebL
         bynjRKgH5+M/m1NNmuTyKIwD+BGq396DelWr25b1AxBp4sF/lXxTUT0eYUgQZJrXccfd
         tGsg==
X-Gm-Message-State: APjAAAWQzVFQJw8qBKAov/76hyIU5yGh42s3VmvAFBfxGZNkNi8RwsVW
        vvyGUzI1lt4zSyNvArXJDBV+AhEqATq3Issx
X-Google-Smtp-Source: APXvYqzA2m9PGnyAs+D2GCqGYrakvFSw+HzfLJ/YHGwHYzKL2C/HTGlOYzyJ0V1uXWkIs3vJl12YRw==
X-Received: by 2002:adf:c449:: with SMTP id a9mr5872354wrg.240.1573834559976;
        Fri, 15 Nov 2019 08:15:59 -0800 (PST)
Received: from rudolphp.sr1.9esec.dev (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id o5sm11637467wrx.15.2019.11.15.08.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:15:59 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/2] firmware: google: Expose coreboot tables and CBMEM
Date:   Fri, 15 Nov 2019 17:15:14 +0100
Message-Id: <20191115161524.23738-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

As user land tools currently use /dev/mem to access coreboot tables and
CBMEM, provide a better way by using sysfs attributes.

Unconditionally expose all tables and buffers making future changes in
coreboot possible without modifying a kernel driver.

Patrick Rudolph (2):
  firmware: google: Expose CBMEM over sysfs
  firmware: google: Expose coreboot tables over sysfs

 drivers/firmware/google/Kconfig          |   6 +
 drivers/firmware/google/Makefile         |   1 +
 drivers/firmware/google/cbmem-coreboot.c | 164 +++++++++++++++++++++++
 drivers/firmware/google/coreboot_table.c |  59 ++++++++
 drivers/firmware/google/coreboot_table.h |  13 ++
 5 files changed, 243 insertions(+)
 create mode 100644 drivers/firmware/google/cbmem-coreboot.c

-- 
2.21.0

