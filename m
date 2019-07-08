Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F8B61BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 10:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfGHIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 04:43:44 -0400
Received: from sonic307-56.consmr.mail.ne1.yahoo.com ([66.163.190.31]:33783
        "EHLO sonic307-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbfGHInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562575422; bh=A1UGk6bgvVU0igLO712Yqx+eV+DhLn5JWD7EaLQraxE=; h=Date:From:Reply-To:Subject:From:Subject; b=uRycPEK/lZBMNUqWNV6t6oX5uicfrp4BIZn2Q6YTyX3sfgMXuUZS/3PVN4nGAd6oN0YxiP1lAS+F0H/1if3SkmKgJRWS0K9K8kFncNoc+vnIbmD17fOh0940mq1MFmnocfA5AS9+EBUT8GyRAyhpaw0OZlBTnZg3zyNM+0KLTw9UjwvvkXDYhtva5ezbNXE6dzmj888JavN2k5BT9IqYtBk3DZFgYb18AV5VFKhx+eZnpqup577+MbJz9EVn0T5lKiZCiQwCGeB3+gF2zlfHWLbUzzbkpCzTb3gHufqXbJ37MrL3D7hlCCKKiodXMo8MyT2iFysZXXcDIbCkhPmpJQ==
X-YMail-OSG: 6ds5uj8VM1nY6lAqJUgG7Yo3pFxRLAMj2CLt_7hbbBXEUGoa1cyhMp4ZnEnaYol
 MTezQv.vXOqu3t6mN5ovuJl_Wnmcns8L_B3X.LkQdsx6p8YbyZQPGpKDDbbAmk0H8f3y4AbYebdU
 FzScdlLtfWbwNbfqDE6prNgMuawvZkDfHl6iyz6GCp4VtnXym7fwowPkdMucnuAcmu5ifhrhgdYP
 Mrl3n0e_h4yxok7cwrBVKyvwE4R9lT4zSnhp.DK03XatD.p1mir_w0qnRp.t08xkwbkWWWo3l5yS
 S1bzca1iKFOJPm0VjS0JFF57Jc3lRn0..FVU7XL4_2UBdhlAgcmQkFsI.NDcKcjZKQ7z.d2a2vST
 Y8J0AD6rLldLZosQ5R574kLrxwC1JFbjVv7FofJON37.0EoLiFndCSbgI0qOtdRFJPurFIcK60ea
 JBJvYKqunGh8xoVgshsEf1iU8ICrWBFagAF8nJuco2a_wQB2AuDxuxSEq16tDh9siTQbGwiMiczP
 rqh90dEdJqnVGceP3JYD6z.QxMjyL8ZOGMBjNCYA3GJzVHP_oUkz1oZwFvnciG_MgEMvINf23FHx
 xSQUqV6wXeZxpyrnTt2FvDcjXrKusqbpAhJjPLhbHndXz5vs_VT8Uf48M46Wszu5M_H6jV2U__Jq
 ZhSqEZDd6tfMGm1zgq.ThCUPBncUyDsqSeUvKP3To9T5DrH0Xvs.OuFhQLkYfAep5Ve6khG2xEUp
 SDrjdV4puXGcZKWfxP1xH_HJ0QAZK_EWlA0qtdG8tfv8gsLg6LIeRWuZhHoedF7wv4TcLiIcQCjA
 aYWowSnMV617fP_pJ.S29o7Yfnn0onvGoCpLJgjW44RkImbg8jfgXXuaXo.49Qq2pvM3oqijiJSv
 0BPY8Yxxpzpwf8Z_WVaPznWsSIW10m01DEva2t63pBtXyvifiVowlDXs7BW899dEZNb_GYE6ZJJ8
 V1bhoNkVecKqQQHg4fADb6fnpzFvacr1i7wbqg1ddNsBhdFhxQkq5hvJA3FhmuLvQ_iIpPWja9RV
 f9RLp8AUQ7zerSBsSlBOFWRIDJCTSFMyQBnigni19J1vI1MUbsmSyFozxvpuiAHSXFXBLdVQlyQW
 o9FlJn.mI_gPUAyjUYEiTMekpvKgaA88rC4vcIxun9W3AEGtk_dOpwbsmy5PsQnNtVywC2YQBTSa
 aqtuN1JiR6dyGCDpFuwZvELWSmsz7vDkwI2vxpZMEV7KWTTA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Jul 2019 08:43:42 +0000
Date:   Mon, 8 Jul 2019 08:43:39 +0000 (UTC)
From:   Ayesha Al-Qaddafi <aishagaddafi1056@gmail.com>
Reply-To: aishagaddafi1056@gmail.com
Message-ID: <1669382141.4187674.1562575419181@mail.yahoo.com>
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
