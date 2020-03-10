Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0CB1804DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgCJRcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:32:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:44198 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJRcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:32:24 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E690C537;
        Tue, 10 Mar 2020 17:32:23 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:32:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dev-tools: kmemleak: Update list of architectures
Message-ID: <20200310113222.2baa64ef@lwn.net>
In-Reply-To: <20200303194215.23756-1-j.neuschaefer@gmx.net>
References: <20200303194215.23756-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 20:42:15 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> * Don't list powerpc twice (once as ppc)
> * Drop tile, which has been removed from the source tree
> * Mention arm64, nds32, arc, and xtensa
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/dev-tools/kmemleak.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
> index 3a289e8a1d12..fce262883984 100644
> --- a/Documentation/dev-tools/kmemleak.rst
> +++ b/Documentation/dev-tools/kmemleak.rst
> @@ -8,7 +8,8 @@ with the difference that the orphan objects are not freed but only
>  reported via /sys/kernel/debug/kmemleak. A similar method is used by the
>  Valgrind tool (``memcheck --leak-check``) to detect the memory leaks in
>  user-space applications.
> -Kmemleak is supported on x86, arm, powerpc, sparc, sh, microblaze, ppc, mips, s390 and tile.
> +Kmemleak is supported on x86, arm, arm64, powerpc, sparc, sh, microblaze, mips,
> +s390, nds32, arc and xtensa.
> 
>  Usage
>  -----
> --
> 2.20.1
> 
Applied, thanks.

jon
