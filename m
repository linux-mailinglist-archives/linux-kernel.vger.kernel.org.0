Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C08104C54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 08:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKUHWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 02:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfKUHWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:22:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F02FC20855;
        Thu, 21 Nov 2019 07:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574320918;
        bh=QZ5Gwedli1zb2+/D+s0LFaq6A2iC1RTvq3qvbeUR4nU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhCRMFKX9tIYyfm97YaXM39BKJwZWePeRoM0ikWGeb1SeSIkHNbTrdOKLRXHLStbC
         0ExWWHLrbZDVg49Srpx+btB4kVtedTBoeThVPAEioOKxcx6u8FcR/+23QKWj4CZ0+E
         wtYWwZbB5WKtlJElLzmFpgT08foiXbr/+8GHtU/o=
Date:   Thu, 21 Nov 2019 08:21:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Corey Minyard <minyard@acm.org>, linux-crypto@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] char: Fix Kconfig indentation
Message-ID: <20191121072156.GA356931@kroah.com>
References: <1574306340-29108-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574306340-29108-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 04:19:00AM +0100, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Fix also 7-space and tab+1 space indentation issues.

And the same here, I've already applied v1 so this does not apply to my
tree.

thanks,

greg k-h
