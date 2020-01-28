Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6024014B08F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 08:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgA1Hux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 02:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgA1Hux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:50:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EF620678;
        Tue, 28 Jan 2020 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580197853;
        bh=JCv/NyT1mrCMzv4okq1iCXZ4H3lbeVqPn9G8p80jpHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyt9jvL5L0NnbDojGspxXNnhsNhkwfABkWI0Z4r7ASOU7AsbfRmykIZJaJ56g6DWJ
         Np6+0WBmRaH8cp1VdbYbrJkoyFgFQyhoYJ5HGPD7EG4gFeGZsZEGYNjIsquamurMHO
         +zA1HLMGAxKsUlurc2zGowhd4rL6JzqZEubIQzSM=
Date:   Tue, 28 Jan 2020 08:50:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        notify@kernel.org
Subject: Re: [PATCH v2 1/1] lkdtm/stackleak: Make the test more verbose
Message-ID: <20200128075050.GC2105706@kroah.com>
References: <20200102234907.585508-1-alex.popov@linux.com>
 <e8f1b3e9-50ae-2482-3e10-32b21cd7ebb4@linux.com>
 <202001271514.345A5CC9C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001271514.345A5CC9C@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:15:08PM -0800, Kees Cook wrote:
> On Wed, Jan 22, 2020 at 02:58:44PM +0300, Alexander Popov wrote:
> > On 03.01.2020 02:49, Alexander Popov wrote:
> > > Make the stack erasing test more verbose about the errors that it
> > > can detect.
> > > 
> > > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> > > ---
> > >  drivers/misc/lkdtm/stackleak.c | 25 +++++++++++++++++--------
> > >  1 file changed, 17 insertions(+), 8 deletions(-)
> > 
> > Hello!
> > 
> > Pinging about this version of the patch.
> > 
> > Kees, it uses dump_stack() instead of BUG(), as we negotiated.
> 
> Yup, this is in my queue -- I've just gotten back from travelling and
> will get to it shortly. :)
> 
> Greg, feel free to take this directly if you want, too.

If I were to take it, it would have to wait until after 5.6-rc1, sorry.

thanks,

greg k-h
