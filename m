Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6ED108D95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 13:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfKYMLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 07:11:23 -0500
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:43062 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727149AbfKYMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574683880; bh=LaXYIwKyp+iUHI4E5pVeKdh2/ANzSCc6varEg/7+mXI=; h=Date:From:Reply-To:Subject:From:Subject; b=X1BrUDCW+55srs+BdbaQ/n9v4/yano0zBw8sLLitcZM6aOgNLxjJXFuI2oLW6ymEt648uxUpeocy+yahL0/Tz2sdKYQ7mAgvgG0mYE+n0VDKIrQ44+21Zrl+FCR/uDFEwuyZBObrhRGNNXUw62gYxhhQDTMh/C04LSLSRPF3d/CNCEyp9hcbKmwlY9fzpWA9vYWOy7PW/pemsVSj0dToB14ZfK+VMk8O03r+amG23jv8DYGeZE4giI2wPOOKMxSnql/GG/IliF5VZ+tnx4gZqxh6PvP6yHaUc7GgaPfdWi/diGvf97W72dqA68PyajlHofaXqPN+2BS8dr6/5rvU9g==
X-YMail-OSG: lAVLFrUVM1l9B9.JgrBcRohzORXcsBKVUriLbmX9fClhW4sxe9l9xcUdDkSruxh
 9Bx8lgtggSPcMYVyJj_6rsaz1O1ArHjLq43gj7XpDQPqj.d9bZ4y6Axwn6trEEKr.3auEe62UBw4
 4lymFkB7ZnMPWrv9yxgw9PpIx7Rt24aToxIvLQctxFQJBR8v1DILDD47Pi4uXxPoOTpGP8iCGh6.
 Ig3NyDF51NxosiXZ4GpkgnSpGLiDDb18Il5Cnv._cKGmS3Ca1equQs1Vug1PETxSPPr9pN4dR4Gy
 PW8cs4yxOFtoGKYnxm.1IZ_ZfTmis2BgfeEZbgaeElexbnoUcOEXhNkshCHMcQAJnhER.enkCDO_
 m4bDH1itNvgnBAXzfr.mt0KXrDXSAFSldjjxDmsrSwuObLDDvP916ul1Zn0mqq8CF9mLV_WnlZFl
 W95EMhWhG4I2YsTQoZX8rsMHriAHQebc5iEuqZ4R2W4Ccpq.yKOe6mfxbgww29ZOabbff.wP4pLP
 .826pHCG_6Hsrq0vOvqTUxydR6Y4fzZTETuYEkUr42CxBMl4evOQgrN7y77lT.5ZMO87cKgq.pjM
 8SNuKXoAK2va0VieD.a8vcBM__zF7Dtnmn3sLlvbg66GsJJAGlorEj.xfU37.mxb8qfmRaYEiwte
 RFDpxaiZf5LMGWRh9Of3uieueA8sTTyp1ZrAD9CnzMezAmBUm7XKihz4EQ_G7P0haqKgveGoh9tW
 ecxVFLkaTbpr3_mhiUw1ilOYw7spsBFFrDRsVjzbiW3ZG77091gqed_MMOSU1Fnn1p0uLgzQcAq_
 H0_f12RDuE0C9wlBjzn88ps61oj07xj69FN8u_HS2zyL2jmBsiuW1BIqey8SANbjDXjPq_Lm50bl
 _7lI6ksRNpVxg3Xw0YMi7U7zfjAy1SzRa6BmSluozmPWbcxCjZ4BPyC3bVWRv2teXUaSPpJ.TIXC
 eenu.iinjd9u7xq2ziztkZOg.j4NekOVuerMr2mZ7bN63wSVRBvfP5hYtCHRbOQQQCRQlNZW7Pbc
 _rvBMCJgc5yZXV9inyze_e2Pzmi5eYufrpzlWseu4dmO5u6FBVV4lZkZwav_.w4BtI.skHzvNHya
 .OkaL.7KYG9tIIKPssL6tnFPwyHUrPsIr9VFdJWoMwy6f4l20tDNC4QER1IV1HYoybNinhr5MAt6
 eR.f7.02l8RKa1MMYYj6JVOimrsQ0OTYo2Wmd5O7nKv.ajUNUVhF1Nu3AiJ0QV2F_jILtpFnoXxe
 hxEaeKoYPsc2Mv7KmX40BK9G_vZMzbDW48rfAjH8mVffReZH7GXnb9Tz_lazc_GAzb4dgJbj9gGg
 xu4UAZT2n1DznahwgV3ErcmaxIP1PjQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Mon, 25 Nov 2019 12:11:20 +0000
Date:   Mon, 25 Nov 2019 12:11:18 +0000 (UTC)
From:   Hanley Bolly <hanlabolly22@gmail.com>
Reply-To: hanlabolly@gmail.com
Message-ID: <1144842412.3232276.1574683878606@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Mr Hanley Bolly work with the department of Audit and accounting manager here in the Bank of Africa,There is this fund that was kept in my custody years ago and if any one provide the rightful information of this said fund that the bank has no option to transfer the fund to you as the beneficiary of this abandoned fund.

I need your help applying for transfer (US$8.5M DOLLARS) to your bank account. I have every inquiry details to make the bank believed you and release the fund in within 8 banking working days with your full co-operation with me for success.

Please i need the following information from you so i can give you the full details.

1)Private telephone number...
2)Age...
3)Nationality...
4)Occupation ...
5)Full name ...

Do reply me urgent with this email address below (hanlabolly@gmail.com) for quick respond.

Thanks.
Mr Hanley Bolly.
