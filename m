Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2668315
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 06:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfGOE6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 00:58:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:43710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfGOE6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 00:58:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBFA3AD12;
        Mon, 15 Jul 2019 04:58:37 +0000 (UTC)
Subject: Re: [PATCH 01/22] x86/paravirt: Fix callee-saved function ELF sizes
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Alok Kataria <akataria@vmware.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <b116e8bf2d3a4f703020e7911b6226ecc3ea34c5.1563150885.git.jpoimboe@redhat.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <445aa72f-c5ba-635d-122b-6d082e9c115e@suse.com>
Date:   Mon, 15 Jul 2019 06:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b116e8bf2d3a4f703020e7911b6226ecc3ea34c5.1563150885.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 02:36, Josh Poimboeuf wrote:
> The __raw_callee_save_*() functions have an ELF symbol size of zero,
> which confuses objtool and other tools.
> 
> Fixes a bunch of warnings like the following:
> 
>    arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_pte_val() is missing an ELF size annotation
>    arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_pgd_val() is missing an ELF size annotation
>    arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_make_pte() is missing an ELF size annotation
>    arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_make_pgd() is missing an ELF size annotation
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
