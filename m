Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA768162B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgBRQup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 11:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgBRQuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:50:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB58D24649;
        Tue, 18 Feb 2020 16:50:43 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:50:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
Message-ID: <20200218115041.20a204e1@gandalf.local.home>
In-Reply-To: <20200218103346.5hbe7d5aj2ma7trk@pathway.suse.cz>
References: <20200217222803.6723-1-idryomov@gmail.com>
        <202002171546.A291F23F12@keescook>
        <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
        <20200218103346.5hbe7d5aj2ma7trk@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 11:33:46 +0100
Petr Mladek <pmladek@suse.com> wrote:

> Reviewed-by: Petr Mladek <pmladek@suse.com>

For what it's worth, I like the patch as well.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
