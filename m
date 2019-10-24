Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBECAE3469
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393632AbfJXNjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 09:39:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733296AbfJXNjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:39:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4BAABD14;
        Thu, 24 Oct 2019 13:39:01 +0000 (UTC)
Date:   Thu, 24 Oct 2019 15:38:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191024133859.GX17610@dhcp22.suse.cz>
References: <20191024074205.GQ17610@dhcp22.suse.cz>
 <B292E9D2-D619-4A57-BBE3-A4D10826AA60@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B292E9D2-D619-4A57-BBE3-A4D10826AA60@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-10-19 07:11:52, Qian Cai wrote:
> 
> 
> > On Oct 24, 2019, at 3:42 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > It's been useful for debugging memory fragmentation problems and we do
> > not have anything that would provide a similar information. Considering
> 
> Actually, zoneinfo and buddyinfo are somewhat similar to it. Why
> the extra information in pagetypeinfo is still useful in debugging
> today’s real-world scenarios?

Because the migrate type is the information that helps to understand
fragmentation related issues. I am pretty sure Vlastimil would tell you
much more.

> > that making it root only is trivial and reducing the lock hold times
> > likewise I do not really see any strong reason to dump it at this
> > moment.
> 
> There is no need to hurry this, and clearly this is rather a good
> opportunity to discuss the consolidation of memory fragmentation
> debugging to ease the maintenance in long term.

Right. I think we should address the issue at hands first and then
handle any possible consolidations.

-- 
Michal Hocko
SUSE Labs
