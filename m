Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA1ACECA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfIHNDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 09:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfIHNDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:03:39 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC47320640;
        Sun,  8 Sep 2019 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947819;
        bh=4SIt8Ad08SY/w8EN5vg534bwrOyvqWWtILnJDS3t184=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhIO9ZkdDl4a0gCPWrqge2n2u2agda81Lw0TYOhwKeuSrEvRwNcOewGogrPMtLItG
         xjT9YpPhKUuCgrqDiCNE22ruShzPnOm9xjBt4RlwsuD1/A2RxC1XhIWta1SGv5O54f
         Et2UIwLIP0r7i/1Xs3SB0twiOBSIpEYk/sdceWno=
Date:   Sun, 8 Sep 2019 14:03:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add millisecond support
Message-ID: <20190908130337.GA9056@kroah.com>
References: <20190908124808.23739-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908124808.23739-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 12:48:08PM +0000, Valentin Vidic wrote:
> Drop duplicated date_time_t struct and add millisecond handling for
> create and modify time. Also drop millisecond field for access time
> since it is not defined in the the spec.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  drivers/staging/exfat/exfat.h       |  38 +++---
>  drivers/staging/exfat/exfat_core.c  |  31 ++++-
>  drivers/staging/exfat/exfat_super.c | 174 ++++++++--------------------
>  3 files changed, 92 insertions(+), 151 deletions(-)

Please run checkpatch on your patches so that we don't have to go and
fix up those issues later on.

Also, can you break this up into smaller patches please?  You are doing
multiple things all at once.

And, are you sure about the millisecond field for access time stuff?  It
was obviously added for some reason (there are lots in the spec that the
code does not yet cover, this seems odd being the other way around).
Did you test it against any other operating system exfat images to
ensure that it really is not being used at all?  If so, which ones?

thanks,

greg k-h
