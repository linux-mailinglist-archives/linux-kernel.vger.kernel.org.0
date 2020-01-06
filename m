Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12BF131916
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 21:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgAFUOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 15:14:05 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44012 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAFUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:14:05 -0500
Received: by mail-qv1-f68.google.com with SMTP id p2so19560391qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zAjSv7QwLnVDNHgBSI40PMyv7BAdw9r1HNnXDMPP2Ok=;
        b=ONQ+uAd6Gf8x5vWcWhtrAXR/SVBEMazn50+msn0BVUrUEHoJQM5rB3xSi9T5au1N69
         tauVhMdhf9e31ZmzdmQ7kVs33UIvDpEOw8+AyX6uNmAet3lk7C8JZk1SiPQNlbxush8u
         ac1+P8ChStqoGgbN8qrnsrVB+SinBC1b1DJLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zAjSv7QwLnVDNHgBSI40PMyv7BAdw9r1HNnXDMPP2Ok=;
        b=W0/hdOcDTefPnxOmNP4DKfhH74LVLmdBaoHpKNijmTNY3iLx5xYIQ9F4C2xbyFRQY4
         nolrIIUHMXOW4O2/OQXyWLmiUewkyp99BncGMOFTIoH2rD9wW0s+jrflZVMRAcPG8BuW
         1Dnhmqqd1obIDOtz0eyU8vq1f/haffD2uHVS7/Y6LeZHKcA+8sTDulJtLk36DfKKfJWg
         lNd5iAj7BFeAeXMnQk7AreimMa+bCaKKqOacWowfPhDvmNMPR/o0HXYBc73gfh7TTpCu
         bN+/fs20WL+s4UuT+aGxbhfCaKRFq8ec7wYKv58NEBY1ZzXlrWdnt5m45KmPv5WtfNfL
         iRkA==
X-Gm-Message-State: APjAAAVzd+vrCVwHgNHSWf8IyxIRc6CJQ5sbXTPU7FrNGuiX9zAo66Hx
        TumR0jGJjIGGmZ9F2VXGaDAC9Q==
X-Google-Smtp-Source: APXvYqz5Rna8W9FnlG3nKTkWAbydEX6Ym9Y2Hw+whIFZGHvlEPQtbVeE4vyKKzvT3K/nRUswZDYxZQ==
X-Received: by 2002:a05:6214:b90:: with SMTP id fe16mr81833259qvb.83.1578341643916;
        Mon, 06 Jan 2020 12:14:03 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id g16sm21278877qkk.61.2020.01.06.12.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:14:03 -0800 (PST)
Date:   Mon, 6 Jan 2020 15:14:01 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        users@linux.kernel.org
Subject: Re: [RFC] tools lib traceevent: How to do library versioning being
 in the Linux kernel source?
Message-ID: <20200106201401.hcneggg4xmoazr5e@chatter.i7.local>
Mail-Followup-To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
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
 <20200106162623.GA11285@kernel.org>
 <20200106113615.4545e3c5@gandalf.local.home>
 <20200106194711.GC11285@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106194711.GC11285@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 04:47:11PM -0300, Arnaldo Carvalho de Melo wrote:
> Sure, regardless of where you do source code control you will need to
> tag, create a tarball, signatures (which kup helps with) for kernel.org,
> for instance I use:
> 
>   kup put perf-${VER}.tar.xz perf-${VER}.tar.sign /pub/linux/kernel/tools/perf/v${VER}/perf-${VER}.tar.xz

It's worth noting that you don't have to use kup if you don't want to -- 
we have a mechanism to create tarball releases directly from tag 
signatures. You just have to add a special note to the tag and the 
backend does the rest automatically -- we have a handy script [^1] to 
make it easier.

Greg KH has been using this process for a while now.

If you would like to switch to that instead of using kup directly, just 
let me know.

-K

[^1]: https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/git-archive-signer
