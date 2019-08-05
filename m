Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D681F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfHEO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 10:26:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727460AbfHEO0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:26:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C3C0AE48;
        Mon,  5 Aug 2019 14:26:24 +0000 (UTC)
Date:   Mon, 5 Aug 2019 16:26:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masoud Sharbiani <msharbiani@apple.com>,
        Greg KH <gregkh@linuxfoundation.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190805142622.GR7597@dhcp22.suse.cz>
References: <20190802144110.GL6461@dhcp22.suse.cz>
 <5DE6F4AE-F3F9-4C52-9DFC-E066D9DD5EDC@apple.com>
 <20190802191430.GO6461@dhcp22.suse.cz>
 <A06C5313-B021-4ADA-9897-CE260A9011CC@apple.com>
 <f7733773-35bc-a1f6-652f-bca01ea90078@I-love.SAKURA.ne.jp>
 <d7efccf4-7f07-10da-077d-a58dafbf627e@I-love.SAKURA.ne.jp>
 <20190805084228.GB7597@dhcp22.suse.cz>
 <7e3c0399-c091-59cd-dbe6-ff53c7c8adc9@i-love.sakura.ne.jp>
 <20190805114434.GK7597@dhcp22.suse.cz>
 <0b817204-29f4-adfb-9b78-4fec5fa8f680@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b817204-29f4-adfb-9b78-4fec5fa8f680@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-08-19 23:00:12, Tetsuo Handa wrote:
> On 2019/08/05 20:44, Michal Hocko wrote:
> >> Allowing forced charge due to being unable to invoke memcg OOM killer
> >> will lead to global OOM situation, and just returning -ENOMEM will not
> >> solve memcg OOM situation.
> > 
> > Returning -ENOMEM would effectivelly lead to triggering the oom killer
> > from the page fault bail out path. So effectively get us back to before
> > 29ef680ae7c21110. But it is true that this is riskier from the
> > observability POV when a) the OOM path wouldn't point to the culprit and
> > b) it would leak ENOMEM from g-u-p path.
> > 
> 
> Excuse me? But according to my experiment, below code showed flood of
> "Returning -ENOMEM" message instead of invoking the OOM killer.
> I didn't find it gets us back to before 29ef680ae7c21110...

You would need to declare OOM_ASYNC to return ENOMEM properly from the
charge (which is effectivelly a revert of 29ef680ae7c21110 for NOFS
allocations). Something like the following

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba9138a4a1de..cc34ff0932ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1797,7 +1797,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 	 * Please note that mem_cgroup_out_of_memory might fail to find a
 	 * victim and then we have to bail out from the charge path.
 	 */
-	if (memcg->oom_kill_disable) {
+	if (memcg->oom_kill_disable || !(mask & __GFP_FS)) {
 		if (!current->in_user_fault)
 			return OOM_SKIPPED;
 		css_get(&memcg->css);

I am quite surprised that your patch didn't trigger the global OOM
though. It might mean that ENOMEM doesn't propagate all the way down to
the #PF handler for this path for some reason.

Anyway what I meant to say is that returning ENOMEM has the
observable issues as well.
-- 
Michal Hocko
SUSE Labs
