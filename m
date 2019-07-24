Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2FF740A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 23:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbfGXVFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 17:05:31 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:53151 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387933AbfGXVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:05:26 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 24 Jul 2019 14:05:05 -0700
Received: from rlwimi.localdomain (unknown [10.166.65.164])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id D379140709;
        Wed, 24 Jul 2019 14:05:24 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v3 02/13] recordmcount: Remove uread()
Date:   Wed, 24 Jul 2019 14:04:56 -0700
Message-ID: <31a87c22b19150cec1c8dc800c8b0873a2741703.1563992889.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1563992889.git.mhelsley@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uread() is only used to initialize the ELF file's pseudo
private-memory mapping while uwrite() and ulseek() work within
the pseudo-mapping and extend it as necessary.  Thus it is not
a complementary function to uwrite() and ulseek(). It also makes
no sense to do cleanups inside uread() when its only caller,
mmap_file(), is doing the relevant allocations and associated
initializations.

Therefore it's clearer to use a plain read() call to initialize the
data in mmap_file() and remove uread().

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 scripts/recordmcount.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index ebe98c39f3cd..c0dd46344063 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -89,7 +89,7 @@ succeed_file(void)
 	longjmp(jmpenv, SJ_SUCCEED);
 }
 
-/* ulseek, uread, ...:  Check return value for errors. */
+/* ulseek, uwrite, ...:  Check return value for errors. */
 
 static off_t
 ulseek(int const fd, off_t const offset, int const whence)
@@ -112,17 +112,6 @@ ulseek(int const fd, off_t const offset, int const whence)
 	return file_ptr - file_map;
 }
 
-static size_t
-uread(int const fd, void *const buf, size_t const count)
-{
-	size_t const n = read(fd, buf, count);
-	if (n != count) {
-		perror("read");
-		fail_file();
-	}
-	return n;
-}
-
 static size_t
 uwrite(int const fd, void const *const buf, size_t const count)
 {
@@ -298,7 +287,10 @@ static void *mmap_file(char const *fname)
 	if (file_map == MAP_FAILED) {
 		mmap_failed = 1;
 		file_map = umalloc(sb.st_size);
-		uread(fd_map, file_map, sb.st_size);
+		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
+			perror(fname);
+			fail_file();
+		}
 	}
 	close(fd_map);
 
-- 
2.20.1

