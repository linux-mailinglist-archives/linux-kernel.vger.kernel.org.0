Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6574F56B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfFZN5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:57:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfFZN5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:57:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B933AAF05;
        Wed, 26 Jun 2019 13:57:45 +0000 (UTC)
Date:   Wed, 26 Jun 2019 15:57:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190626135744.GX17798@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
 <20190513124112.GH24036@dhcp22.suse.cz>
 <1561123078.5154.41.camel@lca.pw>
 <20190621135507.GE3429@dhcp22.suse.cz>
 <CAFgQCTvSJjzFGGyt_VOvyB46yy6452wach7UmmuY5ZJZ3YZzcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTvSJjzFGGyt_VOvyB46yy6452wach7UmmuY5ZJZ3YZzcg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-06-19 16:42:20, Pingfan Liu wrote:
> Hi Michal,
> 
> What about dropping the change of the online definition of your patch,
> just do the following?

I am sorry but I am unlikely to find some more time to look into this. I
am willing to help reviewing but I will not find enough time to focus on
this to fix up the patch. Are you willing to work on this and finish the
patch? It is a very tricky area with side effects really hard to see in
advance but going with a robust fix is definitely worth the effort.

Thanks!
-- 
Michal Hocko
SUSE Labs
