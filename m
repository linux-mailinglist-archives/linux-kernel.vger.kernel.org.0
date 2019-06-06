Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B1937D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 21:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfFFTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 15:45:14 -0400
Received: from sonic301-3.consmr.mail.bf2.yahoo.com ([74.6.129.42]:36535 "EHLO
        sonic301-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbfFFTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559850311; bh=yqDabFs/2ajL4+uqvl75CNrBfWTfbOsHh54Xr0A4zFM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ZGz9XHYHMJh23VX4A/a3o6A6CycaaO66drqBAmEv2OyJlrp2ri4uYlVoJUfWuDRuUR/nmdCnht0RhYz5Q4UESUU5PptgyEwZui52FXutLlbQ4XmZDPS2UUI9nP2lyuaf/vVRucDMAteI/vpM0r1ocB7V9yedZP6FGalxtoosISc3cd8aJ0YOCdCYlv9XyZbDLdl2Oq881Upf/0Lga4RLLfiia4KgaiscOYjqN9hW1UxGkj2Du2J1GAM/YqZ7ZVkcFwv8VZ1+dYoBR2NaaHJahPS2tsTlaqHDrYtC/kfLsGyjncINI3YW8JgLyOXybQxSI/Q40Zb7tWfwzN7dfheLtA==
X-YMail-OSG: FzAYOSQVM1l.PGzt2H.vWSH.BrSejP80IwwC.g.vDHiRVw49Wlf5mGINBuyHiny
 RVBiFGgHc0uaaDmms.waZVwjcDLlc_3ChtK2.HdPq6Kr4H5PhCLCaa0bJTNBIajSHP0bmEToh7oD
 2xp2afYr95ljqg7l7zbw0Y_tD8XV8ViVrAXhMHr.3xwv3sq_9FGGUIOY.82lNDfRngUewd9ItMiO
 67dJZl3AXjNxDN_BOWSPMmwpCjlxfxLBjgqN2jM6oOhhHNvef85qHguYCvQCcuiKzC1Fp0jXeIJ5
 2oHcgU7h.CTfbTsbHFsZ7naKW83XXzxTJEjWZP5agY7olj0PvsCgBJTS085yC36lRkSmakU.1WKm
 alTXXwrCZbZHItdR6MfQYvK3xy0QHy3sC0VQj4oVfqrhsoZMP7VpZop5p8BpIOev0bweeqWqH17a
 8up5PjrelTs.enNFIpUv.o7YMhmLeF77InsPYdpgasIfnnFxLyx6NuBsf2oOMMHOuzyXMbdzJs5W
 tSBeY6m7DS8mXwpZ5ZGt21l2mG93U1DkW_u23upjFs_MdYGWx3nkZ3ZCTVJneL0DudpXf84XgFQd
 ZiTQjNZ0QgUxmxEItfOq2QUIcyCDj3MGoZ_crhIsMV_kVeZUJRn5lNb6y8swPTIu_jtbmGfxz0qW
 4yNoDbwhQl2VOo2QeKP3hTmXOYPFR2HtTIVlqLs5MAen0wOXh9GK4memABYAck37bz6hjKDwVNLo
 xnJVxFu50LrIIkv0fVNA9xe3SH35MkLiDhODpWror9i74hb._H2ZXeC9ZJR88Uhh2GOx4uejZi_5
 Y56n1lTqHpsHXUPpkWGoUmXmdvvqemXtEOJktj0YU3lgyjxg15M_Dl.tduMCsF1Gke7bb0i5VN6.
 i..Sffx5vR0qyM8aijrkEZPbLIGRDLeRS3WhUi8lBMqcSBS8iPb_OOLgvmHQYF74Oayk5fo8MK_I
 jppHB_tO11ojbHkX6Nt2ERBuuIitdkeqWkaVvZktRre4xrg2Zuj_Gy3Uppp0bJSi4YldMGicMBk3
 uhPNANJ3DQ4CU5zE95Hk1_U7OaLtVfN6dKl5RgL13c3M06n6X_VJV0Xe532hpYYbL1p0sLPZwDBo
 t65scODEu5Ym8_LwfVOpswtAOLoVtorpqe0xPVLofSkxgJsWCKIUXrQ789jeWZlIHq6IC5Rjp6Tt
 4ITdIcLPUv0Jy1QICxjJImovs_gDz6sN9Ku0Y8S5hbADXsLiJInX_5TZQgJk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 6 Jun 2019 19:45:11 +0000
Date:   Thu, 6 Jun 2019 19:45:07 +0000 (UTC)
From:   Elizabeth Edwards <mrselizabethedward1@gmail.com>
Reply-To: Elizabeth Edwards <elisabeth1981@mail.com>
Message-ID: <1394480549.961492.1559850307304@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1394480549.961492.1559850307304.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13797 YahooMailBasic Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

Please forgive me for stressing you with my predicaments as I know that thi=
s letter may come to you as big surprise. Actually, as my pastor advised me=
 to reject earthly reward and thanks by handing the project to someone I ha=
ve never seen or met for a greater reward in heaven awaits for whoever can =
give such a costly donation. I came across your E-mail from my personal sea=
rch, and I decided to email you directly believing that you will be honest =
to fulfill my final wish before or after my death.

Meanwhile, I am Madam Elizabeth Edwards, 73 years, am from USA, still child=
less. I am suffering from Adenocarcinoma Cancer of the lungs for the past 8=
 years and from all indication my condition is really deteriorating as my d=
octors have confirmed and courageously advised me that I may not live beyon=
d 2 weeks from now for the reason that my tumor has reached a critical stag=
e which has defiled all forms of medical treatment.

Since my days are numbered, I=E2=80=99ve decided willingly to fulfill my lo=
ng-time vow to donate to the underprivileged the sum of Eighteen million fi=
ve hundred thousand dollars ($18.5m) I deposited in a different account ove=
r 8 years now because I have tried to handle this project by myself but I h=
ave seen that my health could not allow me to do so anymore. My promise for=
 the poor includes building of well-equipped charity foundation hospital an=
d a technical school for their survival.

If you will be honest, kind and willing to assist me handle this charity pr=
oject as I=E2=80=99ve mentioned here, I will like you to provide me your pe=
rsonal data like. Contact me through this email address (elisabethe1981@mai=
l.com) and also send me your private email address.

(1) Your full name:
(2) country:
(3) phone number:
(4) Age:

Best Regards!
Mrs. Elizabeth Edwards
