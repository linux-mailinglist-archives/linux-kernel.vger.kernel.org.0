Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D210917D290
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 09:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCHIKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 04:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgCHIKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:43 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A05A72072A;
        Sun,  8 Mar 2020 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655042;
        bh=SOr81exaFY7eTtkz9t/BsF2BMpxMMKz/aNikSfIVNJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zijrPhfNxfCUy3WFuieJtCC9zc568fih/UG9rx/TnoYb4iSQ3irmiBgfDnfqyeSya
         HVKsqriQ7Euah81h9N8aj5L3dnqbUp30iUALNyZAYScmwWeGYzw3Xy8SQ/h84HsQR5
         AekRCsHEM0Ae02fPIR4r3r+XCOrNJ69tLswDX6ds=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 27/28] efi/x86: Fix cast of image argument
Date:   Sun,  8 Mar 2020 09:08:58 +0100
Message-Id: <20200308080859.21568-28-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

handle_protocol expects void **, not void *.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200305143642.820865-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index bf0c3f60762a..e61782849ebd 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -383,7 +383,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
-	status = efi_bs_call(handle_protocol, handle, &proto, (void *)&image);
+	status = efi_bs_call(handle_protocol, handle, &proto, (void **)&image);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
 		efi_exit(handle, status);
-- 
2.17.1

