Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB64143B05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 11:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgAUKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 05:30:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUKab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:30:31 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4292420678;
        Tue, 21 Jan 2020 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579602630;
        bh=8MDhT70qIH9QnWSCOyu+SP78oh5aOhTOcOpaFXWOWG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/9fVY5xN684neRDQ7FZ+p4tH0kThqrEj/PaWTjbZG4GmC3o1pGs4xAcogJVdomaD
         YU5DimpEWF9jRbLaj2PixmgGLJG++r3b9XTd4cAKz61LMsC9xAgOE2+jPkI5/Fkfco
         Vq8PMwBUlyfsEuwhXzccq3+FhQ9zHJ9Q5r1mlKyU=
Date:   Tue, 21 Jan 2020 10:30:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
Message-ID: <20200121103025.GC11154@willie-the-truck>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:03PM +0000, Julien Thierry wrote:
> This patch series is the continuation of Raphael's work [1]. All the
> patches can be retrieved from:
> git clone -b arm64-objtool-v5 https://github.com/julien-thierry/linux.git

[...]

>   objtool: arm64: Decode unknown instructions
>   objtool: arm64: Decode simple data processing instructions
>   objtool: arm64: Decode add/sub immediate instructions
>   objtool: arm64: Decode logical data processing instructions
>   objtool: arm64: Decode system instructions not affecting the flow
>   objtool: arm64: Decode calls to higher EL
>   objtool: arm64: Decode brk instruction
>   objtool: arm64: Decode instruction triggering context switch
>   objtool: arm64: Decode branch instructions with PC relative immediates
>   objtool: arm64: Decode branch to register instruction
>   objtool: arm64: Decode basic load/stores
>   objtool: arm64: Decode load/store with register offset
>   objtool: arm64: Decode load/store register pair instructions
>   objtool: arm64: Decode FP/SIMD load/store instructions
>   objtool: arm64: Decode load/store exclusive
>   objtool: arm64: Decode atomic load/store
>   objtool: arm64: Decode pointer auth load instructions
>   objtool: arm64: Decode load acquire/store release
>   objtool: arm64: Decode load/store with memory tag
>   objtool: arm64: Decode load literal
>   objtool: arm64: Decode register data processing instructions
>   objtool: arm64: Decode FP/SIMD data processing instructions
>   objtool: arm64: Decode SVE instructions

That's a lot of decoding logic which we already have in
arch/arm64/{kernel/insn.c,include/asm/insn.h}. I'd prefer to see this stuff
reused or generated from a single source, since it's really easy to get it
wrong, has a tendency to bitrot and is nasty to debug.

Will
