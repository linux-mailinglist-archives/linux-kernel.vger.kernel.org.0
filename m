Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524BF68A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfGONRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 09:17:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:49938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730012AbfGONRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:17:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CA51AF7E;
        Mon, 15 Jul 2019 13:17:34 +0000 (UTC)
Date:   Mon, 15 Jul 2019 15:17:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     dvyukov@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
Message-ID: <20190715131732.GX29483@dhcp22.suse.cz>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 13-07-19 04:49:04, Yang Shi wrote:
> When running ltp's oom test with kmemleak enabled, the below warning was
> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> passed in:

kmemleak is broken and this is a long term issue. I thought that
Catalin had something to address this.

While this patch only adds a comment and discourages future changes of
the warning which is fine and probably something that we should do,
kmemleak really should be fixed sooner than later.
-- 
Michal Hocko
SUSE Labs
