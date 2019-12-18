Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653D91254F6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 22:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLRVpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 16:45:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33304 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLRVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id d71so3271867qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMoRoBbX4GBQAHcRoIosXpobvZM+hptW0zgg3rSHqGA=;
        b=kGheghDY+J6EwzZ9XzBEcI3UPYDpaCH+gfWt2FBXgSBGX47upxK2G2oSvUNdsBrUm4
         681JI0IvPJlZeIAtB4voOGWZnrqU6w5J/Y0LoyC4wu7DIdzZiWGuNHy88QD+KI1lxiRb
         zmwJvNCBVM17z8xAS679YQGOKrZKxKrNV2MfihJe9Cp0yW/eUGlqBDQC9ocvqOWkupzc
         Zz79KDN1gbWYAk2bZFSAXsGsdsWPzOKHbFXhQV3jQAn8yruE3iUWx7u3aFoPMf/4B0Ms
         bngF3MSKkgnw/FkJZ9mE3U4S1pVRURp23+Tz3wfw5XCyZapU5/M0kL3bOaNjf/q9D4Jc
         lnIg==
X-Gm-Message-State: APjAAAV4a5poyob+uHecbnpq7sZ+qXQLJaXMWesmdJyouMfhtquUWKMj
        Mrihx2gTQBy+0Cq6AFbDlxwFZHZg
X-Google-Smtp-Source: APXvYqxqlP9Y87Ii6nqSVZBFlYLp060UXfLU8jhpuuK2sm4BMOIAONcURt29nMMbNuZrruKtU4ZsVQ==
X-Received: by 2002:a05:620a:849:: with SMTP id u9mr5015170qku.414.1576705507847;
        Wed, 18 Dec 2019 13:45:07 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:07 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/24] Consolidate dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:42 -0500
Message-Id: <20191218214506.49252-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218211231.GA918900@kroah.com>
References: <20191218211231.GA918900@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves initialization of conswitchp to dummy_con into vt.c,
and configures DUMMY_CONSOLE unconditionally when CONFIG_VT is enabled.

The patches after the first two remove conswitchp = &dummy_con; from
the various architecture setup functions where it currently appears. If
the first two look ok, I was thinking of sending the others
individually.

Changes from v1:
- Fix subject lines

Arvind Sankar (24):
  console/dummycon: Remove bogus depends on from DUMMY_CONSOLE
  vt: Initialize conswitchp to dummy_con if unset
  arch/alpha/setup: Drop dummy_con initialization
  arch/arc/setup: Drop dummy_con initialization
  arch/arm/setup: Drop dummy_con initialization
  arch/arm64/setup: Drop dummy_con initialization
  arch/c6x/setup: Drop dummy_con initialization
  arch/csky/setup: Drop dummy_con initialization
  arch/ia64/setup: Drop dummy_con initialization
  arch/m68k/setup: Drop dummy_con initialization
  arch/microblaze/setup: Drop dummy_con initialization
  arch/mips/setup: Drop dummy_con initialization
  arch/nds32/setup: Drop dummy_con initialization
  arch/nios2/setup: Drop dummy_con initialization
  arch/openrisc/setup: Drop dummy_con initialization
  arch/parisc/setup: Drop dummy_con initialization
  arch/powerpc/setup: Drop dummy_con initialization
  arch/riscv/setup: Drop dummy_con initialization
  arch/s390/setup: Drop dummy_con initialization
  arch/sh/setup: Drop dummy_con initialization
  arch/sparc/setup: Drop dummy_con initialization
  arch/unicore32/setup: Drop dummy_con initialization
  arch/x86/setup: Drop dummy_con initialization
  arch/xtensa/setup: Drop dummy_con initialization

 arch/alpha/kernel/setup.c             | 2 --
 arch/arc/kernel/setup.c               | 4 ----
 arch/arm/kernel/setup.c               | 2 --
 arch/arm64/kernel/setup.c             | 3 ---
 arch/c6x/kernel/setup.c               | 4 ----
 arch/csky/kernel/setup.c              | 4 ----
 arch/ia64/kernel/setup.c              | 3 ---
 arch/m68k/kernel/setup_mm.c           | 4 ----
 arch/m68k/kernel/setup_no.c           | 4 ----
 arch/m68k/sun3x/config.c              | 1 -
 arch/microblaze/kernel/setup.c        | 4 ----
 arch/mips/kernel/setup.c              | 2 --
 arch/nds32/kernel/setup.c             | 5 -----
 arch/nios2/kernel/setup.c             | 4 ----
 arch/openrisc/kernel/setup.c          | 5 -----
 arch/parisc/kernel/setup.c            | 4 ----
 arch/powerpc/kernel/setup-common.c    | 3 ---
 arch/powerpc/platforms/cell/setup.c   | 3 ---
 arch/powerpc/platforms/maple/setup.c  | 3 ---
 arch/powerpc/platforms/pasemi/setup.c | 4 ----
 arch/powerpc/platforms/ps3/setup.c    | 4 ----
 arch/riscv/kernel/setup.c             | 4 ----
 arch/s390/kernel/setup.c              | 2 --
 arch/sh/kernel/setup.c                | 4 ----
 arch/sparc/kernel/setup_32.c          | 4 ----
 arch/sparc/kernel/setup_64.c          | 4 ----
 arch/unicore32/kernel/setup.c         | 2 --
 arch/x86/kernel/setup.c               | 2 --
 arch/xtensa/kernel/setup.c            | 2 --
 drivers/tty/vt/vt.c                   | 5 +++--
 drivers/video/console/Kconfig         | 1 -
 31 files changed, 3 insertions(+), 99 deletions(-)

-- 
2.24.1

