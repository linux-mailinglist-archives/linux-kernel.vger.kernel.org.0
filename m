Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20CBBC71C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 13:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394644AbfIXLr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 07:47:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:32834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388764AbfIXLr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:47:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA33AB681;
        Tue, 24 Sep 2019 11:47:25 +0000 (UTC)
Date:   Tue, 24 Sep 2019 13:47:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
Message-ID: <20190924114725.GL23050@dhcp22.suse.cz>
References: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
 <20190923105224.GH6016@dhcp22.suse.cz>
 <9b85f517-fee5-650a-4e18-29408ca85804@redhat.com>
 <ef55498f-a410-bb51-389c-7ac09641c51a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef55498f-a410-bb51-389c-7ac09641c51a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 09:42:31, Anshuman Khandual wrote:
> 
> 
> On 09/23/2019 04:24 PM, David Hildenbrand wrote:
> > On 23.09.19 12:52, Michal Hocko wrote:
> >> On Mon 16-09-19 11:17:37, Anshuman Khandual wrote:
> >>> In add_memory_resource() the memory range to be hot added first gets into
> >>> the memblock via memblock_add() before arch_add_memory() is called on it.
> >>> Reverse sequence should be followed during memory hot removal which already
> >>> is being followed in add_memory_resource() error path. This now ensures
> >>> required re-order between memblock_[free|remove]() and arch_remove_memory()
> >>> during memory hot-remove.
> >>
> >> This changelog is not really easy to follow. First of all please make
> >> sure to explain whether there is any actual problem to solve or this is
> >> an aesthetic matter. Please think of people reading this changelog in
> >> few years and scratching their heads what you were thinking back then...
> >>
> > 
> > I think it would make sense to just draft the current call sequence in
> > the add and the removal path (instead of describing it) - then it
> > becomes obvious why this is a cosmetic change.
> 
> Does this look okay ?
> 
> mm/hotplug: Reorder memblock_[free|remove]() calls in try_remove_memory()
> 
> Currently during memory hot add procedure, memory gets into memblock before
> calling arch_add_memory() which creates it's linear mapping.
> 
> add_memory_resource() {
>         ..................
>         memblock_add_node()
>         ..................
>         arch_add_memory()
>         ..................
> }
> 
> But during memory hot remove procedure, removal from memblock happens first
> before it's linear mapping gets teared down with arch_remove_memory() which
> is not coherent. Resource removal should happen in reverse order as they
> were added.
> 
> try_remove_memory() {
>         ..................
>         memblock_free()
>         memblock_remove()
>         ..................
>         arch_remove_memory()
>         ..................
> }
> 
> This changes the sequence of resource removal including memblock and linear
> mapping tear down during memory hot remove which will now be the reverse
> order in which they were added during memory hot add. The changed removal
> order looks like the following.
> 
> try_remove_memory() {
>         ..................
>         arch_remove_memory()
>         ..................
>         memblock_free()
>         memblock_remove()
>         ..................
> }

OK, this is better. I would just a note that the inconsistency doesn't
pose any problem now but if somebody makes any assumptions about linear
mappings then it could get subtly broken like your example for arm64
which has found a different solution in the meantime.

-- 
Michal Hocko
SUSE Labs
