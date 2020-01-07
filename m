Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54B3132D53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgAGRov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 12:44:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35385 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgAGRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:44:50 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so471602qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l6Qo0K02qol2vT4XKfjT5PiBgjGoo2TpWJxoAhWK9HQ=;
        b=RfUbMuZMnJ4s9dNKBIWKMN98q4/5vNSrzh7sYWLO0noyZdMBRnkVX0+VDebs/xwcY1
         jnXj+yWjI6zLPknb/0Lrh4sSmuXuyeDDGTK8A6t5e34+wgMDcdIZX/sePGLWXvpB/EsR
         hpSWyu5S25XHfI3dHW52YJFb8BwQfGKjAjopaNV2y5zlSwH3KdA5CmTAsbB5PgKnLfe9
         6hZ0aXYwezvncz2fI8NLVMGg6ra93xeVzuzap5srw77egXzhbQO56HWpV+XyJU5PrvoX
         ztZudKRdZQ6mGFfs+MVxkbElxsrixXfY+Mocc/UXMuaqTC5KN0krDP7hEDKWE9DVlAL3
         2kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l6Qo0K02qol2vT4XKfjT5PiBgjGoo2TpWJxoAhWK9HQ=;
        b=WEwrjbSUxhNv1DjnLD1Ktn/ae+Jo8B5Q3hvdr9UsrPT+53xTiposUJOeA/2SBBpLBS
         EcSOYrv+9ydqJ75yPVDHzfy/tFY1P4D3Z23UdZWe0XT90zP7rtYucOqhhm6QQgjEtZ6x
         mdH3MFkiWGBRI/7qpJN3QcuMjn6tG84I6DmvwUBslaB3W8Ap/Rh5gSvG++v9eWcLQpRx
         KMhwyQsLgP/naWBR3IH/pvGeY2w3mg3vZYyVtMR8aAXyrqCGC7foA5osnCR6N18uAdTv
         WJ95qF6GvPwGrXM6agkWWIUkZ+97Wcaat+XZQr7kDSJrxuGtLphNCNxlieCj6vTgeU+n
         Gvnw==
X-Gm-Message-State: APjAAAXb2hEPv/Mjwwh7k3I18YjeuBfzVaLcjVxj1gOnftWoT9d/0hLH
        B7HMaipAtRxkvahZuAuHgyX5MQ==
X-Google-Smtp-Source: APXvYqwgkxv2aw15TpEfv2EE+J9tpTjQ/MgnWBR9K7t3IA5WmHgUMEnKjjZjbqmle8Hx8mIWrDkQTQ==
X-Received: by 2002:ac8:5059:: with SMTP id h25mr141462qtm.20.1578419089641;
        Tue, 07 Jan 2020 09:44:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 124sm137383qkn.58.2020.01.07.09.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 09:44:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iosuO-0007e2-GF; Tue, 07 Jan 2020 13:44:48 -0400
Date:   Tue, 7 Jan 2020 13:44:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        users@linux.kernel.org
Subject: Re: [kernel.org users] [RFC] tools lib traceevent: How to do library
 versioning being in the Linux kernel source?
Message-ID: <20200107174448.GA26174@ziepe.ca>
References: <20200102122004.216c85da@gandalf.local.home>
 <20200102234950.GA14768@krava>
 <20200102185853.0ed433e4@gandalf.local.home>
 <20200103133640.GD9715@krava>
 <20200103181614.7aa37f6d@gandalf.local.home>
 <20200106151902.GB236146@krava>
 <20200106162623.GA11285@kernel.org>
 <20200106113615.4545e3c5@gandalf.local.home>
 <20200106204715.GA22353@ziepe.ca>
 <20200106155232.4061d755@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106155232.4061d755@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 03:52:32PM -0500, Steven Rostedt wrote:
> On Mon, 6 Jan 2020 16:47:15 -0400
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > If it is not tightly linked to the kernel and is just a normal
> 
> Well, it's used by perf, trace-cmd, power-top and rasdaemon (and
> perhaps even more). It lives in the kernel tree mainly because of perf.

I see
 
> > With github actions now able to provide a quite good CI it covers a
> > lot of required stuff for a library in one place, in a way that
> > doesn't silo all the build infrastucture.
> 
> Github has ways to help with libraries? I'm totally clueless about
> this. I'm interested in hearing more.

These days it is a lot of work to get a library ready for the
distributions and github now has a built-in CI (git hub actions) that
lets projects run through all the build and in some cases runtime
tests needed often and automatically.

For instance we build rdma-core for Centos 6,78, Fedora 31, Ubuntu,
SuSe, cross compile on ARM and PPC, all automatically and all drive
from a fairly short script in the source tree, so anyone can
contribute.

The release process to .tar.gz (and distro packages if we wanted) is
also automated via the same. Push a tag and all the release stuff is
done and the right .tar.gz appears automatically in the right place.

It is nothing so unique, but having everything nicely integrated in
one place makes it possible for a project to spend a small amount of
time on CI and administration stuff instead of a large amount :)

Jason
