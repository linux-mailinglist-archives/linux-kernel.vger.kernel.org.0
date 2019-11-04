Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3DEE129
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 14:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfKDNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 08:30:43 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:45383 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727236AbfKDNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:30:43 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iRcQv-0005Lj-UU; Mon, 04 Nov 2019 14:30:13 +0100
To:     Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v4 03/17] arm64: kvm: stop treating register x18 as  caller save
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 14:39:34 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <dave.martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <clang-built-linux@googlegroups.com>,
        <kernel-hardening@lists.openwall.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <79e8f958cbde52a3d90aec24dd4638d9@www.loen.fr>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com>
 <20191101221150.116536-4-samitolvanen@google.com>
 <79e8f958cbde52a3d90aec24dd4638d9@www.loen.fr>
Message-ID: <63921b46250e2eb8eb9fcf0f8ec93b0c@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: samitolvanen@google.com, will@kernel.org, catalin.marinas@arm.com, rostedt@goodmis.org, mhiramat@kernel.org, ard.biesheuvel@linaro.org, dave.martin@arm.com, keescook@chromium.org, labbott@redhat.com, mark.rutland@arm.com, ndesaulniers@google.com, jannh@google.com, miguel.ojeda.sandonis@gmail.com, yamada.masahiro@socionext.com, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-04 12:13, Marc Zyngier wrote:
> Hi Sami,
>
> On 2019-11-01 23:20, Sami Tolvanen wrote:
>> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> In preparation of reserving x18, stop treating it as caller save in
>> the KVM guest entry/exit code. Currently, the code assumes there is
>> no need to preserve it for the host, given that it would have been
>> assumed clobbered anyway by the function call to __guest_enter().
>> Instead, preserve its value and restore it upon return.
>>
>> Link: https://patchwork.kernel.org/patch/9836891/
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> [Sami: updated commit message, switched from x18 to x29 for the 
>> guest
>> context]
>> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> If you intend for this to be merged via the arm64 tree, please add my
>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Erm... Muscle memory strikes again. Please ignore the above and use the
following instead:

Reviewed-by: Marc Zyngier <maz@kernel.org>

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
