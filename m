Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5F214D0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 20:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgA2TE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 14:04:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34359 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgA2TEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:04:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so579736ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTxpg9MeHuZ64pDGRpya4uIsSc8RC7lqfQ9WDK+ACzQ=;
        b=VVTccVFGNgPYvbLsRcfqqcYoip4MnvcsfWIQA8NIIdUxdwmCyGqn9XF7AM07xfOwgX
         MEUycooZvIV4Xac5E0h6vWMYSJPOC88DqLgsjrdJtzuTHGkmnC7QVZWFJRsMgU7VDSLw
         3I/DU2yFwe0eOkvmXUkCykx98ogMkjIB1Wi4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTxpg9MeHuZ64pDGRpya4uIsSc8RC7lqfQ9WDK+ACzQ=;
        b=halm2uXCIpBWH+uYzjHtHzMlRfAW9UWX8+HSc3aOAp8HjQUzF0PEEzTSoGvXPA7G9d
         zObzUY+Lzp0RMlg20MGy+XomjLtLoD80ssABjjKfT5eVPBR2rqqxkRU8KZv+noM2CJBM
         dWlhKxKqC0mWu8ptp1WZhzBQYugXl5wVL7ByKPLCiV85gC7wXoCVzqLwNZtYlzE1gGCB
         J/a9FSY+CPfi/dmM8m611LtM4NPgD5LBJZEEoYSujI2dfUe5Ff5TZKiBlLfmj3IrZcuW
         iAOZobHJq+GxZCPKneTxES4kSHwYT7Z3emzz81mHkbbxgTtJswf1DsjV1PiMCz4eSqL/
         3Asw==
X-Gm-Message-State: APjAAAWvDidxE2U76ozMFhh47h2gcNhXw0V9qA6UteLEk6kHYsRu5R4A
        L09AP4tL7lUfPIwWDssSDiOgtOB5mio=
X-Google-Smtp-Source: APXvYqxDa3NcgQ7/6DU3imfw38qym6cLLn/bpNRaVyVhQ2bEjCRJdXPRdgKk7wkEUKBiXEfqiTvQag==
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr371168ljc.39.1580324692632;
        Wed, 29 Jan 2020 11:04:52 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id j19sm1770292lfb.90.2020.01.29.11.04.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 11:04:51 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id v201so421922lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 11:04:51 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr402695lfm.152.1580324690992;
 Wed, 29 Jan 2020 11:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20200129120206.GA15554@paulmck-ThinkPad-P72>
In-Reply-To: <20200129120206.GA15554@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jan 2020 11:04:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whK-nw7PizDEzMgKwQQ6H5NXg0=NTwb6ECDb5PfchFQjQ@mail.gmail.com>
Message-ID: <CAHk-=whK-nw7PizDEzMgKwQQ6H5NXg0=NTwb6ECDb5PfchFQjQ@mail.gmail.com>
Subject: Re: [GIT PULL tip/core/rcu urgent] RCU fix for boot-time splat
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 4:02 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello, Ingo,
>
> This pull request contains a single commit that fixes an embarrassing
> bug discussed here:

Ingo, just FYI: I'll just take this pull directly, just to avoid
having the warning in my current tree.

               Linus
