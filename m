Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E316EE743
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 19:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfKDSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 13:21:11 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:53875 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfKDSVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:21:10 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iRgyS-0007QC-RG; Mon, 04 Nov 2019 18:21:08 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iRgyS-00068u-E8; Mon, 04 Nov 2019 18:21:08 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] byteorder: fix warning due to type mismatch in be32 array code
Date:   Mon,  4 Nov 2019 18:21:07 +0000
Message-Id: <20191104182107.23568-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loop should use a "size_t" as the len parameter is a size_t which
should silence the following warning:

./include/linux/byteorder/generic.h:195:16: warning: comparison of integer expressions of different signedness: ‘int’ and ‘size_t’ {aka ‘unsigned int’} [-Wsign-compare]
./include/linux/byteorder/generic.h:203:16: warning: comparison of integer expressions of different signedness: ‘int’ and ‘size_t’ {aka ‘unsigned int’} [-Wsign-compare]

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: linux-kernel@vger.kernel.org
---
 include/linux/byteorder/generic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index 4b13e0a3e15b..c9a4c96c9943 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -190,7 +190,7 @@ static inline void be64_add_cpu(__be64 *var, u64 val)
 
 static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++)
 		dst[i] = cpu_to_be32(src[i]);
@@ -198,7 +198,7 @@ static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
 
 static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++)
 		dst[i] = be32_to_cpu(src[i]);
-- 
2.23.0

