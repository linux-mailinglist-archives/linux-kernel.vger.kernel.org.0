Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07224122ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLQLzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 06:55:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfLQLzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:55:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so10938770wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OtmFiej67XuS7AjH3gCT52rylnlqajW0xLd41zGxrVA=;
        b=N/W+u9xh/vc1iC2i1uCwSGxezovI6wLYK90KMcPZe7tO5yvZF6eyXaGDbWksCZv4yZ
         H/s59+ZMS88SrjcBKEVyYCWaXtfTl8pCtNB5uclNssLfxXCcUPUfJjM4I+JvNd07N/Kh
         I6IzcgJU/xI2qKkC0LipoKudIUUOO8wvVFH4LXULFjZBqtpZgHYLl9B+jPp/1zHAjSJ0
         QSQ9J8gxSEckgnspslvZU77AFiBs4hOecq63yESrE1XfLTrDtCJex53IhY77EeHWIeIk
         vIrhvAmJ+ssxuKBMMZJcLtKUxsszVoejJY+Bc0HZ+4I3nd9fNxHmELiW6xWooUaUk7wM
         2nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OtmFiej67XuS7AjH3gCT52rylnlqajW0xLd41zGxrVA=;
        b=XWIRPELsgK5q6gz6W4H6oa/BDG+Ej+UvFMGdclc1sUxq6mtafeGPgaXbCfditZnCVU
         0TQgo09blVaqiAHtgqqUPzJb1XvVFhlVxKv1Yuqv2dSAlOORUMrvGcgc4SwJjiK9uDUK
         NwcmFV8quJP+7wGiybHHBq4T+Wz9lYiJtrLHB9AkJOCXAUQ3AEo4C2Z7w3HdZw2njS/N
         pbRdL/PJHp2rseNkiLpKSrD3E1BGSyluqbXC+6E5S7BZej4QqNyeXYGrABD2Rn/V5Rs6
         OncBj2vI2hyAFpD3DoEosN/b+ZAL0XurQgt3pHKJ8RNac2NuiKhtq2Z5HVNRvP6kMofF
         GWdA==
X-Gm-Message-State: APjAAAX5aPHqLj/R3baodYBbGGeplrB6pQHQbb/4Gqf52EgWHLrdpUv2
        UGC0Qrfx/rug8M/w0yFKi58=
X-Google-Smtp-Source: APXvYqyVlfTe/p1PtUB4pXyc6v3v8TQTmAcnI44j0/aMfqRT9KZDiOXpGvbTEgIWOkPo3ijPqnR+Eg==
X-Received: by 2002:adf:ef10:: with SMTP id e16mr34917892wro.336.1576583749962;
        Tue, 17 Dec 2019 03:55:49 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u14sm25678590wrm.51.2019.12.17.03.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:55:49 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:55:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] timer fixes
Message-ID: <20191217115547.GA68104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: e0748539e3d594dd26f0d27a270f14720b22a406 x86/intel: Disable HPET on Intel Ice Lake platforms

Add HPET quirks for the Intel "Coffee Lake H" and "Ice Lake" platforms.

 Thanks,

	Ingo

------------------>
Kai-Heng Feng (2):
      x86/intel: Disable HPET on Intel Coffee Lake H platforms
      x86/intel: Disable HPET on Intel Ice Lake platforms


 arch/x86/kernel/early-quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 4cba91ec8049..2f9ec14be3b1 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -710,8 +710,12 @@ static struct chipset early_qrk[] __initdata = {
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x3e20,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x8a12,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
 	{}
