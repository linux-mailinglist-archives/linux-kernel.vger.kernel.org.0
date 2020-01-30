Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2114D55C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 04:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgA3DXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 22:23:47 -0500
Received: from sagan.benjaminlowry.com ([45.63.74.94]:40688 "EHLO
        sagan.benjaminlowry.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgA3DXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 22:23:47 -0500
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 22:23:47 EST
From:   Benjamin Lowry <ben@ben.gmbh>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ben.gmbh; s=mail;
        t=1580354119; bh=j8oyEOiPBP56U9yWLGORPNAsQ1g/OQ1gsXovl0MjMyE=;
        h=From:To:Cc:Subject:Date:From;
        b=tXXJXUStU6lMhGMkw4cCSy2Wam77wjqZaxc9cvr+iRLazQJZqQnCUcjAK5VpdaVGt
         nHL32GjnQX3j0/t54bkoYkFn6gtzBMGByZTB9s1Wznq35XVucMefEe9YEFtPkLUtjg
         obK36h/PXpzB8Z0koTti/D9CHkkJfaBmBWAqN0DibxLjLVzLAPIJ/jLPajYFGeCKAF
         ZEovlgIbpeOe4KCTTse1/eg+tnLabGqZyDv14xUpHX0yu4avjW+ZR5T9BK2kU27mBv
         owXX4FWt8wxE0EdRUz2Ez8Ak3WX9qFNwPTDV35wDYjylnYn9+K9Q/tDclGcMZQeHlz
         FdBoFN4Fuussg==
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Lowry <ben@ben.gmbh>
Subject: [PATCH] tools/testing/selftests/proc: replace "pragma once" with include guard
Date:   Wed, 29 Jan 2020 21:14:06 -0600
Message-Id: <20200130031404.30136-1-ben@ben.gmbh>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Benjamin Lowry <ben@ben.gmbh>
---
 tools/testing/selftests/proc/proc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc.h b/tools/testing/selftests/proc/proc.h
index b7d57ea40237..627f99c3740d 100644
--- a/tools/testing/selftests/proc/proc.h
+++ b/tools/testing/selftests/proc/proc.h
@@ -1,4 +1,5 @@
-#pragma once
+#ifndef _PROC_H
+#define _PROC_H
 #undef NDEBUG
 #include <assert.h>
 #include <dirent.h>
@@ -49,3 +50,5 @@ static struct dirent *xreaddir(DIR *d)
 	assert(de || errno == 0);
 	return de;
 }
+
+#endif
-- 
2.24.1

