Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984F6F6863
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfKJKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 05:14:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfKJKOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:14:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E71207FA;
        Sun, 10 Nov 2019 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573380862;
        bh=I8uBTdBu6y3d7ebGvaS+Jksj8GBV3jRw44ugdooGv6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFkq0L70MN7yEadD6XEv0rZ/ogssi+tDsA90t3Z4xy2h9nocWlOnZHrXaOBeISL8L
         JX/yhEWR8eIE1pxEjWN2Xk1GON5l/JLt+VMspZh3HifclGJ4GZb7edSNpxaZr4mD8k
         EHWXbQsyYQhr0OqAqTC/yR7tv/r+aFXHrO0lzOYg=
Date:   Sun, 10 Nov 2019 11:14:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: "statsfs" API design
Message-ID: <20191110101418.GA1441328@kroah.com>
References: <20191109184441.GA5092@avx2>
 <20191110091435.GC1435668@kroah.com>
 <20191110100913.GA5064@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110100913.GA5064@onstation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 05:09:13AM -0500, Brian Masney wrote:
> On Sun, Nov 10, 2019 at 10:14:35AM +0100, Greg KH wrote:
> > On Sat, Nov 09, 2019 at 09:44:41PM +0300, Alexey Dobriyan wrote:
> > > > statsfs is a proposal for a new Linux kernel synthetic filesystem,
> > > > to be mounted in /sys/kernel/stats
> > > 
> > > I think /proc experiment teaches pretty convincingly that dressing
> > > things into a filesystem can be done but ultimately is a stupid idea.
> > > It adds so much overhead for small-to-medium systems.
> > > 
> > > > The first user of statsfs would be KVM, which is currently exposing
> > > > its stats in debugfs
> > > 
> > > > Google has KVM patches to gather statistics in a binary format
> > > 
> > > Which is a right thing to do.
> > 
> > It's always "simpler" to just take binary data and suck it in.  That
> > works for a year or so until another value needs to be supported.  Or
> > removed.  Or features are backported.
> > 
> > The reason text values in individual files work is they are "self
> > describable" and "self discoverable".  You "know" what the value is and
> > that it is supported because the file is there or not.  With binary
> > values in a single file you do not know any of that.
> > 
> > So you need some way of describing the data to userspace in order for
> > this to work properly over the next 20+ years.
> > 
> > Maybe something like varlink which describes the data coming from the
> > kernel in an easy-to-handle format?  Or something else, but just using
> > blobs does not work over the long-term, sorry.
> 
> What about using a text format like YAML? Here's some benefits:
> 
>   - The fields are self describing based on the key name.
>   - New fields can be easily added without breaking compatibility.
>   - Allows for a script to easily parse the contents while keeping
>     human readability.
>   - Would work for systems that run busybox as their userspace without
>     having to install additional tools.
>   - Allows for a nested data structure.

varlink was created to solve the issues that people have had with YAML
over time, so you might want to look into that :)
	https://varlink.org/

> The downside is that the output would be larger than a binary interface
> but it's more maintainable in my opinion.

binary interfaces are unmaintainable over time, especially when you do
not control both sides of the interface (unlike Google and their use of
this for KVM stats.)

thanks,

greg k-h
