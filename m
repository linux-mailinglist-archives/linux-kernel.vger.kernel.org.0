Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE4CFC00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfJHOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 10:09:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:54040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbfJHOJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:09:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 668A1AC45;
        Tue,  8 Oct 2019 14:08:59 +0000 (UTC)
Date:   Tue, 8 Oct 2019 16:08:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        linux-mm@kvack.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008140858.GN6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <1570460350.5576.290.camel@lca.pw>
 <20191007151237.GP2381@dhcp22.suse.cz>
 <1570462407.5576.292.camel@lca.pw>
 <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
 <20191008091349.6195830d@gandalf.local.home>
 <1570541032.5576.297.camel@lca.pw>
 <20191008134256.5ti6rjkvadn5b5q4@pathway.suse.cz>
 <1570543381.5576.301.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570543381.5576.301.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 10:03:01, Qian Cai wrote:
[..]
> I don't think there is "removing useful messages" in this patch. That one
> printk() in __offline_isolated_pages() basically as Michal mentioned it is that
> useful, but could be converted to printk_deferred() if anyone objected.

"remove from free list" printk is quite dubious as I've said. And I
wouldn't be opposed to remove it altogether. It just swamps the low with
something that is of no real use. It might have been useful while
shaping and debugging the initial code but it has close to zero value
for end users. But it makes no sense to make to make it printk_deferred
on grounds mentioned so far.

-- 
Michal Hocko
SUSE Labs
