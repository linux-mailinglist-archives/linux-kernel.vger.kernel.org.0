Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0AE9E3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfH0JTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 05:19:33 -0400
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:33515
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbfH0JTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1566897572; bh=yqDabFs/2ajL4+uqvl75CNrBfWTfbOsHh54Xr0A4zFM=; h=Date:From:Reply-To:Subject:From:Subject; b=C6dap/RfLrk/cntXBvLS87DmoED1nXnVf3cqkYtd9Er0e7UolW6OSB6u0Z15I5PwBxKBaS9xb9sam3yK2+Bgs/oR+GQFue+DPK8rtlKdQOGFNf0OA09Es6R4AXp9lWWbjgCxDsa6EPUPO1IHEkSZ4vWpzCPYFGu5HsBzB1VxKgRtMzWIrAG/71RMfBh3mKzmxNV5O9Cia/YUAwRSJVKhl4veGFQDGA9bCMdOzeqMrxbeb0UQQ5AWP5jfnHorwwbXSxKPWRKJXwvzVDt0av/kUTxQ5y5TC1LWOSC5naov0c1p5LGXlnl0CJLDjUBsP7YiGFlta4GINTCTLl2BfqLlUQ==
X-YMail-OSG: UZ5CBhgVM1mpP5mMN_fOTiMOOJ7Fpk_MTTERi8A3TNSUIvs3BIzZ.FYrHzNkEvo
 Kma77TnOyRTe_k874DG_XI4VKG8XQLqsSRhilbfjKpoFddq8FQnn7c7YKgb87guJ3NJ.lYtlW9R5
 QGKyyWwckhofBYx5hW5tIXS9lct59aD5xXGiOLwg6P7ZsSEq63VldaIiINmxvIorZECmXcc02kha
 Q9UGS_XhFqjY5_SASND8vuC0KQ1RIZRnVXQ2YJ8r2.yoPqI2.UOzJlFeFOmKJ2Vl.Je9XODO0VpV
 9kOP3qKHTTH7aqstFPrFIGq0d2n3W040DpnLQXo4iUmURht9hQHdjDzp0LTTC1TVKuIg4tFoE.2d
 6w5A6kRzDSfmSYCIkoREY.2zDabfYyxiwft9KX5HTR9U563HfS5DncWOwZ2bL4gSV2VhD5LMDYHi
 x1I8MtrvM7ZCuKv1zkQPBI4TM5mI8RjBngNokN6ZaTKKJ_Pg9ER_6bHhYxvzjR8eplzJTeodrP3B
 N1c9XrXKrAcSHrMNRoIpCjhE37qy4M1F4gYvdAQ8aOv3zByig.KgKQRS1fi.ocoMEa_NvFeBlzha
 h5I2sChBmZM.B.0Q2pFhE8v30pNRhm62QFsyNiY3ozK7LxSxG1g3RrALiDIA5cYCT1NMjIJ9ibNx
 WgluOo_5WEP2hv2oSVQWTaZ7eb.R1d2QS6Hv0d.ky7DAOc_ZwvvzawtiEY0ctJCmidCkStC92kKo
 cS_C3frNjppEGejO1xg_DnqmsyFev6JDWUOTDO.HWcQU4jhmSTJHrenozbZMeAoWgBRv0fyXOZgx
 3VAZtRrOzGmZtSzwDtEq50MOawmZvW8T.VEDJKNZk3.kGgnve1oNkxeg0_zGGYPcNpfttQngtsvh
 P8AQe_sSYR_AUX2rYG86LeW_DlYmtMQuarluE99W7IAcGpc9d2j6P_.IO_eClK3A67FG6hL0kFXc
 yHH.PBYwfJe057hLNnNxtZ.giTZuGWhA2eDm72RnIRG9Xo.fDwjsW8gu_FJJbcbJ7k6EsVPuFdY8
 8gUsmcmJfTfzXWMT1V8Da4vVSGIEjNhPTc7.Kzf.0u6xbAoCaH9cUlH9lrWdwRapGIL66Wox4UN2
 5HNYK9xJmphro4HTlm8kldPPpQxlNhYKrUUUMxHx0ETH0wzN7aH.6l3KkLMb5Bt.h5YfCatzumCp
 L3H8ar9oiMIxHewvg57p9.ZeptWhJO1qOkchww4.8w2fj2PH9WOML2QMIOdxGsPJG3g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Tue, 27 Aug 2019 09:19:32 +0000
Date:   Tue, 27 Aug 2019 09:19:29 +0000 (UTC)
From:   Elizabeth Edwards <mrselizabethedward1@gmail.com>
Reply-To: ee3201366@gmail.com
Message-ID: <2026022299.1863383.1566897569081@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
