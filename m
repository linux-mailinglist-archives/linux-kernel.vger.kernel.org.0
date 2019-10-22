Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7032DFC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 05:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfJVDKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 23:10:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34647 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfJVDKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:10:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id f5so4052763lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 20:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8PSb99Ge+xEM0Y69nCMYhCdyrZD0MqeaLJcNORWi1c=;
        b=nZtH6Ev4ZSEcjk7KCd9ScQaym8kTbtTUpijNuhaUibPYq+J6jgLamwLNoNn8OPEQnq
         k8os5lZinQGDgDjCSJIkuD+hob+VbkVOdH9YchedA3PHxJdh5k9KkBgPjFPlmerXH7l7
         XyrXMqlqBFV7/iRqdVwwLaOgpQxNrGwmJL3dg1/oN7vtBVNh0eWS981ZZMr/qnu7/DLW
         FIjMKldUCiYRJwS18v3jP/0sxsaCzDWQRGwmbbIgsuQulkfXl0H0zlpsYETRyPiIe0ss
         4V9Ekne5cl8u/oN2BhEpaQNDYkFZktdPOyJTfZEka8OzlmRt2G+dUJf0v4hoZlEeN3ZO
         Y3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8PSb99Ge+xEM0Y69nCMYhCdyrZD0MqeaLJcNORWi1c=;
        b=CeRq5DRTj9tci/R5qiVXDnVm9e9taeBY3qKEZMRbma1hM7/gG9iY3NddN4E7oGJ94h
         xg6u5UyjnP5To9klzbyctHf+AwqWIvylLfBCmfHlR5OIYr9YtQMn7X3WCKW3yTfG3NIJ
         mLgGbccpm6+g8w8SyAsbjRVMbEkSQFI2725qjIkHX+7pgHUUjbSC+UF+b6fX0TcGsftD
         ncR2BNvKb0tFlTbbxvrI94LcNTItGDZuSo3ua8wKLEllS0navbvEeuuf6OaFlQkmQJgy
         +k80Y8D3exYDhYeD03/4SUQZYoFCJzIOgc38yGIU04KHi2Xa2kQDq1HsHL/mDekyf+Lq
         3SeA==
X-Gm-Message-State: APjAAAUKbqo11xQ9aS8vDQTHX2GBMdID3oRm/YV6RzFnAEg6CANQaKyd
        M3kc+vUoRaUbs8mWQ/IUpFHBzC8XU4mF2Mc2sg0=
X-Google-Smtp-Source: APXvYqwWjJE1Pssba3kXlqn6u3PHxWMs80aUfkYoBURshvQe+M2QsWAbva6vBPgIpwVQYIXBwmUDhoWoBxI0QMpB17Q=
X-Received: by 2002:a19:fc1e:: with SMTP id a30mr4057378lfi.167.1571713822001;
 Mon, 21 Oct 2019 20:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190827180622.159326993@infradead.org> <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com> <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home> <20191004112237.GA19463@hirez.programming.kicks-ass.net>
 <20191004094228.5a5774fe@gandalf.local.home> <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
 <20191021204310.3c26f730@oasis.local.home>
In-Reply-To: <20191021204310.3c26f730@oasis.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Oct 2019 20:10:09 -0700
Message-ID: <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 5:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 21 Oct 2019 17:36:54 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
>
> > What is the status of this set ?
> > Steven, did you apply it ?
>
> There's still bugs to figure out.

what bugs you're seeing?
The IPI frequency that was mentioned in this thread or something else?
I'm hacking ftrace+bpf stuff in the same spot and would like to
base my work on the latest and greatest.
