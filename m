Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB11657D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 07:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgBTGhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 01:37:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:47100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgBTGhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:37:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB201AD33;
        Thu, 20 Feb 2020 06:37:22 +0000 (UTC)
Subject: Re: [PATCH] x86/xen: Distribute switch variables for initialization
To:     Kees Cook <keescook@chromium.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200220062318.69299-1-keescook@chromium.org>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <16a166da-c6e7-aa36-53a0-1b56197c8fc0@suse.com>
Date:   Thu, 20 Feb 2020 07:37:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220062318.69299-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.20 07:23, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> arch/x86/xen/enlighten_pv.c: In function ‘xen_write_msr_safe’:
> arch/x86/xen/enlighten_pv.c:904:12: warning: statement will never be executed [-Wswitch-unreachable]
>    904 |   unsigned which;
>        |            ^~~~~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
