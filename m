Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4BDEF69
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 16:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfJUOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 10:25:42 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:39238 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfJUOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:25:42 -0400
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 272231C300B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 15:25:40 +0100 (IST)
Received: (qmail 29241 invoked from network); 21 Oct 2019 14:25:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Oct 2019 14:25:40 -0000
Date:   Mon, 21 Oct 2019 15:25:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
Message-ID: <20191021142534.GA3016@techsingularity.net>
References: <20191021094808.28824-1-mgorman@techsingularity.net>
 <20191021094808.28824-2-mgorman@techsingularity.net>
 <85A7E76A-0839-4A43-86F3-6847639F9F92@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <85A7E76A-0839-4A43-86F3-6847639F9F92@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:01:24AM -0400, Qian Cai wrote:
> Warnings from linux-next,
> 
> [   14.265911][  T659] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> [   14.265992][  T659] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 659, name: pgdatinit8
> [   14.266044][  T659] 1 lock held by pgdatinit8/659:

Fixed in v2 posted this morning. It should hit linux-next eventually.

-- 
Mel Gorman
SUSE Labs
