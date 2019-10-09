Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11ED0EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfJIM2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 08:28:36 -0400
Received: from sonic302-20.consmr.mail.ir2.yahoo.com ([87.248.110.83]:37119
        "EHLO sonic302-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727219AbfJIM2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570624114; bh=Y3TWFWuOTE5CQkBWoUgdRvykNtAy7iWo0XA1fZ7yQKQ=; h=Date:From:Reply-To:Subject:From:Subject; b=N/wfbmjJ8MersS8tHxPPxkAS6VJrhzvCt+w8V8uVJEdTMNNq9aXA0nNc2FmIsVNxLEMPiSaKaFoRPH7l+VDb1R7l1GO65C2aWUmHrNkmgG67WO+vwvpuYa01NWdcN6JOY9RAOhacJwKj8ewTWAyn7lin3vHOsoQG8rZSe1amC7tp08sSfT4BQEtk3PX3ENU8rZM+gI6vfKmvbs2DiyhM471/b12QxuBihnGlgGu8SZA5KuRMjwZJLdERivKKMijnr5rNPieWmFCFBelDMz4lMF1QAy2a0liLosiqD6N8ijRqqsiXFGawfeeyWD+NRcdHyu59sRRNfC/YOc+kNxdkew==
X-YMail-OSG: Zxk1SjsVM1ntMMKygoy784HOaGf0_.pNYIpvZ3mKWkuOxhtr84BFaIyqz7isaNQ
 7z5DP8cgHTkoUcQsmI8Xq1sh2HKD.XTXGS6ybHpL2o456NUzQkAkJtOiVJCiPRuFMszeEg2k9Ou2
 uggzd2muyIMiqpJDdEOjGngvjalFjJ6wHrFKHmkQcX1HuEKGab7lE4gq8fu5Sc.uYW2Skp0Q.mtY
 ueA127QU.YYdLTnr8bhbbnL_CWpTFffiWfrZ.OOOW_zRzyydt7PLGejIvUyOrjZphCoU2Aa2hO60
 sSYKIv3TI87RrSWQEFb_KcgEl7NXNuTCX3T986tZr3jp30p8OBXxWB4Q.421RCoaiqfLmtTbgYg4
 9DvbI2cJEOrE_amBX31raDrPsUkg.t2RTi7f4TipW3tiKrtkLch_5hwo.UrPjSozWYimDEfaY9B_
 ukFQmdjLCEp9hG3yXwDI3d0eIY2CaLEdTkDjjGu8t5MGcZp.Mn8HixgkHDvQnYZZ03o_PaDl_tq6
 zw_qyy9lRzs9uTJncrB6ggG0tT7.mRqEzJOCsAgQwvHWS4MbpcvgbFKk2_pqTCgCrSqECoTutcct
 QEv6ve50deGx0evP_RMUNKUbvGcL5eJ5dIJz8l3MhJRU6NHyF1w2BpVpfSzePPJ1lrK5CpgY3ODF
 2N5nHfASBPsBFn5S00J1nUfYyOIwD1gCTW8IuvTl5Mynu7eNDFzJE7HvAAwhkaDIbRRc6RN9_WbC
 7ovYZQVsVxaxYS303pBRs7TiUr0fklXrQ7oYyBdGhbaRAqqRbE4veyl0omUa4OiXqo8Hdxr9zAGb
 6sknzd4pM_bY2zaf9aJvObsNTpZVRbUwhoR9LLcDTXs2GKL7gG16fNQXjf4FlNCNf2H7ZnIcMv0k
 _p3Qi7B65KSc_7mhf51fb7_Sigyc7Tr0_5D.N2MGQY1D47POwZAR2y7FWCe3mbFAjeXXPkS7LFm5
 dRrgUYNVccw6OXA6_5.TCvvUld.p8xQSS6CJo_TcEhgj0qH7RVtD39PrqF9ZTXBYefSUOqD53fHc
 .MOppjUehM6kzV2tCwIvEEu1MKvUZTg0qmPwJB9SrUpIA4z6tUH9USeFlYmhPG.LRHoYkDWw4Lnh
 Dv4Tcek.BPtLFN5wUF9sfew.l0rf6J2.AO4fI5CGbkosaDvABqKCt2u3CoKmxc6tZxRuXohE9N3c
 KvkyOjmjCu5mbHzHOkSIBMBUQurBQA47zEn1F4Big2nZZAZgbLQMfNUnb4RVSDofDS9cG4MUSvvS
 tMBG54plxuo.1qhbWX5i97GEqd9TAerWdO5VdY2XvCal_n1viju0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Wed, 9 Oct 2019 12:28:34 +0000
Date:   Wed, 9 Oct 2019 12:28:32 +0000 (UTC)
From:   Diana Markus <dianamarkus343@gmail.com>
Reply-To: markusdian121@gmail.com
Message-ID: <1081640945.8572917.1570624112834@mail.yahoo.com>
Subject: Spendenfonds von Frau Diana Markus,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guten Tag, wie geht es dir heute ?. Ich bin Frau Diana Markus, ich bin seit=
 19 Jahren ohne Kind mit meinem Mann verheiratet und mein Mann ist 2014 ges=
torben. Ich melde mich, um Ihnen meinen Wunsch mitzuteilen, einen Betrag vo=
n $2,900.000,00 US-Dollar zu spenden, den ich von meinem geerbt habe versto=
rbener Ehemann. F=C3=BCr wohlt=C3=A4tige Stiftungsschulen, Kirchen, Witwen,=
 die das Wort Gottes in Ihrem Land verbreiten

K=C3=BCrzlich sagte mir mein Arzt, dass ich die n=C3=A4chsten acht Monate a=
ufgrund eines Krebsleiden nicht durchhalten w=C3=BCrde. Das Problem, das mi=
ch am meisten st=C3=B6rt, ist meine Schlaganfallkrankheit. Ich habe diese E=
ntscheidung getroffen, weil ich kein Kind habe, das dieses Geld erbt, und i=
ch ziehe an Ich m=C3=B6chte nicht, dass dieser Fonds gottlos angelegt wird.

Sobald ich Ihre Antwort erhalten habe, die Ihre Zustimmung zur von mir ange=
wiesenen Arbeit best=C3=A4tigt, gebe ich Ihnen alle relevanten Informatione=
n, die die Freigabe und =C3=9Cberweisung des Geldes an Sie als meinen ordnu=
ngsgem=C3=A4=C3=9F zugewiesenen Vertreter autorisieren. Und auch mein Bild

Bitte versichern Sie mir, dass Sie dementsprechend handeln werden, wie ich =
es hier angegeben habe. In der Hoffnung, bald Ihre Antwort zu erhalten,

Bleibe im Herrn gesegnet.
Deine Schwester in Christus
Frau Diana Markus
