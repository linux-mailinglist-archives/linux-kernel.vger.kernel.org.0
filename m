Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A158D5BC59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 15:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfGANG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 09:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:06:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B5E82173C;
        Mon,  1 Jul 2019 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561986386;
        bh=0X0xr4A7yYrG88nxD8R2S/Y/4CZFGGbMeK7o6zhraFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fq5iKGr574swSgHzgPoMk3E/2hgbWtd2u/3USny8p5dKiUWJditre/gmizKGMOhaX
         3w0xeQTmuE2MqBYWIkmCeyJmOWU2DHQaV4r6RshKTvh0K9ukMv8KwMwWPjsVHn6YKB
         2VijRdELCMEmYpow2KNWfnfL2zj1CeDBN7z3ruZw=
Date:   Mon, 1 Jul 2019 15:05:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.3
Message-ID: <20190701130556.GA14021@kroah.com>
References: <20190701103001.21235-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701103001.21235-1-kishon@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 04:00:01PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.3 merge window below. It adds couple
> of new PHY drivers and other misc driver fixes. Please see the tag message
> for complete list of changes.
> 
> Let me know if I have to change something.
> 
> Thanks
> Kishon
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.3

Now pulled and pushed out, thanks.

greg k-h
