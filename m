Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA98158100
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 18:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBJRNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 12:13:21 -0500
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]:38163 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727598AbgBJRNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:13:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 12440180A9558;
        Mon, 10 Feb 2020 17:13:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2691:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:6119:8985:9025:10004:10400:10471:10848:11026:11232:11658:11914:12043:12050:12295:12296:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:14777:21080:21433:21451:21611:21627:21740:21819:21985:21990:30003:30054:30055:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: cough69_7412b12c76328
X-Filterd-Recvd-Size: 2585
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Feb 2020 17:13:17 +0000 (UTC)
Message-ID: <f666487838350308d2470c30d34a33eb7922e720.camel@perches.com>
Subject: Re: Checkpatch being daft, Was: [PATCH -v2 08/10] m68k,mm: Extend
 table allocator for multiple sizes
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        sean.j.christopherson@intel.com
Date:   Mon, 10 Feb 2020 09:12:02 -0800
In-Reply-To: <20200210163843.GL14897@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
         <20200131125403.882175409@infradead.org>
         <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
         <20200207113417.GG14914@hirez.programming.kicks-ass.net>
         <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
         <20200207123035.GI14914@hirez.programming.kicks-ass.net>
         <20200207123334.GT14946@hirez.programming.kicks-ass.net>
         <3f8a8a2f89bfd2d4cca9ac176ef41abf3a0ed4ab.camel@perches.com>
         <20200210163843.GL14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 17:38 +0100, Peter Zijlstra wrote:
> On Sun, Feb 09, 2020 at 10:24:15AM -0800, Joe Perches wrote:
> > Maybe this?
> 
> This isn't anywhere near RFC compliant,

Nothing really is.

https://metacpan.org/pod/Email::Address

doesn't really do a perfect job either, but I suppose
it'd be possible to use it one day instead.

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[]
>  one little nit below..
[]
> > +sub same_email_addresses {
> > +	my ($email1, $email2) = @_;
> > +
> > +	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
> > +	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
> > +
> > +	return $email1_name eq $email2_name &&
> > +	       $email1_address eq $email2_address;
> 
> strictly speaking only _address needs be the same for the whole thing to
> arrive at the same inbox, but I suppose that for sanity's sake, this
> comparison makes sense.

I know, and I believe that's true too.


