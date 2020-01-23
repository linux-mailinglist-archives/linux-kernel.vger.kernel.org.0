Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47EAD14691E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAWNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 08:30:57 -0500
Received: from mout02.posteo.de ([185.67.36.66]:41665 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgAWNa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:30:56 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7BEA42400FF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1579786254; bh=iarPYW24XwnOcNKIc9y4ecet74CCTDRkn8cloENLcIU=;
        h=From:To:Cc:Subject:Date:From;
        b=H4nRpvF/CsB370b3kwlN5V+yZUfGWwkPtiJIuuCvCiinTE1hS/at5+u9uaUbUHFW6
         GmT8CsArpKRXRKbK+mQ9sIgbzEHqURKR7wJ+yYrFUIFq5iytmpY/RuXg2Dtxdyv7oE
         /QcCe/c0rt5Eijko5At+j6V1xzRUFxmp5YZEIrjOZhGFovoxe78p8cPMdlOYAyp68V
         JaYgpAkinUnPKdGrQRUbMk3RFYj04yJTM9gJSzijQ4Qps7OWaMDL394PXw2Ku227g3
         JaoaSth6CgmR1xY7VH1K41E8PuxlQ/FpwEvX3VYUV54u6S7mYSFFKAAx7tyMkYS1qF
         9zXk6619T7fmQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 483NSt0qsyz9rxY;
        Thu, 23 Jan 2020 14:30:54 +0100 (CET)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/iopl: Include prototype header for ksys_ioperm()
Date:   Thu, 23 Jan 2020 14:30:51 +0100
Message-Id: <20200123133051.5974-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. in order to fix a -Wmissing-prototype warning.

No functional change.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/kernel/ioport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 8abeee0dd7bf..a53e7b4a7419 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -13,6 +13,7 @@
 
 #include <asm/io_bitmap.h>
 #include <asm/desc.h>
+#include <asm/syscalls.h>
 
 #ifdef CONFIG_X86_IOPL_IOPERM
 
-- 
2.17.1

