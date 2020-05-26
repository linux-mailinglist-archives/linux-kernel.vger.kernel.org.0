Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B34219AE3E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 16:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgDAOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 10:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733111AbgDAOqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:46:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0893B206F6;
        Wed,  1 Apr 2020 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585752372;
        bh=35rZ+7TtMwaCXUuzYbOGlS5TJ0pxBgzyQj8nN1jLwu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbMUAZ4dsoge3+TdaE/TXoijvI4yRPr9HSvgupcvDavJCLAO1Dqbalqt5wGo/SVEV
         4B/sjnii/gqAtM7iwzAmC7bu77UmX74FI2BxeE1VJM9oKVzeXzteuf24JRQZ2gPVzj
         vPT0GoVyqP5M/IXqDPb2kez8pXkyMxkolc2zLvqQ=
Date:   Wed, 1 Apr 2020 16:46:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] tty/sysrq: Export sysrq_mask()
Message-ID: <20200401144610.GA2433317@kroah.com>
References: <20200401143904.423450-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401143904.423450-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 03:39:04PM +0100, Dmitry Safonov wrote:
> Build fix for serial_core being module:
>   ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/tty/sysrq.c | 1 +
>  1 file changed, 1 insertion(+)

Is this a new problem?  What commit does this fix?

thanks,

greg k-h
