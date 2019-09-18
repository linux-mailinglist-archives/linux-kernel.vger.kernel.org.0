Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA655B5FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfIRI7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 04:59:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfIRI7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:59:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0C55AF4C;
        Wed, 18 Sep 2019 08:59:08 +0000 (UTC)
Date:   Wed, 18 Sep 2019 09:59:05 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix an unused function "node_cpu" warning
Message-ID: <20190918085905.GC3605@suse.de>
References: <1568730894-10483-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1568730894-10483-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 10:34:54AM -0400, Qian Cai wrote:
> Clang reports a warning,
> 
> kernel/locking/osq_lock.c:25:19: warning: unused function 'node_cpu'
> [-Wunused-function]
> 
> due to osq_lock() calls vcpu_is_preempted(node_cpu(node->prev))), but
> vcpu_is_preempted() is compiled away. Fix it by converting the dummy
> vcpu_is_preempted() from a macro to a proper static inline function.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
