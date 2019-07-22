Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC770C31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfGVV5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:57:33 -0400
Received: from ms.lwn.net ([45.79.88.28]:43576 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfGVV5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:57:32 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D114E7DA;
        Mon, 22 Jul 2019 21:57:31 +0000 (UTC)
Date:   Mon, 22 Jul 2019 15:57:30 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Kitt <steve@sk2.org>, Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
Message-ID: <20190722155730.08dfd4e3@lwn.net>
In-Reply-To: <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
References: <1561722948-28289-1-git-send-email-nitin.r.gote@intel.com>
        <20190629181537.7d524f7d@sk2.org>
        <201907021024.D1C8E7B2D@keescook>
        <20190706144204.15652de7@heffalump.sk2.org>
        <201907221047.4895D35B30@keescook>
        <15f2be3cde69321f4f3a48d60645b303d66a600b.camel@perches.com>
        <20190722230102.442137dc@heffalump.sk2.org>
        <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 14:50:09 -0700
Joe Perches <joe@perches.com> wrote:

> On Mon, 2019-07-22 at 23:01 +0200, Stephen Kitt wrote:
> > How about you submit your current patch set, and I follow up with the above
> > adapted to stracpy?  
> 
> OK, I will shortly after I figure out how to add kernel-doc
> for stracpy/stracpy_pad to lib/string.c.
> 
> It doesn't seem appropriate to add the kernel-doc to string.h
> as it would be separated from the others in string.c
> 
> Anyone got a clue here?  Jonathan?

If the functions themselves are fully defined in the .h file, I'd just add
the kerneldoc there as well.  That's how it's usually done, and you want
to keep the documentation and the prototypes together.

jon
