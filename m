Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07F674172
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 00:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfGXWdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 18:33:20 -0400
Received: from sonic316-12.consmr.mail.bf2.yahoo.com ([74.6.130.122]:38897
        "EHLO sonic316-12.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728130AbfGXWdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1564007598; bh=SPPeLnkU37h6IEEddULHVtoSg4HbUr/YQkJNiVMbBWg=; h=From:To:Cc:Subject:Date:From:Subject; b=GGlDxOWTHfwZvZeIFIyrmy8YWAlFW5Uf/DNumTcpt4L9YGiVM/OkJXnxeeTDZd2eFXOkZwKP9SFFV8qIeJbNkNYfoaXa6yoC0fNdyIM58MbbeUHDPYWtnyhBmfvHK1eEfwlh65NFPsqo8P6rV4W4jdjp//LNlTNOg6S0uHoX82y7/vwlu7yCb3CJkRVIPDyFNEnw5S6hlRpO0cmsI1zwXnmglegxgKytIsWuoHFB58gkqtpcaCnpoLaTRgaDBG3rLMCb8RNOSe4NuonhsfYjBMTx4c+t5ylREzIejvrLh2jXTq2OAPvNz1+nOtZuqW7Jd77XFzXFl5QR1z7NdhSRrA==
X-YMail-OSG: 2oJ0R5YVM1lFJY_iueNsT5RC81Eh3DXl1dyOyDapLmF5ylx1fBX6DEI9svzdfla
 GOS_cgFPUW3twNxDj4bcf21ddO1PTNtVb6fNZ14vDNj89FU8ipWNjl5Cl.UWsjZ7.ZDInFcQVK3W
 AVhRemfveReK4R3kcwbGRP9oG6HUMOZ.ktbTzQ06g2pqxN0twZJBM7e3Eii57wu_haH.DHqGTeq.
 .wnIwJK_jOVxw2FMRW5Fep3hB.JMNAAID_LPHC7v8ET57gPOTsT3zRgUI.WixNQTw7X1YZ0xpNRp
 nNHwy80eN3ChP_MLeEhaemM8Wufh97JKcEpwg22YjqaOAt.bjZCEu7a9ighfodOpwN_i17hA2tQE
 psoD3ZIZ9f4.TDYx9jvZbCq.5NSHWNoxhMGJ0J6x2L157ukHHHdyb2FKO.jbdk_kae3L2g8fXsKh
 RdSV7WGKhMrwOLPTc483evVzTAQwfuOzV.fDcRjeTuGowLp1.5pbcDFtSg_2zDyWISeg40GaOEo7
 CSTtQchXl2ctGbgONsMlnF81bIVaRCxdv.ikddptOk_vmfnpRFm42sfwGoUp0ekzOfs.01P.KFiV
 SUhDLF1yIXU6x9PCe0kiv.TAKwv_2SA09BMiLM1fqUDXx3lmwgHoaYTnmV_wZRoqHNNNnx.y0TK9
 nhI.zW3cD7VqGc28UfMQbb.sAufH.RLrhi7I6YHpXmv4RdGw6FLHrMVaZuMR1DwhzOyYzqhPEdL5
 OgBZrGEM8IJViRFogPSAZgfrzAeWUFOQt9bD2BUYrbEgv6YPgDHoD8j0_xfw1abIdqOvOagxM7zo
 4KOkpa838AauLOHcLwwLD25DoBW2MLAn4ZxlC.bqA76CSymsZOc2.Mj_x28PbszFTdYIf5auAWV.
 7Iw7yMolAJvg1GT3eaIZW3YUMgJffp_IVsNqOntYVBhzumjkbgsvDIcLZWhfwcepVuGooSzOM_Cv
 ZQY1B4AKEa2KpWR.rbY1kpgrZ.RZdiqhfTaBlJpWGRrU1wR0nHkp1jETLA81pl8tAu35y95OYKSa
 r8S.SG.koUHnKt4gpVum6inJHUIJxKftSte.Cyq4Fc6eE1ZDcv5fZxL6B4MHvW5Xa1QxCW05Yhuz
 nScLSnV0D_0Bx.yXjdB_jeV.kQIo1axJDLAzGyUvSC5N1aIKHs8MdE.ODwkPHRSJUTqkBC6BGvfb
 s3XnDkUN8jdmk2xJuluofryClJd.5gtJptY.BmTsIAM6BtLQjTqTftb8O8_aVHpKcR8UYNCuoTNg
 n40hs4MHUYjUk7hsWQ74-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Wed, 24 Jul 2019 22:33:18 +0000
Received: by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 43333be216d12705f4c89f176b7fa2c0;
          Wed, 24 Jul 2019 22:33:16 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] random: print a message when waiting for random
Date:   Wed, 24 Jul 2019 18:33:13 -0400
Message-Id: <20190724223313.2498-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- many programs now use getrandom on startup, including for cases which
  may not be security-sensitive (e.g. hash tables)
- boot times are faster than ever with the widespread use of high-speed
  SSD storage
- no major distributions currently use RNDADDENTROPY ioctl when
  restoring the random seed, including systemd and OpenRC. systemd may
  add this functionality soon
  (https://github.com/systemd/systemd/pull/13137) but it seems to have
  some special requirements (systemd-boot) and/or require special
  opt-in.
- despite the availability of virtio-rng, many hosts do not offer it,
  and many/most distributions do not configure rngd by default

in combination, many programs (e.g. sshd, gdm) now block on startup,
sometimes for many minutes. in the kernel, we can't fix this easily, but
we should at least notify users why their program is stuck.

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 drivers/char/random.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..e4490c6c9c84 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -511,6 +511,8 @@ static struct ratelimit_state unseeded_warning =
 	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
 static struct ratelimit_state urandom_warning =
 	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
+static struct ratelimit_state wait_for_random_warning =
+	RATELIMIT_STATE_INIT("warn_wait_for_random", HZ, 3);
 
 static int ratelimit_disable __read_mostly;
 
@@ -1745,6 +1747,9 @@ int wait_for_random_bytes(void)
 {
 	if (likely(crng_ready()))
 		return 0;
+	if (__ratelimit(&wait_for_random_warning))
+		pr_info("random: %s: waiting for randomness\n",
+		       current->comm);
 	return wait_event_interruptible(crng_init_wait, crng_ready());
 }
 EXPORT_SYMBOL(wait_for_random_bytes);
@@ -1901,6 +1906,7 @@ int __init rand_initialize(void)
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
 		unseeded_warning.interval = 0;
+		wait_for_random_warning.interval = 0;
 	}
 	return 0;
 }
-- 
2.22.0

