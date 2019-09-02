Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72974A5223
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfIBIrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 04:47:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:45676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729328AbfIBIrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:47:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9537B6C9;
        Mon,  2 Sep 2019 08:47:37 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "powerpc: Add barrier_nospec to raw_copy_in_user()"
Date:   Mon,  2 Sep 2019 10:47:26 +0200
Message-Id: <20190902084726.14515-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821153656.57fabe9c@kitsune.suse.cz>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This reverts commit 6fbcdd59094ade30db63f32316e9502425d7b256.

Not needed. Data handled by raw_copy_in_user must be loaded through
copy_from_user to be used in the kernel which already has the barrier.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/uaccess.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 8b03eb44e876..76f34346b642 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -312,7 +312,6 @@ raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	unsigned long ret;
 
-	barrier_nospec();
 	allow_user_access(to, from, n);
 	ret = __copy_tofrom_user(to, from, n);
 	prevent_user_access(to, from, n);
-- 
2.22.0

