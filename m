Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6405DF423
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfJURY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 13:24:26 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:52486 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbfJURYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:24:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 6E7C63F44D;
        Mon, 21 Oct 2019 19:24:17 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Im5uoJFP;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3jkxGiYTO4-O; Mon, 21 Oct 2019 19:24:16 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 046B93F323;
        Mon, 21 Oct 2019 19:24:14 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 82CF73600C3;
        Mon, 21 Oct 2019 19:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571678654; bh=FkEEwR2RBpoIJ/NNeMBBtN/WItwtV3/wP0v7WLjagNU=;
        h=From:To:Cc:Subject:Date:From;
        b=Im5uoJFPMs+LAvTd2zfuliGzxOTkmmejPHZIFUCR4rTvKdgaYC0kvV/X35VvrbtQw
         A8xKek3Ts9eZqBHlEu36Us6Cg42qlTfw0F2dBy7j8JYAM6iae26bZ8W7VW25wQ0zCL
         uibzekm/jORSCwE16cgOP/Gr0rH5PbpFxJzO5tjw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        clang-built-linux@googlegroups.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 0/2] x86/cpu/vmware: Fixes for 5.4
Date:   Mon, 21 Oct 2019 19:24:01 +0200
Message-Id: <20191021172403.3085-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Two fixes for recently introduced regressions:

Patch 1 is more or less idential to a previous patch fixing the VMW_PORT
macro on LLVM's assembler. However, that patch left out the VMW_HYPERCALL
macro (probably not configured for use), so let's fix that also.

Patch 2 fixes another VMW_PORT run-time regression at platform detection
time

v2:
- Added an R-B for patch 1 (Nick Desaulniers)
- Improved on asm formatting in patch 2 (Sean Christopherson)

Cc: clang-built-linux@googlegroups.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
