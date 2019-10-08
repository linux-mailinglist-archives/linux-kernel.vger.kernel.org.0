Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1699DCF74B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfJHKjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 06:39:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730256AbfJHKjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:39:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB0CFAEAF;
        Tue,  8 Oct 2019 10:39:08 +0000 (UTC)
Date:   Tue, 8 Oct 2019 12:39:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008103907.GE6681@dhcp22.suse.cz>
References: <20191008084031.GC6681@dhcp22.suse.cz>
 <298970BD-529E-4095-8D87-61470ADBDD32@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298970BD-529E-4095-8D87-61470ADBDD32@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 06:04:32, Qian Cai wrote:
> 
> 
> > On Oct 8, 2019, at 4:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Does this tip point to a real deadlock or merely a class of lockdep
> > false dependencies?
> 
> I lean towards it is a real deadlock given how trivial to generate those lock orders everywhere.

Have you actually triggered any real deadlock? With a zone->lock in
place it would be pretty clear with hard lockups detected.

-- 
Michal Hocko
SUSE Labs
