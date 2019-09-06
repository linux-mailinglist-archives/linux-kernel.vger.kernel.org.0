Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8BD3ABD8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfIFQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 12:18:46 -0400
Received: from mout.web.de ([212.227.17.11]:47143 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfIFQSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567786695;
        bh=wJW95vyrbAXAhbMPGzJHA//AkuLBlNVghAehWcPv918=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=K9PByqfowi2KKuxM76Az5avjDvkD0BthZ1MpE2Bo+92fc5MZJJrz6yKPJ64Wvvi41
         nfXE5vHtxMN04JjAspTt0YOrZT4k9YHv6aKBIt1SKQrnxg1tkYAZY4d53N5U7VRfBe
         NzhDb/C9GYBmChY6svn5vZwtI71qy1CPWPrXUIN8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.58.4]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwqJw-1iCrXj0lc8-016Khs; Fri, 06
 Sep 2019 18:18:15 +0200
To:     kernel-janitors@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dca: Use PTR_ERR_OR_ZERO() in dca_sysfs_add_req()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        zhong jiang <zhongjiang@huawei.com>
Message-ID: <266c98ba-43ad-28c8-055b-a3e832e7e8a5@web.de>
Date:   Fri, 6 Sep 2019 18:18:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kPGDBJdW9+YDxTz07QfNzF8hdnfGtS57xdrTf8fXkd6N8I+pTWz
 1c9DZVFKkzuRfKFOyRlUxJMKOtdmceJWBgRHH6ZCMk0zmsOF/l6MqKyiYMXQw/MJ4mpDTfW
 d1WZ3RK6nxKar4wwNulZyw/zGMJ4HYrYkAfc5bzm1vOYADgVOwlKrJ30PFC5Z1VoQQ0v630
 40dijDzbpLC7ZWluLEWBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4r1P5NBAdo0=:5TI5Y7LdMFsJW0PUeA8lPB
 l5IF4beZlpvTqvXdqoCHOVsfECZe/CbIlHIROsjy7ylBjCk3LSSS6VoNp6X7KO/dSzfyvxOCq
 bPPhRkoH/gR1Amt8fJ2mSpGGVT3Ej1AJtzxaAKqaOpa55uDVGkmSS0DLn4eV/TMFEAvb+e9bx
 FXqvDd5yr5se4TJM94pIi/tPWdRAiPz8WuZK+7YNjOc7DbTK2KnSVhElXfXjWpmTDNFDSsuKU
 FYuutc+vnEs36YQFECJhcgL/p38T4giZw6wqFdCueRyOKFnHc8663xuQSJLy81N8Abpoo9XiJ
 g3FTMRaY2KYBvpnsWzs9f4lLbys/rBiIxw+ObRJutLBfr7NuGbVvoDnO9kAO+elrgtxUUcrGR
 29pPONgZZm3FpdR79iTIhYCNctiFZ/NTPomUzvZerWftWfd3VRrAkQmAoJjOBYFlZWelPGHCH
 oY77ApJd8SUPZMPehnihPMeRhGRFx4nxLTwlaDmZWW7fbuYRfafebfq+FlmhAZChJqZgVzM+X
 IAGooIIeSloui+xRXvo+AWMVY2NuOygONwuemr9VKtnn6TtmW4CgLBU/pdZmaQL+SnWBhBlB/
 quXMxdkIrMFS5hjc9+1cnfB8l3Tp71Wx9ciWxvt6GvenomdtCgJIS7vgBsJB8+RcHLN40XhdL
 Rp/J6WNFAGnzlG/a6ng1/vvE7dq2P5knxXNhqUmFfmtM8oWvk5J++Lrh7UsylPRmyrtCpxQD0
 WFSmBqheKicw9IVhzyzzkjvUTtfaEzsAia63Sa7tt70UTYCxc+pPDwqb0KMRDThZSZ2NPiwpV
 iKwkHUHUEJ39zQnyvVPfbfdMiE2wTE4kEbvQTlZbUQVj9qbaIyEFh4+nP3W56CNePx/xeeTVX
 ujmKJXXPD9Wuf2dn7VW7JRi9yyVNiyABec3++EZ5YNREDRStPMEwpjrgsWa38hH9a10KYCqEK
 2nrrvVNiafD6j8JS4htEkwJtFQCKv0XKmiZlaSxiOLFJpR+0RTXKS/D+QGuEg6DK0+a8Qk2Tv
 EVki3fT76CheTiBIbZQazuYYBq8AtwHOrRw4e2cUx2+djYCIqrFGja3FOwraJ4tC0UlRhOBIg
 QZlBMAXciDNW14Tolcx5mLSwxunMvbdkUIhXwOOD1Dbjlh0LvdRQrYNkdRncmlctZsJmzRkJW
 OilzJ+BbRrueOtSMURrijEdOuTmoCVZgM5HI/u+usN2gYiy9R2ggT+XAING2oY5In/TORa+uy
 rfp8s0sEbVV3Qibtz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 6 Sep 2019 18:05:21 +0200

Simplify this function implementation by using a known function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dca/dca-sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dca/dca-sysfs.c b/drivers/dca/dca-sysfs.c
index eb25627b059d..21ebd0af268b 100644
=2D-- a/drivers/dca/dca-sysfs.c
+++ b/drivers/dca/dca-sysfs.c
@@ -24,9 +24,7 @@ int dca_sysfs_add_req(struct dca_provider *dca, struct d=
evice *dev, int slot)

 	cd =3D device_create(dca_class, dca->cd, MKDEV(0, slot + 1), NULL,
 			   "requester%d", req_count++);
-	if (IS_ERR(cd))
-		return PTR_ERR(cd);
-	return 0;
+	return PTR_ERR_OR_ZERO(cd);
 }

 void dca_sysfs_remove_req(struct dca_provider *dca, int slot)
=2D-
2.23.0

