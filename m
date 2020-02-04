Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 791E3151B04
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgBDNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 08:14:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:48721 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbgBDNOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:14:33 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 014DDuF4027799;
        Tue, 4 Feb 2020 07:13:56 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 014DDrtu027796;
        Tue, 4 Feb 2020 07:13:53 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 4 Feb 2020 07:13:53 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-s390@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-sh@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 10/10] mm/memory_hotplug: Cleanup __remove_pages()
Message-ID: <20200204131353.GJ22482@gate.crashing.org>
References: <20191006085646.5768-1-david@redhat.com> <20191006085646.5768-11-david@redhat.com> <20200204094652.GE6494@linux> <5d698f94-af18-0714-bc97-14b6c520572c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d698f94-af18-0714-bc97-14b6c520572c@redhat.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:41:06PM +0100, David Hildenbrand wrote:
> On 04.02.20 10:46, Oscar Salvador wrote:
> > I have to confess that it took me while to wrap around my head
> > with the new min() change, but looks ok:
> 
> It's a pattern commonly used in compilers and emulators to calculate the
> number of bytes to the next block/alignment. (we're missing a macro
> (like we have ALIGN_UP/IS_ALIGNED) for that - but it's hard to come up
> with a good name (e.g., SIZE_TO_NEXT_ALIGN) .

You can just write the easy to understand

  ...  ALIGN_UP(x) - x  ...

which is better *without* having a separate name.  Does that not
generate good machine code for you?


Segher
