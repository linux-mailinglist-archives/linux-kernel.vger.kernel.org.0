Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6417613176B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgAFSWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 13:22:34 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:42899 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgAFSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:22:34 -0500
Received: by mail-qk1-f173.google.com with SMTP id z14so39005435qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 10:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5o2wRNCAKMcT/+6xTLyRnYIYx1n3D4DAHiecu8IQyes=;
        b=ckOvbiZou7OnvBjv8IpRiWZLu+SoPVStYUAKND4GlXtFrSgfa/yHShzLtmSZ5DA8ik
         zptwYPm0bcT9pRCpM+VVrUrM+ScseQ62S6oT/IdvF3k0Mm6h0cbmQltHvZ+U/qVUjn00
         sYRLoLFt+rvethCpi9tOihwEAuR3yyxP2pgBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5o2wRNCAKMcT/+6xTLyRnYIYx1n3D4DAHiecu8IQyes=;
        b=TaaFPckkqUCyuJGZkxsKdoJPz7hu6Sj/u/LyiwbGI3wAb66vQzwFt9TsgnKDuTAHys
         /f6tP5Mr5RbpDzeSPHynoiSVVXf8wVqHpWVrfbHwc/587WsRGqfV+4dLjKZIaxRGINfa
         Zpm7UHNuhRCR28Cwv00WPeS0MjoHkK261rF05qiubnQPOY6aL18XRM6iyuf/eWV/NvJe
         9kk2Q8jGCtcHWY7zqlCZwI1mBdtuIqQCt+AYENBT7nQRRlQm/PrQv0NISaGX3VmXHvuC
         CDJnUI0EkcTKY5bdoyqryemD9lgCQjH1BpFPqWTXOpWGOYpHRYLkgHp6+sj0yl6RbfSK
         qiww==
X-Gm-Message-State: APjAAAUzTrHQsCpHugIgsqBg2hliqhG/TYpd1EBKep8P4+Ruypq9g8pY
        ImcZZ8rSDJo1FSIy2tV6DeMjvw==
X-Google-Smtp-Source: APXvYqy+kLdlot2GUS5g7xCWLYAFic1eAv6vabAR+KojeGzv8G2ONbXwuzGXftaPD9ArDnSSsPOMbA==
X-Received: by 2002:a05:620a:1183:: with SMTP id b3mr80424517qkk.316.1578334951923;
        Mon, 06 Jan 2020 10:22:31 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id z141sm21094092qkb.63.2020.01.06.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:22:31 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:22:29 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        users@linux.kernel.org
Subject: Re: [RFC] tools lib traceevent: How to do library versioning being
 in the Linux kernel source?
Message-ID: <20200106182229.3sntyytugif4hesi@chatter.i7.local>
Mail-Followup-To: Jiri Olsa <jolsa@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        users@linux.kernel.org
References: <20200102122004.216c85da@gandalf.local.home>
 <20200102234950.GA14768@krava>
 <20200102185853.0ed433e4@gandalf.local.home>
 <20200103133640.GD9715@krava>
 <20200103181614.7aa37f6d@gandalf.local.home>
 <20200106151902.GB236146@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106151902.GB236146@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 04:19:02PM +0100, Jiri Olsa wrote:
> > I wonder if there should be a:
> > 
> >   git://git.kernel.org/pub/scm/utils/lib/
> > 
> > directory to have:
> > 
> >   git://git.kernel.org/pub/scm/utils/lib/traceevent/
> >   git://git.kernel.org/pub/scm/utils/lib/libbpf/
> >   git://git.kernel.org/pub/scm/utils/lib/libperf/

We already have 'pub/scm/libs' so I suggest we just place things there:

pub/scm/libs/traceevent
pub/scm/libs/libbpf
pub/scm/libs/libperf

Normally, we do a whole subdir, but that can be unnecessary, especially 
to avoid repetitions like:

pub/scm/libs/libgpiod/libgpiod.git

If the suggested locations work for you, just email helpdesk@kernel.org 
requesting their creation, and please specify who should have push 
access to them.

-K
