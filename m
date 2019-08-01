Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE557D557
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfHAGPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:15:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfHAGPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:15:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0985EAEBD;
        Thu,  1 Aug 2019 06:15:30 +0000 (UTC)
Date:   Thu, 1 Aug 2019 08:15:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190801061527.GB11627@dhcp22.suse.cz>
References: <20190731161151.26ef081e@canb.auug.org.au>
 <1564554484.28000.3.camel@mtkswgap22>
 <20190801155130.29a07b1b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801155130.29a07b1b@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 15:51:30, Stephen Rothwell wrote:
> Hi Miles,
> 
> On Wed, 31 Jul 2019 14:28:04 +0800 Miles Chen <miles.chen@mediatek.com> wrote:
> >
> > On Wed, 2019-07-31 at 16:11 +1000, Stephen Rothwell wrote:
> > > 
> > > After merging the akpm-current tree, today's linux-next build (powerpc
> > > ppc64_defconfig) produced this warning:
> > > 
> > > mm/memcontrol.c: In function 'invalidate_reclaim_iterators':
> > > mm/memcontrol.c:1160:11: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
> > >   } while (memcg = parent_mem_cgroup(memcg));
> > >            ^~~~~
> > >   
> > 
> > Hi Stephen,
> > 
> > Thanks for the telling me this. Sorry for the build warning. 
> > Should I send patch v5 to the mailing list to fix this? 
> 
> You might as well (cc'ing Andrew, of course).
> 
> I would suggest finishing that loop like this:
> 
> 		memcg = parent_mem_cgroup(memcg);
> 	} while (memcg);
> 
> rather than adding a set of parentheses.

Qian has already posted a patch http://lkml.kernel.org/r/1564580753-17531-1-git-send-email-cai@lca.pw
-- 
Michal Hocko
SUSE Labs
