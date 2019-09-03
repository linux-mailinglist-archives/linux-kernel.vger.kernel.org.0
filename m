Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5001A7417
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfICT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 15:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfICT4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:56:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A99C207E0;
        Tue,  3 Sep 2019 19:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567540613;
        bh=2/37sJPnUxxD47PUnZ3POQ1Y47PcdSEHSMljEYEH3v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xT35FxMKW8XUYLwyDYWBalquVdvfv8gCXbyKHwXC0NWjCXLQPp6OelYhcJy9xhoHA
         tFQqgYGrpFuDyHrk45RRwxnFFQgV/iqbB3gF+85k12aW6Bj/t6Bq3RRsgEiSs319Pz
         oP+2GItBkp08rvNbUDu7pXLGtzK8CcG/9TbGfrAE=
Date:   Tue, 3 Sep 2019 21:56:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt changes for v5.4
Message-ID: <20190903195651.GD13390@kroah.com>
References: <20190831135616.GR3177@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831135616.GR3177@lahna.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 04:56:16PM +0300, Mika Westerberg wrote:
> Hi Greg,
> 
> The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:
> 
>   Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v5.4

Pulled and pushed out, thanks.

greg k-h
