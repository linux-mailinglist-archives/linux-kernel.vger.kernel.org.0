Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0DF073C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 21:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfKEUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 15:49:58 -0500
Received: from foss.arm.com ([217.140.110.172]:32788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfKEUt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:49:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEAD111B3;
        Tue,  5 Nov 2019 12:49:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AD203FB7F;
        Tue,  5 Nov 2019 01:04:38 -0800 (PST)
Date:   Tue, 5 Nov 2019 09:04:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/17] arm64: disable kretprobes with SCS
Message-ID: <20191105090426.GA4743@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com>
 <20191101221150.116536-11-samitolvanen@google.com>
 <20191104170454.GA2024@lakrids.cambridge.arm.com>
 <CABCJKue=yZqe23DYg3_WyiSKhxXS+GXe+3skhvYon4ytkfH+XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKue=yZqe23DYg3_WyiSKhxXS+GXe+3skhvYon4ytkfH+XA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:42:09PM -0800, Sami Tolvanen wrote:
> On Mon, Nov 4, 2019 at 9:05 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > I'm a bit confused as to why that's the case -- could you please
> > elaborate on how this is incompatible?
> >
> > IIUC kretrobes works by patching the function entry point with a BRK, so
> > that it can modify the LR _before_ it is saved to the stack. I don't see
> > how SCS affects that.
> 
> You're correct. While this may not be optimal for reducing attack
> surface, I just tested this to confirm that there's no functional
> conflict. I'll drop this and related patches from v5.

Great; thanks for confirming!

Mark.
