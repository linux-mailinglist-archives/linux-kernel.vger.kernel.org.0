Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1FFB252
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 15:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKMONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 09:13:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:44666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbfKMONr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:13:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A4E5AD79;
        Wed, 13 Nov 2019 14:13:46 +0000 (UTC)
Date:   Wed, 13 Nov 2019 15:13:44 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/10] ftrace: Add register_ftrace_direct()
In-Reply-To: <20191108213450.032003836@goodmis.org>
Message-ID: <alpine.LSU.2.21.1911131500210.18679@pobox.suse.cz>
References: <20191108212834.594904349@goodmis.org> <20191108213450.032003836@goodmis.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -1757,6 +1761,18 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>  				return false;
>  			rec->flags--;
>  
> +			if (ops->flags & FTRACE_OPS_FL_DIRECT)
> +				rec->flags &= ~FTRACE_FL_DIRECT;
> +
> +			/*
> +			 * Only the internal direct_ops should have the
> +			 * DIRECT flag set. Thus, if it is removing a
> +			 * function, then that function should no longer
> +			 * be direct.
> +			 */
> +			if (ops->flags & FTRACE_OPS_FL_DIRECT)
> +				rec->flags &= ~FTRACE_FL_DIRECT;
> +

The flag is dropped twice here.

Miroslav
