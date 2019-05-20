Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D5724337
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfETVyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 17:54:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:36360 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfETVyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:54:24 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 23E726A2;
        Mon, 20 May 2019 21:54:24 +0000 (UTC)
Date:   Mon, 20 May 2019 15:54:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Eckelmann <sven@narfation.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Message-ID: <20190520155423.2ad5d16a@lwn.net>
In-Reply-To: <20190521074435.7a277fd6@canb.auug.org.au>
References: <20190521074435.7a277fd6@canb.auug.org.au>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 07:44:35 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> In commit
> 
>   9eaa65e8aad5 ("scripts/spdxcheck.py: Add dual license subdirectory")
> 
> Fixes tag
> 
>   Fixes: 99871f2f9a4d ("scripts/spdxcheck.py: Fix path to deprecated licenses")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean
> 
> Fixes: e6d319f68d4d ("scripts/spdxcheck.py: Fix path to deprecated licenses")

Argh, sorry, I should have caught that.  Fixed, thanks.

jon
