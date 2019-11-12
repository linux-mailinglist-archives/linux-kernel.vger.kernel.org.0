Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79939F96B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 18:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKLRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 12:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfKLRKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:10:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4461320679;
        Tue, 12 Nov 2019 17:10:30 +0000 (UTC)
Date:   Tue, 12 Nov 2019 12:10:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 04/17] x86/alternatives: Add and use text_gen_insn()
 helper
Message-ID: <20191112121028.3ef25207@gandalf.local.home>
In-Reply-To: <20191111132457.703538332@infradead.org>
References: <20191111131252.921588318@infradead.org>
        <20191111132457.703538332@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 14:12:56 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> +void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
> +{
> +	static union text_poke_insn insn; /* text_mutex */
> +	int size = 0;
> +
> +	lockdep_assert_held(&text_mutex);
> +
> +	insn.opcode = opcode;
> +
> +#define __CASE(insn)	\
> +	case insn##_INSN_OPCODE: size = insn##_INSN_SIZE; break
> +
> +	switch(opcode) {
> +	__CASE(INT3);
> +	__CASE(CALL);
> +	__CASE(JMP32);
> +	__CASE(JMP8);
> +	}
> +
> +	if (size > 1) {
> +		insn.disp = (long)dest - (long)(addr + size);
> +		if (size == 2)

Could we add a comment here. It took me a little bit to figure out why
you have this BUG_ON().

-- Steve


> +			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
> +	}
> +
> +	return &insn.text;
> +}
