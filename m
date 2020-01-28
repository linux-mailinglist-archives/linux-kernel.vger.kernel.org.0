Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE89114C1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 21:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgA1UtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 15:49:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33958 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1UtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:49:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so10203831lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmZOcC2KHTnaCYf4oE5bxsybrzf0YfINSmM6yhty+i8=;
        b=Nx9uBzj6UigY8Oe7sJxYo1AbWDA51aAdcDv9umnB3fAS4k9I3ANt3MB9GiNm4Rtogo
         2hqWXBEPAieaM/lI1/S72lnzj6P9nDPvv9UfXEiBEW4oMm85CmcYVuFMH3EiJIlyd2K0
         U0AHK/BCEByiV7eahMTogwVDbexpknpBtEe3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmZOcC2KHTnaCYf4oE5bxsybrzf0YfINSmM6yhty+i8=;
        b=Z9NAjXGhFANOpgnp/fdJvDXoYuBCMd6DauXyiWpgidwjQayHavbQtP9sCF1JtsC8E+
         8+AC9mHR7POWdRfGWtQw9Gqce2nDr3MpVbfrQ4nkeMEDlGqIuk9E/WwjXIgqf2Qj8FNb
         4e40gqz0bLsS8oBIxZs16v0GLaDxi8GY62wrW56Wn+QAlckfb1bGhVfG4sMRCUMNZTee
         nBZzpncQJR5dmVSrnJW6k/hIU2Aac5j7YIcGMY1mhpK51+KQARD4Ly5Cf2B3WnYggyhX
         69EwdKyJpjCbBr4ij2Tz8j2mm8g2lkq9NIssx/1h/0aFWJJKJn64OKgc9cgJ2GuGjCKh
         rKog==
X-Gm-Message-State: APjAAAVofepPFKCHkny7EmgnI0A5IqmcMk0zngHZZxmGG8vQefpV7eVE
        Wt3BPUyvpMN1lUsQ6GsUUuJxZClvE64=
X-Google-Smtp-Source: APXvYqwbWYf73sqOW4baemUeWYewyRR+JdZq964hCBQm0PmRhxINWwGhyxvAa8XU9z5vKlAcXIVqGw==
X-Received: by 2002:a19:a416:: with SMTP id q22mr3466897lfc.60.1580244539315;
        Tue, 28 Jan 2020 12:48:59 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id x29sm12741876lfg.45.2020.01.28.12.48.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 12:48:58 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id f24so10191443lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:48:58 -0800 (PST)
X-Received: by 2002:a05:6512:78:: with SMTP id i24mr3553036lfo.10.1580244538010;
 Tue, 28 Jan 2020 12:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20200128175751.GA35649@gmail.com>
In-Reply-To: <20200128175751.GA35649@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jan 2020 12:48:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjoZfKFHL0wSsfnm32zv=zWNxtJcPob+1z2+P-tMcdoCg@mail.gmail.com>
Message-ID: <CAHk-=wjoZfKFHL0wSsfnm32zv=zWNxtJcPob+1z2+P-tMcdoCg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cpu changes for v5.6
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 9:57 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

No diffstat in the pull request?

The shortlog does match, and the diffstat I get looks sane, so I'm
pulling it, but please fix whatever thing that caused the diffstat to
not show in the email..

                 Linus
