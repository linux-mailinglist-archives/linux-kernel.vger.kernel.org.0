Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5661215833B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 20:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBJTEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 14:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgBJTEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:04:22 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590592080C;
        Mon, 10 Feb 2020 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581361460;
        bh=AFgD6yboFm7FOthsnmhCQT4RoIp6cfaXMDxquhOOyKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DW5Zh/4t4VXQlbOMIdk3zlSNpDHgMj/RpVNS2BL7mthv3qF5DUkTxEDoEckEMBCXG
         wBlkN3z1eRavm9iBlwZjFqMXgz06jQkuCCkpJ+sVn9VoXkbrPGklVjWjwETE/E/fW/
         U4ryYv0SAT251feye1DOc2FX0eE7t3aEhTJ0h5XI=
Date:   Mon, 10 Feb 2020 11:04:19 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
Message-ID: <20200210190419.GC1058087@kroah.com>
References: <00000000000095e1d8059d4675ac@google.com>
 <20200131050651.hlq27kehtir3agf2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131050651.hlq27kehtir3agf2@kili.mountain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:06:52AM +0300, Dan Carpenter wrote:
> We changed this from dev_err() to dev_WARN() in commit 0cb54a3e47cb
> ("USB: debugging code shouldn't alter control flow").
> 
> The difference between dev_WARN() and dev_err() is that dev_WARN()
> prints a stack trace and if you have panic on OOPS enabled then it leads
> to a panic.  The dev_err() function just prints the error message.
> 
> Back in the day we didn't have usb emulators fuzz testing the kernel
> so dev_WARN() didn't cause a problem for anyone, but these days the
> dev_WARN() interferes with syzbot so let's change this to a dev_err().
> 
> Reported-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> 
>  drivers/usb/core/urb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index da923ec17612..0980c1d2253d 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -475,7 +475,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
>  
>  	/* Check that the pipe's type matches the endpoint's type */
>  	if (usb_urb_ep_type_check(urb))
> -		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
> +		dev_err(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
>  			usb_pipetype(urb->pipe), pipetypes[xfertype]);

Like others said, we should have the stack trace here.  So can you
change this to dev_warn() and a stacktrace?

thanks,

greg k-h
