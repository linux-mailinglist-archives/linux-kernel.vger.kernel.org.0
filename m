Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB35F852
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfGDMkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 08:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbfGDMkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:40:10 -0400
Received: from localhost (unknown [89.205.128.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8648B2082E;
        Thu,  4 Jul 2019 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562244009;
        bh=Dg6E6spylfkSYzp+dH8xuoGlslv5RTNRs4e7ma6/gxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHWoi76spS7D37Em1G1Ol+M/BRzeEKM7UHA3Qx+3I87kXPq9Do7fwcyFYUX1Tl6ic
         foyeb46xwkST0KD0RxCU587FOWHx5EigV3hKMUGpqkopLOyno+LAueEo3Q7WvfSUPu
         qUakIsWHxbOS3VZgyHlDNMP6ott3OWjahW0V4aWk=
Date:   Thu, 4 Jul 2019 14:40:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 4
Message-ID: <20190704124005.GA6733@kroah.com>
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

Ugh.

Looks like it's one of the block scheduler, and it seems to be creating
that directory in the root of debugfs, not in a subdir like it is trying
to do so.  Odd, let me look into it some more.

Oh, and I guess we might want to move this down to a 'dev_dbg' message,
although this is showing that there is a problem here, so it did succeed
:)

thanks,

greg k-h
