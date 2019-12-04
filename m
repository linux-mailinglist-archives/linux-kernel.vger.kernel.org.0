Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35629112E53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfLDP2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 10:28:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37386 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfLDP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:28:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so9137682wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=n0PMYgXBxpTJTwUFndMR8j8g1X+3mghMk/wqd/jqgb4=;
        b=cPNuQoPsK/IaM6bjnT9f9fznnLZV6W3amrqNwE5KT0g0fAzb0IB/r7CZzMMmqG5ooF
         bH1J5zqnHViwUlMvEZUMnhKSdwt5CVERjPLQwXJJ59xzXl4TkPThLLFguRiCuTZqZLgh
         p8o9z51+Io63YGZ1D9Y3mBoy3VbQcM+CbjGLvPNMOhaoW6Hz6VFWLzT4xI3Xe6Ft6jSG
         SWNl6f5cKTA5UVJI9eL/iWIM3Xqav0Ge9KFr1dzDqT+TaR4jNStC23Z+6MfNvMlDZFg5
         vHOUT9n0pWZu63JbNZUgt5Wr8SRaNB8EYuYCYVvGYsz6+agsYFdQQOU/RNfLOp2vMOnS
         7XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=n0PMYgXBxpTJTwUFndMR8j8g1X+3mghMk/wqd/jqgb4=;
        b=ssoJvp1IQlNNdxv6l82wqAt2phbxE134YESyBx9mkIjH0khvm0TeEsHuiT/Pbo+cgV
         /y0LX/bpa7EueLQI8K2ijdVgwMfxMU3IM9sB8gkUPc0fNR2hsDEhqhS2idUJ4QsPCzzs
         DxOXdlPCkMePCLrLC9GVXw0G3fq3C6uIv7IWa6Asfw9X5kl+RWUXD2DNB6isMDgQflv2
         QWStJwMD27SJmpSp5TkxCwdMS5pw7Ph2dMQMuTFDxuArH9KcdYtf7JqZljJydduqKf9T
         QcBRiEfvMsnrFZn0W9l6hUkKmlwPanI3mr6+jyI2PC46HZdg4Q5lsP67PjbkJRpnYJB9
         Tl0A==
X-Gm-Message-State: APjAAAXpUJoZXdcisPAuMHEELq9V/usUfk/q2GsgW1Qzhiu1W9LENQoS
        H6CuG2DLKCyRtauIiub3mBF04Q==
X-Google-Smtp-Source: APXvYqzg1TyHqcrLbHlAbi08TX3/2GpmskSRV7ZVEsEDmRuvJ1eZlWpKFOWi870svMg0kU8UUNR6OA==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr4788809wrn.239.1575473284403;
        Wed, 04 Dec 2019 07:28:04 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b2sm8607869wrr.76.2019.12.04.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:28:03 -0800 (PST)
Message-ID: <5de7d083.1c69fb81.82fe2.b0da@mx.google.com>
Date:   Wed, 04 Dec 2019 07:28:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-9340-g16839329da69
X-Kernelci-Tree: ardb
X-Kernelci-Branch: for-kernelci
X-Kernelci-Lab-Name: lab-collabora
Subject: ardb/for-kernelci bisection: boot on rk3288-rock2-square
To:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        mgalka@collabora.com, Ard Biesheuvel <ardb@kernel.org>,
        broonie@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

ardb/for-kernelci bisection: boot on rk3288-rock2-square

Summary:
  Start:      16839329da69 enable extra tests by default
  Details:    https://kernelci.org/boot/id/5de791acd6451dc5be960f08
  Plain log:  https://storage.kernelci.org//ardb/for-kernelci/v5.4-9340-g16=
839329da69/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/boot-r=
k3288-rock2-square.txt
  HTML log:   https://storage.kernelci.org//ardb/for-kernelci/v5.4-9340-g16=
839329da69/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/boot-r=
k3288-rock2-square.html
  Result:     16839329da69 enable extra tests by default

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       ardb
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
  Branch:     for-kernelci
  Target:     rk3288-rock2-square
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 16839329da69263e7360f3819bae01bcf4b220ec
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Tue Dec 3 12:29:31 2019 +0000

    enable extra tests by default

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5575d48473bd..36af840aa820 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -140,7 +140,6 @@ if CRYPTO_MANAGER2
 =

 config CRYPTO_MANAGER_DISABLE_TESTS
 	bool "Disable run-time self tests"
-	default y
 	help
 	  Disable run-time self tests that normally take place at
 	  algorithm registration.
@@ -148,6 +147,7 @@ config CRYPTO_MANAGER_DISABLE_TESTS
 config CRYPTO_MANAGER_EXTRA_TESTS
 	bool "Enable extra run-time crypto self tests"
 	depends on DEBUG_KERNEL && !CRYPTO_MANAGER_DISABLE_TESTS
+	default y
 	help
 	  Enable extra run-time self tests of registered crypto algorithms,
 	  including randomized fuzz tests.
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 88f33c0efb23..5df87bcf6c4d 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -40,7 +40,7 @@ static bool notests;
 module_param(notests, bool, 0644);
 MODULE_PARM_DESC(notests, "disable crypto self-tests");
 =

-static bool panic_on_fail;
+static bool panic_on_fail =3D true;
 module_param(panic_on_fail, bool, 0444);
 =

 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [b94ae8ad9fe79da61231999f347f79645b909bda] Merge tag 'seccomp-v5.5-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good b94ae8ad9fe79da61231999f347f79645b909bda
# bad: [16839329da69263e7360f3819bae01bcf4b220ec] enable extra tests by def=
ault
git bisect bad 16839329da69263e7360f3819bae01bcf4b220ec
# good: [25cbf24a7eec7c3dee4113b2e98b572e128009b7] crypto: aead - move cryp=
to_aead_maxauthsize() to <crypto/aead.h>
git bisect good 25cbf24a7eec7c3dee4113b2e98b572e128009b7
# good: [7b19c7a82950ed034645fa92adce29cd6163ed3e] crypto: testmgr - check =
skcipher min_keysize
git bisect good 7b19c7a82950ed034645fa92adce29cd6163ed3e
# good: [062752a354aaf03b46b86cba5fdaa2fd5c932860] crypto: testmgr - create=
 struct aead_extra_tests_ctx
git bisect good 062752a354aaf03b46b86cba5fdaa2fd5c932860
# good: [2cd56a00fff8584e342164c65e6b55da61f79c4a] crypto: testmgr - genera=
te inauthentic AEAD test vectors
git bisect good 2cd56a00fff8584e342164c65e6b55da61f79c4a
# first bad commit: [16839329da69263e7360f3819bae01bcf4b220ec] enable extra=
 tests by default
---------------------------------------------------------------------------=
----
