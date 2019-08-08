Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C186B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbfHHUHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 16:07:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390169AbfHHUHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:07:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83B03AD2A;
        Thu,  8 Aug 2019 20:07:16 +0000 (UTC)
Date:   Thu, 8 Aug 2019 22:07:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH] mm/oom: Add killed process selection information
Message-ID: <20190808200715.GI18351@dhcp22.suse.cz>
References: <20190808183247.28206-1-echron@arista.com>
 <20190808185119.GF18351@dhcp22.suse.cz>
 <CAM3twVT0_f++p1jkvGuyMYtaYtzgEiaUtb8aYNCmNScirE4=og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM3twVT0_f++p1jkvGuyMYtaYtzgEiaUtb8aYNCmNScirE4=og@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[please do not top-post]

On Thu 08-08-19 12:21:30, Edward Chron wrote:
> It is helpful to the admin that looks at the kill message and records this
> information. OOMs can come in bunches.
> Knowing how much resource the oom selected process was using at the time of
> the OOM event is very useful, these fields document key process and system
> memory/swap values and can be quite helpful.

I do agree and we already print that information. rss with a break down
to anonymous, file backed and shmem, is usually a large part of the oom
victims foot print. It is not a complete information because there might
be a lot of memory hidden by other resource (open files etc.). We do not
print that information because it is not considered in the oom
selection. It is also not guaranteed to be freed upon the task exit.
 
> Also can't you disable printing the oom eligible task list? For systems
> with very large numbers of oom eligible processes that would seem to be
> very desirable.

Yes that is indeed the case. But how does the oom_score and
oom_score_adj alone without comparing it to other eligible tasks help in
isolation?

[...]

> I'm not sure that change would be supported upstream but again in our
> experience we've found it helpful, since you asked.

Could you be more specific about how that information is useful except
for recording it? I am all for giving an useful information in the OOM
report but I would like to hear a sound justification for each
additional piece of information.

E.g. this helped us to understand why the task has been selected - this
is usually dump_tasks portion of the report because it gives a picture
of what the OOM killer sees when choosing who to kill.

Then we have the summary to give us an estimation on how much
memory will get freed when the victim dies - rss is a very rough
estimation. But is a portion of the overal memory or oom_score{_adj}
important to print as well? Those are relative values. Say you get
memory-usage:10%, oom_score:42 and oom_score_adj:0. What are you going
to tell from that information?
-- 
Michal Hocko
SUSE Labs
