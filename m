Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3FFD4A5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 17:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfFRPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 11:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfFRPpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:45:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D1120673;
        Tue, 18 Jun 2019 15:45:10 +0000 (UTC)
Date:   Tue, 18 Jun 2019 11:45:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] powerpc/ftrace: Update ftrace_location() for
 powerpc -mprofile-kernel
Message-ID: <20190618114509.5b1acbe5@gandalf.local.home>
In-Reply-To: <186656540d3e6225abd98374e791a13d10d86fab.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <186656540d3e6225abd98374e791a13d10d86fab.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 20:17:04 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> @@ -1551,7 +1551,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>  	key.flags = end;	/* overload flags, as it is unsigned long */
>  
>  	for (pg = ftrace_pages_start; pg; pg = pg->next) {
> -		if (end < pg->records[0].ip ||
> +		if (end <= pg->records[0].ip ||

This breaks the algorithm. "end" is inclusive. That is, if you look for
a single byte, where "start" and "end" are the same, and it happens to
be the first ip on the pg page, it will be skipped, and not found.

-- Steve

>  		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
>  			continue;
>  		rec = bsearch(&key, pg->records, pg->index,
