Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDD30480
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfE3WCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 18:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE3WCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:02:22 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915B626223;
        Thu, 30 May 2019 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559253428;
        bh=ADpd0+yMsDnrTF8OERno5hORW9BHTgfmkRfkI2dhT/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9JYJUX9zDkf7Iux+V5B28VTlCSlD5JulFyl06pRUNKxbPaXIKo7eQbUKLehoynbx
         D2NfiKiB4KBfwACPlcQ3iSaDvdOA0tYZFgW0el44S9dyImNj5PXahXkEmEDKNJgxWf
         T1wR0WcBiSn7Gp7o8+MOAGFQBRE49Cdh+br0Pub0=
Date:   Thu, 30 May 2019 14:57:08 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Sherman <benjamin@bensherman.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-dma: sizeof via pointer dereference
Message-ID: <20190530215708.GA20810@kroah.com>
References: <20190530214142.cna6mgdhqgxgaczw@valkyrie-prime.rpi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530214142.cna6mgdhqgxgaczw@valkyrie-prime.rpi>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 09:41:43PM +0000, Benjamin Sherman wrote:
> Pass the size of a struct into kzalloc by pointer dereference.  This
> complies with the Linux kernel coding style and removes the possibility
> for a bug when the pointer's type is changed.
> 
> Signed-off-by: Benjamin Sherman <benjamin@bensherman.io>
> ---
> This is my first patch, so please forgive any seemingly obvious
> mistakes.  I apologize if this is the incorrect mailing list.
> ---
>  drivers/staging/mt7621-dma/mtk-hsdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can you resend and properly cc: the needed developers and mailing list
that scripts/get_maintainer.pl says to cc:?

thanks,

greg k-h
