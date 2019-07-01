Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059D233692
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfFCR13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 13:27:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbfFCR12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:27:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 718D71682;
        Mon,  3 Jun 2019 10:27:28 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164EC3F5AF;
        Mon,  3 Jun 2019 10:27:25 -0700 (PDT)
Date:   Mon, 3 Jun 2019 18:27:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH REBASE v2 1/2] x86, arm64: Move ARCH_WANT_HUGE_PMD_SHARE
 config in arch/Kconfig
Message-ID: <20190603172723.GH63283@arrakis.emea.arm.com>
References: <20190526125038.8419-1-alex@ghiti.fr>
 <20190526125038.8419-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526125038.8419-2-alex@ghiti.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 08:50:37AM -0400, Alexandre Ghiti wrote:
> ARCH_WANT_HUGE_PMD_SHARE config was declared in both architectures:
> move this declaration in arch/Kconfig and make those architectures
> select it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/Kconfig       | 3 +++
>  arch/arm64/Kconfig | 2 +-
>  arch/x86/Kconfig   | 4 +---
>  3 files changed, 5 insertions(+), 4 deletions(-)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
