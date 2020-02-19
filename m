Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B87164097
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgBSJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 04:41:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:33408 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSJlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:41:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 30ECB4A8;
        Wed, 19 Feb 2020 09:41:39 +0000 (UTC)
Date:   Wed, 19 Feb 2020 02:41:22 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] documentation: vm: Advertise support for pte_special in
 riscv
Message-ID: <20200219024122.5fe552a5@lwn.net>
In-Reply-To: <20200219065953.27350-1-alex@ghiti.fr>
References: <20200219065953.27350-1-alex@ghiti.fr>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 01:59:53 -0500
Alexandre Ghiti <alex@ghiti.fr> wrote:

> Risc-V architecture has actually supported pte_special since its merge
> upstream, simply add this info to the documentation.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  Documentation/features/vm/pte_special/arch-support.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
> index 2dc5df6a1cf5..3d492a34c8ee 100644
> --- a/Documentation/features/vm/pte_special/arch-support.txt
> +++ b/Documentation/features/vm/pte_special/arch-support.txt
> @@ -23,7 +23,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |

Applied, thanks.

jon
