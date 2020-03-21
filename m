Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3B18E2D9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 17:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCUQL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 12:11:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgCUQL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rDHp5EkQVqal1KnnLcQv1KsG4j/TBGs8Jpkhs3ktxK0=; b=HXtwAPOsfT+13uB7XIgG4qtOHz
        z/ve7Xn0NvjqHtqTnSKLQ3Yz7DzFg/PP3qLLkQ1vewmKWjEPJB+RI79N2dVmn2FNUN3PGFXQd8LB+
        IQ9/vQciIg1V103pnfOafymjZhyjGdLVzS2QOUMM0c+JXt7v5w3xH+SqQjtmzeSlxpAUvw7/2hR/i
        x9Mva5axNRiL8IU5odbqCMin3JyYNfzFL962tB7PdgSiIVqe0Os+CrCURM4Pm+tS6ymjjPDcvzkH8
        q1AR3sdPNFfUfPTF7Jy9UinuE+VyMrDFTC1NT0uAIa+LaICsMjLOxeAhtrMlS7EeT5H9kVyeLdfhf
        353bILTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFgj4-0004AS-8d; Sat, 21 Mar 2020 16:11:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C393E983502; Sat, 21 Mar 2020 17:11:51 +0100 (CET)
Date:   Sat, 21 Mar 2020 17:11:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v2 17/19] objtool: Optimize !vmlinux.o again
Message-ID: <20200321161151.GB3323@worktop.programming.kicks-ass.net>
References: <20200317170234.897520633@infradead.org>
 <20200317170910.819744197@infradead.org>
 <20200318132025.GH20730@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.2003201719200.21240@pobox.suse.cz>
 <20200321151421.GD2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321151421.GD2452@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 04:14:21PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 20, 2020 at 05:20:47PM +0100, Miroslav Benes wrote:
> 
> > I think there is one more missing in create_orc_entry().
> 
> I'm thikning you're quite right about that.... lemme see what to do
> about that.

---
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -472,6 +472,14 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }

+void elf_add_rela(struct elf *elf, struct rela *rela)
+{
+	struct section *sec = rela->sec;
+
+	list_add_tail(&rela->list, &sec->rela_list);
+	elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+}
+
 static int read_relas(struct elf *elf)
 {
 	struct section *sec;
@@ -519,8 +527,7 @@ static int read_relas(struct elf *elf)
 				return -1;
 			}

-			list_add_tail(&rela->list, &sec->rela_list);
-			elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+			elf_add_rela(elf, rela);
 			nr_rela++;
 		}
 		max_rela = max(max_rela, nr_rela);
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -127,6 +127,7 @@ struct section *elf_create_rela_section(
 int elf_rebuild_rela_section(struct section *sec);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
+void elf_add_rela(struct elf *elf, struct rela *rela);

 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -111,8 +111,7 @@ static int create_orc_entry(struct elf *
 	rela->offset = idx * sizeof(int);
 	rela->sec = ip_relasec;

-	list_add_tail(&rela->list, &ip_relasec->rela_list);
-	hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+	elf_add_rela(elf, rela);

 	return 0;
 }

