Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45D111635E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 19:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLHSLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 13:11:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44914 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLHSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:11:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so8892912lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bP+MLqv2/4jxjq5G8WI3V8blQrwy5vvH8NjA0Oq9xU=;
        b=H0B9voLfv9AYLRDixmAeg/5DRF8QLotazZN/4owvkzDMXfPsktWaen4Q3k9MedABQL
         0pB2E+DsxZ88pf8Iftm8Zpi/eUzhjTeP2HrbKUH1z9La6YaZoUY5Mc7J6SV7VX3rGun9
         NOn+0S2wMJe3ABAu0HEETzU4Av3UFzbmNvuFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bP+MLqv2/4jxjq5G8WI3V8blQrwy5vvH8NjA0Oq9xU=;
        b=ZdehyLhcT65+BRwI628RRdLhjDtlNSsit8maM+49mUWqVn+gJDjwWYkgxeN405+8Ma
         +Inz7DKXLfRftIkj/vATARIjeMA6Kj2lpZhWC91ViHly1RiEq8etLnw0wopPiTFFemrP
         GbF3/LlaANZ+DIhQv8NZUGb4E4BQ1QMwlMFxvOEAL/wGEs7wN3rwFVq5VCfjrUHQ43qq
         tDVZ3YoXhdsm0BjwDPqoXWPV0KHJDceyTU1tYexP9bjFBqY1SEqUXoz+GGVqdUywh4W3
         J40icMpuzjulRg2jU5mRPjkbSjEDYxf3MeUItbV4iHQKBAmXkOEFiTtKD8ejwvjdtENb
         qhKg==
X-Gm-Message-State: APjAAAV9NLKR17SoMXQbX3fsRR36gH0UOd7BHvfkPmkaEmBRMay1+gfY
        cSgs4i6vnAO5g9ak1ZPTP8dVQjR5FDY=
X-Google-Smtp-Source: APXvYqypd/cd3H513YQtuoFqmxsBlp1mhOJ8PHcCeZQi0ns+0l7DThz1IFT8gEXyIdnOYHiqzaVnow==
X-Received: by 2002:a19:5212:: with SMTP id m18mr13150437lfb.7.1575828669500;
        Sun, 08 Dec 2019 10:11:09 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id w2sm9764155ljo.61.2019.12.08.10.11.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 10:11:08 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 15so8951269lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:11:07 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr10244080lfo.134.1575828667708;
 Sun, 08 Dec 2019 10:11:07 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude> <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude> <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
 <20191208175602.GA1844@latitude>
In-Reply-To: <20191208175602.GA1844@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 10:10:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgh9zUy9nbiCgGjtrgw1V9Vk=01Ncju-0iib5Jn-V1arw@mail.gmail.com>
Message-ID: <CAHk-=wgh9zUy9nbiCgGjtrgw1V9Vk=01Ncju-0iib5Jn-V1arw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 8, 2019 at 9:56 AM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> whereas with a fresh cloned repo I get:
>
> v5.4-13331-g9455d25f4e3b
>
> I assume the later is right. With this version the bug seems to be
> fixed, regardless of the commit count. Tested with different websites
> and firefox works as expected again.

Ok, good. It was almost certainly the select/poll race fix - Mariusz
Ceier reported a problem with youtube hanging, and confirmed that the
poll/select fix seems to have cleared that one up. I suspect that your
hang on fb and spiegel.de were the same thing.

So I think the pipe code is stable again with current -git. Thanks for
reporting and testing,

             Linus
