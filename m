Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F105859896
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfF1Kkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 06:40:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfF1Kkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:40:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2E705AFE9;
        Fri, 28 Jun 2019 10:40:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 832415DA63;
        Fri, 28 Jun 2019 10:40:41 +0000 (UTC)
Date:   Fri, 28 Jun 2019 12:40:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        tmricht@linux.ibm.com, brueckner@linux.ibm.com,
        kan.liang@linux.intel.com, ben@decadent.org.uk,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v2 2/5] perf pmu: Support more complex PMU event aliasing
Message-ID: <20190628104040.GA15960@krava>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-3-git-send-email-john.garry@huawei.com>
 <20190616095844.GC2500@krava>
 <a27e65b4-b487-9206-6dd0-6f9dcec0f1f5@huawei.com>
 <20190620182519.GA15239@krava>
 <6257fc79-b737-e6ca-2fce-f71afa36e9aa@huawei.com>
 <cafed7d6-13c7-3a92-a826-024698bc6cc8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cafed7d6-13c7-3a92-a826-024698bc6cc8@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 28 Jun 2019 10:40:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 05:27:32PM +0100, John Garry wrote:

SNIP

> > > 
> > > heya,
> > > sry for late reply
> > > 
> > > > 
> > > > > if tok is NULL in here we crash
> > > > > 
> > > > 
> > > > As I see, tok could not be NULL. If str contains no delimiters, then
> > > > we just
> > > > return same as str in tok.
> > > > 
> > > > Can you see tok being NULL?
> > > 
> > > well, if there's no ',' in the str it returns NULL, right?
> > 
> > No, it would return str in tok.

ok

> > 
> > > and IIUC this function is still called for standard uncore
> > > pmu names
> > > 
> > > > 
> > > > > > +        res = false;
> > > > > > +        goto out;
> > > > > > +    }
> > > > > > +
> > > > > > +    for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",",
> > > > > > &tmp)) {
> > > > > 
> > > > > why is name shifted in here?
> > > > 
> > > > I want to ensure that we match the tokens in order and also guard
> > > > against
> > > > possible repeated token matches in 'name'.
> > > 
> > > i might not understand this correctly.. so
> > > 
> > > str is the alias name that can contain ',' now, like:
> > >   hisi_sccl,ddrc
> > 
> > For example of pmu_nmame=hisi_sccl,ddrc and pmu=hisi_sccl1_ddrc0, we
> > match in this sequence:
> > 
> > loop 1. tok=hisi_sccl name=hisi_sccl1_ddrc0
> > loop 2. tok=ddrc name=ddrc0
> > loop 3. tok=NULL -> breakout and return true

ok, plz put something like above into comment

thanks,
jirka
