Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2785DCDDD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfJGIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 04:55:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfJGIzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:55:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F275718C4266;
        Mon,  7 Oct 2019 08:55:08 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC5835D9C9;
        Mon,  7 Oct 2019 08:55:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 5.4 regression fix] x86/boot: Provide memzero_explicit
Date:   Mon,  7 Oct 2019 10:55:01 +0200
Message-Id: <20191007085501.23202-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Mon, 07 Oct 2019 08:55:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purgatory code now uses the shared lib/crypto/sha256.c sha256
implementation. This needs memzero_explicit, implement this.

Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/boot/compressed/string.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 81fc1eaa3229..511332e279fe 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -50,6 +50,11 @@ void *memset(void *s, int c, size_t n)
 	return s;
 }
 
+void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+}
+
 void *memmove(void *dest, const void *src, size_t n)
 {
 	unsigned char *d = dest;
-- 
2.23.0

