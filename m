Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54729A9FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404359AbfHWIOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 04:14:01 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:24463 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404149AbfHWIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:13:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 91C433F65E;
        Fri, 23 Aug 2019 10:13:46 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=M7KaK+96;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QbkcW5whgrGH; Fri, 23 Aug 2019 10:13:45 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 814D53F633;
        Fri, 23 Aug 2019 10:13:44 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id CC6C83601BA;
        Fri, 23 Aug 2019 10:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566548024; bh=ilH49lZ4+PXH0zJxFFM4Kn+312EuN85tBhlUd8R6IoU=;
        h=From:To:Cc:Subject:Date:From;
        b=M7KaK+96YlQipatKnh5GI58RdErCtNHEQiToHgc/ZIjumFeTjVcFNc9XUwBjj75HZ
         PL5O0wYfEJ+WATDYrRXtr2V/zWeNfRx9yLCd0ec12QkJXaURpAlXzvC/yXNQcZdBey
         mJilm/xiTz+VaUDxk5qnwo9aCQArrFG6b8ImOnzs=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2 0/4] Add support for updated vmware hypercall instruction
Date:   Fri, 23 Aug 2019 10:13:12 +0200
Message-Id: <20190823081316.28478-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>

VMware has started using "vmcall" / "vmmcall" instead of an inl instruction
for the "backdoor" interface. This series detects support for those
instructions.
Outside of the platform code we use the "ALTERNATIVES" self-patching
mechanism similarly to how this is done with KVM.
Unfortunately we need two new x86 CPU feature flags for this, since we need
the default instruction to be "inl". IIRC the vmmouse driver is used by
other virtualization solutions than VMware, and those might break if
they encounter any of the other instructions.

v2:
- Address various style review comments
- Use mnemonics instead of bytecode in the ALTERNATIVE_2 macros
- Use vmcall / vmmcall also for the High-Bandwidth port calls
- Change the %edx argument to what vmcall / vmmcall expect (flags instead of
  port number). The port number is added in the default ALTERNATIVE_2 path.
- Ack to merge the vmmouse patch from Dmitry.
- Drop license update for now. Will get back with a freestanding patch.
