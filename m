Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C165E72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfGKR0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 13:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfGKR0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF2BB307CB38;
        Thu, 11 Jul 2019 17:26:24 +0000 (UTC)
Received: from treble (ovpn-122-237.rdu2.redhat.com [10.10.122.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 405481001B28;
        Thu, 11 Jul 2019 17:26:24 +0000 (UTC)
Date:   Thu, 11 Jul 2019 12:26:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
Message-ID: <20190711172621.a7ab7jorolicid3z@treble>
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 11 Jul 2019 17:26:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 02:40:06PM +0200, Arnd Bergmann wrote:
> During randconfig testing with clang-9, I came across an object file
> that makes objtool segfault, see attachment. Let me know if you need
> more information to
> debug this.
> 
> I also get a ton of objtool warnings building random configurations, but Nick
> mentioned that there is still a bug related to asm-goto in the build I'm using
> that may be the root cause. Once I have a fixed clang-9 build, I can have a look
> at those as well.

Seg fault fix:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 27818a93f0b1..ad18f8ef905a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -902,7 +902,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 			    struct rela *table, struct rela *next_table)
 {
 	struct rela *rela = table;
-	struct instruction *alt_insn;
+	struct instruction *alt_insn, *prev_insn;
 	struct alternative *alt;
 	struct symbol *pfunc = insn->func->pfunc;
 	unsigned int prev_offset = 0;
@@ -924,6 +924,20 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 		if (!alt_insn)
 			break;
 
+		if (!alt_insn->func) {
+			/*
+			 * Clang 9 has a quirk where a switch table may have
+			 * unused entries in the middle of the table which
+			 * point to just past the end of the function.  They're
+			 * still part of the table but can be ignored.
+			 */
+			prev_insn = list_prev_entry(alt_insn, list);
+			if (prev_insn->func && prev_insn->func->pfunc == pfunc)
+				goto skip;
+
+			break;
+		}
+
 		/* Make sure the jmp dest is in the function or subfunction: */
 		if (alt_insn->func->pfunc != pfunc)
 			break;
@@ -936,6 +950,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 
 		alt->insn = alt_insn;
 		list_add_tail(&alt->list, &insn->alts);
+skip:
 		prev_offset = rela->offset;
 	}
 
