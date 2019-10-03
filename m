Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CFC9B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfJCJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 05:52:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:37062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729101AbfJCJwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:52:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CDD4B147;
        Thu,  3 Oct 2019 09:52:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] x86/asm: Make boot_gdt_descr local
Date:   Thu,  3 Oct 2019 11:52:38 +0200
Message-Id: <20191003095238.29831-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003095238.29831-1-jslaby@suse.cz>
References: <20191003095238.29831-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can see, it was never used outside head_32.S. Not even when
added in 2004. So make it local.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/head_32.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 30f9cb2c0b55..7feb953e10d2 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -597,8 +597,6 @@ int_msg:
  */
 
 	.data
-.globl boot_gdt_descr
-
 	ALIGN
 # early boot GDT descriptor (must use 1:1 address mapping)
 	.word 0				# 32 bit align gdt_desc.address
-- 
2.23.0

