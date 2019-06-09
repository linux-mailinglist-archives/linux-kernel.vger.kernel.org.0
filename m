Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4C3AAEB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfFIRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 13:42:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35119 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfFIRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:42:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1911A802A0; Sun,  9 Jun 2019 19:42:03 +0200 (CEST)
Date:   Sun, 9 Jun 2019 19:41:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>
Subject: Re: [PATCH 0/7] TTY Keyboard Status Request
Message-ID: <20190609174139.GA11944@xo-6d-61-c0.localdomain>
References: <20190605081906.28938-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605081906.28938-1-ar@cs.msu.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch series introduces TTY keyboard status request, a feature of
> the n_tty line discipline that reserves a character in struct termios
> (^T by default) and reacts to it by printing a short informational line
> to the terminal and sending a Unix signal to the tty's foreground
> process group. The processes may, in response to the signal, output a
> textual description of what they're doing.
> 
> The feature has been present in a similar form at least in
> Free/Open/NetBSD; it would be nice to have something like this in Linux
> as well. There is an LKML thread[1] where users have previously
> expressed the rationale for this.
> 
> The current implementation does not break existing kernel API in any
> way, since, fortunately, all the architectures supported by the kernel
> happen to have at least 1 free byte in the termios control character
> array.

I like the idea... I was often wondering "how long will this dd take". (And in
case of dd, SIGUSR1 does the job).

I assume this will off by default, so that applications using ^T today will not
get surprise signals?
									Pavel
