Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4D57AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 06:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfF0Eip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 00:38:45 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:40788 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0Eio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:38:44 -0400
Received: by mail-lj1-f173.google.com with SMTP id a21so848332ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 21:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI/CurwELFO5rqxaUjVeh3NIzHPBCNbNCcw11h4RDrs=;
        b=QBzs0jVpaRngXNkhNeYrZEmCadowG8F0BLG3INhcQjU//0JIw8D17sJdGuWI101Lj1
         t0LTaW+ZgMvQclbuoUIB9zYPu2sjdqOz53LMamHA/Ng2wTqv47tWJiC2rgHhsJIs2vpz
         NaItkCQ7+KGft20AJ83enZqkL8aQuu2Nf6wAkMPIO/IuOqSuiAvNGclDbFrmhmxWa3lC
         v/paqOtK5udz/IhmtIqsxpNHnqdG+VQr5RkeM5u/VP8WZ0ya5klOLpSeieyNHVmQ/kA5
         ezEw5LmCEf1+wUKuMQmByTE3rkNTefx6Awc1csHytP86zf+zcxapzIYG7ZnAcOhYuqXA
         sgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI/CurwELFO5rqxaUjVeh3NIzHPBCNbNCcw11h4RDrs=;
        b=G0Dz4tRFm6OqbkeQw8vV5RY9vzF0Zh6myKoSIRWDKMM/IWcDp7URK7uIcNjgP5G017
         qexr5mBTwuYX8HJ4Xeir6FgkPqT+nea4Wm1TjO0Y0o78UFvR1O0f2zyNIxV3xrm/RULI
         /HxTsopjP9RjKKWbJa7GFZl3SQw4roCOq9Hld9gp+RaUn+vUFRJOegTzRskNrIfpn5JZ
         FyEKZBWEj59XJje249A457o2BXJjVi6mGfXzm4XxVpE+cvoxToef903t/XKi+hA158iH
         u0jCo9W3OaozkPD7GaJBmSk0YeOC+l1MlWJGlohmnllXazfJkdZJvf+41gCf4b+etlXn
         2EPA==
X-Gm-Message-State: APjAAAWWTemUte0hl0Dbja3+wS9dVZrbS3w7ld863QZx60Au1RJB0HuY
        BEPAo+wXqY+0dBOySVe/W4k379Y3IWxcdi543nc=
X-Google-Smtp-Source: APXvYqzF8qbK/dtxeTCqVNS//O58i3UG2hqgWw8oKeKraVLEq9rfu4ZFLAvE+OfexOuE6W+AbdKy1I7YHpBUdAeKvvk=
X-Received: by 2002:a2e:968e:: with SMTP id q14mr1077059lji.195.1561610322670;
 Wed, 26 Jun 2019 21:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561595111.git.jpoimboe@redhat.com> <426541f62dad525078ee732c09bc206289e994aa.1561595111.git.jpoimboe@redhat.com>
 <CAADnVQ+veayfD70Xsu8UnNrLdRW6rh9jxPb=OGoiYT-O=_zW=A@mail.gmail.com>
 <20190627024700.q4rkcbhmrna6ev4y@treble> <CAADnVQJRs9NdHgGiAZfzCLb=eWAPD03-+uf3fisLZrKZUSSoyg@mail.gmail.com>
 <20190627034447.gl5tusbhkbr6dadc@treble> <20190627035623.owkbrxa7dx7suv4a@treble>
In-Reply-To: <20190627035623.owkbrxa7dx7suv4a@treble>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Jun 2019 21:38:31 -0700
Message-ID: <CAADnVQK4B6oaaYnVsUsZ7coL0yw1fJtapazcf=_hDKyzkrmGZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] objtool: Add support for C jump tables
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 8:56 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> The last patch was based weird, this one's based on upstream.  Will test
> tomorrow.

Great. Once it passes your tests I'll be happy to test it on my side.
