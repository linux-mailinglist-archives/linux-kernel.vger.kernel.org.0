Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7410838A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2019 14:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKXNss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Nov 2019 08:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfKXNsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 08:48:47 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604D32071A;
        Sun, 24 Nov 2019 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574603327;
        bh=vRGUVLAcUuZh1Fo6Olic1qmPe1jv7ZKjYbAXpyNgem8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrvL4psCN4R9RDCHRFLm32wo1sCgKWgKtJqROmDCvSwCnRLmzxOoLZrusXivJspLp
         4oigQaEgXZExFs2mQPqDO6Xa7pTJLgzYNCTgREPzCxEbA6XndjhlMrzRYxA/WP4LOV
         04ti3HnKeJnp7KLzcU4WXpMjqK98scYnJpbFOusc=
Date:   Sun, 24 Nov 2019 15:48:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] sparc64: add support for folded p4d page tables
Message-ID: <20191124134840.GA6630@rapoport-lnx>
References: <20191124085720.6201-1-rppt@kernel.org>
 <e91984fa-3544-8b7e-d577-54125b075fbe@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91984fa-3544-8b7e-d577-54125b075fbe@physik.fu-berlin.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 10:44:36AM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 11/24/19 9:57 AM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Implement primitives necessary for the 4th level folding, add walks of p4d
> > level where appropriate and replace 5leve-fixup.h with pgtable-nop4d.h.                                      
>                                       ^^^^^ typo?

Oops, indeed :)

David, if everything else is ok, could you please fix this when applying?

> 
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- 
Sincerely yours,
Mike.
