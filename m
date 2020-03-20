Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AED18DBE1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 00:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCTX03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 19:26:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:44152 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTX03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:26:29 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6C8252D6;
        Fri, 20 Mar 2020 23:26:28 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:26:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Add BUG()-family
Message-ID: <20200320172627.6532fda9@lwn.net>
In-Reply-To: <202003141524.59C619B51A@keescook>
References: <202003141524.59C619B51A@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Mar 2020 15:29:50 -0700
Kees Cook <keescook@chromium.org> wrote:

> Linus continues to remind[1] people to stop using the BUG()-family of
> functions. We should have this better documented (even if checkpatch.pl
> has been warning[2] since 2015), so add more details to deprecated.rst,
> as a distinct place to point people to for guidance.
> 
> [1] https://lore.kernel.org/lkml/CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com/
> [2] https://git.kernel.org/linus/9d3e3c705eb395528fd8f17208c87581b134da48
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/process/deprecated.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Applied, thanks.

jon
