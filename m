Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1AB11CBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 12:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfLLLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 06:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfLLLIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:08:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B501F2173E;
        Thu, 12 Dec 2019 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576148916;
        bh=deuLf2nnBJBe69PXS9rhbsEM6xSlAG5E9wksUh2vIGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qokv9s00FXWaCas/YvTf8ieF6dvHFVZWeE4UOASx2X8fW/k5tTojjPgKXDu2PriWX
         T6cYdZuab8ZzaBfkoL1AvO1EG/plsq3KWnMFAPmXnjoEicfFOe46EFlmc5ORblRIto
         HmcQRe9zpzZETLHRiMDipSW46/WqKrHb6LaxIcJw=
Date:   Thu, 12 Dec 2019 12:08:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] tty: serial: samsung_tty: use 'unsigned int' not
 'unsigned'
Message-ID: <20191212110834.GB1490894@kroah.com>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-8-gregkh@linuxfoundation.org>
 <eb3cf8f9-3606-c2d6-ad90-4388a52c320b@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3cf8f9-3606-c2d6-ad90-4388a52c320b@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:12:07PM +0100, Marc Gonzalez wrote:
> [ Trim recipients list ]
> 
> On 10/12/2019 15:37, Greg Kroah-Hartman wrote:
> 
> > The function uart_console_write() expects an unsigned int, so use that
> > variable type, not 'unsigned', which is generally frowned apon in the
> > kernel now.
> 
> "frowned upon"
> 
> Wait, what?!
> 
> 'unsigned' and 'unsigned int' are the same type, if I remember my C
> lessons correctly.
> 
> Is this a uniformization issue?

Yes.  It's a long-time checkpatch warning, it's good to be explicit for
this type of thing.

thanks,

greg k-h
