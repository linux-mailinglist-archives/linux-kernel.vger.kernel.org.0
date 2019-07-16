Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4DB6AF64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbfGPS5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 14:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPS5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:57:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B19C20665;
        Tue, 16 Jul 2019 18:57:18 +0000 (UTC)
Date:   Tue, 16 Jul 2019 14:57:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: BUG: KASAN: global-out-of-bounds in
 ata_exec_internal_sg+0x50f/0xc70
Message-ID: <20190716145716.6b081bdc@gandalf.local.home>
In-Reply-To: <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
References: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
        <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 11:28:29 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> The cited code looks like a check comparing that the pointer distance
> is greater than the size of bytes being passed in.  I'd wager
> someone's calling memmove with overlapping memory regions when they
> really wanted memcpy.  Maybe a better question, is why was memmove
> ever used; if there was some invariant that the memory regions
> overlapped, why is that invariant no longer holding.

I'm confused by the above statement as memmove() allows overlapping of
src and dest, where as memcpy() does not.

-- Steve
