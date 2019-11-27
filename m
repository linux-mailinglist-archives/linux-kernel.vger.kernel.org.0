Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5779910B501
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 19:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfK0SB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 13:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfK0SB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:01:28 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463D520871;
        Wed, 27 Nov 2019 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574877687;
        bh=DqpIVPpSNRYaQEY8qH901L06azIBYeg8eGVRD3v38ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPN7uf5PWAbcDCgYiwF4fFKQrfACX9EBB8jN7v59ShMpiCDzuvyga3x4d/5ms0cFP
         cvl8GIhLVQbEbnOlAoFDQZXuyPKOKoi7hI2Gd2IFXpvIRK9plXluFd5jLNelQp5PUr
         rDpAsmZRnaRsh+DdSezcD+mg44xMbQYDDQ/5fk5w=
Date:   Wed, 27 Nov 2019 10:01:25 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?iso-8859-1?Q?Jo=E3o?= Moreira <joao.moreira@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v7] crypto: x86: Regularize glue function prototypes
Message-ID: <20191127180125.GA49214@sol.localdomain>
References: <201911262205.FD985935F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201911262205.FD985935F@keescook>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:08:02PM -0800, Kees Cook wrote:
> The crypto glue performed function prototype casting via macros to make
> indirect calls to assembly routines. Instead of performing casts at the
> call sites (which trips Control Flow Integrity prototype checking), switch
> each prototype to a common standard set of arguments which allows the
> removal of the existing macros. In order to keep pointer math unchanged,
> internal casting between u128 pointers and u8 pointers is added.
> 
> Co-developed-by: Jo�o Moreira <joao.moreira@intel.com>
> Signed-off-by: Jo�o Moreira <joao.moreira@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
