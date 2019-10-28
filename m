Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86D4E729F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 14:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbfJ1Nay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 09:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfJ1Nay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:30:54 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C812620873;
        Mon, 28 Oct 2019 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572269452;
        bh=Q4aTENSogO5dIUk61tZ+mKng+1PdVCEMMsHb/lYON2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbT5L1eHkeWMiJ7d35cXaAKdgbCDLGGfIdru6dSJRHiWLiDqpQJCHV4Is0NGz914Y
         W27fseMJaz3ZPyVyiHLeXzYiaHwXNMBTDdNompmkd6xpWv2Q00cywIlqCl6gB+GlmV
         7ylMyirXSq0aERB7GU7/+ezvoTR7TLXaMSpV3LQA=
Date:   Mon, 28 Oct 2019 14:30:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+8f2612936028bfd28f28@syzkaller.appspotmail.com>,
        allison@lohutok.net, alsa-devel@alsa-project.org,
        benquike@gmail.com, dan.carpenter@oracle.com, glider@google.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tiwai@suse.com, wang6495@umn.edu, yuehaibing@huawei.com
Subject: Re: KMSAN: uninit-value in get_term_name
Message-ID: <20191028133050.GA13691@kroah.com>
References: <000000000000f838060595f602a7@google.com>
 <s5hr22xau8f.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr22xau8f.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 02:13:20PM +0100, Takashi Iwai wrote:
> On Mon, 28 Oct 2019 11:32:07 +0100,
> syzbot wrote:
> > 
> > Uninit was stored to memory at:
> >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
> >  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
> >  __msan_chain_origin+0x6b/0xd0 mm/kmsan/kmsan_instr.c:179
> >  parse_term_proc_unit+0x73d/0x7e0 sound/usb/mixer.c:896
> >  __check_input_term+0x13ef/0x2360 sound/usb/mixer.c:989
> 
> So this comes from the invalid descriptor for a processing unit, and
> it's very likely the same issue as already spotted -- the validator up
> to 5.3-rc4 had a bug that passed the invalid descriptor falsely.
> This should have been covered by 5.3-rc5, commit ba8bf0967a15 ("ALSA:
> usb-audio: Fix copy&paste error in the validator").

SHould we be backporting the validator to any older kernels as well?

thanks,

greg k-h
