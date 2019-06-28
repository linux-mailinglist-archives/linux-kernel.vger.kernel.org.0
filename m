Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5A58F25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 02:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfF1Aq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 20:46:56 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:35410 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF1Aqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:46:54 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id D2A782DC0032;
        Thu, 27 Jun 2019 20:46:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1561682810;
        bh=UhW8aV9JrdJrV6DY1cn+26607uxAHeKKSDkYSCJIz2M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Bf889EkYMaeNluUjhKxTar/zrDWtyG6z4MPIgQbMM1hlBS3knrgi5bTM8SXlXknuf
         V6ubG90eRxu9h07jXXMnZJorUJrKXQjE2E7s5j0FewNgumQlepxJb5NZVPsdPc+AOA
         9Pj2jJffN6tZ4FlLq1IGlIAvGgktDs1tW84J9ZVKmlur+850hOTKPGNjBgFOa7NpEd
         lrAoZFoig0zuD0+uai9JHtm00vwzl83aiAWpMyvoYoymkm1IZyq3oZ9lu4z9Xb5lNz
         inOieRfjfotmRvlxvbPgmQmAPaZX9QNe/uLjKV0MhXwmnAJwy/f217xz6G1vxiPcy/
         7ItzyL/DSdZJe0gofc6J9n/BFBb18P8NglNk+B55nwdn4KzgHIEA3sHoG3wynJ53KZ
         94cqC2Ani2ar+hIbnXdcBpKrat9bJUCpkzwdVO8v95czBy26uqFRSa8tISVw+Q934m
         ac4o6vS2yJTFf9Quc1UYkXXd1bEJ/5yBu+vMghCf1s8RsZQaLL2eXRJudkZWP/mMI1
         BzQHnbBrxRQivmnKZc03+cxY5jiyTcUwQejTVSo5W2VayozVUy23nsKdIi+XgEgjbn
         xDx1+ZdkXwzOCfEdJ7Nrd7eAutlmBMC08PlSwG2sS0aEN9fr1wqFnHEUvd6LcQb9m5
         j7IIohidJfKiyX+lq2oOy0tU=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5S0kS8t045453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Jun 2019 10:46:44 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <833b9675bc363342827cb8f7c76ebb911f7f960d.camel@d-silva.org>
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
Date:   Fri, 28 Jun 2019 10:46:28 +1000
In-Reply-To: <20190627080724.GK17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
         <20190626061124.16013-2-alastair@au1.ibm.com>
         <20190626062113.GF17798@dhcp22.suse.cz>
         <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
         <20190626065751.GK17798@dhcp22.suse.cz>
         <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
         <20190627080724.GK17798@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 28 Jun 2019 10:46:45 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 10:10 +0200, Michal Hocko wrote:
> On Thu 27-06-19 10:50:57, Alastair D'Silva wrote:
> > On Wed, 2019-06-26 at 08:57 +0200, Michal Hocko wrote:
> > > On Wed 26-06-19 16:27:30, Alastair D'Silva wrote:
> > > > On Wed, 2019-06-26 at 08:21 +0200, Michal Hocko wrote:
> > > > > On Wed 26-06-19 16:11:21, Alastair D'Silva wrote:
> > > > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > > > 
> > > > > > If a memory section comes in where the physical address is
> > > > > > greater
> > > > > > than
> > > > > > that which is managed by the kernel, this function would
> > > > > > not
> > > > > > trigger the
> > > > > > bug and instead return a bogus section number.
> > > > > > 
> > > > > > This patch tracks whether the section was actually found,
> > > > > > and
> > > > > > triggers the
> > > > > > bug if not.
> > > > > 
> > > > > Why do we want/need that? In other words the changelog should
> > > > > contina
> > > > > WHY and WHAT. This one contains only the later one.
> > > > >  
> > > > 
> > > > Thanks, I'll update the comment.
> > > > 
> > > > During driver development, I tried adding peristent memory at a
> > > > memory
> > > > address that exceeded the maximum permissable address for the
> > > > platform.
> > > > 
> > > > This caused __section_nr to silently return bogus section
> > > > numbers,
> > > > rather than complaining.
> > > 
> > > OK, I see, but is an additional code worth it for the non-
> > > development
> > > case? I mean why should we be testing for something that
> > > shouldn't
> > > happen normally? Is it too easy to get things wrong or what is
> > > the
> > > underlying reason to change it now?
> > > 
> > 
> > It took me a while to identify what the problem was - having the
> > BUG_ON
> > would have saved me a few hours.
> > 
> > I'm happy to just have the BUG_ON 'nd drop the new error return (I
> > added that in response to Mike Rapoport's comment that the original
> > patch would still return a bogus section number).
> 
> Well, BUG_ON is about the worst way to handle an incorrect input. You
> really do not want to put a production environment down just because
> there is a bug in a driver, right? There are still many {VM_}BUG_ONs
> in the tree and there is a general trend to get rid of many of them
> rather than adding new ones.
> 
> Now back to your patch. You are adding an error handling where we
> simply
> do not expect invalid data. This is often the case for the core
> kernel
> functionality because we do expect consumers of the code to do the
> right
> thing. E.g. __section_nr already takes a pointer to struct section
> which
> assumes that this core data structure is already valid. Adding a
> check
> here adds an unnecessary overhead so this doesn't really sound like a
> good idea to me.


Thanks for providing a good explanation.

In this situation, since we return a bogus section number, we get
crashes elsewhere in the kernel if the code rumbles on.

Given that there is already a VM_BUG_ON in the code, how do you feel
about broadening the scope from 'VM_BUG_ON(!root)' to 'VM_BUG_ON(!root
|| (root_nr == NR_SECTION_ROOTS))'?

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


