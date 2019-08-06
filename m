Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4775382D60
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbfHFIES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 04:04:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728843AbfHFIES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:04:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B33EAF1D;
        Tue,  6 Aug 2019 08:04:17 +0000 (UTC)
Date:   Tue, 6 Aug 2019 10:04:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>, lkp@01.org
Subject: Re: [mm]  755d6edc1a:  will-it-scale.per_process_ops -4.1% regression
Message-ID: <20190806080415.GG11812@dhcp22.suse.cz>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190806070547.GA10123@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806070547.GA10123@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 15:05:47, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -4.1% regression of will-it-scale.per_process_ops due to commit:

I have to confess I cannot make much sense from numbers because they
seem to be too volatile and the main contributor doesn't stand up for
me. Anyway, regressions on microbenchmarks like this are not all that
surprising when a locking is slightly changed and the critical section
made shorter. I have seen that in the past already.

That being said I would still love to get to bottom of this bug rather
than play with the lock duration by a magic. In other words
http://lkml.kernel.org/r/20190730125751.GS9330@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
