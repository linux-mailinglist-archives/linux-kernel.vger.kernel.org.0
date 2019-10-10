Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEEFD27A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbfJJK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 06:59:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:42804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfJJK7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:59:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F349B17F;
        Thu, 10 Oct 2019 10:59:28 +0000 (UTC)
Date:   Thu, 10 Oct 2019 12:59:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010105927.GG18412@dhcp22.suse.cz>
References: <20191009162339.GI6681@dhcp22.suse.cz>
 <6AAB77B5-092B-43E3-9F4B-0385DE1890D9@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6AAB77B5-092B-43E3-9F4B-0385DE1890D9@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-10-19 05:01:44, Qian Cai wrote:
> 
> 
> > On Oct 9, 2019, at 12:23 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > If this was only about the memory offline code then I would agree. But
> > we are talking about any printk from the zone->lock context and that is
> > a bigger deal. Besides that it is quite natural that the printk code
> > should be more universal and allow to be also called from the MM
> > contexts as much as possible. If there is any really strong reason this
> > is not possible then it should be documented at least.
> 
> Where is the best place to document this? I am thinking about under
> the “struct zone” definition’s lock field in mmzone.h.

I am not sure TBH and I do not think we have reached the state where
this would be the only way forward.

-- 
Michal Hocko
SUSE Labs
