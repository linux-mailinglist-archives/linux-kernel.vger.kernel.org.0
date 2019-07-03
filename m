Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAB25DEC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGCHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 03:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfGCHWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:22:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0392187F;
        Wed,  3 Jul 2019 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562138527;
        bh=PFpMLdbDgQ6ffBDsYgeYQhLec0dTBHClDOXUnMEzacI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zf3IUxagZeRTlzz37sz3ajpvRMhA/5gcvi6GVHeaEWu7rWjUFd4g7ETw5BSgXgFJU
         BEb5569cGgLzJRiMzB8SoaEhi9B+Mw11qtVUlwNBa4GPh6xKiu5YspiN64hFR9hmG3
         P2/NDVfyy3g0pQ1WUGDlTxt0ga28lfUC7DVwTpsI=
Date:   Wed, 3 Jul 2019 09:22:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] FSI changes for 5.3
Message-ID: <20190703072204.GC3033@kroah.com>
References: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 03:39:17AM +0000, Joel Stanley wrote:
> Hello Greg,
> 
> We've not had a MAINAINERS entry for drivers/fsi, so this fixes that. It names
> Jeremy and I as maintainers, so if it works for you we will send pull requests
> to you each cycle.
> 
> I realise this one is a bit late, but please consider including so we have a
> clear path for future submissions from 5.3 on.
> 
> This pull request contains two code changes. One touches hwmon and has an ack
> from Guenter as the hwmon maintainer.
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-5.3

Pulled and pushed out, thanks for doing this!

greg k-h
