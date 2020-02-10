Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D2157E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgBJPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 10:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgBJPTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:19:16 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D359206ED;
        Mon, 10 Feb 2020 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581347955;
        bh=JqaNMooa6dE5vSnfD9rwkvCtggIprvOdi7XG448QR40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtjiMHXEg2E9MoB5ocWMybjprlQPDyTnSWglv3Rx7JV2pDWQJZX3Yxhj7FEyHIUZ9
         sRup8fP/LSYmY6WQoxcKADmXbUnNnhGeGhtKvWe8/3qRfPFz84N7KkJqmlfKDHtlss
         gaipYqNj01BwFElHx9vdrfdwKNHkUlzmlPmrwkTI=
Date:   Mon, 10 Feb 2020 07:19:15 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] powerpc: powernv: no need to check return value of
 debugfs_create functions
Message-ID: <20200210151915.GA686798@kroah.com>
References: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
 <20200209105901.1620958-6-gregkh@linuxfoundation.org>
 <CAOSf1CEKwjDkp-=SMjmJfQirxdGCkadougZbdDS6FK1muNNCZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CEKwjDkp-=SMjmJfQirxdGCkadougZbdDS6FK1muNNCZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:01:53AM +1100, Oliver O'Halloran wrote:
> On Mon, Feb 10, 2020 at 12:12 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> For memtrace debugfs is the only way to actually use the feature. It'd
> be nice if it still printed out *something* if it failed to create the
> files rather than just being mysteriously absent, but maybe debugfs
> itself does that. Looks fine otherwise.

No, debugfs will only spit out an error message to the log if a
file/directory is attempted to be created for an already present
file/directory.

For other failures, no error will be printed, other than the normal
lower-level "out of memory" issues that might rarely happen.

thanks,

greg k-h
