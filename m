Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23183D010D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfJHTRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 15:17:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:34248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfJHTRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:17:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F338B112;
        Tue,  8 Oct 2019 19:17:30 +0000 (UTC)
Date:   Tue, 8 Oct 2019 21:17:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008191728.GS6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <20191008183525.GQ6681@dhcp22.suse.cz>
 <1570561573.5576.307.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570561573.5576.307.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 15:06:13, Qian Cai wrote:
> On Tue, 2019-10-08 at 20:35 +0200, Michal Hocko wrote:
[...]
> > I fully agree that this class of lockdep splats are annoying especially
> > when they make the lockdep unusable but please discuss this with lockdep
> > maintainers and try to find some solution rather than go and try to
> > workaround the problem all over the place. If there are places that
> > would result in a cleaner code then go for it but please do not make the
> > code worse just because of a non existent problem flagged by a false
> > positive.
> 
> It makes me wonder what make you think it is a false positive for sure.

Because this is an early init code? Because if it were a real deadlock
then your system wouldn't boot to get run with the real userspace
(remember there is zone->lock spinlock involved and that means that you
would hit hard lock after few seconds - but I feel I am repeating
myself).
-- 
Michal Hocko
SUSE Labs
