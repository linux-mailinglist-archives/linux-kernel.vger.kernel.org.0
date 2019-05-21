Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14824A55
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEUI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:28:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38133 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:28:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so17513134wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wdhVxNuHfuoXyI8xqp0bn0VEfqPUWcUQ2Mncaqbkigc=;
        b=DHMHMt8rXcg+AZHnauGhcnKjaSDn1qrv1bVc62py3SZ2mqnMVXV7hOW+Md2tQjsqxv
         zhp6xJs2rQim2fGBgyS/ua/9ViDkCZ4SQAvrH2ZlYERqrsxen7lC/FtfSS6J8JcOKqhZ
         YNt6ZXw91HD4zuybQxzs9mx/9NPH+U354Z4+DBc+H5XjFKsmAzoahwJLGbjPklEJVeHU
         Zfkw6Ao3q93BFS1HbQp/kFNt1LGikSxoE+YgNKVeWsKu+aiyeiVZSvpy2vuwb7f1MUMI
         GqFjCUeKAGOaNWo7kxT5qcpklJmYS+WoX+sGpuHsjE/wBqYW6iONrW+GoMIjIuep+Uh5
         hVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wdhVxNuHfuoXyI8xqp0bn0VEfqPUWcUQ2Mncaqbkigc=;
        b=Jnb/fuCzgjx8C2G0Ubv1pTVytZtBrCaFntY1tQjBQwwdWyMoO8PGg58uRrqdCXi0Bq
         LO+NSOrS5VMC8/+BkgObXa+eo4Usp0u39kixJi1U/BiCJIyXX3G3HNw1tnfhyRi7U0mx
         SumpH1tYz74FnsxpfGHwQ2LQ16msKovZCklJNMvB/D6VWUnyD1onkKWVQ2v31mYLhajq
         zSGUbUEMHkv5BGyJU6/D45vPN1EQEVSCOOEsbnlUEjnu9x3ApslZafaz1vWwb3Iv3yB0
         a0r3jTHHNqglwinl2NNr9X6K//WvmoDUUt6mWFRgydeVjcMdvvBJHmcrxNFHClZNVsRF
         CA1w==
X-Gm-Message-State: APjAAAWxQz9HAF9oriiPQFsTslzQuL/8VDl8BvoNlviatQxofabZ213d
        zibWEILihz89NTX9I0JBtlA=
X-Google-Smtp-Source: APXvYqwSSuVgJIZT8/5pgyV6OAY3GMrCrG35wtPM8ehlCIM2Ip48q9Hzz2y9QiClIjSJGm6t730S+A==
X-Received: by 2002:adf:ec06:: with SMTP id x6mr47349963wrn.159.1558427292361;
        Tue, 21 May 2019 01:28:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 6sm25116098wrd.51.2019.05.21.01.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 01:28:11 -0700 (PDT)
Date:   Tue, 21 May 2019 10:28:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH -tip v9 0/6] tracing/probes: uaccess: Add support
 user-space access
Message-ID: <20190521082809.GA112373@gmail.com>
References: <155789866428.26965.8344923934342528416.stgit@devnote2>
 <20190515055534.GA39270@gmail.com>
 <20190520112605.421bda88@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520112605.421bda88@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 15 May 2019 07:55:34 +0200
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Hi,
> > > 
> > > Here is the v9 series of probe-event to support user-space access.
> > > Previous version is here.
> > > 
> > > https://lkml.kernel.org/r/155741476971.28419.15837024173365724167.stgit@devnote2
> > > 
> > > In this version, I fixed more typos/style issues.
> > > 
> > > Changes in v9:
> > >  [3/6]
> > >       - Fix other style & coding issues (Thanks Ingo!)
> > >       - Update fetch_store_string() for style consistency.
> > >  [4/6]
> > >       - Remove an unneeded line break.
> > >       - Move || and && in if-condition at the end of line.  
> > 
> > LGTM:
> > 
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > 
> 
> Hi Ingo,
> 
> Do you want me to take this through my tree, or do you want to take it
> through yours?

Since these changes are more heavy on the kernel/tracing/ side I suspect 
your tree is the better match for this series?

Thanks,

	Ingo
