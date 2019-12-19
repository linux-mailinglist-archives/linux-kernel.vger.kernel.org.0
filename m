Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD67126759
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 17:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLSQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 11:43:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41995 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:43:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so5519106edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6MJKY5kaJhdcPD2Yij+K4j3QBznO/FzqxPRwZHg2tA=;
        b=XYNY/1juioQpuXWDwItjvluLKzqTb1s+LUDJh70eT+FynV6pmhNjrfR8rKpTN0Y4Vq
         95LNMIm35iIung4zroafpJpZMFHIQW6gyl0nMe0sXzlo0Usj/osB8dJgXFazZDihbiKk
         TXHN/eqPdNOFXyC7+ATLgVoMdiY/9k9+NozPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6MJKY5kaJhdcPD2Yij+K4j3QBznO/FzqxPRwZHg2tA=;
        b=RFac+VBdIxQ77VWJL+zqZNERIv4Q4sHGYaq1coQuPEU9NqDbx/jJIIS2v4LInmGvgZ
         b6W8BvZCJLFngG10ZLBcYpE66TPKSKS90sDpQyMUAruE8kNS8Bg+jh2SuGY7nHo+5HbW
         plXaLWtqNaA2T9eyESkJgzwU7ZHYj8SK2MD+c25mf8wYpYBgYDbtist0aAsvLqVJXHV7
         KTNUPnxP5V6RRYZOJLRsSVumbQcHZ3GnYyfqguFvMu5ED3zpdn/0FGxazG1q2ADVBUgs
         LaXj9U3H1wj2vqgrXvsKCwxhO1WrJdOZRBEtlGJypHDamudBX9Jjftd2tFo6nE2xzqEd
         zIBA==
X-Gm-Message-State: APjAAAXKojZS9zjYtJpFesqokHWn4bvZHr+WUvAPLMtdBZYf7QEcLW9i
        RUS1yMMo2zXSzr6XX/XRnWQFrtwziwI=
X-Google-Smtp-Source: APXvYqzJrnDhyqXry2Juez68Ic0FZffsvBz9pdNakQx5OknlAgsdfpA3d5HGd3d/OE3zijzIjYZueg==
X-Received: by 2002:a05:6402:2042:: with SMTP id bc2mr10139724edb.300.1576773834324;
        Thu, 19 Dec 2019 08:43:54 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id by2sm597353ejb.45.2019.12.19.08.43.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 08:43:54 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id b6so6704466wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:43:53 -0800 (PST)
X-Received: by 2002:adf:ee92:: with SMTP id b18mr10865736wro.281.1576773336863;
 Thu, 19 Dec 2019 08:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20191205000957.112719-1-thgarnie@chromium.org> <20191219133452.GM2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191219133452.GM2827@hirez.programming.kicks-ass.net>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Thu, 19 Dec 2019 08:35:25 -0800
X-Gmail-Original-Message-ID: <CAJcbSZEubkFN0BLugoBm8fsPrNWxfFCDytC3nYUepr74dQFS=w@mail.gmail.com>
Message-ID: <CAJcbSZEubkFN0BLugoBm8fsPrNWxfFCDytC3nYUepr74dQFS=w@mail.gmail.com>
Subject: Re: [PATCH v10 00/11] x86: PIE support to extend KASLR randomization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 5:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 04, 2019 at 04:09:37PM -0800, Thomas Garnier wrote:
> > Minor changes based on feedback and rebase from v9.
> >
> > Splitting the previous serie in two. This part contains assembly code
> > changes required for PIE but without any direct dependencies with the
> > rest of the patchset.
>
> ISTR suggestion you add an objtool pass that verifies there are no
> absolute text references left. Otherwise we'll forever be chasing that
> last one..

Correct, I have a reference in the changelog saying I will tackle in
the next patchset because we still have non-pie references in other
places but the fix is a bit more complex (for exemple per-cpu) and not
included in this phase. I will add a better explanation in the next
message for patch v11.
