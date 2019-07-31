Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D0B7BB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfGaIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 04:17:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfGaIR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:17:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C289CAF54;
        Wed, 31 Jul 2019 08:17:27 +0000 (UTC)
Date:   Wed, 31 Jul 2019 10:17:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage
 allocations"
Message-ID: <20190731081726.GB9330@dhcp22.suse.cz>
References: <20190503223146.2312-1-aarcange@redhat.com>
 <20190503223146.2312-3-aarcange@redhat.com>
 <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com>
 <20190520153621.GL18914@techsingularity.net>
 <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
 <20190730131127.GT9330@dhcp22.suse.cz>
 <20190730110544.84d91ba80365cf35f5aae291@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730110544.84d91ba80365cf35f5aae291@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-07-19 11:05:44, Andrew Morton wrote:
> On Tue, 30 Jul 2019 15:11:27 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Thu 23-05-19 17:57:37, Andrew Morton wrote:
> > [...]
> > > It does appear to me that this patch does more good than harm for the
> > > totality of kernel users, so I'm inclined to push it through and to try
> > > to talk Linus out of reverting it again.  
> > 
> > What is the status here?
> 
> I doesn't seem that the mooted alternatives will be happening any time
> soon,
> 
> I would like a version of this patch which has a changelog which fully
> describes our reasons for reapplying the reverted revert.

http://lkml.kernel.org/r/20190503223146.2312-3-aarcange@redhat.com went
in great details IMHO about the previous decision as well as adverse
effect on swapout. Do you have any suggestions on what is missing there?

-- 
Michal Hocko
SUSE Labs
