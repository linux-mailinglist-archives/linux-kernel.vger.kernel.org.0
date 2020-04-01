Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DB19AE97
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbgDAPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 11:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732442AbgDAPN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:13:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662E420776;
        Wed,  1 Apr 2020 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585754007;
        bh=hyQu1ctMKE8nmrawXsixMKYHfW2cZqRZg1Gi0Y8mBME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkZKt07pTmVTmM0RhAgh++/6UyLFYe3vAvL1BBE/XFMYUBOyV/O+W6D3vzbCg0ymW
         r+ooAhYcElfc5EAf6QDgwWy0V2SiJODiOZs9ZTd7WiQLTbqYxsyD4huPJt2kxAAYec
         X6vRBHCQgkR0d68I4dLKceMJITmjwfRgXF+/nNUw=
Date:   Wed, 1 Apr 2020 17:12:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] tty/sysrq: Export sysrq_mask()
Message-ID: <20200401151222.GA2508664@kroah.com>
References: <20200401143904.423450-1-dima@arista.com>
 <20200401144610.GA2433317@kroah.com>
 <b0099c8c-5bab-960a-8d0d-4691e11a462f@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0099c8c-5bab-960a-8d0d-4691e11a462f@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 03:49:56PM +0100, Dmitry Safonov wrote:
> On 4/1/20 3:46 PM, Greg Kroah-Hartman wrote:
> > On Wed, Apr 01, 2020 at 03:39:04PM +0100, Dmitry Safonov wrote:
> >> Build fix for serial_core being module:
> >>   ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Jiri Slaby <jslaby@suse.com>
> >> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> >> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> >> Signed-off-by: Dmitry Safonov <dima@arista.com>
> >> ---
> >>  drivers/tty/sysrq.c | 1 +
> >>  1 file changed, 1 insertion(+)
> > 
> > Is this a new problem?  What commit does this fix?
> 
> Right, sorry I've managed to forget adding the tag:
> 
> Fixes: eaee41727e6d ("sysctl/sysrq: Remove __sysrq_enabled copy")
> 
> Maybe also:
> 
> Link:
> https://lore.kernel.org/linux-fsdevel/87tv23tmy1.fsf@mpe.ellerman.id.au/

Thanks, that works.  WIll queue this up after -rc1 is out.

greg k-h
