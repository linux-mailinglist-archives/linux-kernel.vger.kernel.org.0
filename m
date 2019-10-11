Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F044FD457F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfJKQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 12:36:27 -0400
Received: from namei.org ([65.99.196.166]:53642 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKQg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:36:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x9BGZPR8008627;
        Fri, 11 Oct 2019 16:35:25 GMT
Date:   Sat, 12 Oct 2019 03:35:25 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH] perf_event: Add support for LSM and SELinux checks
In-Reply-To: <20191011160330.199604-1-joel@joelfernandes.org>
Message-ID: <alpine.LRH.2.21.1910120334280.6863@namei.org>
References: <20191011160330.199604-1-joel@joelfernandes.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019, Joel Fernandes (Google) wrote:

> This patch adds LSM and SELinux access checking which will be used in
> Android to access perf_event_open(2) for the purposes of attaching BPF
> programs to tracepoints, perf profiling and other operations from
> userspace. These operations are intended for production systems.


Acked-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

