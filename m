Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324D1C3E43
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfJARMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 13:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfJARML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:12:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4012086A;
        Tue,  1 Oct 2019 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569949931;
        bh=Imi9bY+6yhPMuvw82i8Qa+vwv8Dk8KW1mW9nmAIXFe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geALupBIgcBFHuj6zyoTCk/oBT+tBiwsHhHaHJWQ2b9e0SpvWFWc82N+LbVshFRBk
         f31tCJaL93eMsMWSstr3k34HhEAYiJFv7EzuXHlcMCF0LgTYCY46s2/gg7BGB5JFIK
         wBvuAFqqJR5B96/Qe+bX+8NlnyE3RlebOE0pzIIo=
Date:   Tue, 1 Oct 2019 18:12:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, nsaenzjulienne@suse.de,
        torvalds@linux-foundation.org, yamada.masahiro@socionext.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Partially revert "compiler: enable
 CONFIG_OPTIMIZE_INLINING forcibly"
Message-ID: <20191001171205.dubfntdlwifxik6z@willie-the-truck>
References: <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
 <20191001162121.67109-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001162121.67109-1-ndesaulniers@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:21:21AM -0700, Nick Desaulniers wrote:
> > So you'd prefer I do something like the diff below?
> 
> Yes, I find that diff preferable.  Use __always_inline only when absolutely
> necessary.  Even then, it sounds like this is a workaround for one compiler,
> so it should probably also have a comment. (I don't mind changing this for
> all compilers).

I wondered about a comment, but I couldn't find a good place to put it.
We basically need to say "If you're using explicit register variables in
your function, then you should use __always_inline", but there are other
functions too (such as arch/arm64/include/asm/vdso/gettimeofday.h) so
a random comment buried in the atomic code doesn't feel very helpful to
me.

Will
