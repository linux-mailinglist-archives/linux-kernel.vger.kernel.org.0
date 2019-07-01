Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A24180B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436849AbfFKWWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 18:22:20 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:29003 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436796AbfFKWWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:22:16 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 11 Jun 2019 15:22:11 -0700
Received: from rlwimi.localdomain (unknown [10.129.220.121])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id C52D641BAB;
        Tue, 11 Jun 2019 15:22:14 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v2 05/13] recordmcount: Kernel style function signature formatting
Date:   Tue, 11 Jun 2019 15:21:47 -0700
Message-ID: <a7a6fcb3fb9d1d25f484fa0eb10bd000c68a0e56.1560285597.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1560285597.git.mhelsley@vmware.com>
References: <cover.1560285597.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uwrite() and ulseek() functions are formatted inconsistently
with the rest of the file and the kernel overall. While we're
making other changes here let's fix this.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 scripts/recordmcount.c | 21 +++++++--------------
 scripts/recordmcount.h | 13 ++++++-------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 584dcbf3f320..1c3599f07f9b 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -52,8 +52,7 @@ static void *file_append; /* added to the end of the file */
 static size_t file_append_size; /* how much is added to end of file */
 
 /* Per-file resource cleanup when multiple files. */
-static void
-cleanup(void)
+static void cleanup(void)
 {
 	if (!mmap_failed)
 		munmap(file_map, sb.st_size);
@@ -68,8 +67,7 @@ cleanup(void)
 
 /* ulseek, uwrite, ...:  Check return value for errors. */
 
-static off_t
-ulseek(off_t const offset, int const whence)
+static off_t ulseek(off_t const offset, int const whence)
 {
 	switch (whence) {
 	case SEEK_SET:
@@ -89,8 +87,7 @@ ulseek(off_t const offset, int const whence)
 	return file_ptr - file_map;
 }
 
-static ssize_t
-uwrite(void const *const buf, size_t const count)
+static ssize_t uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
@@ -127,8 +124,7 @@ uwrite(void const *const buf, size_t const count)
 	return count;
 }
 
-static void *
-umalloc(size_t size)
+static void * umalloc(size_t size)
 {
 	void *const addr = malloc(size);
 	if (addr == 0) {
@@ -394,8 +390,7 @@ static uint32_t (*w)(uint32_t);
 static uint32_t (*w2)(uint16_t);
 
 /* Names of the sections that could contain calls to mcount. */
-static int
-is_mcounted_section_name(char const *const txtname)
+static int is_mcounted_section_name(char const *const txtname)
 {
 	return strncmp(".text",          txtname, 5) == 0 ||
 		strcmp(".init.text",     txtname) == 0 ||
@@ -446,8 +441,7 @@ static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
 	}).r_info;
 }
 
-static int
-do_file(char const *const fname)
+static int do_file(char const *const fname)
 {
 	Elf32_Ehdr *const ehdr = mmap_file(fname);
 	unsigned int reltype = 0;
@@ -595,8 +589,7 @@ do_file(char const *const fname)
 	return rc;
 }
 
-int
-main(int argc, char *argv[])
+int main(int argc, char *argv[])
 {
 	const char ftrace[] = "/ftrace.o";
 	int ftrace_size = sizeof(ftrace) - 1;
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index f863d6fce066..3198459f7431 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -475,11 +475,10 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
 char const *already_has_rel_mcount = "success"; /* our work here is done! */
 
 /* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
-static char const *
-__has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
-		 Elf_Shdr const *const shdr0,
-		 char const *const shstrtab,
-		 char const *const fname)
+static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
+				     Elf_Shdr const *const shdr0,
+				     char const *const shstrtab,
+				     char const *const fname)
 {
 	/* .sh_info depends on .sh_type == SHT_REL[,A] */
 	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
@@ -531,8 +530,8 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 
 
 /* Overall supervision for Elf32 ET_REL file. */
-static int
-do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
+static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
+		   unsigned const reltype)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-- 
2.20.1

