Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CFED551A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfJMHvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 03:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfJMHvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 03:51:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 746DA2082F;
        Sun, 13 Oct 2019 07:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570953081;
        bh=xqe5fzWkqRn8ZLk2K1POoXYmKzVrl5qJFQYjJR3VfjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kM0ID2XreHV8D8yhFdl9IdYh0EkbXNEoUEBn6/z5g5ElnqhbYQkaMbv4KxYL3yCy9
         hCJSQp36K5vXJ716stWPXRRIze9/Fr4Ad3lwJgRz+CrF2x5skm3oZ1eXRWNZAHiUsU
         6WOToNiHSQIDScpbPOhQdNyCfoEAzGs6jCkSOFAY=
Date:   Sun, 13 Oct 2019 09:51:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3.6
Message-ID: <20191013075118.GB2206301@kroah.com>
References: <48afc878-5424-7554-cd02-4175ec12eaea@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48afc878-5424-7554-cd02-4175ec12eaea@googlemail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 08:16:26PM +0100, Chris Clayton wrote:
> 
> > I'm announcing the release of the 5.3.6 kernel.
> 
> 
> 5.3.6 build fails here with:
> 
> arch/x86/entry/vdso/vdso64.so.dbg: undefined symbols found
>   CC      arch/x86/kernel/cpu/mce/threshold.o
> make[3]: *** [arch/x86/entry/vdso/Makefile:59: arch/x86/entry/vdso/vdso64.so.dbg] Error 1
> make[3]: *** Deleting file 'arch/x86/entry/vdso/vdso64.so.dbg'
> make[2]: *** [scripts/Makefile.build:497: arch/x86/entry/vdso] Error 2
> make[1]: *** [scripts/Makefile.build:497: arch/x86/entry] Error 2
> make[1]: *** Waiting for unfinished jobs....

Does 5.3.5 work?  If so, can you do 'git bisect' to find the offending
patch?

thanks,

greg k-h
