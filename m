Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF25A1A08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfH2M3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 08:29:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfH2M3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:29:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8B80AC97;
        Thu, 29 Aug 2019 12:29:10 +0000 (UTC)
Date:   Thu, 29 Aug 2019 14:29:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     James Courtier-Dutton <james.dutton@gmail.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessm.com, hadess@hadess.net,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190829122909.GG28313@dhcp22.suse.cz>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <20190820064620.5119-1-drake@endlessm.com>
 <CAAMvbhH=ftMoh9eFVR3YgN9DVSLaN5tXa-vTsBocY8YuL0Rc1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhH=ftMoh9eFVR3YgN9DVSLaN5tXa-vTsBocY8YuL0Rc1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-08-19 22:42:29, James Courtier-Dutton wrote:
> On Tue, 20 Aug 2019 at 07:47, Daniel Drake <drake@endlessm.com> wrote:
> >
> > Hi,
> >
> > And if there is a meaningful way to make the kernel behave better, that would
> > obviously be of huge value too.
> >
> > Thanks
> > Daniel
> 
> Hi,
> 
> Is there a way for an application to be told that there is a memory
> pressure situation?

PSI (CONFIG_PSI) measures global as well as per memcg pressure characteristics.

[...]

> I have also found, for the desktop, one of the biggest pressures on
> the system is disk pressure. Accessing the disk causes the UI to be
> less responsive.
> For example, if I am in vim, and trying to type letters on the
> keyboard, whether some other application is using the disk or not
> should have no impact on my letter writing. Has anyone got any ideas
> with regards to what we can do about that?

This is what we have the page cache for.
-- 
Michal Hocko
SUSE Labs
