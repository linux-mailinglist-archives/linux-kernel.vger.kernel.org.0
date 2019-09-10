Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E0EAE4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 09:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfIJHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 03:31:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:56496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfIJHbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:31:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53D38B011;
        Tue, 10 Sep 2019 07:31:22 +0000 (UTC)
Date:   Tue, 10 Sep 2019 09:31:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Chris Down <chris@chrisdown.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@01.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [LKP] [mm, memcg] 1e577f970f: will-it-scale.per_process_ops
 -7.2% regression
Message-ID: <20190910073120.GK2063@dhcp22.suse.cz>
References: <20190909021544.GP15734@shao2-debian>
 <20190909194652.GE2063@dhcp22.suse.cz>
 <87d0g8hbly.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0g8hbly.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 15:08:41, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Mon 09-09-19 10:15:44, kernel test robot wrote:
> >> Greeting,
> >> 
> >> FYI, we noticed a -7.2% regression of will-it-scale.per_process_ops due to commit:
> >
> > What is the memcg setup for this test?
> 
> Except enabling memcg in kernel config, we don't do any special
> setup for memcg for the test.

OK, this is really interesting because the local events introduced by
this commits do not apply to the root memcg. So this smells like another
case when a microbenchmark is sensitive on the memcg layout changes.
-- 
Michal Hocko
SUSE Labs
