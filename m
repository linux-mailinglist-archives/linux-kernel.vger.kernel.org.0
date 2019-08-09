Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF2876C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406224AbfHIJzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 05:55:25 -0400
Received: from sonic307-56.consmr.mail.ne1.yahoo.com ([66.163.190.31]:40301
        "EHLO sonic307-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbfHIJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565344523; bh=A1UGk6bgvVU0igLO712Yqx+eV+DhLn5JWD7EaLQraxE=; h=Date:From:Reply-To:Subject:From:Subject; b=Kk0vG3U7X8FBm4EfMRyu+rW70p7seIhDroqgedUooR7Gexngf1jopHcNU+gobLKuid1/ahX8tb4ZJQkI+09k+A2ZtXcV+DZjFJhGpQYFQEahUjF9D30p2EXPFnMwQZpHlwb9mVoiFsVN1HYEBWV2evP1UjosFXmRL/h1hQx7r4AnXn6T0aIKdrmlP0fD2fWVFr4JlpZlR7uZQ+EzkqyQZZJMb6GJzytc8u1IgqoSOC2mfsczECkBAQj2duLIA4MXr42KOY4SzhXhDANpK8DX9GSURkZkxOUyPQGVPyxezk6uakcaQcMMhBSwlaniiupHBXXg4DbO5TW1YWChGJSYcw==
X-YMail-OSG: DmQtz.QVM1kpuo4Jk4RKEkuOf0Om_IhNwDpwHmU94pOvoUAdK6r2V7d4qK6lQH4
 5_eDKEOWzqmeAMHYE0oeUcQg_PRWonPPCHw8WSyw.TfAEJqseDms88XAUyU2Jfb5zy_xECyoQWet
 OYrClmHJMI1BrM9x_N_zbLpakBhucQ2HJP7ZJmCsxoI6c3RmIzYeDzBjD.jJI3ZSV2f95dNtjlzZ
 Jz2Do0wUBwugLWjhqL706TK1KDKUF0SYwU8HtakmxTMpRwgza2XEVgWn08ccVqL9ZnsymcUxrcbe
 ubWFuinsPMoZCiHONNhldkOQgaLNaR5ZI76W4WEhxieLbBE5TCFYU.Jxb4mfy9b7DLdQ28.KwH15
 0gdkSuOC0fv8t2owSNg6MghMU8esJVuXuEts5dDMz.Z1PhyQ81lBHzBMLhyqMWF.wCYm4gAvVJZ1
 auqv.7E194U6MNrs0Zw7__HpqvkaZ67r6AwA5iVexdUCsR3uAUwaUA3l2WsPjyADmQ8WOOD4x05s
 vCyDaCCZUde6etqzfAHJHHFHslsXiKQPHDQVdIuQ7yuPI0iaxrRqT6FAzFloAdbFxliyUmbDlqRo
 _LMiA7brKSQLdkbOjl6WojmncuWVnc0E64jMQSmAs6ZnfqLTYmEjrXaItZjNppAK_5JjNHqO.gg5
 XN4jR7rZG1MeKeslUUvZD3n7J.lWNMikB5UOPYu_v9Q70sOWQmMcvxlccA3bEibrWdkkUMp.fjnt
 2WRqUWLzQDprm_hiS0ehC1Y080NiSznDfAtQTLXnnPB2KGmIT2rStPb4SLVn0Ubbd_Gznwn7b8LH
 .9hO7mzm3hGo7BS69y1Mmzlcv5xNrvx.wl4LbV4lg92elOzSiVz3N2iSaKXkzCFRtFh9k82giyq4
 Jr2JWNAF.L8K493TbXLZPuYv4Q2lBmh4u.QTVAsYAeuqnISWlHEFlQaUqwuhRoVOiEk7ETLnh0De
 AprzaShTuzRxr97atIw.Jmpjr1y3FVXcqGSRj1Pj9xOeOTyrMdxasEO7eAr0s8VK8.ntHVXaYG8h
 paRfFdUXYbFqb26uasJK_HkGU3GXN9RByWvYC8TBILUWlVXP2972SpvJql3EMnqMqj2YrD7eOAXr
 GJ9lsJSGUtPPi4._pEN9Hb1P6BkDGdj8MHMiKp.gQHwMUwleeeahoYQlmwVeUwnHl5Yh95EZ4sc0
 yeCGUA6k0Ab.AGScvH_EqVoQ.1Wi66twQCRvDpFS0b_nz9nWpRTOc.NqgTA1oiBwa.X5zbAON
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Aug 2019 09:55:23 +0000
Date:   Fri, 9 Aug 2019 09:55:18 +0000 (UTC)
From:   Ayesha Al-Qaddafi <aishagaddafi1056@gmail.com>
Reply-To: aishagaddafi1056@gmail.com
Message-ID: <1632677843.3163535.1565344518905@mail.yahoo.com>
Subject: Investment offer to you,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

 It=E2=80=99s my pleasure to contact you through this media as i am in need=
 of your urgent assistance. My names are Mrs. Ayesha Al-Qaddafi a single Mo=
ther and a Widow with three Children. I am the only biological Daughter of =
late Libyan President (Late Colonel Muammar Al-Qaddafi).

I have an investment funds worth Twenty Eight Million Four Hundred Thousand=
 United State Dollar ($28.400.000.00) and i need an investment Manager/Part=
ner and because of the asylum status i will authorize you the ownership of =
the funds, however, I am interested in for the investment project assistanc=
e in your country, may be from there, we can build a business relationship =
in the near future.

I am willing to negotiate investment/business profit sharing ratio with you=
 base on the future investment earning profits. If you are willing to handl=
e this project kindly reply urgent to enable me provide you more informatio=
n about the investment funds. Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Ayesha Al-Qaddafi.
