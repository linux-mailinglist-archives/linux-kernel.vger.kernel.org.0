Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43E14D827
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 10:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgA3JLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 04:11:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37608 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgA3JLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:11:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so1778886lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 01:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDEBs7tdapXBabQOiBoAGEGQx/1cLn7Wu5HMxzqN18I=;
        b=PPz/lOcITbWLP4VAUl1X+qy44oWLkoH+iT3aQU9HWuykv7DfJswAp/xQi6UttYQ56p
         osScvrmHY2bO4VANAtxlhlDLL9L/QcwlNJKQFAkvLJlCAfeZlg/MJeNX7TRcQs63WBn8
         ovia+RwozR9cAoPfVnxvk5KjcfHy5IG7ZHVhMuGnsGXbbl5KKnkEdVsoFH5r6Iy7Iifi
         iWU03GvgTl02k73q4muSnfhXMWE2jcag6g9BlHUYO0+aL1QONAKsMzjDTJiUyv8a8Ecn
         AAZzvdqXVwBlIHJYua165w0E1D3/odE+Zk0gcj6ocbNuXoShtKS4YsjU5ONv0Bvf8d8G
         2B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDEBs7tdapXBabQOiBoAGEGQx/1cLn7Wu5HMxzqN18I=;
        b=f/TUyowY/zJsfxY1L1lXEa4WDqUgHFj9Qj12lU82GvJYByg5MAh+9YFTAYmVAy+75G
         rzBntjm8TXUDd0I1waP3usvEwH8SmoUXumK7OtwMbw6QiJNg7t9dh+aj5e7VBNEqt2wI
         WJ7D2IRg0jCDo9O6CX1OtV+LGm8k7PnMRsNtD1Mx0IAI5299ZJaQptbCnd7nQE+O7v0V
         exZrVRAMYQzn2KCgplTxbc56cK3SyOpgoqbSFHL7g+/LhMMkjhCucW9EGASz5tn4364x
         zQigAUoXDvk4wc3LZh/uR3AGrrNaJxPIsrropReHOvxE/BkXUAx+Cex5/d9V5rjWButd
         521w==
X-Gm-Message-State: APjAAAW8h8OiYABoZXOU6BeMNJE34vCSTwbVSBQWovqTbov5w12LlPSd
        QnwJzWS87j+oDxmODDPUnovlSVdeGW4oVRmlRjMRlilUjmCodA==
X-Google-Smtp-Source: APXvYqxzAL4hnlQLfqSRiF1X6IPq+Ta1Ap+a2XzTGp/tudNRqclBv4V2SihWfr2E/GonWPLggP78FZusHp+16MbxKKQ=
X-Received: by 2002:a19:5f05:: with SMTP id t5mr2083586lfb.149.1580375499750;
 Thu, 30 Jan 2020 01:11:39 -0800 (PST)
MIME-Version: 1.0
References: <226388d32e69b8e366dc0b41f5296d9048d2c9d2.camel@nokia.com>
In-Reply-To: <226388d32e69b8e366dc0b41f5296d9048d2c9d2.camel@nokia.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Jan 2020 10:11:28 +0100
Message-ID: <CAKfTPtCKE4V+oA=HCcEkwur_1bG-BgF9S_xu-P1FQTsTT8bA1w@mail.gmail.com>
Subject: Re: BUG: Scheduler crashes with 4.19 kernels
To:     "Huttunen, Janne (Nokia - FI/Espoo)" <janne.huttunen@nokia.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janne,

On Thu, 30 Jan 2020 at 09:09, Huttunen, Janne (Nokia - FI/Espoo)
<janne.huttunen@nokia.com> wrote:
>
>
> We have experienced somewhat reproducible scheduler crashes
> and BUGs with a 4.19 kernel. The workload is some kind of
> container related stress-test i.e. it creates and destroys
> containers in a rapid rate. Currently I don't have any more
> details about the specifics of the test case.
>
> Within a few hours of testing, the scheduler code in the
> kernel either triggers an assertion or tries to dereference
> a completely invalid pointer and crashes there.
>

[snip]

>
> Based on the similarity of our crashes and the one reported
> in the commit log, I cherry picked f6783319737f to top of
> 4.19.97 (with 5d299eabea5a as a prerequisite to make the
> fix apply more cleanly). With the patched kernel the test
> ran for three days without a crash in any of the machines.
>
> So, do you think f6783319737f is the proper fix? Should it
> be backported to 4.19.y? Does it require (or benefit from)
> some additional patches that should be backported too?

Yes I think that' you're right and both patches below should be backported
f6783319737f ('sched/fair: Fix insertion in rq->leaf_cfs_rq_list')
5d299eabea5a ('sched/fair: Add tmp_alone_branch assertion')

The other related patch has already been backported to 4.19
c40f7d74c741 sched/fair: Fix infinite loop in
update_blocked_averages() by reverting a9e7f6544b9c

and there is no other patch related to this problem

>
