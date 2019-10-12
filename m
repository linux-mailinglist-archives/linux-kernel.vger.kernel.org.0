Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943A4D4F72
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 13:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJLLzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 07:55:02 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:47045 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfJLLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 07:53:02 -0400
Received: by mail-wr1-f50.google.com with SMTP id o18so14522059wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eQEhmCt1FY27ZzjbJxnMMBw+p7F/n24+TN6e19f7dtw=;
        b=pLcnk7zh1WRMLfrnzi+Z69Ctaz8959kmZ2oyJowZJpjxg59yfCZA2e4E0X/NdmISQD
         X+sp2fAlXt0p4ZeWs+kH0+t1hTIERp+vvJ0IimtVawTEZWpPYKToCRtXGQ9zG9SlrPCD
         cutcFTWkp6pMupkNy0c/VdwBZim3lT32fK9z4OQiOsEDONTrTWrOllxbfOfV3xRmMxJJ
         2HB1qYkmlWaTzBJxbVD72Fb3My49/Xh2n1FWy3vnpzdpXNPl5JPEw+wjaxNHOIANUMv+
         V4Lyxfnl4gxcHOEHn79QT2mfwFYKNpfLYt9GGLzRkvEqjrtp3NiyeNxXLJWjeYWf3bWE
         VYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=eQEhmCt1FY27ZzjbJxnMMBw+p7F/n24+TN6e19f7dtw=;
        b=NMih3W3P1RJy8UuyQvMB5QsOQTPoQiO9FtGP+g74AcKFSvQjMg+jHfuOZJ4btyDlHC
         gi/PFCOlizikZ17wHqBUMn+FZ9olkK4AZ4JIC887ageSpyghd6O4wcCD1Jt6En31c735
         L2C03onCiWbv4Zyq6UyrGmOyOoHj268/FMTWDG9ahR3h1aik1AorxsJ05f2uW7xERVAd
         1iMK3B0xpf/fFKWfqqN2mmslp4bd+B0KGLUNkHkij5hWAVf6yZ6wXBJm6PAPuQetuA00
         dXoLye3yOr0uD637TaZvC3+wFcWtM+t9hzkULSOkcsdL7b3vfuQInxOm4QWGuMDDZKjj
         jAXA==
X-Gm-Message-State: APjAAAUY9lu+MEL7I55ex3xeQN2FTgu66YqMCLJruQa/bag1F2wJ6XHf
        /pB982WEHJnDHAwXWpSk5+/5BGnr
X-Google-Smtp-Source: APXvYqw1MmXkmipNxhcz8nzW4U9S+OQjYs9r/6CEcmxdNhP1IZMvhgNAMOY2AyutbjeNiXuA5yotbw==
X-Received: by 2002:a5d:6192:: with SMTP id j18mr7543014wru.63.1570881180111;
        Sat, 12 Oct 2019 04:53:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f143sm17746327wme.40.2019.10.12.04.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 04:52:59 -0700 (PDT)
Date:   Sat, 12 Oct 2019 13:52:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 license updates
Message-ID: <20191012115257.GA95775@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 6184488a19be96d89cb6c36fb4bc277198309484 x86: Use the correct SPDX License Identifier in headers

Fix a couple of SPDX tags in x86 headers to follow the canonical pattern.

 Thanks,

	Ingo

------------------>
Nishad Kamdar (1):
      x86: Use the correct SPDX License Identifier in headers


 arch/x86/include/asm/cpu_entry_area.h | 2 +-
 arch/x86/include/asm/pti.h            | 2 +-
 arch/x86/kernel/process.h             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index cff3f3f3bfe0..8348f7d69fd5 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _ASM_X86_CPU_ENTRY_AREA_H
 #define _ASM_X86_CPU_ENTRY_AREA_H
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 5df09a0b80b8..07375b476c4f 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PTI_H
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 320ab978fb1f..1d0797b2338a 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Code shared between 32 and 64 bit
 
