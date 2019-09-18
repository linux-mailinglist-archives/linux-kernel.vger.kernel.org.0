Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B07DB62D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 14:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfIRMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 08:10:41 -0400
Received: from mout.web.de ([212.227.15.3]:54007 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbfIRMKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568808622;
        bh=gV92216Xq6eVj771htUYtf8kVuhstFgMMf1Gv//Wpj4=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=hxlLMrJHyUAz0bKMPalEywe8SFhZovSvFxLFi6fyB4UrBaPF375B4G+7aM9WydlMA
         94Cu2h2PzNgk3zYZH+gaKZ5u0eA3O41ISkBnDoorFQ8DmerQntRrCcXm2R025vNB6b
         Z4g/mtsgdnUmQ8Q9+ZLPXuZzC7e3G8wjhTixne/U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MP047-1iFlJy3dln-006LrO; Wed, 18
 Sep 2019 14:10:22 +0200
To:     kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peng Hao <peng.hao2@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] misc/pvpanic: Use devm_platform_ioremap_resource() in
 pvpanic_mmio_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Message-ID: <e0ce24fe-ff3c-cbbb-4a56-4e529ebbe8d0@web.de>
Date:   Wed, 18 Sep 2019 14:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fhMEE37LPi7vtrhRc3vQ75ZpXtYgxoq8wPkGHnadzwYMH86hXAj
 /P7z5+VQZEpbDckcYyJ/5Ub4wqkXVLPnRJ4PxOP0+A20skJm4ap9cIWv2V7i4YXzTRxDiGB
 0BVmOlesqYnRspayuIqiQ42uLVRKhCY3g0mV15RcdrvpvbyuztnDO/QUs5cGlLVnw1oXItA
 NA7rA1XqXetVTtQBobdbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/31WlIHjdcs=:R11A8UQQBNkdWJlvA7WqrG
 cIXReSJTo0w/Df79VY+kbPLSQO9Kl1+FRAirlpf3Q/aXeMSiI7KONi4Qn/pRppY9vH77Nq/B6
 TaaaWIki2HGqcsorXRDixorvjfC94U6YOXJXKow7gLKJ93B4+gb6chPjB/hcewdr4IuwDuTgQ
 1hXtcJUCSenDqBs53dx/luN1xxshjzapT/G52+xEFN2CS3gUKBNCEmacD212GIh0MQR6N6gJi
 c9YjiK+Fvk5EDouu3ZNPblSUwzTaV5vAOQXME12rNOm2K8f20D+PsZ0AIWiJtdvcKfLgdKhiu
 XLQPZD0vNEqTccTj4ABgSA/8VtphAcIaO7WOobRqzM7msnDXPidYOmWKTYd/c1j6Tjf0oMK5a
 2vsDb/hX8cowDvEK7Dy+8aTYJTrMUYJGjPpQ2hKrRdoLOXJ/MHW//8tkSjX44SfD2WhKAwG4y
 GzlR9hb4yfSPZjkko+rXwKWGVxWarPdmeOfxyqVvGBxhDezSQ7DmduVwWUOTMHGAGSkfQMnXb
 5A2qt0PnTVZ1Kl25bXNzcjH7j9ofUULjIBIdI50OIfGuz5NbtI8bWqQ7jVsLeiJNorUGnFNbY
 6eL0S0g81GGn4u98DDa9O5Of+3pwkHakh7yXJ/AaVdQulEan3zqeGtVfWkExfRXaNpqHRo64G
 GTBbf1u0GmYJ+6MOxXoYMp4OgB4KW5tC3kAY1HCmPaCnwtdXZbCUZDUaqrrd2lmF+UTdBp5tU
 PAoRAmHKB4TJPQK0FFVxJHFxmMtraNWtYvsAvUxvwPP6Uon2+AqbJbHT7HsudTC7apzww/4GF
 BI73QGAJhPpTbBR/NNP3wOPtnpGYLRLUAX8HAnaGw71XxtfV4mqOaEexP3XxEDVTXO7PeY7aA
 SiOgwFHbHp0TNOaGgko3icWZCfhpCfT0oRSxHkPQ3f4K4biv9kZz7fXlsUCjICeXlmMk4K+Ln
 A2wQ/q76DFK+QSIxRFTtM6XipipVnwaT7XHjzVq+Smb9Cdwn0pa61yvFPnlXUqOmVJOhoKA+X
 XNUsxXDeTsStx9tmbVbgToRulyd7At1GiaGEBbjYry2zBd6GulJ6wQ9pdkBYVPsyT5PMwELaH
 qxDs7+DX0HqUGOU0iyOerqFag+JNPzfULCvHbPQvTBVsNkHsu0WT/fFBxhMmQoolhML9xbFvA
 5on8csGzUXXbmuy0WUA08Or+5uJd5Tl/7vqYDisZLczjxxFbuPge213JPVHz3lxEOXfIU/wnx
 Jl0X5rI9WAXv1JIOf0YFZLfkEvlVRYgQT7uZsEGP3U39LRdJDjJi7Fenan08=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 14:00:13 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/misc/pvpanic.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 95ff7c5a1dfb..74bcdd171558 100644
=2D-- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -137,13 +137,7 @@ static void pvpanic_unregister_acpi_driver(void) {}

 static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
-	struct resource *mem;
-
-	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -EINVAL;
-
-	base =3D devm_ioremap_resource(&pdev->dev, mem);
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

=2D-
2.23.0

