Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8818DE4E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 07:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgCUGpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 02:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgCUGpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 02:45:14 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB79206F9;
        Sat, 21 Mar 2020 06:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584773113;
        bh=kCtRiTU7crd5ifKSb3kmQ7l5gFP8U6qpxWv87hCw/p8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NNpbUJEoMq2YS88femhVeYjAXVTEfjwAmJHB33aqr9h6UaOry15uZl8mcckGB3pg/
         B68T8AYTq4GuH3+U/0dMUT+XnUSBgPtwAJkqHros+KGiRhbq1yDETi90l50ch484dr
         /zg6lJXhue6kSwpaU+IKrxZQ7y/LpEpvkFaxJ2jM=
Date:   Fri, 20 Mar 2020 23:45:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Entropy Moe <3ntr0py1337@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: KASAN: stack-out-of-bounds Write in mpol_to_str
Message-Id: <20200320234513.9b05abe1ade85712db2d6478@linux-foundation.org>
In-Reply-To: <CALzBtj+8AYASaYW2fqgmgthCgeAJ2N0Q+ey2wqgEKjBtH34Vcg@mail.gmail.com>
References: <CALzBtjLSqFhSNAf4YusxuE1piUTzOSLFGFD4RrhPLQAmgpyL5g@mail.gmail.com>
        <9e699198-d1e4-f285-f4ed-15fbf8a8c16e@infradead.org>
        <CALzBtj+8AYASaYW2fqgmgthCgeAJ2N0Q+ey2wqgEKjBtH34Vcg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 12:36:38 +0400 Entropy Moe <3ntr0py1337@gmail.com> wrote:

> Hello Randy,
> please see attached POC for the vulnerability.
> 

Thanks.  Ouch.  afaict shmem's S_IFREG inode's mpol's preferred_node is
messed up.

I don't think anyone has worked on this code in a decade or more.  Is
someone up to taking a look please?


> On Mon, Mar 16, 2020 at 10:46 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 3/15/20 12:57 PM, Entropy Moe wrote:
> > > Hello team,
> > > how are you ?
> > > I wanted to report a bug on mempolicy.c. I found the bug on the latest
> > version of the kernel.
> > >
> > > which is stack out of bound vulnerability.
> > >
> > > I am attaching  report.
> > >
> > > If you need the POC crash code, I can provide.
> >
> > Hi Moe,
> >
> > Please post the POC code and your kernel .config file.
> >
> > thanks.
> > --
> > ~Randy
> >
> >
