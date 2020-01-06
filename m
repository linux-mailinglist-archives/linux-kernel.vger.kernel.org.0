Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDC0131997
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgAFUrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 15:47:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40514 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:47:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so40715210qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DHIwKB1SdWvG9S5/QAvd4TjIognysn5YuV1n6f7gju4=;
        b=Ra6NkQtFY7ijfnuXcAGbxOh84AXs0GWCp722hpltolpulCuDmOLw8xBTEKXWQtdU+h
         2OGkYYMcxBKG2t7aYoNXT7nLc6Ti0my91ZM3b+texHVG5h/wSGkOic3KAWj47Ry08SHn
         R7Dp/dPAv3KbpsRpBkV/2WwjI1BrSDy/eZugBIFEG/6s5dE5gmiqNAkkExzhPnpE3IJI
         jnoj1PE/njE4mZgeMqGQJfCILswzX/1AI4LO9cAS3dpvOPX5nTS6mGoC4lRRGTzVL6nY
         dRkDX701YnWJcV1QYJYEP2mjxIraSqA6JbePQEroGvKRZGaXUwws0WuQSZZRD2tXVRit
         dadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DHIwKB1SdWvG9S5/QAvd4TjIognysn5YuV1n6f7gju4=;
        b=LQkStbOAge8QHONrOkYvo0nTFt/GxcengozVNjYGeRYB1K+MyMBU05ElPioD1P14mM
         +vKpE36EINBt2wDKai1V4Iy1nwAlaCjWbNE4sWt19ppEqcVsmKMfXi0T+83aqCZBUbEe
         KlwFSUQvxGZwKH2H2Bn27S73B36ZB627jr0Lin1+pFbZ3nIUUhSwyq1dktRXFUD2O2KW
         jlurBTBz1DmtI3KmsygTWf2v5n1yA1RwsBI+p61lqzTezXJ6KuRcTYIw6YgYaf1ASdf3
         NeqnS8C1joRPbYQBIQnxjgiaNIRpLBMPJhF9xe0eHk5Vp2FpqnhEO9trfFlOxOmf+smR
         8V8A==
X-Gm-Message-State: APjAAAVZo/O0OqM2mshCYCLuh2oT+OaNk/ZJCHtJn17JGBYXZIKSv+Xz
        GTy3RfpRiQtzqWekbwwh9nt95w==
X-Google-Smtp-Source: APXvYqzEgsE5n2gRG76eAGoeg63WHVa5P6c8cDUeUTV19BhlgMQXoclCr81eaop/b4Jhnynt+RpN3A==
X-Received: by 2002:a05:620a:143a:: with SMTP id k26mr85511562qkj.450.1578343636899;
        Mon, 06 Jan 2020 12:47:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d184sm13598598qkb.128.2020.01.06.12.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 12:47:16 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ioZHP-0007G2-J2; Mon, 06 Jan 2020 16:47:15 -0400
Date:   Mon, 6 Jan 2020 16:47:15 -0400
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
Message-ID: <20200106204715.GA22353@ziepe.ca>
References: <20200102122004.216c85da@gandalf.local.home>
 <20200102234950.GA14768@krava>
 <20200102185853.0ed433e4@gandalf.local.home>
 <20200103133640.GD9715@krava>
 <20200103181614.7aa37f6d@gandalf.local.home>
 <20200106151902.GB236146@krava>
 <20200106162623.GA11285@kernel.org>
 <20200106113615.4545e3c5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106113615.4545e3c5@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 11:36:15AM -0500, Steven Rostedt wrote:
> On Mon, 6 Jan 2020 13:26:23 -0300
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> 
> > So, we have:
> > 
> > https://www.kernel.org/pub/linux/kernel/tools/perf/
> > 
> > trying to mimic the kernel sources tree structure, so perhaps we could
> > have:
> > 
> > https://www.kernel.org/pub/linux/kernel/tools/lib/{perf,traceevent}/
> > 
> > To continue that directory tree mirror?
> 
> Wouldn't that become a bit of manual work. Unlike perf, the versions
> will not correspond to the Linux kernel versions. They would need to
> follow library versioning.
> 
> It would at a minimum require new scripting to get this right.

If it is not tightly linked to the kernel and is just a normal
library, you might consider using github. This is what we do for the
rdma user space and it works well. We still take patches from the
mailing list flow, but do use a fair amount of the github stuff too:

https://github.com/linux-rdma/rdma-core

With github actions now able to provide a quite good CI it covers a
lot of required stuff for a library in one place, in a way that
doesn't silo all the build infrastucture.

If you are interested in how we set it up I can write a longer email.

Regards,
Jason
