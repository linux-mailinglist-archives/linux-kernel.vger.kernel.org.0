Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD8BAFEE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfIWIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 04:50:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731680AbfIWIur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:50:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 886DDAAB2;
        Mon, 23 Sep 2019 08:50:45 +0000 (UTC)
Date:   Mon, 23 Sep 2019 10:50:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Lucian Adrian Grijincu <lucian@fb.com>, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@fb.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm: memory: fix /proc/meminfo reporting for
 MLOCK_ONFAULT
Message-ID: <20190923085045.GC6016@dhcp22.suse.cz>
References: <20190913211119.416168-1-lucian@fb.com>
 <20190916152619.vbi3chozlrzdiuqy@box>
 <20190917101519.GD1872@dhcp22.suse.cz>
 <20190917113550.v6nool7oizht66fx@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917113550.v6nool7oizht66fx@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-09-19 14:35:50, Kirill A. Shutemov wrote:
> On Tue, Sep 17, 2019 at 12:15:19PM +0200, Michal Hocko wrote:
> > On Mon 16-09-19 18:26:19, Kirill A. Shutemov wrote:
> > > On Fri, Sep 13, 2019 at 02:11:19PM -0700, Lucian Adrian Grijincu wrote:
> > > > As pages are faulted in MLOCK_ONFAULT correctly updates
> > > > /proc/self/smaps, but doesn't update /proc/meminfo's Mlocked field.
> > > 
> > > I don't think there's something wrong with this behaviour. It is okay to
> > > keep the page an evictable LRU list (and not account it to NR_MLOCKED).
> > 
> > evictable list is an implementation detail. Having an overview about an
> 
> s/evictable/unevictable/
> 
> > amount of mlocked pages can be important. Lazy accounting makes this
> > more fuzzy and harder for admins to monitor.
> > 
> > Sure it is not a bug to panic about but it certainly makes life of poor
> > admins harder.
> 
> Good luck with making mlock accounting exact :P

I didn't say exact. All I am saying is that the more imprecise it will
be the harder it is for admin to make any sense of the value.

> For start, try to handle sanely trylock_page() failure under ptl while
> dealing with FOLL_MLOCK.

There are likely cases when accounting is problematic/impossible. But
those should be a minority.
 
> > If there is a pathological THP behavior possible then we should look
> > into that as well.
> 
> There's nothing pathological about THP behaviour. See "MLOCKING
> Transparent Huge Pages" section in Documentation/vm/unevictable-lru.rst.

Thanks this documentation helps. I was worried there is something more
going on.
-- 
Michal Hocko
SUSE Labs
