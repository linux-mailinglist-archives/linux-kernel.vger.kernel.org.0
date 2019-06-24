Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1AEC50D62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 16:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfFXOJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 10:09:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731916AbfFXOJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:09:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86070AF2C;
        Mon, 24 Jun 2019 14:09:52 +0000 (UTC)
Date:   Mon, 24 Jun 2019 15:09:50 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, jhladky@redhat.com,
        lvenanci@redhat.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -mm] autonuma: Fix scan period updating
Message-ID: <20190624140950.GF2947@suse.de>
References: <20190624025604.30896-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190624025604.30896-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:56:04AM +0800, Huang Ying wrote:
> The autonuma scan period should be increased (scanning is slowed down)
> if the majority of the page accesses are shared with other processes.
> But in current code, the scan period will be decreased (scanning is
> speeded up) in that situation.
> 
> This patch fixes the code.  And this has been tested via tracing the
> scan period changing and /proc/vmstat numa_pte_updates counter when
> running a multi-threaded memory accessing program (most memory
> areas are accessed by multiple threads).
> 

The patch somewhat flips the logic on whether shared or private is
considered and it's not immediately obvious why that was required. That
aside, other than the impact on numa_pte_updates, what actual
performance difference was measured and on on what workloads?

-- 
Mel Gorman
SUSE Labs
