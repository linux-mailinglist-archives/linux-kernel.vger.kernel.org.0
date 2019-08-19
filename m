Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53B94D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 20:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfHSSnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 14:43:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48422 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSSnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:43:14 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzmcR-0001p5-Vz; Mon, 19 Aug 2019 20:43:04 +0200
Date:   Mon, 19 Aug 2019 20:43:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Mayr <me@sam.st>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes/x86: fix detection of 32-bit user mode
In-Reply-To: <2d8f1744136431b5eb0bda24ea767374d6fde4e5.camel@sam.st>
Message-ID: <alpine.DEB.2.21.1908192042190.1796@nanos.tec.linutronix.de>
References: <20190728152617.7308-1-me@sam.st> <2d8f1744136431b5eb0bda24ea767374d6fde4e5.camel@sam.st>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Sebastian Mayr wrote:
> > @@ -1056,7 +1056,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe
> > *auprobe, struct pt_regs *regs)
> >  unsigned long
> >  arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
> > struct pt_regs *regs)
> >  {
> > -	int rasize = sizeof_long(), nleft;
> > +	int rasize = sizeof_long(regs), nleft;
> >  	unsigned long orig_ret_vaddr = 0; /* clear high bits for 32-bit 
> > apps */
> >  
> >  	if (copy_from_user(&orig_ret_vaddr, (void __user *)regs->sp,
> > rasize))
> 
> Any feedback on this patch would be greatly appreciated.

Sorry, fell through the cracks. Thanks for the reminder!
