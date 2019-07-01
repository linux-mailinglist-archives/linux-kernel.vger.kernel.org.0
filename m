Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C104D85B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 20:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfFTS0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 14:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfFTSZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9913316290E;
        Thu, 20 Jun 2019 18:25:42 +0000 (UTC)
Received: from krava (ovpn-204-72.brq.redhat.com [10.40.204.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id 56BEC19C5B;
        Thu, 20 Jun 2019 18:25:23 +0000 (UTC)
Date:   Thu, 20 Jun 2019 20:25:19 +0200
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
Message-ID: <20190620182519.GA15239@krava>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-3-git-send-email-john.garry@huawei.com>
 <20190616095844.GC2500@krava>
 <a27e65b4-b487-9206-6dd0-6f9dcec0f1f5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27e65b4-b487-9206-6dd0-6f9dcec0f1f5@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 20 Jun 2019 18:25:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:06:08AM +0100, John Garry wrote:
> On 16/06/2019 10:58, Jiri Olsa wrote:
> > On Fri, Jun 14, 2019 at 10:08:00PM +0800, John Garry wrote:
> > > The jevent "Unit" field is used for uncore PMU alias definition.
> > > 
> > > The form uncore_pmu_example_X is supported, where "X" is a wildcard,
> > > to support multiple instances of the same PMU in a system.
> > > 
> > > Unfortunately this format not suitable for all uncore PMUs; take the Hisi
> > > DDRC uncore PMU for example, where the name is in the form
> > > hisi_scclX_ddrcY.
> > > 
> > > For the current jevent parsing, we would be required to hardcode an uncore
> > > alias translation for each possible value of X. This is not scalable.
> > > 
> > > Instead, add support for "Unit" field in the form "hisi_sccl,ddrc", where
> > > we can match by hisi_scclX and ddrcY. Tokens in Unit field are
> > > delimited by ','.
> > > 
> > > Signed-off-by: John Garry <john.garry@huawei.com>
> > > ---
> > >  tools/perf/util/pmu.c | 39 ++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 34 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index 7e7299fee550..bc71c60589b5 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -700,6 +700,39 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
> > >  	return map;
> > >  }
> > > 
> > > +static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
> > > +{
> > > +	char *tmp, *tok, *str;
> > > +	bool res;
> > > +
> > > +	str = strdup(pmu_name);
> > > +	if (!str)
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * uncore alias may be from different PMU with common
> > > +	 * prefix or matching tokens.
> > > +	 */
> > > +	tok = strtok_r(str, ",", &tmp);
> > > +	if (strncmp(pmu_name, tok, strlen(tok))) {
> > 
> 
> Hi Jirka,

heya,
sry for late reply

> 
> > if tok is NULL in here we crash
> > 
> 
> As I see, tok could not be NULL. If str contains no delimiters, then we just
> return same as str in tok.
> 
> Can you see tok being NULL?

well, if there's no ',' in the str it returns NULL, right?
and IIUC this function is still called for standard uncore
pmu names

> 
> > > +		res = false;
> > > +		goto out;
> > > +	}
> > > +
> > > +	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
> > 
> > why is name shifted in here?
> 
> I want to ensure that we match the tokens in order and also guard against
> possible repeated token matches in 'name'.

i might not understand this correctly.. so

str is the alias name that can contain ',' now, like:
  hisi_sccl,ddrc

and name is still pmu with no ',' ... please make this or
proper version that in some comment

thanks,
jirka
