Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB7F680D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfKJJOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 04:14:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfKJJOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 04:14:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56AD320854;
        Sun, 10 Nov 2019 09:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573377277;
        bh=iXYcjJF2QbR0X3I4+SZ8RcHGCAwVI+5NgsV0GWb7dsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hs8oYq5iGWXDnjohem3kHevM/kLJykYtv5Jj3pDqZz+GhHyLj4HzS+SZQbd2MzF/h
         t8JCln2ZhndeyYwqSDIQkY717eLSFw+iCNB0dc73WFSZkl9TPLSloBt4ymnp+tiPFp
         nAdCLo9yjxIbR5MN2a0y6Rjuy2wUK7ahPbrGCJfw=
Date:   Sun, 10 Nov 2019 10:14:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: "statsfs" API design
Message-ID: <20191110091435.GC1435668@kroah.com>
References: <20191109184441.GA5092@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109184441.GA5092@avx2>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2019 at 09:44:41PM +0300, Alexey Dobriyan wrote:
> > statsfs is a proposal for a new Linux kernel synthetic filesystem,
> > to be mounted in /sys/kernel/stats
> 
> I think /proc experiment teaches pretty convincingly that dressing
> things into a filesystem can be done but ultimately is a stupid idea.
> It adds so much overhead for small-to-medium systems.
> 
> > The first user of statsfs would be KVM, which is currently exposing
> > its stats in debugfs
> 
> > Google has KVM patches to gather statistics in a binary format
> 
> Which is a right thing to do.

It's always "simpler" to just take binary data and suck it in.  That
works for a year or so until another value needs to be supported.  Or
removed.  Or features are backported.

The reason text values in individual files work is they are "self
describable" and "self discoverable".  You "know" what the value is and
that it is supported because the file is there or not.  With binary
values in a single file you do not know any of that.

So you need some way of describing the data to userspace in order for
this to work properly over the next 20+ years.

Maybe something like varlink which describes the data coming from the
kernel in an easy-to-handle format?  Or something else, but just using
blobs does not work over the long-term, sorry.

greg k-h
