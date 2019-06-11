Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6F41812
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 00:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391688AbfFKWWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 18:22:45 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:3298 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436796AbfFKWWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:22:21 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 11 Jun 2019 15:22:12 -0700
Received: from rlwimi.localdomain (unknown [10.129.220.121])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id D536241BAF;
        Tue, 11 Jun 2019 15:22:18 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v2 11/13] objtool: recordmcount: Start using objtool's elf wrapper
Date:   Tue, 11 Jun 2019 15:21:53 -0700
Message-ID: <0e19d11de05d6d989c8f97d5afff713bf406a6eb.1560285597.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1560285597.git.mhelsley@vmware.com>
References: <cover.1560285597.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct elf to grab the file descriptor. We will later
move these calls into other functions as we expand the
lifetime of the struct elf so that it can be passed to
objtool elf.[ch] functions.

This creates the libelf/objcount data structures and gives
us two separte ways to walk the ELF file -- the libelf/objtool
way and the old recordmcount wrapper way which avoids these
extra data structures by using indices, offsets, and pointers
into the mmapped ELF file.

Subsequent patches will convert from the old recordmcount
accessors to the libelf/objtool accessors.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 2de31e2913d1..61050b78d5a0 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -33,6 +33,8 @@
 
 #include "builtin-mcount.h"
 
+#include "elf.h"
+
 #ifndef EM_AARCH64
 #define EM_AARCH64	183
 #define R_AARCH64_NONE		0
@@ -53,6 +55,8 @@ static void *file_ptr;	/* current file pointer location */
 static void *file_append; /* added to the end of the file */
 static size_t file_append_size; /* how much is added to end of file */
 
+static struct elf *lf;
+
 /* Per-file resource cleanup when multiple files. */
 static void file_append_cleanup(void)
 {
@@ -69,6 +73,9 @@ static void mmap_cleanup(void)
 	else
 		free(file_map);
 	file_map = NULL;
+	if (lf)
+		elf_close(lf);
+	lf = NULL;
 }
 
 /* ulseek, uwrite, ...:  Check return value for errors. */
@@ -166,11 +173,12 @@ static void *mmap_file(char const *fname)
 	file_updated = 0;
 	sb.st_size = 0;
 
-	fd_map = open(fname, O_RDONLY);
-	if (fd_map < 0) {
+	lf = elf_open(fname, O_RDONLY);
+	if (!lf) {
 		perror(fname);
 		return NULL;
 	}
+	fd_map = lf->fd;
 	if (fstat(fd_map, &sb) < 0) {
 		perror(fname);
 		goto out;
@@ -190,14 +198,14 @@ static void *mmap_file(char const *fname)
 		}
 		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
 			perror(fname);
-			free(file_map);
-			file_map = NULL;
+			mmap_cleanup();
 			goto out;
 		}
 	} else
 		mmap_failed = 0;
 out:
-	close(fd_map);
+	elf_close(lf);
+	lf = NULL;
 	fd_map = -1;
 
 	file_end = file_map + sb.st_size;
-- 
2.20.1

