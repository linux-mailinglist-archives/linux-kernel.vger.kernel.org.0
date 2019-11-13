Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58357FB025
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 13:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfKMMDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 07:03:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfKMMDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:03:45 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A0A22459;
        Wed, 13 Nov 2019 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573646624;
        bh=BRAnggnfsbJTgIQ5lZaz2HxeSPSfVSTjxwdPk8Pofm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xzp4NRxMOJpx/y4unzpizB452z625+l9fYQ4y2pPh8Jr8JH8Gbg4TYdE+wmmx2FDj
         q3HJwGgk5l8lI5cyRdIz4/d5ajRorVMfbEoF2VB1/4r3LUK9DrdvCEkMlReB1zlG71
         zSTA8aSv2TN/opgU3z5GAvp5x6uy6tCRImCbEgvY=
Date:   Wed, 13 Nov 2019 12:03:38 +0000
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] add support for Clang's Shadow Call Stack
Message-ID: <20191113120337.GA26599@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191105235608.107702-1-samitolvanen@google.com>
 <201911121530.FA3D7321F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911121530.FA3D7321F@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:44:42PM -0800, Kees Cook wrote:
> On Tue, Nov 05, 2019 at 03:55:54PM -0800, Sami Tolvanen wrote:
> > This patch series adds support for Clang's Shadow Call Stack
> > (SCS) mitigation, which uses a separately allocated shadow stack
> > to protect against return address overwrites. More information
> 
> Will, Catalin, Mark,
> 
> What's the next step here? I *think* all the comments have been
> addressed. Is it possible to land this via the arm tree for v5.5?

I was planning to queue this for 5.6, given that I'd really like it to
spend some quality time in linux-next.

Will
