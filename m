Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EED71AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390714AbfGWO6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 10:58:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46349 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbfGWO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:58:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so43507586wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Q95sKPFk9TccCca5wm3MHqC/bILt6AlguaLb9p5BtM=;
        b=g8Ky7hATJwptR//UND/jG/r3mccmYHC8uZCQYn50bwCFHZGB/3RVRJRJWdvyy+Rc2i
         kpEyC/4wLVYqeP91OeI/Zh2dXNi/HvG/Ta5pBu6akBNEiAT0/XSIhrRH1zjhvJ9+pfv8
         in1u9nnjoiEcyTghVgOHXPEFCodJqBCZ4bNvhoHFburxMVx/hwS4hSJ8YCBSHV1/ZJh5
         D3DYZu1kN1BD5qafV7enODJrm4x5poIZEcZ6u9gW7o805qYb4GKKqiBAOYb1tkYA5JVa
         G0GotRYSFMbuiOGrpUV1t2K6Mh8Z29bqngMtKoTxfvhT6EMmtBhbBF8Y97YCItX16Hjj
         +OtQ==
X-Gm-Message-State: APjAAAVeslfvVsrATinvQYKjDKAWtdBOOUcnXvxQSPca7vz7BA3SWn+e
        6mOmLMxbJgz7JpgZBuIfA44VZQ==
X-Google-Smtp-Source: APXvYqwajsaIpsTNukBrd6DpemfTekkynv+5Etmj9MGkQ//eh78SY+UKHQhzkijD9ozwvRSKVYHHOw==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr85777998wrr.41.1563893903061;
        Tue, 23 Jul 2019 07:58:23 -0700 (PDT)
Received: from localhost.localdomain ([151.82.8.29])
        by smtp.gmail.com with ESMTPSA id x11sm30735456wmi.26.2019.07.23.07.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 07:58:21 -0700 (PDT)
Date:   Tue, 23 Jul 2019 16:58:18 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Message-ID: <20190723145818.GI25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
 <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
 <20190722083214.GF25636@localhost.localdomain>
 <20190723103131.GB3402@hirez.programming.kicks-ass.net>
 <20190723131100.GE696309@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723131100.GE696309@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/19 06:11, Tejun Heo wrote:
> On Tue, Jul 23, 2019 at 12:31:31PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 22, 2019 at 10:32:14AM +0200, Juri Lelli wrote:
> > 
> > > Thanks for reporting. The set is based on cgroup/for-next (as of last
> > > week), though. I can of course rebase on tip/sched/core or mainline if
> > > needed.
> > 
> > TJ; I would like to take these patches through the scheduler tree if you
> > don't mind. Afaict there's no real conflict vs cgroup/for-next (I
> > applied the patches and then did a pull of cgroup/for-next which
> > finished without complaints).
> 
> Yeah, for sure, please go ahead.
> 
> Thanks.

Thanks!
