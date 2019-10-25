Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964BCE4C10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394623AbfJYN1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 09:27:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfJYN1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:27:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D5D0AD3A;
        Fri, 25 Oct 2019 13:27:01 +0000 (UTC)
Date:   Fri, 25 Oct 2019 15:27:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025132700.GJ17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
 <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
 <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
 <20191025114633.GE17610@dhcp22.suse.cz>
 <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
 <20191025120505.GG17610@dhcp22.suse.cz>
 <20191025121104.GH17610@dhcp22.suse.cz>
 <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-10-19 15:10:39, Robert Stupp wrote:
[...]
> cat /proc/$(pidof test)/smaps

Nothing really unusual that would jump at me except for
> 7f8be90ed000-7f8be9265000 r-xp 00025000 103:02
> 44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
> Size:               1504 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                 832 kB
> Pss:                   5 kB
> Shared_Clean:        832 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:         0 kB
> Referenced:          832 kB
> Anonymous:             0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                5 kB

Huh, 5kB, is this really the case or some copy&paste error?
How can we end up with !pagesize multiple here?

> THPeligible:		0
> VmFlags: rd ex mr mw me lo sd
-- 
Michal Hocko
SUSE Labs
