Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F794B7762
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbfISK0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 06:26:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389338AbfISK0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:26:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46YtKk2RyPz9sPf; Thu, 19 Sep 2019 20:26:02 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1fdfa4c6af0cc1854b017f308af6bece94568bb6
In-Reply-To: <20190912074037.13813-1-yamada.masahiro@socionext.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: improve prom_init_check rule
Message-Id: <46YtKk2RyPz9sPf@ozlabs.org>
Date:   Thu, 19 Sep 2019 20:26:02 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 07:40:37 UTC, Masahiro Yamada wrote:
> This slightly improves the prom_init_check rule.
> 
> [1] Avoid needless check
> 
> Currently, prom_init_check.sh is invoked every time you run 'make'
> even if you have changed nothing in prom_init.c. With this commit,
> the script is re-run only when prom_init.o is recompiled.
> 
> [2] Beautify the build log
> 
> Currently, the O= build shows the absolute path to the script:
> 
>   CALL    /abs/path/to/source/of/linux/arch/powerpc/kernel/prom_init_check.sh
> 
> With this commit, it is always a relative path to the timestamp file:
> 
>   PROMCHK arch/powerpc/kernel/prom_init_check
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1fdfa4c6af0cc1854b017f308af6bece94568bb6

cheers
