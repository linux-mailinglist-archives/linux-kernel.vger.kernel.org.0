Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E759A7B158
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfG3SOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:14:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33580 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfG3SOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:14:25 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 14:14:24 EDT
Received: from X1 (216.sub-174-222-135.myvzw.com [174.222.135.216])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E68D5310E;
        Tue, 30 Jul 2019 18:05:46 +0000 (UTC)
Date:   Tue, 30 Jul 2019 11:05:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert
 "mm, thp: restore node-local hugepage allocations"
Message-Id: <20190730110544.84d91ba80365cf35f5aae291@linux-foundation.org>
In-Reply-To: <20190730131127.GT9330@dhcp22.suse.cz>
References: <20190503223146.2312-1-aarcange@redhat.com>
        <20190503223146.2312-3-aarcange@redhat.com>
        <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com>
        <20190520153621.GL18914@techsingularity.net>
        <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
        <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
        <20190730131127.GT9330@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 15:11:27 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> On Thu 23-05-19 17:57:37, Andrew Morton wrote:
> [...]
> > It does appear to me that this patch does more good than harm for the
> > totality of kernel users, so I'm inclined to push it through and to try
> > to talk Linus out of reverting it again.  
> 
> What is the status here?

I doesn't seem that the mooted alternatives will be happening any time
soon,

I would like a version of this patch which has a changelog which fully
describes our reasons for reapplying the reverted revert.  At this
time, *someone* is going to have to carry a private patch.  It's best
that the version which suits the larger number of users be the one
which we carry in mainline.

I'll add a cc:stable to this revert.
