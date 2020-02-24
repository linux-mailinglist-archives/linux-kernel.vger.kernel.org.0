Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5EF16A5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 13:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgBXMFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 07:05:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42082 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBXMFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:05:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id p18so6446354wre.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 04:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LeHmzlfx+umAweFKxJZyLgVIhI59yzqxwgRoOvY7YU=;
        b=QcS06Jt0AX7e2PSCjcI6PQQBMyLRc2VD60FxrDz8h3EMqDsSuRd2RLDZoSJNg0uB+x
         zUf1zfn1OE5eQjVajP9RazyprH54XrJBCcKWKP8vEaRxvHPv9D8wtU2SVZwUxuElKmuB
         on6Q1/ECXDTJ2sTIClbiKwdj2XQJkEurqdz5M1RjLOyv1/wkhsOuCNychQOnppnIJ4tw
         h3g6GLRaIeiiVUxuG1xkozDGubu2Frr+uaYt6jhwM+WtpGKoa4bujb5jhqAsHYBYnsKJ
         H7T5JV0M8G+u1ODdhO2YGP/r4uyHHSRWxSxm/h0lob/F8hLTfp6HEN6Ju2i4WEuNg10Q
         ObNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+LeHmzlfx+umAweFKxJZyLgVIhI59yzqxwgRoOvY7YU=;
        b=SQojVCREANDWs2m0VmkGoVt8Wb8xswzs0W7pU9tQPjOkFxm31y+zQ0XFG3B+LRXpiL
         t+z88Tpe36WMgIJ3Gup4S2eTtHYTbfhNrf10D2rSUP9UvMOCUYtrb1F5Fs8M5BARZBE8
         PJRtbvRE5+G71xstLsn9KEb/eO4XNnNnp/PHeBl5sSj421jgLhoM0TDOZOOuaazLmPXr
         6hXUoKfAed8ZzKLXABtnLmiJKTa8+dC58RRbUySbT9gZ+pN4hVaCQwmanizQGrfOrKtx
         84ayHcLHOtiQMlcKKMATE62MuCmaBFGdBEMwAZyw1ClqApDcL+SUEb4d73W+wakw9JKX
         9ujA==
X-Gm-Message-State: APjAAAVI7+OG4o20BbEa0KeaL6HfdhYaXXwOZTSamrqfep+s9Up3pFb/
        OmZmYgHihjugWr6ZPBwCEOpRTKTe7xoadQ==
X-Google-Smtp-Source: APXvYqwUdVXRUTfIuXkyOrnXa8hcj1rmhHlTKci7z6BlJe+5ABh3MjFYWICh8Q4tQN/oLuHwepyRoA==
X-Received: by 2002:a5d:61d1:: with SMTP id q17mr68226377wrv.156.1582545919575;
        Mon, 24 Feb 2020 04:05:19 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z21sm17611297wml.5.2020.02.24.04.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 04:05:19 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, maz@kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] irqchip: xilinx: Switch to generic domain handler
Date:   Mon, 24 Feb 2020 13:05:12 +0100
Message-Id: <cover.1582545908.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is based on cascade mode patch sent by Mubin
(https://lkml.org/lkml/2020/2/11/888 - v3 series).

The first patch is just fixing error patch. The second is converting microblaze
do_IRQ() to generic IRQ handler with appropriate changes in xilinx intc driver.

Also removes concurrent_irq global variable which wasn't wired
anywhere but it stores number of concurrent IRQs handled by one call. There
is option to get it back if needed but I haven't seen it in other archs
that's why I have removed it too.

Thanks,
Michal

Changes in v2:
- Merge generic irq multi handler(v1 2/3) and domain irq patch (v1 3/3) from together
- Add likely() suggested by Marc

Michal Simek (2):
  irqchip: xilinx: Fill error code when irq domain registration fails
  irqchip: xilinx: Enable generic irq multi handler

 arch/microblaze/Kconfig           |  2 ++
 arch/microblaze/include/asm/irq.h |  3 ---
 arch/microblaze/kernel/irq.c      | 21 +------------------
 drivers/irqchip/irq-xilinx-intc.c | 35 ++++++++++++++++++-------------
 4 files changed, 24 insertions(+), 37 deletions(-)

-- 
2.25.1

