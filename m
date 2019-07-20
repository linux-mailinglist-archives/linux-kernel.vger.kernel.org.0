Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C16EF34
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfGTLb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 07:31:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfGTLb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 07:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XWGVqgDTHORb+rIdtzWL7tRjmLiJWFVw+H/edNKyhlc=; b=HNrutw/F12QMsnvSfb46RWQYt
        1xz41mBVB63BHZdhfjeBAHH7i6uYBkMBtnbIex3eLcnFgbmnfbBLvaCtmT8s4f/xLM9O9wtcPdtF7
        zmrb+S+YBytngRFh+N+3U9Me92Z5ug+eM9skYBXrbOa6hS2MyhI3MbAHgI1t7kLV83GPoKHbJjqm7
        hulaYQNEuTx2ZcaoHd/eMgBWBu5W1tpuVYzKntITPFf+fhwh3DURocD89nKnhKpC6y0lvcnNUDvVs
        UM44HzCpfhwYt6CJB5pF7W8BhTnyDhGweuGiasM6HaA7U3X1QF3tA2IUSRWeeBgnuLnnX0KvQ6SJ/
        ARY5sk/lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1honaG-0005Jg-Uu; Sat, 20 Jul 2019 11:31:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56DEC20197A78; Sat, 20 Jul 2019 13:31:23 +0200 (CEST)
Date:   Sat, 20 Jul 2019 13:31:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
Message-ID: <20190720113123.GS3402@hirez.programming.kicks-ass.net>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
 <20190719125443.GJ3419@hirez.programming.kicks-ass.net>
 <CAKfTPtBrogvg8Km1O9QOh=hoLM8g5Oc8gUKRoMmHpM54nueijw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBrogvg8Km1O9QOh=hoLM8g5Oc8gUKRoMmHpM54nueijw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 04:02:15PM +0200, Vincent Guittot wrote:
> On Fri, 19 Jul 2019 at 14:54, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jul 19, 2019 at 09:58:23AM +0200, Vincent Guittot wrote:

> > > -void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)

> > Maybe strip this out first, in a separate patch. It's all magic doo-doo.
> 
> If I remove that 1st, we will have commit in the branch that might
> regress some performance temporarily and bisect might spot it while
> looking for a culprit, isn't it ?

Maybe; but at least for review it is much better to not have it all
squashed in one patch.
