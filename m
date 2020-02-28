Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15521173FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 19:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgB1Svv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 13:51:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44640 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Svv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:51:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id j23so2767183qtr.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FwDeIP3CdKitemqVTHkgE7RTKquwmO027xl/hGvLAk8=;
        b=Vr0W+nZMTKhqrIx+qMz0Lpx1d69wtt3RW1bb5sXapd+kKYJ66pba10KDzd05VGeufs
         SDiju8QuACF059WoxJqr5+98CBAfU4CrAjr263xmKGyliYY/Z0dZQgzjziPkzXS8HE2P
         6TDx7U1d1TuDHQCUjiM8EGLXJYG1ihV0dLiuq+sGph9od+sxO+rtmBpSg9znoLlSI6zB
         sWb64Dx+05W1LanSVHdbKypfVVML4eaF+pqnss5wgQZgpb7hGOen8twd2nVEsOhUjMrV
         A27sMN6MniQRwjvMdpR0+Dbkr+E/+jE66r/QOFwSXQGYcVfn9o7ozooYHGKZgodZYSk2
         ZPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FwDeIP3CdKitemqVTHkgE7RTKquwmO027xl/hGvLAk8=;
        b=XAUl8DAdVDeqR9UurH/Ynv3Obqv/FejVmuhxhPEz1/qZoiJ/U/UiRnt8DrkBZtSvg9
         X6TowxnBE2IvD4PjmqHjotwtW6r/jiI0NyOQx9FzqYTAD0ujrJXQKhzh7ahIPHTqHYu6
         lo7NxVoFYq6ptt5jVItqIaGonJQFnmcW+R8tnR1iy4JIZvfSKlfGyUWc04xD0EX1CpyC
         UQlRhn1CqoHmeR1r6/Y8bwO0/DxAj7ABDhGZcqRBZBbko2e+0XeVDiQs0pPkzKps12jZ
         qTIfI7PBowUj6/ksEPNzWu2GirCWp1xPlJPqFqsZqusKk9NckVYLtk73I2bEb+4raWXT
         98+g==
X-Gm-Message-State: APjAAAUTQaYXS+u0z9uP4cAT5H3G0CrbU3zELUU0AWsW0HiCa/ApQnbv
        li/dqTpA6Gx2QGamJuz0whk=
X-Google-Smtp-Source: APXvYqyht9utYMcFvICAKVYiMBPsR0aYF1+7O2pv8YMt5vgA1iEFX/U2avTicTYLCPame26/Y8zOmw==
X-Received: by 2002:ac8:4cc9:: with SMTP id l9mr5297658qtv.207.1582915907093;
        Fri, 28 Feb 2020 10:51:47 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q125sm5554167qke.116.2020.02.28.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 10:51:45 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F3A8403AD; Fri, 28 Feb 2020 15:51:43 -0300 (-03)
Date:   Fri, 28 Feb 2020 15:51:43 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/13] kprobes: Add symbols for kprobe insn pages
Message-ID: <20200228185143.GA2904@kernel.org>
References: <20200228135125.567-1-adrian.hunter@intel.com>
 <20200228135125.567-4-adrian.hunter@intel.com>
 <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
 <20200228172004.GI5451@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228172004.GI5451@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 28, 2020 at 06:20:04PM +0100, Jiri Olsa escreveu:
> On Fri, Feb 28, 2020 at 11:36:00PM +0900, Masami Hiramatsu wrote:
> > On Fri, 28 Feb 2020 15:51:15 +0200
> > Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > 	# perf probe __schedule
> > > 	Added new event:
> > > 	  probe:__schedule     (on __schedule)
> > > 	# cat /proc/kallsyms | grep '\[kprobe\]'
> > > 	ffffffffc0035000 t kprobe_insn_page     [kprobe]
> > > 	ffffffffc0054000 t kprobe_optinsn_page  [kprobe]

> > Could you make the module name as [kprobes] ?
> > BTW, it seems to pretend to be a module, but is there no concern of
> > confusing users? Shouldn't it be [*kprobes] so that it is non-exist
> > module name?
 
> note we already have bpf symbols as [bpf] module

That bracket-wrapped convention by now is not module related, but
instead non-main-kernel :-) If one wants to enumerate the modules in the
system, then use /proc/modules, then, to get the symbols for it, look at
symbols in /proc/kallsyms in that [ start, start + module size ] range
and strip whatever comes after '[' :-)

- Arnaldo
