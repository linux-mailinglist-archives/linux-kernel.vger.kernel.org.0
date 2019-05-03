Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CF131E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfECQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:10:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54A920651;
        Fri,  3 May 2019 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556899852;
        bh=IHAD1xkHOGtFOzVEp9fxb0mJPCYNZhC4tbr+OPKAX9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOb3GdpG+6i+sMdwWfccrbzNf9OGSU91S0dzpyTDqZTo0XsFq+AjGbWVpdRr/3XoX
         Ou2/hfVFeCq+Lwl3vswfE9hMtkhxuN+AME9hm4KXO7gsBNfU7vzkNEiFxTBBplLh7h
         q3ecOly9zxd/ue3+LR/bVnmNU46PiUk3qe9uAH9I=
Date:   Fri, 3 May 2019 18:10:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] GNSS updates for 5.2-rc1
Message-ID: <20190503161041.GA654@kroah.com>
References: <20190503155805.GA12685@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503155805.GA12685@localhost>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 05:58:05PM +0200, Johan Hovold wrote:
> The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:
> 
>   Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.2-rc1

Now pulled and pushed out, thanks.

greg k-h
