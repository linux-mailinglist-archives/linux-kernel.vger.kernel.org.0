Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E793615A41B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 09:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgBLI6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 03:58:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgBLI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id r11so1170825wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YuUuRZ5bjGI5stcrrhH2oCqZtxeGefrisf5kOUhppog=;
        b=pOue1wgzvhPnbKVZTqrahekk0CuQ+y0tthB5h0OtFbXKF48lbAQ8TtUYN2GO72M9dz
         akQLmiAUBE19dJrNi+leHSBvnXIOeogNB/utZ4xS8x/owwzxOD7SmEq8sYT+tG7hvo47
         /YNCcQskgIDmp9g64RUpqps+XjzqSyL/ftIiaSlJ3i667d5oxARCbi8CATOSi9d0Hlav
         DEF2heosWa8UeVf5TEYxYYJa+EJClRumZjaApJWokJQ0OV5xPbqL5F95KeuKNhfhAqRU
         zqMGcwTsVTtsKgSkyw3guoxl24khgl/J6HMPoheiaOyaovlgmv0yQeMrfOta7U1iFAVz
         34Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YuUuRZ5bjGI5stcrrhH2oCqZtxeGefrisf5kOUhppog=;
        b=VK5RqMf0DmJ2JPE+4b6FO9kZKN2KHybwc2w0sL9Ehsn93S2ESMG8wNvsJMo3jfie9k
         FgZKZvzoaRTfirtMogYQCMKQCnUwqKBLshwm2QmCymFilYNBTHVdRtqVJwreVKGQwfwV
         HjDVAWJRIvKOMhXj0IX+/Zm2kMh4LFhvorkm+KE0RuEBMePn2dhNUaA53v1n1mBGFVg9
         G93+W5vWjXq3lioCh7fADKrFVGbs37lDUFZ6R4BPK9KdJ3hNv0TArPSitbWnfy3Q2cGO
         uSdVG5bPY7NRAZAPLMAsqwokiR6X1TXdpDhoIH77jsLQ0BsIBhl6J+bUF93+UlTIrJHC
         31Qg==
X-Gm-Message-State: APjAAAXiMiwva0bUtf0d93SsU7RKCDisH9Wif3lY13fvieYPASlCwoIJ
        bCc1UCuMfHz1/gQQVR4SHpzSP+e1fQEiRw==
X-Google-Smtp-Source: APXvYqxZLlN0XaNPm3I3n7JrfLmeFdbmq8dTGm92xiaDpJ5tBoL+HHDVh1LG7X9a9sK0YJtOPgsmeg==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr13884522wrv.120.1581497892963;
        Wed, 12 Feb 2020 00:58:12 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z133sm7530894wmb.7.2020.02.12.00.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:12 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Piggin <npiggin@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 02/10] microblaze: Remove architecture tlb.h and use generic one
Date:   Wed, 12 Feb 2020 09:57:59 +0100
Message-Id: <1243cf3b894f81b728011621b2fd3d40b8935e99.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to have this empty file if it is just link to
asm-generic/tlb.h.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/include/asm/Kbuild |  1 +
 arch/microblaze/include/asm/tlb.h  | 17 -----------------
 2 files changed, 1 insertion(+), 17 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/tlb.h

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index e5c9170a07fc..7ae427f73105 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -31,6 +31,7 @@ generic-y += preempt.h
 generic-y += serial.h
 generic-y += shmparam.h
 generic-y += syscalls.h
+generic-y += tlb.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += vga.h
diff --git a/arch/microblaze/include/asm/tlb.h b/arch/microblaze/include/asm/tlb.h
deleted file mode 100644
index 628a78ee0a72..000000000000
--- a/arch/microblaze/include/asm/tlb.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2008-2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_MICROBLAZE_TLB_H
-#define _ASM_MICROBLAZE_TLB_H
-
-#include <linux/pagemap.h>
-#include <asm-generic/tlb.h>
-
-#endif /* _ASM_MICROBLAZE_TLB_H */
-- 
2.25.0

