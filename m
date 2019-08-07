Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1384285468
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbfHGURA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 16:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387969AbfHGURA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:17:00 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAC82199C;
        Wed,  7 Aug 2019 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565209019;
        bh=9jrCLwX3LNqceRPrIp1jyjebmoHx3o9gZO1ZatQ4skM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sEN1paERUMluEqczWXfNlPMKbSdmYQaq4T7rTni0CxSxEnrjjHKQ765sgQWu8A8s0
         QKx24YVdqUtvGPcVbdAJxRFJMxYJyV6Ah+0UPLJtP5uaP8snDxXhkkuBKnRyRw75Aq
         iNGGe6IBLOd1dbfd+9eQdQKz0RAljH5GsNO+CLMo=
Date:   Wed, 7 Aug 2019 13:16:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v10 20/22] x86: mm: Convert dump_pagetables to use
 walk_page_range
Message-Id: <20190807131658.08793793a97fa4310af4f495@linux-foundation.org>
In-Reply-To: <066fa4ca-5a46-ba86-607f-9c3e16f79cde@arm.com>
References: <20190731154603.41797-1-steven.price@arm.com>
        <20190731154603.41797-21-steven.price@arm.com>
        <20190806165823.3f735b45a7c4163aca20a767@linux-foundation.org>
        <066fa4ca-5a46-ba86-607f-9c3e16f79cde@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019 13:58:21 +0100 Steven Price <steven.price@arm.com> wrote:

> > ./arch/x86/include/asm/pgtable_64_types.h:56:22: error: initializer element is not constant
> >  #define PTRS_PER_PGD 512
> >                       ^
> 
> This is very unhelpful of GCC - it's actually PTRS_PER_P4D which isn't
> constant!

Well.  You had every right to assume that an all-caps macro is a
compile-time constant.

We are innocent victims of Kirill's c65e774fb3f6af2 ("x86/mm: Make
PGDIR_SHIFT and PTRS_PER_P4D variable") which lazily converted these
macros into runtime-only, under some Kconfig settings.  It should have
changed those macros into static inlined lower-case functions.
