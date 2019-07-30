Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0885E7B45E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 22:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfG3UiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 16:38:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:50696 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfG3UiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:38:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6UKbpqf027328;
        Tue, 30 Jul 2019 15:37:51 -0500
Message-ID: <ea83e4d6227b70ae4731c2bfcd727e3afeac3bf8.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch
 fall-through
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Jul 2019 13:37:50 -0700
In-Reply-To: <201907301005.0661E63CF@keescook>
References: <20190730143704.060a2606@canb.auug.org.au>
         <878ssfzjdk.fsf@concordia.ellerman.id.au> <201907301005.0661E63CF@keescook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 10:07 -0700, Kees Cook wrote:
> 
> > Why do we think it's an expected fall through? I can't really
> > convince
> > myself from the surrounding code that it's definitely intentional.
> 
> Yeah, good question. Just now when I went looking for who
> used SMU_I2C_TRANSFER_COMBINED, I found the only caller in
> arch/powerpc/platforms/powermac/low_i2c.c and it is clearly using a
> fall-through for building the command for "stdsub" and "combined",
> so I think that's justification enough:

Yes, sorry for the delay, the fall through is intentional.

Cheers,
Ben.


