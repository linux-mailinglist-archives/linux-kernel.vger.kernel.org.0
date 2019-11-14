Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB4DFCB29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 17:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKNQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 11:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNQzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:55:51 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E967206EF;
        Thu, 14 Nov 2019 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573750551;
        bh=dmIjxufMZwDwYVYvIb2nm0yNxgfVrXjNxzLP6Pgh94o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzGGwjyciTKlzmrZBe3z2LhKo3H5tzqUde6OJUAVSTyiyLtYTbl+vuvWjzRN8HKDn
         NoTlA/uKqpf+EvzwPxFDRG6ohm9a5lc/gONOg5EEdHX0cmbDE8Ki6Ysl4re3bvZnAT
         URRngKjUj0+p6Lluc4uYu8/7XQHtgwXIMSmSE13w=
Date:   Thu, 14 Nov 2019 16:55:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RESEND PATCH] arm64: fix alternatives with LLVM's integrated
 assembler
Message-ID: <20191114165544.GB5158@willie-the-truck>
References: <20191031194652.118427-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031194652.118427-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

Sorry -- I thought I'd already replied to this, but it had actually
slipped through the cracks.

On Thu, Oct 31, 2019 at 12:46:52PM -0700, Sami Tolvanen wrote:
> LLVM's integrated assembler fails with the following error when
> building KVM:
> 
>   <inline asm>:12:6: error: expected absolute expression
>    .if kvm_update_va_mask == 0
>        ^
>   <inline asm>:21:6: error: expected absolute expression
>    .if kvm_update_va_mask == 0
>        ^
>   <inline asm>:24:2: error: unrecognized instruction mnemonic
>           NOT_AN_INSTRUCTION
>           ^
>   LLVM ERROR: Error parsing inline asm
> 
> These errors come from ALTERNATIVE_CB and __ALTERNATIVE_CFG,
> which test for the existence of the callback parameter in inline
> assembly using the following expression:
> 
>   " .if " __stringify(cb) " == 0\n"
> 
> This works with GNU as, but isn't supported by LLVM. This change
> splits __ALTERNATIVE_CFG and ALTINSTR_ENTRY into separate macros
> to fix the LLVM build.

Please could you explain a bit more about the failure and why LLVM's
integrated assembler rejects this? Could we use something like .ifb or
.ifeqs instead?

Thanks,

Will
