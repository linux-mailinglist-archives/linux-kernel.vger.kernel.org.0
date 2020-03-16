Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F277B187058
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 17:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbgCPQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 12:46:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbgCPQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UldIcImfTlWsfuaRmvn6WjdH00Ncoz606zt/8JlydiE=; b=Z+bUmJMag1G3RqumhLOE1Q/vjz
        v9szg5QlQu8n0i5EUlQC8V9GhRoGksMR0LBbbhcrfvaVRNM7E4njQ4xLWgx1GtsBvnrVaeZMUI4T/
        hQPHE9MzLhI9kkSFRqxyN6XH71BF9W8Wmkn7DStsz3IhPB+fKYOV5RjggnNWLtYn3ZMRCRA0B2Ty+
        TKIrZfPWT0Yo9pcYXXTV0vre/fZKoAZKq6XsuokK6oZE67ELPvEOSjQ7qLcFs4+lNjRr/gUnT0Ueg
        XfcWFOriiF+vo6Z/P6lGMo56Z7pjnYUE1+Pe4MMnihFG3yB3xznCeg9PAOmwZ2riMPUdPUEn1cYJm
        bD4GPytw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDsso-0003Jc-R5; Mon, 16 Mar 2020 16:46:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39F603045E0;
        Mon, 16 Mar 2020 17:46:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D9292B4CD481; Mon, 16 Mar 2020 17:46:28 +0100 (CET)
Date:   Mon, 16 Mar 2020 17:46:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 15/16] objtool: Implement noinstr validation
Message-ID: <20200316164628.GG12521@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.288201372@infradead.org>
 <20200315180320.cgy2ealklbjlx4g7@treble>
 <20200316132419.GF12521@hirez.programming.kicks-ass.net>
 <20200316161904.zouwkwup6vwsmxgp@treble>
 <20200316162147.xufxhddz5ztqq5q3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316162147.xufxhddz5ztqq5q3@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:21:47AM -0500, Josh Poimboeuf wrote:
> On Mon, Mar 16, 2020 at 11:19:07AM -0500, Josh Poimboeuf wrote:
> > > And I was hoping to get vmlinux.o objtool clean, surprisingly there
> > > really aren't that many complaints. But the -i thing makes it run
> > > significantly faster without duplicating all the bits we've already
> > > checked.
> > 
> > My suggestion is that the "-i" option would be hard-coded (for now).  So
> > nothing extra would get checked.
> 
> If that wasn't clear, I mean that for vmlinux.o we'd only do the
> instr-checking.  For individual .o's we'd do everything else.

That'd get in the way of making vmlinux.o objtool clean though :/
