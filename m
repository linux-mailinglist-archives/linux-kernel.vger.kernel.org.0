Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7584F18364
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 03:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEIBxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 21:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfEIBxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:53:45 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C407214AF;
        Thu,  9 May 2019 01:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557366823;
        bh=Ia5NTdPNksMbvfErcxsP1sUxTwe35xIeWtyPqzIqz/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGQsl6WOS9zKSdKOLgLLcDqyYwZhRuEFW2zMQxCSTK/EJG4ZLf4AviWPfjPBTZztL
         CaoXbEb95DXvsQ/Wr3reS/ASsIqHRtCYXKWBFrm3+my0SOUEQSWsAFTmuAvqg+K2uT
         GzOwVgDN0getI4EZsHxkviFr576fPZQnmvj5WzEc=
Date:   Wed, 8 May 2019 18:53:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Joao Moreira <jmoreira@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3 0/7] crypto: x86: Fix indirect function call casts
Message-ID: <20190509015340.GA693@sol.localdomain>
References: <20190507161321.34611-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507161321.34611-1-keescook@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 09:13:14AM -0700, Kees Cook wrote:
> It is possible to indirectly invoke functions with prototypes that do
> not match those of the respectively used function pointers by using void
> types or casts. This feature is frequently used as a way of relaxing
> function invocation, making it possible that different data structures
> are passed to different functions through the same pointer.
> 
> Despite the benefits, this can lead to a situation where functions with a
> given prototype are invoked by pointers with a different prototype. This
> is undesirable as it may prevent the use of heuristics such as prototype
> matching-based Control-Flow Integrity, which can be used to prevent
> ROP-based attacks.
> 
> One way of fixing this situation is through the use of inline helper
> functions with prototypes that match the one in the respective invoking
> pointer.
> 
> Given the above, the current efforts to improve the Linux security,
> and the upcoming kernel support to compilers with CFI features, this
> creates macros to be used to build the needed function definitions,
> to be used in camellia, cast6, serpent, twofish, and aesni.
> 
> -Kees (and Joao)

Did you try enabling -Wcast-function-type?  It seems you missed some cases:

arch/x86/crypto/sha256_ssse3_glue.c: In function ‘sha256_update’:
arch/x86/crypto/sha256_ssse3_glue.c:62:10: warning: cast between incompatible function types from ‘void (*)(u32 *, const char *, u64)’ {aka ‘void (*)(unsigned int *, const char *, long long unsigned int)’} to ‘void (*)(struct sha256_state *, const u8 *, int)’ {aka ‘void (*)(struct sha256_state *, const unsigned char *, int)’} [-Wcast-function-type]
          (sha256_block_fn *)sha256_xform);
          ^
arch/x86/crypto/sha256_ssse3_glue.c: In function ‘sha256_finup’:
arch/x86/crypto/sha256_ssse3_glue.c:77:11: warning: cast between incompatible function types from ‘void (*)(u32 *, const char *, u64)’ {aka ‘void (*)(unsigned int *, const char *, long long unsigned int)’} to ‘void (*)(struct sha256_state *, const u8 *, int)’ {aka ‘void (*)(struct sha256_state *, const unsigned char *, int)’} [-Wcast-function-type]
           (sha256_block_fn *)sha256_xform);
           ^
arch/x86/crypto/sha256_ssse3_glue.c:78:32: warning: cast between incompatible function types from ‘void (*)(u32 *, const char *, u64)’ {aka ‘void (*)(unsigned int *, const char *, long long unsigned int)’} to ‘void (*)(struct sha256_state *, const u8 *, int)’ {aka ‘void (*)(struct sha256_state *, const unsigned char *, int)’} [-Wcast-function-type]
  sha256_base_do_finalize(desc, (sha256_block_fn *)sha256_xform);
                                ^
  CC      arch/x86/crypto/sha512_ssse3_glue.o
arch/x86/crypto/sha512_ssse3_glue.c: In function ‘sha512_update’:
arch/x86/crypto/sha512_ssse3_glue.c:61:10: warning: cast between incompatible function types from ‘void (*)(u64 *, const char *, u64)’ {aka ‘void (*)(long long unsigned int *, const char *, long long unsigned int)’} to ‘void (*)(struct sha512_state *, const u8 *, int)’ {aka ‘void (*)(struct sha512_state *, const unsigned char *, int)’} [-Wcast-function-type]
          (sha512_block_fn *)sha512_xform);
          ^
arch/x86/crypto/sha512_ssse3_glue.c: In function ‘sha512_finup’:
arch/x86/crypto/sha512_ssse3_glue.c:76:11: warning: cast between incompatible function types from ‘void (*)(u64 *, const char *, u64)’ {aka ‘void (*)(long long unsigned int *, const char *, long long unsigned int)’} to ‘void (*)(struct sha512_state *, const u8 *, int)’ {aka ‘void (*)(struct sha512_state *, const unsigned char *, int)’} [-Wcast-function-type]
           (sha512_block_fn *)sha512_xform);
           ^
arch/x86/crypto/sha512_ssse3_glue.c:77:32: warning: cast between incompatible function types from ‘void (*)(u64 *, const char *, u64)’ {aka ‘void (*)(long long unsigned int *, const char *, long long unsigned int)’} to ‘void (*)(struct sha512_state *, const u8 *, int)’ {aka ‘void (*)(struct sha512_state *, const unsigned char *, int)’} [-Wcast-function-type]
  sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_xform);
                                ^
