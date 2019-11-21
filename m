Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA6105763
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 17:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfKUQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 11:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUQrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:47:49 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8EF20672;
        Thu, 21 Nov 2019 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574354869;
        bh=Rhz53Nthy9abK6KiEjsCvKG+KEUuxWCEJqroR7XTPC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOg27dHu45rQGktSVBJnfOB142+0v88mpq5X3S4n3cFa1ycoXQUNzYNkC+HSXVuok
         o+NqmWg1iSBXfIM+p2vxqpg9wZgVqzvpd3rsQVwljW7zQ22VxePR7kNjetPrHNVbTs
         jjJIca0IUOiAEBQk5pVVKdJbSU2jNJ7HeszVB1zA=
Date:   Thu, 21 Nov 2019 17:47:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.5
Message-ID: <20191121164744.GG651886@kroah.com>
References: <20191121144223.GA14312@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121144223.GA14312@ogabbay-VM>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 04:42:23PM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver for kernel 5.5.
> 
> It mainly contains improvements to MMU and reset code, and exposes more
> information through our INFO IOCTL.
> 
> Please see the tag message for more details on what this pull request
> contains.
> 
> Thanks,
> Oded
> 
> The following changes since commit ab64ec1db25e0cceab0bad15b03fd57e2b461b15:
> 
>   misc: Fix Kconfig indentation (2019-11-20 15:09:49 +0100)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-11-21

Pulled and pushed out, thanks.

greg k-h
