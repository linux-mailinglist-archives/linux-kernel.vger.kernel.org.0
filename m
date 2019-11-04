Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D5EE560
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 18:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfKDRAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 12:00:09 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:49465 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbfKDRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:00:08 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iRfhR-0008Lz-89; Mon, 04 Nov 2019 17:59:29 +0100
To:     Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v4 06/17] scs: add accounting
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 18:08:50 +0109
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
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CABCJKuegREpQiJCY01B_=nsNJFFCkyxxp63tQOPT=h+yAPifyA@mail.gmail.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com>
 <20191101221150.116536-7-samitolvanen@google.com>
 <791fc70f7bcaf13a89abaee9aae52dfe@www.loen.fr>
 <CABCJKuegREpQiJCY01B_=nsNJFFCkyxxp63tQOPT=h+yAPifyA@mail.gmail.com>
Message-ID: <5aaee4e0339daef7deadf29db9ea1747@www.loen.fr>
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

On 2019-11-04 17:52, Sami Tolvanen wrote:
> On Mon, Nov 4, 2019 at 5:13 AM Marc Zyngier <maz@kernel.org> wrote:
>> Is there any reason why you're not consistently using only one of
>> "#if IS_ENABLED(...)" or "#ifdef ...", but instead a mix of both?
>
> This is to match the style already used in each file. For example,
> fs/proc/meminfo.c uses #ifdef for other configs in the same function,
> and include/linux/mmzone.h uses #if IS_ENABLED(...).

Ah, fair enough.

         M.
-- 
Jazz is not dead. It just smells funny...
