Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F9100D63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 22:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKRVCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 16:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfKRVCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:02:50 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814232230C;
        Mon, 18 Nov 2019 21:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574110969;
        bh=a9vMYyllcb3gUHdpiiVPt9cfrewV13thVHZ2UmvwyMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n+6S+KFJNTvRFatmv8GN66bVEgtHZ9W5jOJRCrH0LLcp8HDqVSa77ahulo1tUvtQu
         C78BVV99K6wTdF6bUZjr6svwQcJ7hTq+M/sQR3s0YrThMMuloVhUgBebZ9ev4i7csn
         2ePpEzt1DJfF7RKmaWYXJGYUkKzSP+1kVIr8GEjo=
Date:   Mon, 18 Nov 2019 13:02:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/2] mm: Fix a huge pud insertion race during faulting
Message-Id: <20191118130249.2ec96ffdf9a1aeb4f3e820dd@linux-foundation.org>
In-Reply-To: <b8600932-517d-99d3-90b4-d9b9e8a6f641@shipmail.org>
References: <20191115115808.21181-1-thomas_os@shipmail.org>
        <20191115115808.21181-2-thomas_os@shipmail.org>
        <20191115115800.45c053abcdb550d70b9baec9@linux-foundation.org>
        <20191118102219.om5monxih7kfodyz@box>
        <b8600932-517d-99d3-90b4-d9b9e8a6f641@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 13:58:04 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> >> Is a -stable backport warranted?
> > I believe it is.
>=20
> Note that this was caught during a code audit rather than a real=20
> experienced problem. It looks to me like the only implementation that=20
> currently creates huge pud pagetable entries is dev_dax_huge_fault()=20
> which doesn't appear to care much about private (COW) mappings or=20
> write-tracking which is, I believe, a prerequisite for create_huge_pud()=
=20
> falling back on thread 1, but not in thread 2.
>=20
> This means (assuming that's intentional) that a stable backport=20
> shouldn't be needed.
>=20
> For the WIP huge page support for graphics memory we'll be allowing both=
=20
> COW mappings and write-tracking, though, but that's still some time away.
>=20
> In any case, I think this patch needs -rc testing to catch potential=20
> pud_devmap issues before submitted to stable.

OK, thanks, I'll queue it for 5.5-rc1 with a -stable tag.  Hopefully
that way it will get a bit of exposure before the stable trees pick it
up.  Maybe this is optimistic..

