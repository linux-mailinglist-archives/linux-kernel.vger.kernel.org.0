Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24990FB750
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 19:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfKMSZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 13:25:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45149 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfKMSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:25:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id w7so1393609plz.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pwxLXS3yTtk2YEMUUCjQyP203hwLsDnQtk6QOIH+hQ=;
        b=gAWOwtuF3lIquOQlfbbubJi3yzRbCWqpkHyHpURP0xiyYdIGDhL2M6a0HVtr6b0Nee
         iacrhyDyGnXJrOQU5Ea08GGqdbt5SzT6nFBJ478ifj6tfAWTrf9E2dhS4CHCo0FG8GrC
         H4ilLZIILSpwzFdlRVRfzIEJreuOREzxlUFVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pwxLXS3yTtk2YEMUUCjQyP203hwLsDnQtk6QOIH+hQ=;
        b=f5OUa5+lNABNauEqrPEzn4WfCKV28oYyfbPXlBSNlUrj/x0Raklrv9Cqa9DxI+xSC0
         l137v9byYt4skpZ6uIFN6sYTQ7YrcmeufhfaRRLFzc/k7fShtoLACXi0dHp7ky/GDhNU
         HXJnJGn9dS5WIqgw5LwDcecxPuYrfcgrrurqMBXToNbmicwBIjYg8Iqm+PbATLHk5lMH
         AAFqkYWd9zLtAB8fGz8PGLWubYotSUsrS86TeLJSZDTgxOvXrCDpcffgefJgNJmcBuy6
         vhXj+LPua57zerAgH7L9rUdX7oB8sfQkX7LRVyRP4lA5cktjFgvrdroGGwK7GjnngONE
         wtTA==
X-Gm-Message-State: APjAAAXoiok9s4/pxXWlpyM4M6bc5pWNXTBjkTdXSIvfGdo1N/0co8nE
        +jZni4M3W/VG/bp1LDPKvt1QSg==
X-Google-Smtp-Source: APXvYqzFyWMtneWFouUDOfR0m5QsWLsUNEWASLVCp8b8qDMIjhCm38Rrg4qYd8K/ZGfuwpWmWeHLcw==
X-Received: by 2002:a17:902:8a8b:: with SMTP id p11mr5284252plo.152.1573669521942;
        Wed, 13 Nov 2019 10:25:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm4130991pfg.3.2019.11.13.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:25:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jo=C3=A3o=20Moreira?= <joao.moreira@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v5 0/8] crypto: x86: Fix indirect function call casts
Date:   Wed, 13 Nov 2019 10:25:08 -0800
Message-Id: <20191113182516.13545-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
- remove macros entirely and switch to declarations with common prototypes
v4: https://lore.kernel.org/lkml/20191111214552.36717-1-keescook@chromium.org
v3: https://lore.kernel.org/lkml/20190507161321.34611-1-keescook@chromium.org

Hi,

Now that Clang's CFI has been fixed to do the right thing with extern
asm functions, this patch series is much simplified. Repeating patch
1's commit log here:

    The crypto glue performed function prototype casting to make indirect
    calls to assembly routines. Instead of performing casts at the call
    sites (which trips Control Flow Integrity prototype checking), switch
    each prototype to a common standard set of arguments which allows the
    incremental removal of the existing macros. In order to keep pointer
    math unchanged, internal casting between u128 pointers and u8 pointers
    is added.

With this series (and the Clang LTO+CFI series) I am able to boot x86
with all crytpo selftests enabled without tripping any CFI checks.

Thanks!

-Kees

Kees Cook (8):
  crypto: x86/glue_helper: Regularize function prototypes
  crypto: x86/serpent: Remove glue function macros usage
  crypto: x86/camellia: Remove glue function macro usage
  crypto: x86/twofish: Remove glue function macro usage
  crypto: x86/cast6: Remove glue function macro usage
  crypto: x86/aesni: Remove glue function macro usage
  crypto: x86/glue_helper: Remove function prototype cast helpers
  crypto, x86/sha: Eliminate casts on asm implementations

 arch/x86/crypto/aesni-intel_glue.c         | 45 ++++++-------
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 74 ++++++++++-----------
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 74 ++++++++++-----------
 arch/x86/crypto/camellia_glue.c            | 45 +++++++------
 arch/x86/crypto/cast6_avx_glue.c           | 70 ++++++++++----------
 arch/x86/crypto/glue_helper.c              | 13 ++--
 arch/x86/crypto/serpent_avx2_glue.c        | 65 +++++++++---------
 arch/x86/crypto/serpent_avx_glue.c         | 72 ++++++++++----------
 arch/x86/crypto/serpent_sse2_glue.c        | 31 +++++----
 arch/x86/crypto/sha1_ssse3_glue.c          | 61 +++++++----------
 arch/x86/crypto/sha256_ssse3_glue.c        | 31 ++++-----
 arch/x86/crypto/sha512_ssse3_glue.c        | 28 ++++----
 arch/x86/crypto/twofish_avx_glue.c         | 76 ++++++++++------------
 arch/x86/crypto/twofish_glue_3way.c        | 38 ++++++-----
 arch/x86/include/asm/crypto/camellia.h     | 64 ++++++++----------
 arch/x86/include/asm/crypto/glue_helper.h  | 11 +---
 arch/x86/include/asm/crypto/serpent-avx.h  | 36 +++++-----
 arch/x86/include/asm/crypto/serpent-sse2.h |  6 +-
 arch/x86/include/asm/crypto/twofish.h      | 20 +++---
 crypto/cast6_generic.c                     |  6 +-
 crypto/serpent_generic.c                   |  6 +-
 include/crypto/cast6.h                     |  4 +-
 include/crypto/serpent.h                   |  4 +-
 include/crypto/xts.h                       |  2 -
 24 files changed, 409 insertions(+), 473 deletions(-)

-- 
2.17.1

