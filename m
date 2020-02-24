Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213D816AE78
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 19:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgBXSPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 13:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBXSPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:15:35 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6529620732;
        Mon, 24 Feb 2020 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582568134;
        bh=t/2K0XLnJvtS4TWQEXZ1LFWhbvFI+cAOsWJ66Zfp0CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpDWs/dE5mPhFZ0jUnGbPTs6U6yinPlR+T5X+uvzrFRuhNd9jCVfE1c6GLVCUEFYP
         wTJ/jNRwy3jLwCZ2Bs2t1S6ZK6nX1QPg0FRZxc+7jaIdx5uEmdNnyvdNzFE/7dyvv7
         cZHlQro4RycFa3pgfowrM4xAKKex8hetRW7rfDcQ=
Date:   Mon, 24 Feb 2020 10:15:32 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tty: fix compat TIOCGSERIAL leaking uninitialized memory
Message-ID: <20200224181532.GA109047@gmail.com>
References: <000000000000387920059f4e0351@google.com>
 <20200224083838.306381-1-ebiggers@kernel.org>
 <1edbbced-58c1-7674-2d01-6a807ddf5968@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edbbced-58c1-7674-2d01-6a807ddf5968@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:47:26AM +0100, Jiri Slaby wrote:
> On 24. 02. 20, 9:38, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Commit 77654350306a ("take compat TIOC[SG]SERIAL treatment into
> > tty_compat_ioctl()") changed the compat version of TIOCGSERIAL to start
> > copying a whole struct to userspace rather than individual fields, but
> > failed to initialize all padding and fields -- namely the hole after the
> > 'iomem_reg_shift' field, and the 'reserved' field.
> > 
> > Fix this by initializing the struct to zero.
> > 
> > Reported-by: syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com
> > Fixes: 77654350306a ("take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()")
> > Cc: <stable@vger.kernel.org> # v4.20+
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  drivers/tty/tty_io.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 1fcf7ad83dfa0..d24c250312edf 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -2731,6 +2731,7 @@ static int compat_tty_tiocgserial(struct tty_struct *tty,
> >  	struct serial_struct v;
> >  	int err;
> >  	memset(&v, 0, sizeof(struct serial_struct));
> > +	memset(&v32, 0, sizeof(struct serial_struct32));
> 
> sizeof(v32) please.
> 

Sure, I was trying to be consistent with the other line, but I'll just change
them both to sizeof.

- Eric
