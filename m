Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5612D203
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfL3Qat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 11:30:49 -0500
Received: from sonic316-20.consmr.mail.ne1.yahoo.com ([66.163.187.146]:34249
        "EHLO sonic316-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbfL3Qat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 11:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577723447; bh=7XLHrrNeuD3sweOBz5hpItC24D41nUTq/oGvzumZYN0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XUUcU+irvyE+Q7Lxk/l7D57Hvq6vb327ahoCuT9qdfGACCtl3OHEIV+dj7Oh3lVuq6vjR68z1KVGOKKOOAEQKFTL0t2oBDCCo0J5k2K7OFzB2mCEAIJnAT2d0yZRywJ799euRna3ABoUecZ2TAuKwmEJTA0kYSAjGNcz9cXLaP1D7Ab1f89gCD0poam8IHnmdFzu2j56ksEe+RUTBTpTSsREUwdXqzZaT9IIYmnxrKFsFMeQaFo2ja/gKderfYx8d1ilh7Lt5eTAJOku19q4XYhx8R3IhJnbdTaNwClvoQ24pwLIuGPkqNBU7DKl+7YNh3dpEVYGoyXc2ocYVm0iqw==
X-YMail-OSG: DHufY0MVM1lGVDx.qwD4OpTbHEh7NUyEtAHTa2SQ07lRzJ5XooIMAXSPVjm8xLX
 nMypIztBAC5L.uoP_wyxpI05oQnYZMB1ahFe0VnFVxDERaMJOCV6.nz9a_7kkcYs4mnPrO_Ke1hO
 ffDSvLTY9552tDO2WhtjMSm7saNuCOIkpljclIcvfF0IRO.XvwOG8plAdW9GCH3pn1_PkJPLLG30
 sSbKNBsaxHainDBHa3AYtlqmM9nQy9kNayn2jniG0agrrHMm6Bd6gXls7JCsPK.OWPrIPzkkduQ3
 dlBRE.WQUhs.azzHp85wrvA8VOjajGjtqPXYnadvgryyHmVAIs2ZsTDNE6gnTrmPAVJo3DnQpWn7
 3CgypR8giiT0UyQ7ET1osjM_Hju2IXe9DbNZqXXCtm5ltGLZC1zoOepB1FLv6YTOYByN0_o5.Ajf
 mi9b_zp5v9wVLAshVCJ5Anbl6.nqPK9rTjj785UqTz7NNVAqe2Q.IePGMwH.NYCk8m1LQtAWfczV
 3enJutwjVT8shE_qBcWu3n4II3JMm972NlmJeul9eidvI6wniSPLrpYttwVSz4VjjzVLUgBBcMhs
 s1QSPul2W5kbyJzPS.YevL0V.qwrQwkokUwuncyEqczBzrnjSof8dlyZ5KTI4yhAwDNE2m7n5ZBI
 xJT3.fwKB0GL5D3eAO83IxPy9cKtKFpzLNiP2SxAj7.Mi2ZVN.NlZHuqU0XlFU9hf_crwrmtA6c3
 dcxrrt7JK9HnsyiXVqrsnA6ngsd_dbSB2DbUkOksPIb5aSxELt_ag2ongVM.jkMpuwd9282eA6rw
 Zkp3TfnczdfKqnngpI0ix5dnMJo5SR6R8JlXtbDGLJFa8693KNynCQU7PQ79qGov3WRi2CMqkx4z
 U1.WHjJc.YmN.JROHiYF.c31IiAtp9bTnuw8kdIQpKu1iA5uVANWIe7cSwr.3PQnWaLhMFVWOJK7
 tyzc_xsHpCs5EbhxT5kdwHhIcXMYqb2aZdznWHTkpLB1fwzFGaV0q9HPBCUdzPyVoFNaCwvn0wdL
 zJ.BDd6KlylWFbalIQldgWWXwnlNhpts5.X240OAl25UXMG0.8LQJNV5hCho0xuY9z1eKuuZXrj1
 pOFqQaddjFGifRXP7POA6e66SCtr6t9iFmuhP3MVObaAOS8iY3utcO40.mqcX1jbNaXCH1h16COg
 652mjAla5Om1VD8aAXwJ5YeQpByv.JyGl2YyJLaGx9TtHdstenxiRwJC_o0MsNMu6kfBWSHceWJ6
 63VfweTMtiDFfXVUn0nsWLlh47H2EDBO9rcme3JdsjFIdvfkEDNvHGkBhofI6DWu3UiQr_0ilqIj
 .tvTfxFd676dXyV3Vt2x8bveN8AmQ7M8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 30 Dec 2019 16:30:47 +0000
Date:   Mon, 30 Dec 2019 16:29:55 +0000 (UTC)
From:   "Mr.Frank Gouli" <frankgouli9090@gmail.com>
Reply-To: frankgouli959@gmail.com
Message-ID: <567990858.4900153.1577723395886@mail.yahoo.com>
Subject: Dear Beneficiary,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <567990858.4900153.1577723395886.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Beneficiary,

Your Over-due ATM Card Payment Compensation fund from United Nations
Compensation Commission valued US$17,750.000.00 has been deposited here in
the Bank on your behalf. Therefore, re-confirm your information such
as,full Name, Address and Telephone Numbers. Also state categorically your
age, occupations and marital status.

Immediately contact the Coordinator Compensation Unite .Mr.Frank Gouli,, who
is in position to release your ATM Card to you.

Mr.Frank Gouli,
Coordinator
United Nations Compensation Unite Programe.
Coris International Bank For Africa Burkina Faso.
E-mail: frankgouli959@gmail.com
*****************************
(United Nations Compensation Commission, MAKING THE WORLD A BETTER PLACE).

yours sincerely,
Mr.Frank Gouli,
