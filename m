Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD54427767
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfEWHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:49:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWHtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 373FF13A82;
        Thu, 23 May 2019 07:49:12 +0000 (UTC)
Received: from krava (unknown [10.40.205.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id CB37210021B1;
        Thu, 23 May 2019 07:49:09 +0000 (UTC)
Date:   Thu, 23 May 2019 09:49:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 01/12] perf tools: Separate generic code in
 dso__data_file_size
Message-ID: <20190523074909.GA27913@krava>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-2-jolsa@kernel.org>
 <20190513194754.GB3198@kernel.org>
 <20190513200015.GA2064@krava>
 <20190523031001.GD196218@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523031001.GD196218@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 23 May 2019 07:49:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 12:10:02PM +0900, Namhyung Kim wrote:
> Hi Jirka,
> 
> On Mon, May 13, 2019 at 10:00:15PM +0200, Jiri Olsa wrote:
> > On Mon, May 13, 2019 at 04:47:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, May 08, 2019 at 03:19:59PM +0200, Jiri Olsa escreveu:
> > > > Moving file specific code in dso__data_file_size function
> > > > into separate file_size function. I'll add bpf specific
> > > > code in following patches.
> > > 
> > > I'm applying this patch, as it just moves things around, no logic
> > > change, but can you please clarify a question I have after looking at
> > > this patch?
> > >  
> > > > Link: http://lkml.kernel.org/n/tip-rkcsft4a0f8sw33p67llxf0d@git.kernel.org
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/perf/util/dso.c | 19 ++++++++++++-------
> > > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > > index e059976d9d93..cb6199c1390a 100644
> > > > --- a/tools/perf/util/dso.c
> > > > +++ b/tools/perf/util/dso.c
> > > > @@ -898,18 +898,12 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
> > > >  	return r;
> > > >  }
> > > >  
> > > > -int dso__data_file_size(struct dso *dso, struct machine *machine)
> > > > +static int file_size(struct dso *dso, struct machine *machine)
> > > >  {
> > > >  	int ret = 0;
> > > >  	struct stat st;
> > > >  	char sbuf[STRERR_BUFSIZE];
> > > >  
> > > > -	if (dso->data.file_size)
> > > > -		return 0;
> > > > -
> > > > -	if (dso->data.status == DSO_DATA_STATUS_ERROR)
> > > > -		return -1;
> > > > -
> > > >  	pthread_mutex_lock(&dso__data_open_lock);
> > > >  
> > > >  	/*
> > > > @@ -938,6 +932,17 @@ int dso__data_file_size(struct dso *dso, struct machine *machine)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +int dso__data_file_size(struct dso *dso, struct machine *machine)
> > > > +{
> > > > +	if (dso->data.file_size)
> > > > +		return 0;
> > > > +
> > > > +	if (dso->data.status == DSO_DATA_STATUS_ERROR)
> > > > +		return -1;
> > > > +
> > > > +	return file_size(dso, machine);
> > > > +}
> > > 
> > > 
> > > So the name of the function suggests we want to know the
> > > "data_file_size" of a dso, then the logic in it returns _zero_ if a
> > > member named "dso->data.file_size" is _not_ zero, can you please
> > > clarify?
> > > 
> > > I was expecting something like:
> > > 
> > > 	if (dso->data.file_size)
> > > 		return dso->data.file_size;
> > > 
> > > I.e. if we had already read it, return the cached value, otherwise go
> > > and call some other function to get that info somehow.
> > 
> > we keep the data size in dso->data.file_size,
> > the function just updates it
> > 
> > the return code is the error code.. not sure,
> > why its like that, but it is ;-)
> > 
> > maybe we wanted separate size and error code,
> > because the size needs to be u64 and we use
> > int everywhere.. less casting
> 
> Maybe we can rename it to dso__update_file_size().

sounds good, I'll queue it

thanks,
jirka
