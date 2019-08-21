Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0897A21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfHUM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 08:59:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34774 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfHUM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:59:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id b24so1409781pfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NgcFw3hVKox4ZMncTJsF8I7dcCJPrgxZ4MMUUDjG2jI=;
        b=gvlhXifzulVxBA1k+iRoWru29nBEQt3aVFtsBJEr1ClYybOdXRI/bo+8zYaZE9BEuM
         z+L+v7mf0GNn2Kz5oicvcwk2GISMV6F6Rh5Y/R+PQ650EzYRIC0tpGQTcjnHk6bHWN0R
         QBd7eZkj98cTywlpukDtDqV/IOiu3Rfzwjm4Jx8kv7YefXkgv6kmVt8m4x4TQhNVORrN
         lYp6zAlnZUr1b0UX0npHdX4WvheApvkmyE0/IX9OZZ7vG1mG/2KjGBH7wf7DgG4kvA2N
         5zm0d9sKc4suFgABlyE45VliP3u/X+tX9FOiq9XTs55KAcqi13zbk48ZTCHuRHPtym3e
         LTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NgcFw3hVKox4ZMncTJsF8I7dcCJPrgxZ4MMUUDjG2jI=;
        b=kBTQvoDYFBGT4UZZNurnilCI28YYCJtzV9snn4xEps4va/2/2NZybF7Ab3TfkHOnla
         IMx6ErWpR7AcYguMZdk9mG560eR9bjkkYbl/Xm5edLfcamZW1+5Rud+z1XM/lJAUaW4L
         rxIBbqnaPlgiKPIPgJZRdgQFoiSkJdsTPJO/iYtkwpvrvs82ApQF70ROjQQpgP+Wo3F4
         z9HHn+GrcpVlSGx6V+XXn8GrGdJ/z9ounuaBcluV4oBk5v18N7pGsQ+18XdVpwgpati7
         p7UI8Haqkm68dXhZaJ0DHkrCMkEGbM9i6MBs410d4iFZ76HjugOL0FptzcGXYJLJ6Wv6
         /QkQ==
X-Gm-Message-State: APjAAAWWsUgBQvmZrRw1svd4MXUqXFLQ5t/TI5L+f0ZrKmxWF+Y7eUke
        gUJdnm1a0ze8uqIxsCfdpUHESg==
X-Google-Smtp-Source: APXvYqyOqIQGBjM7cgB9Ls3JuPghOspsk2eAlS2J0JiABhuavH0Gfjs6KSkNWBW0wNpi1dWFpP/kFQ==
X-Received: by 2002:a17:90a:94c3:: with SMTP id j3mr5011299pjw.10.1566392380046;
        Wed, 21 Aug 2019 05:59:40 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.28])
        by smtp.gmail.com with ESMTPSA id o24sm47377476pfp.135.2019.08.21.05.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 05:59:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/4] Create and consolidate trusted keys subsystem
Date:   Wed, 21 Aug 2019 18:29:01 +0530
Message-Id: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set does restructuring of trusted keys code to create and
consolidate trusted keys subsystem.

Changes in v5:
1. Drop 5/5 patch as its more relavant along with TEE patch-set.
2. Add Reviewed-by tag for patch #2.
3. Fix build failure when "CONFIG_HEADER_TEST" and
   "CONFIG_KERNEL_HEADER_TEST" config options are enabled.
4. Misc changes to rename files.

Changes in v4:
1. Separate patch for export of tpm_buf code to include/linux/tpm.h
2. Change TPM1.x trusted keys code to use common tpm_buf
3. Keep module name as trusted.ko only

Changes in v3:

Move TPM2 trusted keys code to trusted keys subsystem.

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (4):
  tpm: move tpm_buf code to include/linux/
  KEYS: trusted: use common tpm_buf for TPM1.x code
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: move tpm2 trusted keys code

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 drivers/char/tpm/tpm-chip.c                        |   1 +
 drivers/char/tpm/tpm-interface.c                   |  56 ---
 drivers/char/tpm/tpm.h                             | 230 -------------
 drivers/char/tpm/tpm2-cmd.c                        | 308 +----------------
 include/Kbuild                                     |   1 -
 include/keys/{trusted.h => trusted_tpm.h}          |  49 +--
 include/linux/tpm.h                                | 270 ++++++++++++++-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  92 +++--
 security/keys/trusted-keys/trusted_tpm2.c          | 378 +++++++++++++++++++++
 12 files changed, 697 insertions(+), 700 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (77%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
 create mode 100644 security/keys/trusted-keys/trusted_tpm2.c

-- 
2.7.4

