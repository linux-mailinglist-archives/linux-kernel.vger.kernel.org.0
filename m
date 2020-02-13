Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4815BBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgBMJjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 04:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMJje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:39:34 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E92F20848;
        Thu, 13 Feb 2020 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581586774;
        bh=qnmvgu6o2o2cTrkQmSx95xnN4T+UKD6INNQhZQrLTII=;
        h=From:To:Cc:Subject:Date:From;
        b=ZI93yGjPn5PPsem/wtSvsfRn+wfkQWD4y/NjsHLadeYAhsz0/pB651XQr9hNN4fM7
         civOSRvY/Q6Vy0ePZr5exOmjxE5KbBLkSZyaYT8pKRWKh6hh/CkDPBFXNvQ//rekae
         kRd4NOMgT1k7LwRpsj6iTkxUoPzq/1Ft3NubWoxU=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     stefana@xilinx.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] asm-generic/bitops: Update stale comment
Date:   Thu, 13 Feb 2020 09:39:27 +0000
Message-Id: <20200213093927.1836-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in 'asm-generic/bitops.h' states that you should "recode
these in the native assembly language, if at all possible". This is
pretty crappy advice now that the generic implementation is defined in
terms of atomic_long_t rather than a spinlock, so update the comment and
hopefully save future architecture maintainers a bit of work.

Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Stefan Asserhall <stefana@xilinx.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/bitops.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
index bfc96bf6606e..df9b5bc3d282 100644
--- a/include/asm-generic/bitops.h
+++ b/include/asm-generic/bitops.h
@@ -4,8 +4,9 @@
 
 /*
  * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents.  You should
- * recode these in the native assembly language, if at all possible.
+ * architecture, here are some C-language equivalents.  They should
+ * generate reasonable code, so take a look at what your compiler spits
+ * out before rolling your own buggy implementation in assembly language.
  *
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
-- 
2.25.0.265.gbab2e86ba0-goog

