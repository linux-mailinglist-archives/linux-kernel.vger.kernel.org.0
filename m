Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE3B1567EF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 23:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgBHWEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 17:04:31 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41335 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgBHWEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:04:30 -0500
X-Originating-IP: 66.190.246.67
Received: from localhost (66-190-246-67.dhcp.astr.or.charter.com [66.190.246.67])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id AF0A9E0005;
        Sat,  8 Feb 2020 22:04:27 +0000 (UTC)
Date:   Sat, 8 Feb 2020 14:04:25 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Applying pipe fix this merge window?
Message-ID: <20200208220425.GA92770@localhost>
References: <20200208083604.GA86051@localhost>
 <CAHk-=whWe0tY3aDraTk_Wesj8PMH+=U=W3VTE2aJCHNE+u+WTw@mail.gmail.com>
 <CAHk-=wjk4Mm-s0zG4CMmudjGU-fytmrhS=VCGx+RBr_rJ0ORbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjk4Mm-s0zG4CMmudjGU-fytmrhS=VCGx+RBr_rJ0ORbQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 01:53:54PM -0800, Linus Torvalds wrote:
> On Sat, Feb 8, 2020 at 10:45 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Sure, I'll apply it and see if anybody hollers.
> 
> Btw, can you verify that commit 0ddad21d3e99 ("pipe: use exclusive
> waits when reading or writing") matches what you've been testing.

Byte-for-byte identical.

> I did put a "tested-by" for you in it, but I had a few different
> versions of that patch because of other changes in fs/pipe.c and
> because I did it while doing the other changes, so maybe I should have
> double-checked with you first.

The commit message for 0ddad21d3e99 looks completely reasonable to me.

Thank you!

- Josh Triplett
