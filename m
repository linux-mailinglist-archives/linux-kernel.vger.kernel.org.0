Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F8213392A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 03:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAHCgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 21:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHCgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:36:55 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0FE12070E;
        Wed,  8 Jan 2020 02:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578451014;
        bh=4eM+CQ/hzMXbUB/GjEjW/3RPOmXGFmhYOFJVxa6Vh30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xgLI3Sq38e5MYIe7o9K/QzFFP6t/01rjyzWa2tVODbqFXHpWltsldk97L6c9AEJ02
         j7M19511g17OHkb5tNhzjyjMmPaCuWiJjDHbgXvm45VruwQVmQcFEOlqK22hCECUSy
         SOai+5ulPki0z/8u8lZa7YjL1ZwXsTN2TMjed41s=
Date:   Wed, 8 Jan 2020 11:36:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf probe: Fix to delete multiple probe event
Message-Id: <20200108113650.a625f11c3cfa510d41edbd63@kernel.org>
In-Reply-To: <20191204112952.7b7d61feb2b14173ae625378@kernel.org>
References: <157536011452.29277.3647564438675346431.stgit@devnote2>
        <20191204112952.7b7d61feb2b14173ae625378@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Could you pick this fix?

Sandipan, could you also test this?

Thank you,

On Wed, 4 Dec 2019 11:29:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue,  3 Dec 2019 17:01:54 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix to delete multiple probe event with filter correctly.
> > 
> > When we put an event with multiple probes, perf-probe fails
> > to delete with filters. This comes from a failure to list
> > up the event name because of overwrapping its name.
> > 
> > To fix this issue, skip to list up the event which has
> > same name.
> > 
> > Without this patch:
> >   # perf probe -l \*
> >     probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:21@
> >     probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:25@
> >     probe_perf:map__map_ip (on append_inlines:12@util/machine.c in
> >     probe_perf:map__map_ip (on unwind_entry:19@util/machine.c in /
> >     probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
> >     probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
> >   # perf probe -d \*
> >   "*" does not hit any event.
> >     Error: Failed to delete events. Reason: No such file or directory (Code: -2)
> > 
> > With this:
> >   # perf probe -d \*
> >   Removed event: probe_perf:map__map_ip
> > 
> 
> Oops, I missed Fixed tag.
> 
> Fixes: 72363540c009 ("perf probe: Support multiprobe event")
> 
> Thanks,	
> 
> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-file.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> > index 5003ba403345..c03a591d41a4 100644
> > --- a/tools/perf/util/probe-file.c
> > +++ b/tools/perf/util/probe-file.c
> > @@ -206,6 +206,9 @@ static struct strlist *__probe_file__get_namelist(int fd, bool include_group)
> >  		} else
> >  			ret = strlist__add(sl, tev.event);
> >  		clear_probe_trace_event(&tev);
> > +		/* Skip if there is same name multi-probe event in the list */
> > +		if (ret == -EEXIST)
> > +			ret = 0;
> >  		if (ret < 0)
> >  			break;
> >  	}
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
