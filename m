Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD5B7507
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 10:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfISIX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 04:23:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:46080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730886AbfISIX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 720C0AFA8;
        Thu, 19 Sep 2019 08:23:55 +0000 (UTC)
Date:   Thu, 19 Sep 2019 10:23:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     corbet@lwn.net, mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, willy@infradead.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] [RESEND] vmscan.c: add a sysctl entry for controlling
 memory reclaim IO congestion_wait length
Message-ID: <20190919082354.GC15782@dhcp22.suse.cz>
References: <20190918095159.27098-1-linf@wangsu.com>
 <20190918122738.GE12770@dhcp22.suse.cz>
 <c5f278da-ec68-3206-d91b-d1ca7c97bb8c@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f278da-ec68-3206-d91b-d1ca7c97bb8c@wangsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-09-19 09:32:48, Lin Feng wrote:
> 
> 
> On 9/18/19 20:27, Michal Hocko wrote:
> > Please do not post a new version with a minor compile fixes until there
> > is a general agreement on the approach. Willy had comments which really
> > need to be resolved first.
> 
> Sorry, but thanks for pointing out.
> 
> > 
> > Also does this
> > [...]
> > > Reported-by: kbuild test robot<lkp@intel.com>
> > really hold? Because it suggests that the problem has been spotted by
> > the kbuild bot which is kinda unexpected... I suspect you have just
> > added that for the minor compilation issue that you have fixed since the
> > last version.
> 
> Yes, I do know the issue is not reported by the robot, but
> just followed the kbuild robot tip, this Reported-by suggested by kbuild robot
> seems a little misleading, I'm not sure if it has other meanings.
> 'If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>'

This would be normally the case for a patch which only fixes the
particular issue. You can credit the bot in the changelog while
documenting changes between version.

-- 
Michal Hocko
SUSE Labs
