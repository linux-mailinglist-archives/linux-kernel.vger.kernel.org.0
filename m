Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD0562D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfFZG5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 02:57:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfFZG5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:57:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A6E5AF96;
        Wed, 26 Jun 2019 06:57:52 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:57:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
Message-ID: <20190626065751.GK17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-2-alastair@au1.ibm.com>
 <20190626062113.GF17798@dhcp22.suse.cz>
 <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-06-19 16:27:30, Alastair D'Silva wrote:
> On Wed, 2019-06-26 at 08:21 +0200, Michal Hocko wrote:
> > On Wed 26-06-19 16:11:21, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > If a memory section comes in where the physical address is greater
> > > than
> > > that which is managed by the kernel, this function would not
> > > trigger the
> > > bug and instead return a bogus section number.
> > > 
> > > This patch tracks whether the section was actually found, and
> > > triggers the
> > > bug if not.
> > 
> > Why do we want/need that? In other words the changelog should contina
> > WHY and WHAT. This one contains only the later one.
> >  
> 
> Thanks, I'll update the comment.
> 
> During driver development, I tried adding peristent memory at a memory
> address that exceeded the maximum permissable address for the platform.
> 
> This caused __section_nr to silently return bogus section numbers,
> rather than complaining.

OK, I see, but is an additional code worth it for the non-development
case? I mean why should we be testing for something that shouldn't
happen normally? Is it too easy to get things wrong or what is the
underlying reason to change it now?

-- 
Michal Hocko
SUSE Labs
