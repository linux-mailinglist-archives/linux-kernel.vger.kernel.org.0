Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1838A159037
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgBKNrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 08:47:19 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39783 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgBKNrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:47:18 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so4982626qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tb7L5BLU1T+t13WEosQ02IwryZN78SHxXhTL4NA7JBQ=;
        b=dZv6TO2/7XFSQsrz43LGtFaV6HtMyTUllj8+VR9t1Fx/4nmtAg42zQhgVGuVo8eEtc
         mOkWrbj/JPq6cCNnlsSsan3thzt3OHR2DwHDYrVPU5RzhGWTPkw464JOq6fLX003U6FR
         YYzW623c27Oxk/MLn2HV9YIMJYzPNXXcrgVSp20SI8m9T5f7/YAZlS5Q0Kbo0U8ykTTp
         q615mnaa3vpXuuy1uhgp0BJ9WXGiF1gDUXDWC9PKbpdT6XVv4FCD4h9244sIbR9D6We9
         69y9zkWbZ59j1WNd4SnU1TsIKrglpCXXGA0M4S+Noy77EfA3H3cIOqYxdwHQ8MI33ai6
         b9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tb7L5BLU1T+t13WEosQ02IwryZN78SHxXhTL4NA7JBQ=;
        b=JkZrkqopGt4oTYZbr+Rf5gAngNshKjMyCdpNhoTqxUgHs2UptckbdFJ6zPOiAQRmjM
         bHGN+8JZcjtHMyBaZ6cdmnbQZ6vHH8MrIbs5GE31zeQpIi/NE6cCV4J/7hnvviC0g9Ws
         s8EQ19kRivX1vNcYEq40s5XdiyX4QwjCf4XII/Q2n+kDTR8DWOh+bDFA4leGPx4xoYy5
         9fUgYvt6BbeaimDedUoqAuNm7T6KXN0mBV14C0O7qEPmk/XYyXKpHQtAHQHORpG/Iiik
         bEsFu4wO/edpNjNhgVi6RV6lKIzOfiV1TJlclFLfjZeviA9HEKol2+arCt55BwFlVl6a
         XBJw==
X-Gm-Message-State: APjAAAWyz9jBULPAZHwJNXsUQ8NBdSJS29TZ+gBwtaXZM2XBg8K9dedk
        eNJbA7l/D0MbObOs3kxJxNHl3XxZsdI=
X-Google-Smtp-Source: APXvYqyPEAUmIYGDQBA5y3m7H6TKRbGaYZ5LxlUZlBjLzIQImWX36L1TbLmB+CyI2o6he0QytlaxLQ==
X-Received: by 2002:a05:6214:4f0:: with SMTP id cl16mr2927817qvb.213.1581428836344;
        Tue, 11 Feb 2020 05:47:16 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id z27sm1948053qkz.89.2020.02.11.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:47:15 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E342540A7D; Tue, 11 Feb 2020 10:47:13 -0300 (-03)
Date:   Tue, 11 Feb 2020 10:47:13 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCHv2 2/4] perf tools: Mark ksymbol dsos with kernel type
Message-ID: <20200211134713.GB32066@kernel.org>
References: <20200210143218.24948-1-jolsa@kernel.org>
 <20200210143218.24948-3-jolsa@kernel.org>
 <20200210151759.GB25639@kernel.org>
 <20200210152537.GA28110@krava>
 <20200210200847.GA36715@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210200847.GA36715@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 10, 2020 at 09:08:47PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 10, 2020 at 04:25:37PM +0100, Jiri Olsa wrote:
> > On Mon, Feb 10, 2020 at 12:17:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Feb 10, 2020 at 03:32:16PM +0100, Jiri Olsa escreveu:
> > > > We add ksymbol map into machine->kmaps, so it needs to be
> > > > created as 'struct kmap', which is dependent on its dso
> > > > having kernel type.
> > > > 
> > > > Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > > > Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/perf/util/machine.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > > index e3e5490f6de5..0a43dc83d7b2 100644
> > > > --- a/tools/perf/util/machine.c
> > > > +++ b/tools/perf/util/machine.c
> > > > @@ -727,8 +727,14 @@ static int machine__process_ksymbol_register(struct machine *machine,
> > > >  	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
> > > >  
> > > >  	if (!map) {
> > > > -		map = dso__new_map(event->ksymbol.name);
> > > > -		if (!map)
> > > > +		struct dso *dso = dso__new(event->ksymbol.name);
> > > > +
> > > > +		if (dso) {
> > > > +			dso->kernel = DSO_TYPE_KERNEL;
> > > > +			map = map__new2(0, dso);
> > > > +		}
> > > > +
> > > > +		if (!dso || !map)
> > > 
> > > We leak dso if map creation fails?
> > 
> > yep :-\ will post v2
> 
> v2 attached, it's also all in my perf/top branch

Thanks for fixing it, will process it into my perf/urgent branch.

- Arnaldo
 
> thanks,
> jirka
> 
> 
> ---
> We add ksymbol map into machine->kmaps, so it needs to be
> created as 'struct kmap', which is dependent on its dso
> having kernel type.
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/machine.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index e3e5490f6de5..0ad026561c7f 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -727,9 +727,17 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
>  
>  	if (!map) {
> -		map = dso__new_map(event->ksymbol.name);
> -		if (!map)
> +		struct dso *dso = dso__new(event->ksymbol.name);
> +
> +		if (dso) {
> +			dso->kernel = DSO_TYPE_KERNEL;
> +			map = map__new2(0, dso);
> +		}
> +
> +		if (!dso || !map) {
> +			dso__put(dso);
>  			return -ENOMEM;
> +		}
>  
>  		map->start = event->ksymbol.addr;
>  		map->end = map->start + event->ksymbol.len;
> -- 
> 2.24.1
> 

-- 

- Arnaldo
