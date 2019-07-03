Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6235C929
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 08:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfGBGRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 02:17:07 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:60706 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfGBGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:17:07 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 1248A2DC009C;
        Tue,  2 Jul 2019 02:17:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1562048223;
        bh=jmxTkz+xmGtAbS/yxNUR0tOcP0AiHxZIRt4HYUN6bgk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kSD9EPjwIJGSwPftuuH7di/739+wc8CPJufU+o7Nxfbv/sW0LijKap+FV5L7IUGNj
         Fh3kViYh+G3msOxmrYk9XqF0G8vzK8I0gQgEQd6bNj9+q8oEVSUV2iD8cTcaejcimR
         f5fwty3mfgNOE9FoRuiA+LG5q1eG667ByT/ysbwvjtsMGhswLAqOEHzcDUyWzJ7FOO
         b+7go36ost7erc7qQcrtKbWKq1Bjl3kF3JrHGslsqhjdpLgzSKihqhTiCelqVG/W6Y
         nsiRvodaITT2+dQohTEPyMEdh7yAjyVLQRgaDGbTcQtCYjrPJmkqk6hWS9f/yjV9vG
         t4WV+6GEFpJmuwjxRRE44fQIY2v2YkLB502ZdT0bM6H45kNQlPUyNXkJrdGfoG5LQv
         X8lqNfUHEj8NMIKO1Q2ceUMdk+/xeYN8vHnMHQZGu/nkvo8H7aFuSaVozHxZruOFBZ
         gWth5ksRUmjbFGE87MShayptzaSeFsCq73NZlNW8yLUj601d1h7ouLWlCefXxWojWt
         CrBnSX2+yYfthxDIKP6bmPEowSLCwGu492zEFKlAXON4NrodnBBpiBjOS38fmSmJHr
         8gN7PFYReFT8Q/qlkbz3ijuIjrUsIlm+PpbWbfiAbyNAwgE0S0+BYlrGM5V0O4sE06
         /tvbJOSAf0xysB78lETKU1bU=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x626GgYG086222
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Jul 2019 16:16:58 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <caa5673459fef4152e0aea7e1a30d6027a81e652.camel@d-silva.org>
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Michal Hocko <mhocko@kernel.org>
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
Date:   Tue, 02 Jul 2019 16:16:42 +1000
In-Reply-To: <20190702061310.GA978@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
         <20190626061124.16013-2-alastair@au1.ibm.com>
         <20190626062113.GF17798@dhcp22.suse.cz>
         <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
         <20190626065751.GK17798@dhcp22.suse.cz>
         <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
         <20190627080724.GK17798@dhcp22.suse.cz>
         <833b9675bc363342827cb8f7c76ebb911f7f960d.camel@d-silva.org>
         <20190701104658.GA6549@dhcp22.suse.cz>
         <7f0ac9250e6fe6318aaf0685be56b121a978ce1b.camel@d-silva.org>
         <20190702061310.GA978@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Tue, 02 Jul 2019 16:16:59 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-02 at 08:13 +0200, Michal Hocko wrote:
> On Tue 02-07-19 14:13:25, Alastair D'Silva wrote:
> > On Mon, 2019-07-01 at 12:46 +0200, Michal Hocko wrote:
> > > On Fri 28-06-19 10:46:28, Alastair D'Silva wrote:
> > > [...]
> > > > Given that there is already a VM_BUG_ON in the code, how do you
> > > > feel
> > > > about broadening the scope from 'VM_BUG_ON(!root)' to
> > > > 'VM_BUG_ON(!root
> > > > > > (root_nr == NR_SECTION_ROOTS))'?
> > > 
> > > As far as I understand the existing VM_BUG_ON will hit when the
> > > mem_section tree gets corrupted. This is a different situation to
> > > an
> > > incorrect section given so I wouldn't really mix those two. And I
> > > still
> > > do not see much point to protect from unexpected input parameter
> > > as
> > > this
> > > is internal function as already pointed out.
> > > 
> > 
> > Hi Michael,
> > 
> > I was able to hit this problem as the system firmware had assigned
> > the
> > prototype pmem device an address range above the 128TB limit that
> > we
> > originally supported. This has since been lifted to 2PB with patch
> > 4ffe713b7587b14695c9bec26a000fc88ef54895.
> > 
> > As it stands, we cannot move this range lower as the high bits are
> > dictated by the location the card is connected.
> > 
> > Since the physical address of the memory is not controlled by the
> > kernel, I believe we should catch (or at least make it easy to
> > debug)
> > the sitution where external firmware allocates physical addresses
> > beyond that which the kernel supports.
> 
> Just make it clear, I am not against a sanitization. I am objecting
> to
> put it into __section_nr because this is way too late. As already
> explained, you already must have a bogus mem_section object in hand.
> Why cannot you add a sanity check right there when the memory is
> added?
> Either when the section is registered or even sooner in
> arch_add_memory.
> 

Good point, I was thinking of a libnvdimm enhancement to check that the
end address is in range, but a more generic solution is better.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


