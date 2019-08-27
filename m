Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDF59DE63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH0HHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 03:07:08 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:52164 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfH0HHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:07:05 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 03:07:05 EDT
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 6A0512DC009A;
        Tue, 27 Aug 2019 03:00:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1566889239;
        bh=Vicp1z3ZYemzE7DrudrWvYVfOYkLSvM90bJCLdQ9aRM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C6v/ytGkutpfzP2PTxrtBrSOrb4+ce4MDkJwsciLjzlMDvtbaD/YozBZV3Ls5WRlm
         k08QBl8jwO4ZVA111hlNhazgFVw4HijplQz7qWREPrDb1rQ3PDUb9i/gXYhDj1QeVM
         rN16RfSPqXnOBdJvg1i9h9qfdcloSjoZF2NMOxHT1n0ZOcv4bpR/tyvEtsQ2bxVckr
         RQvG+Cqxj4+anhZF1w8iwbcwwavco6NFXdU+hm+IUOAp77E5ZH7hE5LzCPtCM2m6IB
         Sgv2zBatFyEC/qW2V5KiQF7RJsc62tKQ5LOU4H/xtDxmayaJnLRT7A1VxHxiLGMQSQ
         hNV8TSivv9k1DqfcYW74bmU1RRCzn2IjDqpr6ubsulqhzDO5V5nIS4fSR2kzy/bgb+
         O5myAjyfXbIHwFi86sQ7Du8681wYwNrg733juzW6Hcbv9jGDmYnN29RMESUp6X0Rmf
         omA9W+2KN5ugfRg0oIWIW1wtbLv0IEtPDqW8hHk3Qg7bQ6HdsN4v1VhN3QHDpZvUcI
         FSWalw652x+LxZyGBii2JfqAwuFV3Pvlww5uPY9kJSxmCSHsWhAzHiJ1Nk5TyN0Pl7
         7ddDF28KQ9LCAgVLWGDal0AeMOUhj7x/pMquym3PkJzU4/KXWYabbILsqVb7CGrBcW
         XjsmcwPtFOvIwHFlP+tCbv14=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x7R70GV1043884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Aug 2019 17:00:32 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <befab2a0a9f160f8af8c1a412068060636a7a64c.camel@d-silva.org>
Subject: Re: [PATCH 2/2] mm: don't hide potentially null memmap pointer in
 sparse_remove_section
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 27 Aug 2019 17:00:16 +1000
In-Reply-To: <20190827062445.GO7538@dhcp22.suse.cz>
References: <20190827053656.32191-1-alastair@au1.ibm.com>
         <20190827053656.32191-3-alastair@au1.ibm.com>
         <20190827062445.GO7538@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Tue, 27 Aug 2019 17:00:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 08:24 +0200, Michal Hocko wrote:
> On Tue 27-08-19 15:36:55, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > By adding offset to memmap before passing it in to
> > clear_hwpoisoned_pages,
> > we hide a theoretically null memmap from the null check inside
> > clear_hwpoisoned_pages.
> 
> Isn't that other way around? Calculating the offset struct page
> pointer
> will actually make the null check effective. Besides that I cannot
> really see how pfn_to_page would return NULL. I have to confess that
> I
> cannot really see how offset could lead to a NULL struct page either
> and
> I strongly suspect that the NULL check is not really needed. Maybe it
> used to be in the past.
> 

You're probably right, but I didn't feel confident in removing the NULL
check. 

While the NULL check remains though, I can't see how adding the offset
would turn a non-NULL pointer into a NULL unless the pointer is invalid
in the first place, and if this is the case, we should have a comment
explaining this.

The NULL check was added in commit:
95a4774d055c ("memory-hotplug: update mce_bad_pages when removing the
memory")
where memmap was originally inited to NULL, and only conditionally
given a value.

With this in mind, since that situation is no longer true, I think we
could instead drop the NULL check.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


