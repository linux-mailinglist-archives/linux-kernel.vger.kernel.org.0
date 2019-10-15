Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00005D6C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 02:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfJOAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 20:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfJOAAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:00:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0933521835;
        Tue, 15 Oct 2019 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571097622;
        bh=DqA41CguxbXMV9awK6tImOFQJT85+9r1Kb3WvHxqd84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clgcAkA/EKPtDiFNzhpAY5Dbm8alSy5d6K2Y1DMDdop6nHBSmaYYi0jta8bcPTRX+
         LPW5G0BI8/Fd8cqdKrzUEgsUqRap1GFEnMaPfENdulBDHyw44kClvDp7q7awGDjG26
         FtxVdRULIuYQAe17+8MUBed4VynI87EO3VkY1oJQ=
Date:   Tue, 15 Oct 2019 01:00:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arm64: fix alternatives with LLVM's integrated assembler
Message-ID: <20191015000017.66jkcya6zzbi7qqc@willie-the-truck>
References: <20191007211418.30321-1-samitolvanen@google.com>
 <CAKwvOdnX6O0Grth11R8JLoD9bp-BECheucZKHbiHt4=XpQferA@mail.gmail.com>
 <CABCJKudGtvVazLpZFdbhe9z-4mx_t16zxzkcwYbdAJriakrWqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudGtvVazLpZFdbhe9z-4mx_t16zxzkcwYbdAJriakrWqw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:47:20PM -0700, Sami Tolvanen wrote:
> On Mon, Oct 7, 2019 at 2:34 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > Should the definition of the ALTERNATIVE macro
> > (arch/arm64/include/asm/alternative.h#L295) also be updated in this
> > patch to not pass `1` as the final parameter?
> 
> No, that's the default value for cfg in case the caller omits the
> parameter, and it's still needed.
> 
> > I get one error on linux-next that looks related:
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang
> > -j71 arch/arm64/kvm/
> > ...
> 
> This patch only touches the inline assembly version (i.e. when
> compiling without -no-integrated-as), while with AS=clang you are
> using clang also for stand-alone assembly code. I believe some
> additional work is needed before we can do that.

Is there any benefit from supporting '-no-integrated-as' but not 'AS=clang'?
afaict, you have to hack the top-level Makefile for that.

Will
