Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAEA6FF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 14:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfGVMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 08:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfGVMKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:10:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D332190D;
        Mon, 22 Jul 2019 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563797407;
        bh=D7rucIM9C6qwRkiitS0j2IO+oWqEriXBgi9bZmKHDGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=US93ZFRVZojVgd4+Oz1dHGM3ahkrIvhMPrq7wiEQppuTtQKNlTe9OZMT7avn6kSAS
         iVMs4PDWZqs3EY/oA0pkCrKOAyQuln2xqEGnzAzYkwxdW6hy56lva9h6HepYe+1UKV
         ijW+TLtNq9l4vBkp43GmX/I71sl3VbEm0f9kvY7Q=
Date:   Mon, 22 Jul 2019 14:10:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.3-rc2
Message-ID: <20190722121005.GA21997@kroah.com>
References: <20190722072621.GA26079@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722072621.GA26079@ogabbay-VM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:26:21AM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs fixes pull request for 5.3-rc2. 
> It contains two minor fixes, nothing too exciting.
> 
> Thanks,
> Oded
> 
> The following changes since commit c8917b8ff09e8a4d6ef77e32ce0052f7158baa1f:
> 
>   firmware: fix build errors in paged buffer handling code (2019-07-22 08:44:40 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-07-22

Pulled and pushed out, thanks.

greg k-h
