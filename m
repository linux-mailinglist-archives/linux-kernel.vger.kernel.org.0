Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A84B3FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbfIPRrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 13:47:41 -0400
Received: from sonic306-2.consmr.mail.bf2.yahoo.com ([74.6.132.41]:39612 "EHLO
        sonic306-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732275AbfIPRrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1568656058; bh=FCjWGTqDRXQUUN8ivg02MDhbiDKrvltOcpc7W52q/3U=; h=Date:From:Reply-To:Subject:From:Subject; b=bT9o7e3of0HTEcDba68Zt7pkW1sa06+XMEvJGYmcdRuCuKZtI+miLIgeevi6gtlFt2xMCTLmOu4OE7hu7dKtyHnQzWLpKK9zhiILkGD7ir6jOl67tGvMZHx8i8LXENwlyyTbhif6cra6iU50km/ejD0RE9V0a+QVsZSmj4Gh/pRWXd4d29Taanwh6FTTZHjtrwhhrQR7t7NyX6Rojbh3UhSleghjdBmx9tDrAq1uUAGFS2sI8+yAAjKHmErbvIoLmOMVQGl2HfIdkSGbsWMPxiXIZqJGcPAEdLT73rEw2BcG/nvXRQMS673DNDS8Md7vX3Iw2cJrTBdi91oor0WBOA==
X-YMail-OSG: H6dRXmUVM1kbHpPZMesHqg5RvCfoz2_sJ9cISOoHSo8OZkVS10W0z27WEAhc6c6
 uMdRFEFCzmBJqkYzt_OZH3fElWSEA_JjSwiviPrTH317mVly5Ymhy677OzoINlWeWtMBRgm0HLOM
 IhwIWEK2Gxk8hT0whMn7.CG8N.pFVRXeS0ptSgRzqXWk.1T031LTPVA_WAKBYHUm4dyoHRsedS74
 I2iDs3SLsvW9EOXkZMN5OkJFYFH4zbQ3UWiD6xivreUFVp7x6hD4ojdxCtmUNl2oyS3BxTjTnQ_C
 TuTuU9emwjE0CfQz9y8LuQ5lkz391dNDTOx73Kqx6wGH.uDgAph4hcM6lhxocXuQM5biVPZKMuAv
 GkV769AKKGu3nhymiFnRFQGLIMXRFpSw8Zx3nYTVZS.X3xgYD86KOOKggz6cpRdBO5x8qML7PjPt
 FfaIhoP481eC0NZDLNDThPptB47ifh1Hb58o8NR9srpFvvESCY6mt9B3oPZrBHi1D0Tv__aK7Lb_
 lzMGySztHquwZLkC57PAZdzVW0opa9pLxxfPLfh5J51_pOBgw6QE_StTelz5FWc2vbFYbBPSkQoj
 .IpzudPVwIy84O.qWdWsGU27MGM0iFJuYpC4iTWqu9EeNdBrm_Y_MofnEGbabHbLSnew0OVzUoZy
 zDNRzoXdvHKt84WLsui2q1ZjWuLz3cZS9_K.2qKgPePLcIj9vyIk_wmB.wXftIBXMgSYnKqW3ZQr
 ssfXS4GeMlmWo5S7MxfSN2XpU0EJKY9qXdl39XDPTB4l_D_No6zMIV2oXdho2q3rLIhMcIziq3ua
 3EKcc_fZxS3r0sC3MFOj35..Fz3u2nR31JQb9ph92ucSOvglUdvrlMYYSAuueRMHiqD.otMdBeNT
 5y5X3N6Cfb6GvGH03hZMjvGm1seQSiqi9CTmLVCezzuRCtYiov9a2OLpW5JX2XqRYlSjR_NkGxI4
 jSvN7e522CqCE.0Nx5evUub1TUc8aSXASVEyXJaoFv_KIXNO_G_nRyI07cceADXzV1Yd3WknvGEw
 TI0Y5XSivArlaeb65ywhxIUgdHbFAuhDfZqRojp4UXUY.3D3aeEDAkENL1CggneJ0sPn8KowiNC.
 KoJ632.IODCOL8o04TCgXT5NzkLz7jY6l_3fgED0FJEBuN35YLU85QL84CTMnGbg5ypWKZzOIuDl
 q4FrLk4.kn2jQ0AoJOpZjW_xhDtEhnVhghqHIx.5_r.CbOYxDQkQGWuLKH.0RQ4_XN7oeFaIVWdO
 Bzo6NHKqpXxEMdCmyQr.vbWtqXnP9DcXMCA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Sep 2019 17:47:38 +0000
Date:   Mon, 16 Sep 2019 17:47:37 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh101@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1888366226.5438287.1568656057401@mail.yahoo.com>
Subject: CONFIDENTIAL FROM MS LISA HUGH(BUSINESS)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank,

There is this fund that was keep in my custody years ago,please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment and the amount is (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me after success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other .

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.


Ms Lisa Hugh
