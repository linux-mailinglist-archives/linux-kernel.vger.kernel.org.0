Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693CCDB9E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 00:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441640AbfJQWtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 18:49:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36953 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438306AbfJQWte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:49:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so4232398lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/cEOoDfGUvop24BI6ZzpG7iBvdRmcFCHbzsqMJ5d8Q=;
        b=nLW6YpiexfLKhssUXQWKzy2sZlvvM3m9DOhQGhkA+wYifCLDjD5aWQrjhyuqi2xXPe
         n1TzNwdkohvt8i80owYaqwbbl8Sd8cLMFPjooo0FUmQsQEkdpGhoF6ayed47A+wb/iGn
         x+1TpFOAyvbDV06AHZFmZ7qbPfugtNvR9R2z4qWAA3RKRLSjzQmeKSMXtN/73XsjvDMP
         fInvi9C37akUmsTdx0Q6fNcAXg1s7oKTQNacx2bDzfb1lQh8SlLYUpZG3tHbf/L98Tpd
         E/3DuPY7akIIH3pOd3eo5eFZKhOjfWQW9vyiyB4HSEj41njiZMLqr+TvDh1hOKzJrUZ3
         M71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/cEOoDfGUvop24BI6ZzpG7iBvdRmcFCHbzsqMJ5d8Q=;
        b=i6xIHQHmzOwTtXlHOu/ozIs9qKF4wDx3hkN7Ms6fy7uxThOTGg/QEcybbxcz+Dpved
         jdTjUOgTkbe6nR3f+5sOatS1YDqfTgpAFYhF1mofv2/g4xBuDzfIl7BgjnmNHyb48WGu
         LbFzWi8QOAkKlNoV+dxzm4YN+KN6MWVl+mefwkHqyoJyt+LEbwVI1B/iaeBkywwFzE3Z
         Uimpz1bR13/HYp8EF6dDUsG4y1TdsMiMqfyCaNKIiYsOAlPX+wVK6dRtZywV1ir0Rnzg
         o54porI/mz/kTB9/jkkNY86x/0rgXBpm0Qv5/TS64OY5oxztxnIhEkMy2l1+LqCfm45O
         elbg==
X-Gm-Message-State: APjAAAWeJu/NAT30AgcEwklWmILNog2vDkjT5P6Vqs2uQrElyXQH3dWO
        /xsjjKARWSEJKQnlHXba768=
X-Google-Smtp-Source: APXvYqwQK4tiyrhkp43QT8S6jtFE0xnRvVPdabNTKsJYBDSRKCl4DpvLVGFid03BbuZyErJztNtUJQ==
X-Received: by 2002:a05:651c:8b:: with SMTP id 11mr3954907ljq.98.1571352571898;
        Thu, 17 Oct 2019 15:49:31 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id v1sm1592347lfq.89.2019.10.17.15.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 15:49:31 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/6] xtensa fixes for v5.4-rc4
Date:   Thu, 17 Oct 2019 15:49:10 -0700
Message-Id: <20191017224910.18457-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of fixes for the Xtensa architecture:

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20191017

for you to fetch changes up to 775fd6bfefc66a8c33e91dd9687ed530643b954d:

  xtensa: fix change_bit in exclusive access option (2019-10-16 00:14:33 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.4:

- fix {get,put}_user() for 64bit values;
- fix warning about static EXPORT_SYMBOL from modpost;
- fix PCI IO ports mapping for the virt board;
- fix pasto in change_bit for exclusive access option.

----------------------------------------------------------------
Al Viro (1):
      xtensa: fix {get,put}_user() for 64bit values

Max Filippov (5):
      xtensa: clean up assembly arguments in uaccess macros
      xtensa: fix type conversion in __get_user_[no]check
      xtensa: drop EXPORT_SYMBOL for outs*/ins*
      xtensa: virt: fix PCI IO ports mapping
      xtensa: fix change_bit in exclusive access option

 arch/xtensa/boot/dts/virt.dts     |  2 +-
 arch/xtensa/include/asm/bitops.h  |  2 +-
 arch/xtensa/include/asm/uaccess.h | 94 ++++++++++++++++++++++-----------------
 arch/xtensa/kernel/xtensa_ksyms.c |  7 ---
 4 files changed, 55 insertions(+), 50 deletions(-)

-- 
Thanks.
-- Max
