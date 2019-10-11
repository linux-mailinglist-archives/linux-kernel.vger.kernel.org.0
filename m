Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88E7D44B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfJKPri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 11:47:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34991 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJKPrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:47:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so4657773plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L8nfwXCisRm1qePDK4SMx1pjknBpWa94Qxj1sS8u5kA=;
        b=DSwaEoz+bD4qFKZIKz/Konam440PIDOX1fNFO3xJHi77xdNlftLPxyfvp0UwWKgZ+4
         HI+lCnFhy2XKfM4ammZOptEEr8v11ae+4A9A04ZH8cEH5w9V2o08IDcb5lTnT0n7li0f
         KJJwrWCiiZDuDfS9eMbKCAn2qytH5+UyHaXoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8nfwXCisRm1qePDK4SMx1pjknBpWa94Qxj1sS8u5kA=;
        b=NOXNhlTSd7SzalNi2Y+O4/RgRzvOLG8+NRcg/okYmhCbfm4IoL3uq9tKl/aFtYmLiq
         Puyh0ZMQkmxepQeIq0J0YH9SXzVwQx75S8wpkf/V89F/LAQ5tGuc6qP3nnwh+UQ8J4y8
         D9qN8T9vguxv8O0Yem4G4AE5/NaujZVwDsn2fI6gkl/opVAdzf17eVbZFPxUXp7yJ2Ly
         /gJc32MxFzLG5ks4+oU2LsoEZRPzcK8QPqqf+mHvZ7yUrnP+vnhUTeclMw+BIRiostDp
         ZkHHkSsgFXvGS2JoXtsOV2tWG/uhQ8rbsdUm4oUiR6K3Pt4gMxK4JnSMt6uni6fthBhI
         TO+g==
X-Gm-Message-State: APjAAAURrCU73T5lRKVLpVVjTKd28TSTDveBZMCDVfVjfxKrGBT/BjIT
        YNb7AVbFSoiz3WGrY+ujCDlDQg==
X-Google-Smtp-Source: APXvYqyZB1iwpECmMrQ/nKWm2V0v/043bP3KVsuGonJdp/o/3FFZ2TVnzLm6gdCdqIIWB8mQFahKJw==
X-Received: by 2002:a17:902:a985:: with SMTP id bh5mr15414239plb.184.1570808856657;
        Fri, 11 Oct 2019 08:47:36 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u65sm3019972pgb.36.2019.10.11.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:47:35 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:47:34 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191011154734.GA105106@google.com>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <20191010081251.GP2311@hirez.programming.kicks-ass.net>
 <20191010151333.GE96813@google.com>
 <20191010170949.GR2328@hirez.programming.kicks-ass.net>
 <20191010183114.GF96813@google.com>
 <20191011070543.GV2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011070543.GV2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:05:43AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2019 at 02:31:14PM -0400, Joel Fernandes wrote:
> > On Thu, Oct 10, 2019 at 07:09:49PM +0200, Peter Zijlstra wrote:
> 
> > > Yes, I did notice, I found it weird.
> > > 
> > > If you have CAP_IPC_LIMIT you should be able to bust mlock memory
> > > limits, so I don't see why we should further relate that to paranoid.
> > > 
> > > The way I wrote it, we also allow to bust the limit if we have disabled
> > > all paranoid checks. Which makes some sense I suppose.
> > > 
> > > The original commit is this:
> > > 
> > >   459ec28ab404 ("perf_counter: Allow mmap if paranoid checks are turned off")
> > 
> > I am thinking we can just a new function perf_is_paranoid() that has nothing
> > to do with the CAP_SYS_ADMIN check and doesn't have tracepoint wording:
> > 
> > static inline int perf_is_paranoid(void)
> > {
> > 	return sysctl_perf_event_paranoid > -1;
> > }
> > 
> > And then call that from the mmap() code:
> > if (locked > lock_limit && perf_is_paranoid() && !capable(CAP_IPC_LOCK)) {
> > 	return -EPERM;
> > }
> > 
> > I don't think we need to add selinux security checks here since we are
> > already adding security checks earlier in mmap(). This will make the code and
> > its intention more clear and in line with the commit 459ec28ab404 you
> > mentioned. Thoughts?
> 
> Mostly that I'm confused by the current code ;-)
> 
> Like I said, CAP_IPC_LIMIT on its own should already allow busting the
> limit, I don't really see why we should make it conditional on paranoid.
> 
> But if you want to preserve behaviour (arguably a sane thing for your
> patch) then yes, feel free to do as you propose.

Ok, I will do it as I proposed above and resend patch today. Thanks!

 - Joel

