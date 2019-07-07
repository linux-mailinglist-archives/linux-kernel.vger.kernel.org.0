Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B040760F7B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfGFIek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 04:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfGFIek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 04:34:40 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B7320989;
        Sat,  6 Jul 2019 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562402079;
        bh=LHNC9eeGrAB0uTsxblnJlRRfFfF4uFlG15ruCcDfwS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3wRFp6CiBmHdXZAg9qp4Qr7ZSInxnqbcQLfO8EqCiG7B0rtPp6uvdXtGmmAEefOR
         RTFwUBY5qQVTHKP278vTCJH6xn5mi9kXauyrRpJr3aKMpgTArtHfIyvB3PKMaQM2vs
         c9MT371IOFxcEwR8ihjI8aUrCT74BT7MEAHqfjoI=
Date:   Sat, 6 Jul 2019 10:34:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 4
Message-ID: <20190706083433.GB9249@kroah.com>
References: <20190704220945.27728dd9@canb.auug.org.au>
 <20190704222450.021c9d71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704222450.021c9d71@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 10:24:50PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> This release produces a whole lot (over 200) of this message in my qemu
> boot tests:
> 
> [    1.698497] debugfs: File 'sched' already present!
> 
> Introduced by commit
> 
>   43e23b6c0b01 ("debugfs: log errors when something goes wrong")
> 
> from the driver-core tree.  I assume that the error(?) was already
> happening, but it is now being reported.

What are you passing to qemu to get this?  I just tried it myself and
see no error reports at all.  Have a .config I can use to try to
reproduce this?

And from a recent syzbot report, I don't think you are alone, as I saw
the messages showing up there too...

thanks,

greg k-h
