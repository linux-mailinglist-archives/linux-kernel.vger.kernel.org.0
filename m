Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F352D125287
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 21:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLRUCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 15:02:21 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45683 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLRUCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:02:21 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so1242106qvu.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvD2JQDuH4fp9sHwXTn54wEBIP+Gb6gwcASllj4GdH8=;
        b=vQG6/WX2wxf2zVdqgUrT/Cgo9+wQif+vlWFpcko5znJBQcgwiWBKd6IwQLrjVvcyok
         ldhRHO7bSVrYvx6s3RHKNemvS3jtdhRWL1etpKJ/d6TLAzTJyfdjTQQ/Q7OTxJMXqxUm
         YzHLHIbVuQmdqVGXi1hQADcYZgTtUfAXpM1DE16qfY1pGbJjjLiQO54ymRazlMYwRlHH
         HDLkqaI+gKbH6YWvPW2HfD4hszCtPGMHcJGq1GNLxWJfoMIu68gNzN91EhhjTbGlwv6x
         4qrA3wuG5/wSRZNUQ2HGmOUySDyZXnN5vDDNoJmIz810LEggTOn0fHUOI5zFFsJjKXXi
         L2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvD2JQDuH4fp9sHwXTn54wEBIP+Gb6gwcASllj4GdH8=;
        b=OkRJw6FhKC4KsBdvU7dVYeCSl2jlMsKaRAdSjURIA4hXAslN85G41apcJnWmdyKDKG
         SgvjFRXaSjmMiYx/G1pJDPPWEimHuM05M2x+8kQhUWgZnzZirWetbtvWuGRJwNyPVxKR
         M6ISnuhjSjFtcOtybqdfTFoaVGHWGfxZatqj8pVBHx0/tStpXILM5uvdK/J1Fqabe5Xh
         yL9rUExgXh+91DIaKUtUYnyuVT9EmLSTlY9D1V8u2wovJegFEk8pM7i5qR6sElOyGBbp
         b4OgIolMXEEWBr88MVqsoHoyQfboxq33VkvitpP2D9xLE9rN76Hdl4pM8kEJrs9w1W7a
         cbwQ==
X-Gm-Message-State: APjAAAV7t1gM6ocJO15B+zZBPIx4M8iRZDjCtP28Uot6WUW2IR93n/am
        TGbovqJu+4XY2ByNfkrvLc+FA+16tjtaj8mP52ixSQ==
X-Google-Smtp-Source: APXvYqw7bs9t7h/GpxmZNvuObe1lghn+cqt1wBgMbxGv8gqgMgbBOEZRuOnFvTJcp7RtCjzI8nK0X4Yrb06qLuLfSMM=
X-Received: by 2002:a05:6214:1189:: with SMTP id t9mr4038064qvv.153.1576699340286;
 Wed, 18 Dec 2019 12:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20191204200623.198897-1-joshdon@google.com> <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
 <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
 <edc9f4aa-a6ab-3bab-0a9e-73a155b8a48a@arm.com> <CABk29Ns3v3KqAo89oEOqQjRQxWN4Wgc+YtweWbS13MtmsUJeyw@mail.gmail.com>
 <55c162e4-2f3a-5628-cbe3-31bce6cb8480@arm.com>
In-Reply-To: <55c162e4-2f3a-5628-cbe3-31bce6cb8480@arm.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 18 Dec 2019 12:02:09 -0800
Message-ID: <CABk29NvMS87uGnFRWoN3Ce0t+UQ--qnjRmQCPJCCEcSASs25uQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched hierarchy
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed; I'll modify the comment to better reflect the intention here.
Thanks for taking a look!
