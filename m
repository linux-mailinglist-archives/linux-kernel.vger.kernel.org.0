Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6223E19AC23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbgDAMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 08:55:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51866 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbgDAMzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:55:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id z7so3785368wmk.1;
        Wed, 01 Apr 2020 05:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NLb9KnHMR+orgTZZ6eLIjfcSjKQyqXclo2S3Zf+Re28=;
        b=Gbrl9cHeIFb+RIMbLkz39emtWPtkoJEkDAcYnVTSfBcIxUr08mcGWtGc23mVWH8kdC
         eCnfczYBW4BO+P1n0qNdN5dJwn7ggTdnhZ3TrPk0Xew43Tn33Ywd2NwJN2sU+uRCjIk3
         1QLo5sOukVtmawjU8PGBacbOeOrfHEGU8aKGKM/ZbOkD2nmhBDLQoiFkb/8EgBosoPKX
         fxjATK4hj8FH1pYkyvIPQOPP8KY7csHEq6VorWG0SMyaSap5sMR+cym1hwLRBxGIgZqY
         F11pAJoQ6v+vywnrmjIYz9pZhF1P/WKtx0muOo9we/yfR3CSsET4VKhMiPuuRpYy8Mby
         YBTg==
X-Gm-Message-State: AGi0PuZnTCwq9TTBIoWJxCpSAfikyTSXNg8C5+macLxTvijYOFFWPAF8
        /DyWhPjy4FikFap4SvpQdcVpsbJI
X-Google-Smtp-Source: APiQypKvALPmhHzMyvuDtmAnvifIfOFdJHLl2AAXGKB3AMV3k6kCs1F0Bqe42eUcrVpmcYwcaUU82Q==
X-Received: by 2002:a7b:cd0c:: with SMTP id f12mr4377106wmj.4.1585745705697;
        Wed, 01 Apr 2020 05:55:05 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id t11sm2760314wru.69.2020.04.01.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 05:55:04 -0700 (PDT)
Date:   Wed, 1 Apr 2020 14:55:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401125503.GJ22681@dhcp22.suse.cz>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
 <20200401070958.GB22681@dhcp22.suse.cz>
 <20200401123230.GB32593@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401123230.GB32593@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 14:32:30, Uladzislau Rezki wrote:
> On Wed, Apr 01, 2020 at 09:09:58AM +0200, Michal Hocko wrote:
> > On Tue 31-03-20 18:12:15, Uladzislau Rezki wrote:
> > > > 
> > > > __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> > > > memory reserves regarless of the sleeping status.
> > > > 
> > > Michal, just one question here regarding proposed flags. Can we also
> > > tight it with __GFP_RETRY_MAYFAIL flag? Means it also can repeat a few
> > > times in order to increase the chance of being success.
> > 
> > yes, __GFP_RETRY_MAYFAIL is perfectly valid with __GFP_ATOMIC. Please
> > note that __GFP_ATOMIC, despite its name, doesn't imply an atomic
> > allocation which cannot sleep. Quite confusing, I know. A much better
> > name would be __GFP_RESERVES or something like that.
> > 
> OK. Then we can use GFP_ATOMIC | __GFP_RETRY_MAYFAIL to try in more harder
> way.

Please note the difference between __GFP_ATOMIC and GFP_ATOMIC. The
later is a highlevel flag to use for atomic contexts. The former is an
explicit way to give an access to memory reserves. I am not familiar
with your code but if you have an existing gfp context coming from the
caller then just do (gfp | __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL).
If you do not have any gfp then decide based on whether the current
context is allowed to sleep
	gfp = GFP_KERNEL | __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL;
	if (!sleepable)
		gfp &= ~__GFP_DIRECT_RECLAIM;
-- 
Michal Hocko
SUSE Labs
