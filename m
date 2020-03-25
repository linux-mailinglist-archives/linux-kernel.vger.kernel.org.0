Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8093E192D78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCYPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 11:53:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgCYPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iLy52IvuoMW6Hkrbig+Fp+kbZfkbatNFpf3zh7r5ON8=; b=nI9H0RY32GkdDIv6Kssk1BqRXm
        ZUtgXI+sIzYzLfpidEZmv6Nk+11iTkv4c1Bh7OPCYFA+4dEvNznA8reQHaJwgUy2tHlJ/ucu6njjO
        Ukxfp215jJPkNTaanV1HrTuIlpUNWVOFPLz39YGg0sQ04WHnCGRkvO8mBLnAVyUZOC8liYLmTHUff
        YLA7jEzUuL3Xk8Jp2xvedCYP4ihuvE8Hyh5iLtL7Cqa1IZZkqTd0rxqtxgGjorK4uuA4QKe7QDBw1
        x/+aYtAkM/PHRVcd8ULgmVYMy0i/tbWYg45EJe8O+sUGv+THWeQo5T0xPOaBN1U2LDa9AnmuPI6aN
        WLUZXtxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8Lm-0007Tn-Li; Wed, 25 Mar 2020 15:53:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7345F3010CF;
        Wed, 25 Mar 2020 16:53:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 617C229A8F434; Wed, 25 Mar 2020 16:53:48 +0100 (CET)
Date:   Wed, 25 Mar 2020 16:53:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 26/26] objtool: Add STT_NOTYPE noinstr validation
Message-ID: <20200325155348.GA20696@hirez.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.470421121@infradead.org>
 <20200324221616.2tdljgyay37aiw2t@treble>
 <20200324223455.GV2452@worktop.programming.kicks-ass.net>
 <20200325144211.irnwnly37fyhapvx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325144211.irnwnly37fyhapvx@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 09:42:11AM -0500, Josh Poimboeuf wrote:
> Sure, but couldn't validate_unwind_hints() and
> validate_reachable_instructions() be changed to *only* run on
> .noinstr.text, for the vmlinux case?  That might help converge the
> vmlinux and !vmlinux paths.

You're thinking something like so then?

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2421,24 +2421,34 @@ static int validate_branch(struct objtoo
 	return 0;
 }
 
-static int validate_unwind_hints(struct objtool_file *file)
+static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 {
 	struct instruction *insn;
-	int ret, warnings = 0;
 	struct insn_state state;
+	int ret, warnings = 0;
 
 	if (!file->hints)
 		return 0;
 
 	clear_insn_state(&state);
 
-	for_each_insn(file, insn) {
+	if (sec) {
+		insn = find_insn(file, sec, 0);
+		if (!insn)
+			return 0;
+	} else {
+		insn = list_first_entry(&file->insn_list, typeof(*insn), list);
+	}
+
+	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited) {
 			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
 		}
+
+		insn = list_next_entry(insn, list);
 	}
 
 	return warnings;
@@ -2622,12 +2632,16 @@ static int validate_section(struct objto
 static int validate_vmlinux_functions(struct objtool_file *file)
 {
 	struct section *sec;
+	int warnings = 0;
 
 	sec = find_section_by_name(file->elf, ".noinstr.text");
 	if (!sec)
 		return 0;
 
-	return validate_section(file, sec);
+	warnings += validate_section(file, sec);
+	warnings += validate_unwind_hints(file, sec);
+
+	return warnings;
 }
 
 static int validate_functions(struct objtool_file *file)
@@ -2712,7 +2726,7 @@ int check(const char *_objname, bool orc
 		goto out;
 	warnings += ret;
 
-	ret = validate_unwind_hints(&file);
+	ret = validate_unwind_hints(&file, NULL);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
