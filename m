Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8415391F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 20:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBETbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 14:31:01 -0500
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:59609 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727162AbgBETbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:31:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id ECD03182CED5B;
        Wed,  5 Feb 2020 19:30:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2901:2914:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6742:7514:7903:8603:10004:10400:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:21795:30051:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:5,LUA_SUMMARY:none
X-HE-Tag: angle11_872e9c773d05
X-Filterd-Recvd-Size: 3088
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Feb 2020 19:30:57 +0000 (UTC)
Message-ID: <04c24b9bd4732ddd8361f912d408e770b35a66c3.camel@perches.com>
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
From:   Joe Perches <joe@perches.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Feb 2020 11:29:45 -0800
In-Reply-To: <87wo919grz.fsf@linutronix.de>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
         <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
         <20200205044848.GH41358@google.com> <20200205050204.GI41358@google.com>
         <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
         <20200205063640.GJ41358@google.com> <877e11h0ir.fsf@linutronix.de>
         <20200205110522.GA456@jagdpanzerIV.localdomain>
         <87wo919grz.fsf@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 16:48 +0100, John Ogness wrote:
> On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > 3BUG: KASAN: wild-memory-access in copy_data+0x129/0x220>
> > 3Write of size 4 at addr 5a5a5a5a5a5a5a5a by task cat/474>
> 
> The problem was due to an uninitialized pointer.
> 
> Very recently the ringbuffer API was expanded so that it could
> optionally count lines in a record. This made it possible for me to
> implement record_print_text_inline(), which can do all the kmsg_dump
> multi-line madness without requiring a temporary buffer. Rather than
> passing an extra argument around for the optional line count, I added
> the text_line_count pointer to the printk_record struct. And since line
> counting is rarely needed, it is only performed if text_line_count is
> non-NULL.
> 
> I oversaw that devkmsg_open() setup a printk_record and so I did not see
> to add the extra NULL initialization of text_line_count. There should be
> be an initializer function/macro to avoid this danger.
> 
> John Ogness
> 
> The quick fixup:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
[]
> @@ -883,6 +883,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
>  	user->record.text_buf_size = sizeof(user->text_buf);
>  	user->record.dict_buf = &user->dict_buf[0];
>  	user->record.dict_buf_size = sizeof(user->dict_buf);
> +	user->record.text_line_count = NULL;

Probably better to change the kmalloc to kzalloc.

 	user = kzalloc(sizeof(struct devkmsg_user), GFP_KERNEL);


