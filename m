Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D91DB28E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 18:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440495AbfJQQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 12:39:19 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41468 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfJQQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:39:19 -0400
Received: by mail-yb1-f195.google.com with SMTP id 206so897112ybc.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYJvPdDl3T7Fx646ASlNZBmczwkC7H3BSoulK6E2T3I=;
        b=L5dLzOreODZtz1fC6R658TQwqBXto0USF2KYsRzaAvcvOCiUwEbkp6P5PvMEs44M0I
         JCSKtrJl55eSbC8ndDhVh1NmUSrMQcOPQC543hljZtgROp448B88vZ2/yI0ib41HDDoK
         tPRnGmmoUIDibih651Fnt9rTGmwhv0x04fS6a5ZbMMukW+VYWAupBqC6dOPguuX0K0CD
         SA44uo2bDMlXVm1hKuv7Lp1uvGn9L0pQ2IHRPUzTR834W1SQBDSAy4N+e2/Xt51BDfuT
         HYShlFdUAiLrpHDbm8LESk4Xx2PIcuL5hLAXPkErrcCvAqxO5ArsXdEbfOiDehwjcJvC
         6KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYJvPdDl3T7Fx646ASlNZBmczwkC7H3BSoulK6E2T3I=;
        b=kREyQAMrB+rOASW80+vDA+CIaB5GQlUhhj7j3PSRup49aSfppJ4fIhaAHhkKlZSTcF
         z0BSYPAvRKU1hUjzfglqfXdG6bP0th2vPmtgKUfRiU7RmWKQbJUawr0/URynIfjJruTm
         hjkBBvWiDsLTDSvkAqR3haWcMY2WeTweyqRupKF7k95iTN9xMIPS8YjA1Ya3H3FY0dIs
         ZatrTcz7trIsuZDK1eSIqsP7y/ZH3nKVuGTTWVOxVZlt/Gr3Z+U8xsgny0JoiNYo/sv1
         5acdX5EVI2FXyeguoeagHQMk/whp1jziiE8biBsqN3p4qUldcQR2krcSc5Z2GRTVJ2ij
         RNQA==
X-Gm-Message-State: APjAAAUi92I1I/9HNr+LzDOP39jNnrS9lxdnVfxM2eMLS6RwuKG/AjrI
        yNgkca8FTndeasjC5NZwqc3kX3YeHMZk41aAzQKgmA==
X-Google-Smtp-Source: APXvYqxdYvRwKra9r9/E+OOqWK7PsmcGav4kYCUYznmop5C9tp4Z3WcERTqCA2rhAHcIwWJPWLpbrclmbwc5zuy3oDY=
X-Received: by 2002:a25:4292:: with SMTP id p140mr2700421yba.147.1571330356542;
 Thu, 17 Oct 2019 09:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <CABCjUKDWRJO9s68qhKQGXzrW39KqfZzZhoOX0HgDcnv-RxJZPw@mail.gmail.com>
 <85512332-d9d4-6a72-0b42-a8523abc1b5f@intel.com>
In-Reply-To: <85512332-d9d4-6a72-0b42-a8523abc1b5f@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 17 Oct 2019 09:39:04 -0700
Message-ID: <CALvZod7S4jeXqLvu7fTbeGTZy8czfTdsd+v45dGsi70zEt39yg@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 9:32 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/17/19 9:01 AM, Suleiman Souhlal wrote:
> > One problem that came up is that if you get into direct reclaim,
> > because persistent memory can have pretty low write throughput, you
> > can end up stalling users for a pretty long time while migrating
> > pages.
>
> Basically, you're saying that memory load spikes turn into latency spikes?
>
> FWIW, we have been benchmarking this sucker with benchmarks that claim
> to care about latency.  In general, compared to DRAM, we do see worse
> latency, but nothing catastrophic yet.  I'd be interested if you have
> any workloads that act as reasonable proxies for your latency requirements.
>
> > Because of that, we moved to a solution based on the proactive reclaim
> > of idle pages, that was presented at LSFMM earlier this year:
> > https://lwn.net/Articles/787611/ .
>
> I saw the presentation.  The feedback in the room as I remember it was
> that proactive reclaim essentially replaced the existing reclaim
> mechanism, to which the audience was not receptive.  Have folks opinions
> changed on that, or are you looking for other solutions?
>

I am currently working on a solution which shares the mechanisms
between regular and proactive reclaim. The interested users/admins can
setup proactive reclaim otherwise the regular reclaim will work on low
memory. I will have something in one/two months and will post the
patches.

Shakeel
