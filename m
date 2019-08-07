Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BFB8542D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbfHGT63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 15:58:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388204AbfHGT63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0khcKVDc1M1qvkv6DyyrH2FLY7iQ9qgNyVVoVFfpCEY=; b=NKiybbKgcU+q44Ei2Q7De+6iG
        ztSVcmsSn3guhAcPw69spDGchYJkKSr1zXigAqS6E+/ezF9+17Tb+bACFAXyPfUqF/uFE0MY485Tg
        fB+PtHAnG4/yAHlBfyE/FFeAvsWT+B00FogAwQYkPKzKvRauSfgXOcvkb9Koh/u9Gb4PI1GoAEOES
        3Anly3YV9QI6OjClj93Ke5Yz6q8JbpuvvuNMDrJ6Z2XOrTA3dWNiKylx+0PaB+GYdZpDq5oPLm6iz
        QyUpcCEL7SDOvTvaiyoK7SPkfuTN/IJHhdVmQY2GbhB0lXBj28pRQ9M1sw38VJgN+0meBi77p0wAu
        t0Ume/Jnw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvS4j-0008Gx-Ai; Wed, 07 Aug 2019 19:58:21 +0000
Date:   Wed, 7 Aug 2019 12:58:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+3de312463756f656b47d@syzkaller.appspotmail.com>
Cc:     allison@lohutok.net, andreyknvl@google.com, cai@lca.pw,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, Jiri Kosina <jkosina@suse.cz>
Subject: Re: BUG: bad usercopy in hidraw_ioctl
Message-ID: <20190807195821.GD5482@bombadil.infradead.org>
References: <000000000000ce6527058f8bf0d0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ce6527058f8bf0d0@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 12:28:06PM -0700, syzbot wrote:
> usercopy: Kernel memory exposure attempt detected from wrapped address
> (offset 0, size 0)!
> ------------[ cut here ]------------
> kernel BUG at mm/usercopy.c:98!

This report is confusing because the arguments to usercopy_abort() are wrong.

        /* Reject if object wraps past end of memory. */
        if (ptr + n < ptr)
                usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);

ptr + n is not 'size', it's what wrapped.  I don't know what 'offset'
should be set to, but 'size' should be 'n'.  Presumably we don't want to
report 'ptr' because it'll leak a kernel address ... reporting 'n' will
leak a range for a kernel address, but I think that's OK?  Admittedly an
attacker can pass in various values for 'n', but it'll be quite noisy
and leave a trace in the kernel logs for forensics to find afterwards.

> Call Trace:
>  check_bogus_address mm/usercopy.c:151 [inline]
>  __check_object_size mm/usercopy.c:260 [inline]
>  __check_object_size.cold+0xb2/0xba mm/usercopy.c:250
>  check_object_size include/linux/thread_info.h:119 [inline]
>  check_copy_size include/linux/thread_info.h:150 [inline]
>  copy_to_user include/linux/uaccess.h:151 [inline]
>  hidraw_ioctl+0x38c/0xae0 drivers/hid/hidraw.c:392

The root problem would appear to be:

                                else if (copy_to_user(user_arg + offsetof(
                                        struct hidraw_report_descriptor,
                                        value[0]),
                                        dev->hid->rdesc,
                                        min(dev->hid->rsize, len)))

That 'min' should surely be a 'max'?

Jiri, this looks like it was your code back in 2007.
