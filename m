Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6386899E85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbfHVSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 14:17:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:58740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfHVSRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:17:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EB42ADF0;
        Thu, 22 Aug 2019 18:17:11 +0000 (UTC)
Date:   Thu, 22 Aug 2019 11:17:01 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Message-ID: <20190822181701.zhfdkjbwjh56i3ax@linux-r8p5>
References: <20190813224620.31005-1-dave@stgolabs.net>
 <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com>
 <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, 21 Aug 2019, Michel Lespinasse wrote:
>>As I had commented some time ago, I wish the interval trees used [start,end)
>>intervals instead of [start,last] - it would be a better fit for basically
>>all of the current interval tree users.

So the vma_interval_tree (which is a pretty important user) tends to break this
pattern, as most lookups are [a,a]. We would have to update most of the
vma_interval_tree_foreach calls, for example, to now do [a,a+1[ such that we
don't break things. Some cases for the anon_vma_tree as well (ie memory-failure).

I'm not sure anymore it's worth going down this path as we end up exchanging one
hack for another (and the vma_interval_tree is a pretty big user); but I'm sure
you're aware of this and thus disagree.

Thanks,
Davidlohr
