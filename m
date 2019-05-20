Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF1E231F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 13:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfETLFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 07:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732235AbfETLFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:05:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B2A206B6;
        Mon, 20 May 2019 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558350310;
        bh=VwQSMr5Rvx+iTC5OoVTUamKLhLW6uSee5o3V25yr4TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fF9P8PNhrc6oWUssYT1FD3oqgs7I5ECIp9YF3zNo77k9bLGVbFI+SbCOjbHjn9Syf
         zeb2/LeLpac4nqYDKzrZFfOByIPFnWqxIFvvn7A/RBJ1m8X1IJ67qBnOT2m3wJuWOn
         LA7yOl3IQbLmLAAdWusF0cdD9LkXYGrJmYLpogGo=
Date:   Mon, 20 May 2019 13:05:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lech Perczak <l.perczak@camlintechnologies.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Piotr Figiel <p.figiel@camlintechnologies.com>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Recurring warning in page_copy_sane (inside copy_page_to_iter)
 when running stress tests involving drop_caches
Message-ID: <20190520110508.GA20211@kroah.com>
References: <d68c83ba-bf5a-f6e8-44dd-be98f45fc97a@camlintechnologies.com>
 <14c9e6f4-3fb8-ca22-91cc-6970f1d52265@camlintechnologies.com>
 <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com>
 <20190515144352.GC31704@bombadil.infradead.org>
 <20190515150406.GA22540@kroah.com>
 <20190515152035.GE31704@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515152035.GE31704@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 08:20:35AM -0700, Matthew Wilcox wrote:
> On Wed, May 15, 2019 at 05:04:06PM +0200, Greg Kroah-Hartman wrote:
> > > Greg, can you consider 6daef95b8c914866a46247232a048447fff97279 for
> > > backporting to stable?  Nobody realised it was a bugfix at the time it
> > > went in.  I suspect there aren't too many of us running HIGHMEM kernels
> > > any more.
> > > 
> > 
> > Sure, what kernel version(s) should this go to?  4.19 and newer?
> 
> Looks like the problem was introduced with commit
> a90bcb86ae700c12432446c4aa1819e7b8e172ec so 4.14 and newer, I think.

Thanks, now queued up.

greg k-h
