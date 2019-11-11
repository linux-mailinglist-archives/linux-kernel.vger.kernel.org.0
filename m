Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C51F7FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 20:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKKTaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 14:30:46 -0500
Received: from sonic316-11.consmr.mail.bf2.yahoo.com ([74.6.130.121]:44791
        "EHLO sonic316-11.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbfKKTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573500642; bh=Y+QMmBxhxETT6cijWO0kim3WKJ/S+sx6+I6sJR+T9sg=; h=Date:From:Reply-To:Subject:From:Subject; b=A7tchzra8oF89AF3ZuXu9nc4wCnISN/EqMrfsuBZhBiv95qp4cG+a7KNeqJNwTA0/swyQrk4cheDiYYItxS/YfXhxoE7I4Og4LLytjKYB/8qAGJoS1adRTKevq2l09fHkoM3nksuW385MusuRjHrtgHJgA3b2fRGBo0F2FWDpxjTMayErOZpioUVQdil1G0X/AGrP2T7LMrqXs7XNmBgC/v0Za7hbkHrdaMdbAQmoC++KYbB/Fw/ny6kZFYVWy+a4JriSzeMPCFX/vgzOOtwrW7UCikdLk0V8fibsouTg/aURG/NIylOixv2AHwqPJnuGOk0n5euI4hemenbGlg8aw==
X-YMail-OSG: F9WZyNIVM1m7fNvno3sS1SmYJmPHZZzcSDCCCHRbVzUa7RBVNIE9Dp2O8lh0Stz
 ZcdJnbdwOkoslgkwITdrH4NPvnDzH.bRUJ2nMNtQ5Jk3Qg4XlJXGRGOZo4tAPjyCTIolucqltbUm
 Y8K1nLe0VpTPfcWL6qeNx4.lxpri7iefey8yXkC1_cwHf1ffm24xRampPPcYSDGnk6VtYwsiewSt
 .ghEoyTqYzbPuvFOn2ZfNlcD39WsZqCCGgHb75i7XndiifrEcanbuVrnDYje2yASpFPx5HJjovFc
 q5LH3xdsIeqbxz1YCOHIG77AoeBUnAqLWDLBbxn7siCbl8qs0LEFK9gOXdQMLJwzRbYbn6se9Yo8
 5GRfT_f46gC0t6ub5t4ieJOPSuFy1t4XZ0CckKz6Aeh9UNnxa8Zjvuk2wLyd5CV8OuoUFizpnTgd
 7NmZqQ2K8eATus6XNICDZ9xCawyRrGpqp43lFiIc1keGmx61N0I3tgbbs7Dgcc9QMSaA9QRnRpIw
 n1OPR1KZxM9p6LSvas1n5s7zZcAoeaN_LZSC00z4gpUGKhCVi6iw.bdz9ex8Hny3..N8eaxFYCpt
 PuXWrvz8TQSpFx45aJv8fJHV9oP2MVu3mt4Jv1LkuEcztN6_S6WYFo9oRqVzPT5v.wTi6VY5jD5U
 35cHYUPMeYIydsU8BIvXDxzgrpjCOUFqJ3mTx2OrczwGCJcQgS77M.LcYvKK6u7AYEPUM1PAX4k8
 pGFyC0u7brjmoGf89GFFfcdDTyr6yj4S4C17gTbqTWZr0Q5gO4VDiD516x6ogZswkQPBC_hV95Qs
 cupTE2eYsis5LhJ0FyMwvyLYkU4yFAwe6bTsXsc2X.TJ9rSPImHnWJ5VFF1RAfz5GItVSmhh9LCn
 Ez03Ttw8LmgsN2Y7Cl9tEAZFNYcN1oQWY2XGIO5K5lhWys383RMwFbqwLWpzNEDGnWjhmpGQ8gHt
 rPul_oVHvOQCJO94PqawouP0hmOzWn70fX9AMSOA7cI83pae3_7ymrpBTda7pJNXrrPY2syiAQMG
 5kgLEGI5lXkv2VP.QgOtnr1rzQPtvkivAn53q7IEJXiTeE_JYO8dRJaEXGqU8d1E_Qd61oGEvFdn
 OuIxnaxtz6o82Yh9GCjH84o0EPCLOt29TAdhwBiTiZHq5KfP_k1PppAZgczTR9S1k_1BgQvIIXma
 kLLVkhbsM9.wxo.eaI595aRYDmua2yzh2VvQVzr6g52gNiT7_nVEx6JEt.k.1Yauqa1NNkxKdn6o
 ODfGFNF_PlUdp3wqKYCRFEv1ZOebKkHl3OemvhaWw68Qi1qJXFajZCFCXI3QsQnf2.iwCBabszjO
 atrSeMw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 11 Nov 2019 19:30:42 +0000
Date:   Mon, 11 Nov 2019 19:30:42 +0000 (UTC)
From:   mohammado ouattara <mohammadouattara27@gmail.com>
Reply-To: mohammadouattara53@gmail.com
Message-ID: <383819251.1749023.1573500642450@mail.yahoo.com>
Subject: I am expecting your urgent respond.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Dear Friend,

I know that this message will come to you as a surprise. I am the Auditing and Accounting section manager in (BOA BANK) Ouagadougou Burkina Faso.

I Hope that you will not expose or betray this trust and confident that I am about to repose on you for the mutual benefit of our both families.

I need your assistance in transferring the sum of ($12.5M) Twelve Million, Five Hundred Thousand United Dollars into your account within 7 to 10 banking days,as one of my Bank clients who died at the collapsing of the world trade center at the United States on September 11th 2001.

If you are really interested in my proposal further details of the Transfer will be forwarded unto you as soon as I receive your willingness mail for a successful transfer.

I am expecting your urgent respond.

Have a great day,
Mr mohammad ouattara.


