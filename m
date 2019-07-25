Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568FD7541E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfGYQeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 12:34:09 -0400
Received: from sonic312-24.consmr.mail.ne1.yahoo.com ([66.163.191.205]:35104
        "EHLO sonic312-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729288AbfGYQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564072448; bh=A1UGk6bgvVU0igLO712Yqx+eV+DhLn5JWD7EaLQraxE=; h=Date:From:Reply-To:Subject:From:Subject; b=VdTyaxgN+zR4UPh5ZnQvWbFgbhi0GuR3CknrUSTEwr/TxD2iCx+uFMIidy/F/kpGGrNL6x3yzPdlcxRiWOv63af+5E1jSFWsbpwP7b8F4dAn/QWpvZKtO4yE+0pH24JBCoewHBXPgo2/VVjNI4Ui/zCiva7gGR/V+T7zgFfasbT6HYoM/N11ANH+tKZEbi5OUqG5MPBSoREAqtj+/5pWdD943ZwJMRsMH2cT8RaGR2tBjjPKueRBH4sH0vK5hzg7ScY+Fc6tp+1RkmapV84zhtiP66hABF7n+Npb9cRYqQtWAJyuVCCEUzMFXVwDwvGu6Hr6uLU3shq4xoJ/tQtNaA==
X-YMail-OSG: gSv.ENYVM1mI5OQ6TDMeTvesw9Pw2jVgp7_GJVVQrZpqVCt46_p3Q_3XhpBpuke
 0oBNcIb1ROGYepGfkvF8J8qh2rmYjzBue77N4GdmVYVV3ExL29Tt01gU4fs5d.MohmhiCgEZP1Zl
 gOxwDuJxXvK.r9M5r_5xwtSHF74uxvT1VNZG7F07g2NgAG87XP7j3k5CaacQs6hPP_8ByOuOtDD4
 fp.P1EYTHT8VP2Rf9saG1tUuBb5obvryEYDrNo8v6qO3Mny8qmjoUwQJntWkXYBMuWN9Kd9zKqnI
 wLG_8ub73B2b89v4eVy6E1Ay1KYHrHUZQybmsKaJieMqaJbUZL2JMWH9pspX9vn.SJWExIk5KQQ0
 .skJzINmuQxqkWTfhzqd8KCVq56Sywr8yXik1IuUyFog.T8s3zOIBvntyzxEf4c9crqF_sEXamJR
 QNuOAVl9ero1Da5hbWtO1RjCxuTvXoOWNWFUWX5Hl9aEWIwJGbOC4fp08xiQa00M2IL2rHDHt.o2
 R1eNWZOWkjqM_7aANc128ljwXBHGt170AUSaXLubAvuX3SZeUstXlD24aFvMceRvMCsj_X_JbmtH
 Io18Q2lg585YcXyEmvIMEChThhX5KOLMUdwAO6P2fd6g1VuDZSPs43MuNOGVnCB_O_wOPtnDJDKN
 VEdtg9UxKy4k5nv75RocXBLAyTLRKUDSDAKq73o1EIzRzLYBk5o.gMgvu93eckBu2cetVSC_JnQ1
 Z2VjHcOuLRNB9URiqocinASvMey.qj3TCkS3A_V_1GqCwGQk5uVIH86bpez85GkSZXnzkpSMAjmO
 kmMq1SNUL8akIS.jQa6L9nJZoUviF0DYMJKunATvV.9NpKfMIDExx3j03IjiExr7FmRg1BDSrNBP
 qgGCKrKCxo7owAh2rgJk9M8CLkGqyI59vquPdxFZdU1aRzqpact9fLN4z1MeMj0y3WwZb5Xfx7gO
 X06cC73YP0t0jVxLuOu1sqJ_kfn6fy342efOIilm57B8wupB.psOMM1Vmwy_BQy3ZWVm7UwcJzv2
 0016JLrpB16vh1fay_pANkzvFPxNOaHD2Ju1DNQKI.ugmSwtXBFdDDvTrav6F2fuj6K.wDoBL.J9
 lj2YTzd7rwrCe7HaIRdiNPw.aJ9S5bifOuIBdex61ltE2s.V4XOtbRiuFPtdhZhRkc0Y5T24.dtk
 gRBOejcdbA.7bBC_IMaXigb3KyCxcEUt99T7gawkH7u5WIWID86s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Jul 2019 16:34:08 +0000
Date:   Thu, 25 Jul 2019 16:34:05 +0000 (UTC)
From:   Ayesha Al-Qaddafi <aishagaddafi1056@gmail.com>
Reply-To: aishagaddafi1056@gmail.com
Message-ID: <142321729.959648.1564072445069@mail.yahoo.com>
Subject: Investment offer,
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
