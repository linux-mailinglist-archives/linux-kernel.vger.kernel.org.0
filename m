Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D966D46547
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfFNRCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 13:02:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:53200 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfFNRCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:02:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 38613128A;
        Fri, 14 Jun 2019 17:02:41 +0000 (UTC)
Date:   Fri, 14 Jun 2019 11:02:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Documentation: Remove duplicate x86 index entry
Message-ID: <20190614110240.4a69fd6e@lwn.net>
In-Reply-To: <alpine.DEB.2.21.1906140902050.1791@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906140902050.1791@nanos.tec.linutronix.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 09:02:49 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> x86 got added twice to the index via the RST conversion and the MDS
> documentation changes. Remove one instance.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/index.rst |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -112,7 +112,6 @@ implementation.
>  .. toctree::
>     :maxdepth: 2
>  
> -   x86/index
>     sh/index
>     x86/index

If one is good, two must be better, right? :)

Applied, thanks.

jon
