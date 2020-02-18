Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE71631B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgBRUCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 15:02:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgBRUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nflWPq7ESAKoZ8WQ7+riCNATlDHNhjAjlMMNmDflZoc=; b=keBX26apztDdU/WjI1j5MVdoNG
        y+VJeT25XRIJUA2ASCzPloyrTWWwXvuTkm6kaJa2MytIz2YT9Jv9WO1ov/qZ4BJlIUcpj0QpL9wOo
        IXBUOh61TD6WULU4WzQcXP8ajtgSpfe41ZNUb7ZpmC1AAv9B+gnkIaHw2Zp5iv0KaaUsqbsoaXyEa
        xSENlv8Jn8O9lCa0uZTsnY3lOalDE5XKm6AiE7qt9m1QzAO9hw0TWz9AdJHWeoX9YOiuBrjYBZu5k
        s7qARYURK3u1zw9Ww3/isi6pUUCyBqatNg00vscFBeh1K+acCha0VUpjrLnpYlKyyasBNrUIXDRKQ
        xPWbyAEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j494C-0005MH-Nc; Tue, 18 Feb 2020 20:02:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B687980E53; Tue, 18 Feb 2020 21:02:00 +0100 (CET)
Date:   Tue, 18 Feb 2020 21:02:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218200200.GE11457@worktop.programming.kicks-ass.net>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 06:20:38PM +0000, Luck, Tony wrote:
> > Anything else I'm missing? It is likely...
> 
> +	hw_breakpoint_disable();
> +	static_key_disable(&__tracepoint_read_msr.key);
> +	tracing_off();
> +
>  	ist_enter(regs);
> 
> How about some code to turn all those back on for a recoverable (where we actually recovered) #MC?

Then please rewrite the #MC entry code to deal with nested exceptions
unmasking the MCE, very similr to NMI.

The moment you allow tracing, jump_labels or anything else you can
expect #PF, #BP and probably #DB while inside #MC, those will then IRET
and re-enable the #MC.

The current situation is completely and utterly buggered.
