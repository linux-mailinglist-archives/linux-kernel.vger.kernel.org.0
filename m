Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDBFAE8E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 11:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKMKbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 05:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKMKbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:31:01 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D5B222C6;
        Wed, 13 Nov 2019 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573641060;
        bh=S89ucV6O9uSjWXXnTQZbFJ7GpLXkEqqeu/ktwkynl0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLHOnpyoX0FUQ5F0X6AhgOQTaJO/s2dg0gzlmfKxh3mABw8CMcwxtHSwlh/pJnmJ/
         GJyDzTpw1jpygiQ9hQm9xfABVskaAdIZR09L1FAbjGgaW5oAAdCMTeZftFiiH22Kn4
         UwjWD5FmfnxMbASfgjk5b227k3eU1cUgimBAQDTU=
Date:   Wed, 13 Nov 2019 10:30:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Collingbourne <pcc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] scripts/tools-support-relr.sh: un-quote variables
Message-ID: <20191113103055.GA25900@willie-the-truck>
References: <20191112134522.12177-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112134522.12177-1-ilie.halip@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:45:20PM +0200, Ilie Halip wrote:
> When the CC variable contains quotes, e.g. when using
> ccache (make CC="ccache <compiler>"), this script always
> fails, so CONFIG_RELR is never enabled, even when the
> toolchain supports this feature. Removing the /dev/null
> redirect and invoking the script manually shows the issue:
> 
>     $ CC='/usr/bin/ccache clang' ./scripts/tools-support-relr.sh
>     ./scripts/tools-support-relr.sh: 7: ./scripts/tools-support-relr.sh: /usr/bin/ccache clang: not found
> 
> Fix this by un-quoting the variables.
> 
> Before:
>     $ make ARCH=arm64 CC='/usr/bin/ccache clang' LD=ld.lld \
>         NM=llvm-nm OBJCOPY=llvm-objcopy defconfig
>     $ grep RELR .config
>     CONFIG_ARCH_HAS_RELR=y
> 
> With this change:
>     $ make ARCH=arm64 CC='/usr/bin/ccache clang' LD=ld.lld \
>         NM=llvm-nm OBJCOPY=llvm-objcopy defconfig
>     $ grep RELR .config
>     CONFIG_TOOLS_SUPPORT_RELR=y
>     CONFIG_ARCH_HAS_RELR=y
>     CONFIG_RELR=y
> 
> Fixes: 5cf896fb6be3 ("arm64: Add support for relocating the kernel with RELR relocations")
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Link: https://github.com/ClangBuiltLinux/linux/issues/769
> Cc: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> ---
>  scripts/tools-support-relr.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, I'll queue this as a fix.

Will
