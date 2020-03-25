Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B547192548
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 11:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCYKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 06:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgCYKSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:18:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E17720714;
        Wed, 25 Mar 2020 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585131520;
        bh=vI8LFTyz5Vq9/z5lQwj1E6QK6Uev1lXJRRMlcnFd5gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1TLVixntVyMsAE9qTgqfRdKf8Vvfd00zUNuVbYMb8rxbCMQablQELX5sGUuckK0mG
         7F4HUrQJ4LsbSvkdz9xzONfwA1OSGNKIN5ubHHwxfklZQZL5xcjTQ59VRKPCWEda4e
         7Ji4zI2+HhoPJj3Y10S3FhrPP8rc7wotLh5bWksI=
Date:   Wed, 25 Mar 2020 11:18:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] .gitignore: add SPDX License Identifier
Message-ID: <20200325101838.GA3084128@kroah.com>
References: <20200303133600.9263-1-masahiroy@kernel.org>
 <20200303133600.9263-2-masahiroy@kernel.org>
 <CAK7LNARZUpDKXpniNZ+_=G5Gskebc0HEHT5TKbaz2Xs_Ni6u4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARZUpDKXpniNZ+_=G5Gskebc0HEHT5TKbaz2Xs_Ni6u4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 07:10:03PM +0900, Masahiro Yamada wrote:
> On Tue, Mar 3, 2020 at 10:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Add SPDX License Identifier to all .gitignore files.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> 
> Ping?

Ah, I just assumed you would take these through your tree, sorry about
that.

Both look find:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Or do you want me to take these?

thanks,

greg k-h
