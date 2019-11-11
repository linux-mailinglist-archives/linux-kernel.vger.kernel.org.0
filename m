Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45AF826D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 22:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKKVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 16:46:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45672 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfKKVqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:46:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id w11so10276120pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUMuZzY6/DzLWZ+BSW2AElhZ5+FoZVNKeE67ie5COFQ=;
        b=cAwz2Wg4t2omEbJEW7GtEAKA/8RyJ50Tgzqm1Lq0FCWYdB//cN84CDXywg5Le20Bpr
         g6Mq3YVWppyYxH4ZUewoT/NPNKADnVJaRmaj3N4QI3L1Y84yYd1c9BFO9HvqAlYF4Nv2
         n/FFlrtlZs23/ufIqdPoJrM71Jpgy9CVakFjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUMuZzY6/DzLWZ+BSW2AElhZ5+FoZVNKeE67ie5COFQ=;
        b=T5ZiiKrmRH+veVbFHXDmpq8PhPxYcG1s2hP3n/fLIa1gHvHgq52C+DGtJepj3WcGYR
         NGeiYTr8eKjQpo/3tmJb4ELVvZWukp7Hikf7dn2LFVPT4IjEH9qF+4nNxN0H9dluUP2g
         Ss5ppdW2IcPmNosI+67qJ4dPaNK9xkd04yN3Yp2R9e/hPyEWmqVVLa98kH9PdjwSbvve
         Dj+CB2rPRX7QQTJHCRVkPr6aZNSeDE2Vr/ANlQf0u1msXkPwqoDM9h5h0Lpl/RRZKSJh
         UI3wM1FQtbKiuWek87CeuU/D7kBOCcHZoHhb7qyOPSSy8IzO7M3boUJkVQUjMbx2ln1j
         dP0w==
X-Gm-Message-State: APjAAAV6RTD1DQGY157HroEmZFAr0GQYGSFRi8zMAy7/g2cKUtQm/hFM
        FvavoWunT+t3eJnBPy3mh/Lc0w==
X-Google-Smtp-Source: APXvYqyLmLWll0jAMr87zupnAn4kgBVxLJiVkXjkaJBUyz/wuHfQ6vmvPDTIY3GKpzn9AAm0i8G5Hg==
X-Received: by 2002:a17:90a:25e1:: with SMTP id k88mr1750174pje.14.1573508764412;
        Mon, 11 Nov 2019 13:46:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s24sm16617072pfh.108.2019.11.11.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:46:00 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jo=C3=A3o=20Moreira?= <joao.moreira@lsc.ic.unicamp.br>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v4 0/8] crypto: x86: Fix indirect function call casts
Date:   Mon, 11 Nov 2019 13:45:44 -0800
Message-Id: <20191111214552.36717-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that Clang's CFI has been fixed to do the right thing with extern
asm functions, this patch series is much simplified. Repeating patch
1's commit log here:

    The crypto glue performed function prototype casting to make indirect
    calls to assembly routines. Instead of performing casts at the call
    sites (which trips Control Flow Integrity prototype checking), create a
    set of macros to either declare the prototypes to avoid the need for
    casts, or build inline helpers to allow for various aliased functions.

With this series (and the Clang LTO+CFI series) I am able to boot x86
with all crytpo selftests enabled without tripping any CFI checks.

Thanks!

-Kees

v4:
- remove C wrappers (no longer needed after Clang CFI fixes)
- simplify everything to avoid casts as much as possible
v3: https://lore.kernel.org/lkml/20190507161321.34611-1-keescook@chromium.org/

Kees Cook (8):
  crypto: x86/glue_helper: Add function glue macros
  crypto: x86/serpent: Use new glue function macros
  crypto: x86/camellia: Use new glue function macros
  crypto: x86/twofish: Use new glue function macros
  crypto: x86/cast6: Use new glue function macros
  crypto: x86/aesni: Use new glue function macros
  crypto: x86/glue_helper: Remove function prototype cast helpers
  crypto, x86/sha: Eliminate casts on asm implementations

 arch/x86/crypto/aesni-intel_glue.c         | 31 +++------
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 73 +++++++++------------
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 63 ++++++------------
 arch/x86/crypto/camellia_glue.c            | 29 +++------
 arch/x86/crypto/cast6_avx_glue.c           | 62 ++++++++----------
 arch/x86/crypto/serpent_avx2_glue.c        | 65 +++++++++----------
 arch/x86/crypto/serpent_avx_glue.c         | 58 ++++++-----------
 arch/x86/crypto/serpent_sse2_glue.c        | 24 ++++---
 arch/x86/crypto/sha1_ssse3_glue.c          | 61 +++++++-----------
 arch/x86/crypto/sha256_ssse3_glue.c        | 31 ++++-----
 arch/x86/crypto/sha512_ssse3_glue.c        | 28 ++++----
 arch/x86/crypto/twofish_avx_glue.c         | 74 ++++++++--------------
 arch/x86/crypto/twofish_glue.c             |  5 +-
 arch/x86/crypto/twofish_glue_3way.c        | 25 +++-----
 arch/x86/include/asm/crypto/camellia.h     | 58 ++++-------------
 arch/x86/include/asm/crypto/glue_helper.h  | 27 ++++++--
 arch/x86/include/asm/crypto/serpent-avx.h  | 23 +++----
 arch/x86/include/asm/crypto/serpent-sse2.h |  6 +-
 arch/x86/include/asm/crypto/twofish.h      | 17 ++---
 crypto/cast6_generic.c                     |  6 +-
 crypto/serpent_generic.c                   |  6 +-
 include/crypto/cast6.h                     |  4 +-
 include/crypto/serpent.h                   |  4 +-
 include/crypto/xts.h                       |  2 -
 24 files changed, 313 insertions(+), 469 deletions(-)

-- 
2.17.1

