Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB25F2F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfGDGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 02:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfGDGkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:40:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E337E21882;
        Thu,  4 Jul 2019 06:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562222412;
        bh=Ygjllhhz70c/y1Sp7VkNxefjkSkF0TREGn4/hYbfeps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrG7WqjgqxWsTdGIAGwj0pNE1AihwSysowskrm9NXwk3DoQhz9GXux2+eO/c3iZSG
         ZzZpY3eAxXuHPvPSLeIv5KPRis8Rbhs+tXFBLZasDlEJB6XWzD/uVPFKulo3pxI4KQ
         xNfqITBtoWgUpuF/9wwUnMSrb4wHFJ3Dmbw7OERk=
Date:   Thu, 4 Jul 2019 08:40:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.3
Message-ID: <20190704064010.GA11575@kroah.com>
References: <20190704062259.GA1094@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704062259.GA1094@ogabbay-VM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 09:22:59AM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver for kernel 5.3.
> 
> It mostly contains improvements to the existing code base. Nothing too
> exciting this time.
> 
> Please see the tag message for details on what this pull request contains.
> 
> Thanks,
> Oded
> 
> The following changes since commit 60e8523e2ea18dc0c0cea69d6c1d69a065019062:
> 
>   ocxl: Allow contexts to be attached with a NULL mm (2019-07-03 21:29:47 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-07-04

Pulled and pushed out, thanks.

greg k-h
