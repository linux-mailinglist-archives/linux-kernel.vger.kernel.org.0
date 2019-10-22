Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E683FE0DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfJVV17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 17:27:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37297 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733101AbfJVV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:27:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id g21so13173521lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sC7HSfb2VOkcipSqiZUGFtYaUxnR7Wt7cAUpMLN2oNc=;
        b=d/RTOx8b3U9xLKMNU8hgAwzgUFgP0wI0I78MgFGo5S9RxNwmUYga4vLUgMB+jV4e90
         JD0z80pZFg5atR7ZfnvDKTGRRXWKxvFCLzkjU4VpwJ0cVyHC7IJE/jenH9piaQ29f9y1
         6O7bbq+Py3xOllvFcTxsY48y8xWuHcYGlQJtgxFzWc3qms3t4t+4x285MPbC9an3ZcvK
         6KUKqwVQEX9c/uJ8QuiXxpKwfIImpNCTTWtFhvagyjvMyGJAbHnmXoNgx2ZIcUrz1Rl2
         1sADZVEtgWJI78llDswMxd+0BfIrHiRkqzBuXv+WBJ3teUdRsXb+THuZqZao+YTKtX9P
         1TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sC7HSfb2VOkcipSqiZUGFtYaUxnR7Wt7cAUpMLN2oNc=;
        b=to4Mgr6NZZtxw88YCgDAodhRfeQ0mhq9Hb5ZUZjiU47PxRelnOCZ/mXKaBjY9HYdqo
         rck5d2qBnB7zCcx9Bl24Us1axg3o07J7IuzNYNviGjCsnEhE9C1ATli93J2vuJEElbNc
         qNHdKaZmVUWKbyY6MGT0dFT0dc5Lbut1A2B880+C/J4MBHbQnPRrRSsF9Bbp50zEYxZx
         2Y8gY60urW1f26GXGTH1nsFHe9GIIll6Pwc2YzsNqIFi4kCsktvW9lIZ2wX/SX3lmh86
         m4t6oS9HwLYWCBrGI7Y5G5wGSofaYdL9g3M96LH1s+CSzcZCvieT85yVk5+EROpKiA9O
         WbtQ==
X-Gm-Message-State: APjAAAUsdreReT2wr8DNF1x0S/KzdbHIDzl9Fhh1snelMzMW3mzxr02y
        IRsv01XFxmKK0CxKdvveVurZePlVFCo4+USxgK1KGg==
X-Google-Smtp-Source: APXvYqwFV8qXwJtM7cnjAnOyJyVn3NlRuVspzSfQ76qX4vGPHP7ckHVTpW+7szVpGRXWavpHfb0/Lto0ZQ2teHSplF8=
X-Received: by 2002:a19:ac48:: with SMTP id r8mr4712555lfc.181.1571779677332;
 Tue, 22 Oct 2019 14:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com> <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
In-Reply-To: <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 22 Oct 2019 14:27:20 -0700
Message-ID: <CAKOZueuhU05wXWcoAnfRM4rShuvQ8BteV32WTiWDmAA3-LBJfg@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 6:14 PM Andy Lutomirski <luto@kernel.org> wrote:
> [adding more people because this is going to be an ABI break, sigh]

Just pinging this thread. I'd like to rev my patch and I'm not sure
what we want to do about problem Andy identified. Are we removing
UFFD_EVENT_FORK?
