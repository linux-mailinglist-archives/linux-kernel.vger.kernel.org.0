Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C59EA266
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfJ3RT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 13:19:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24897 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726602AbfJ3RT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572455966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYb5zRD7pK3sLStdyv5gkgP6u1qsYdzN5mSOo4AiXXU=;
        b=CbKJM/EMfHROzeiOE+UTvuycxiLNVlRJ3rW2Yifg1T5+EPIALdD6R0vS2FmUo4AJquf9iJ
        GE3q4M3pdVKq6JMb6P9F5NMDeUzkpnv0UYuupAcfV+f4wEhXmYI3XBw+XJoO0QDcc542H1
        eGRaoSC6qPf2aDm3djMXm4XMw9VR908=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-7ZDI3WjNNs6B979ETWTejQ-1; Wed, 30 Oct 2019 13:19:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B71A800D49;
        Wed, 30 Oct 2019 17:19:21 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04E525C883;
        Wed, 30 Oct 2019 17:19:16 +0000 (UTC)
Date:   Wed, 30 Oct 2019 13:19:15 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Message-ID: <20191030171914.GF1686@pauld.bos.csb>
References: <20191021075038.GA27361@gmail.com>
 <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb>
 <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb>
 <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb>
 <564ca629-5c34-dbd1-8e64-2da6910b18a3@arm.com>
 <bf96be8a-2358-b9ab-b8eb-d0b8b94ed0d7@arm.com>
MIME-Version: 1.0
In-Reply-To: <bf96be8a-2358-b9ab-b8eb-d0b8b94ed0d7@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 7ZDI3WjNNs6B979ETWTejQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 30, 2019 at 05:35:55PM +0100 Valentin Schneider wrote:
>=20
>=20
> On 30/10/2019 17:24, Dietmar Eggemann wrote:
> > On 30.10.19 15:39, Phil Auld wrote:
> >> Hi Vincent,
> >>
> >> On Mon, Oct 28, 2019 at 02:03:15PM +0100 Vincent Guittot wrote:
> >=20
> > [...]
> >=20
> >>>> When you say slow versus fast wakeup paths what do you mean? I'm sti=
ll
> >>>> learning my way around all this code.
> >>>
> >>> When task wakes up, we can decide to
> >>> - speedup the wakeup and shorten the list of cpus and compare only
> >>> prev_cpu vs this_cpu (in fact the group of cpu that share their
> >>> respective LLC). That's the fast wakeup path that is used most of the
> >>> time during a wakeup
> >>> - or start to find the idlest CPU of the system and scan all domains.
> >>> That's the slow path that is used for new tasks or when a task wakes
> >>> up a lot of other tasks at the same time
> >=20
> > [...]
> >=20
> > Is the latter related to wake_wide()? If yes, is the SD_BALANCE_WAKE
> > flag set on the sched domains on your machines? IMHO, otherwise those
> > wakeups are not forced into the slowpath (if (unlikely(sd))?
> >=20
> > I had this discussion the other day with Valentin S. on #sched and we
> > were not sure how SD_BALANCE_WAKE is set on sched domains on
> > !SD_ASYM_CPUCAPACITY systems.
> >=20
>=20
> Well from the code nobody but us (asymmetric capacity systems) set
> SD_BALANCE_WAKE. I was however curious if there were some folks who set i=
t
> with out of tree code for some reason.
>=20
> As Dietmar said, not having SD_BALANCE_WAKE means you'll never go through
> the slow path on wakeups, because there is no domain with SD_BALANCE_WAKE=
 for
> the domain loop to find. Depending on your topology you most likely will
> go through it on fork or exec though.
>=20
> IOW wake_wide() is not really widening the wakeup scan on wakeups using
> mainline topology code (disregarding asymmetric capacity systems), which
> sounds a bit... off.

Thanks. It's not currently set. I'll set it and re-run to see if it makes
a difference.=20


However, I'm not sure why it would be making a difference for only the cgro=
up
case. If this is causing issues I'd expect it to effect both runs.=20

In general I think these threads want to wake up the last cpu they were on.
And given there are fewer cpu bound tasks that CPUs that wake cpu should,
more often than not, be idle.=20


Cheers,
Phil



--=20

