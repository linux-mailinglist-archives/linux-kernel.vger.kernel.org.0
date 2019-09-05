Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43901AAD61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbfIEUu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 16:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404044AbfIEUuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:50:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B26206CD;
        Thu,  5 Sep 2019 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567716620;
        bh=BS5DK9GBdZOzJUMu/R6EbA8/+V27Y9jP64qS0hGDPkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lD4VubIrzE/48xBJAIjwzyGN4/bKumoNZppPFl9EkYr/HPs0YWnFNdzjzwiVSxaLO
         ogOhUKz8KSUOa7rjxbP96XIWct20hXalZGL0GV8RNB4Iti7SBg10sD37aoAymGGG+L
         xkVPVVbW/uZhreNy2JttY/Bvku0g1sTv+R1ntWE4=
Date:   Thu, 5 Sep 2019 22:50:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.4
Message-ID: <20190905205017.GA25089@kroah.com>
References: <20190905121934.GA31853@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905121934.GA31853@ogabbay-VM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:19:34PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver for kernel 5.4.
> 
> It contains one major change, the creation of an additional char device
> per PCI device. In addition, there are some small changes and
> improvements.
> 
> Please see the tag message for details on what this pull request contains.
> 
> Thanks,
> Oded
> 
> The following changes since commit 25ec8710d9c2cd4d0446ac60a72d388000d543e6:
> 
>   w1: add DS2501, DS2502, DS2505 EPROM device driver (2019-09-04 14:34:31 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-09-05

Is that a signed tag?  It doesn't seem to me like it is, have you always
sent unsigned tags?

thanks,

greg k-h
