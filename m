Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05638F5D20
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 03:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfKIC6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 21:58:32 -0500
Received: from sonic304-10.consmr.mail.bf2.yahoo.com ([74.6.128.33]:42439 "EHLO
        sonic304-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbfKIC6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 21:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573268309; bh=+LcMzBQbc0DroM8jcxU51mNS/2GMTAbQMl9+3INHvyc=; h=Date:From:Reply-To:Subject:From:Subject; b=RfAPOX0lzrcOfEmWHmTTLuipTcoXDWuCmG1KyFxxXyXCAFMksFdBjRBOUTuNKUhMfOeBpO2xnUOn9n91QSujv5ZgpYrAyJ70QFRELeFd9EA/6rFeS5BKimylqf/26QdxYgdfBo+bEFPSIZ2naJN/0fNcFgRxzG4QS9L+LccpFeyyFpQ0VoUOPtd5FpZeHeHFApnrTcTIfR5xdDh1EebhOBrhMX9/zl6/JBoXmDPhl04tLMS2dKwj9uPkdYh+SuQS4hrs3r2QNeaflVCBHbjLtssUQ9nzG0SSw9ZXf9JwWvJwnXLZoPxwMzLF6QOyBzXU5hGmlKeXCxk7GgDizEjkwA==
X-YMail-OSG: e6XynwIVM1mpXzzPCKRSlsq8jek.izUR5l.VegpQ3l4QV7mkyPed2Ix5mnS3Og0
 3MuN79lH_KpvCHIYxO7QQhu4ycH8zUcKvLApf_PvSuEF2UVkdianJuDyI_LTCNV.juAgt046y6mL
 T_OkmwjI2WScjEgoe5ukvMNt2x9gZRJ_k.3JzC1tGEJcPYmtvXDpqGi4GnIA6VYLBPGujrR.NwRx
 nOf3Md0tF1Jr9zcFvA4ymR4oZEYH9cetCP8BxG6pTEah_4N9f8v7DYRlO6TOpiuLVsKPNotKg7bM
 UtOs9Le8_SmSaCxHsV6IGjb5R0ovXIQHq7m1WHlSXk4yJ_C0ZbWxmUttZWPTOOfwkRtb7L9W1XI1
 7F63bRE4euuYNKh2HgeV5PZ8m2aWilX.HvQ99OCoZaaeme9UhETMua0srB1W_aYOBXifMSc0S0Uu
 I9gCqGSrpQ6EdPXMGyPIOfEdIXPLFXwObGELvJGQyH2jVYZUUon0QZZmFXQbc.Gem.yF8y8qCxjr
 FUF9tCrCbRfWDIVLu1oKuO_0JT0cOEXoRgRumoa0mT4Pq1KydTdGAX3WHK3i1MdTqk.BvnDPBAom
 ZPS77oXlevAXS.WHyMnw86GcpNs.GnEI.NHSk2OXt76WzzK9tMalKYUL0QC52SrEXcLNd0od4uGq
 EoPLbZPqYdz8Ji6XA9RrhbZTJEfzAIZW9dkkaG9cEmcvDAA6DxJVelmsuJgdOak9VH6AVwSlkwUL
 3uDeF5wxQBcp8TSOJm54O6oI7qJjl7tv9uNWgGKUb0pVfRweBqxpKA7pUaYOloOMb5LkpU.wf8u.
 Xxhlap3DS4kEDIy2dT5qWM65jFCQMakdgHnMrzCSmgnsxxBt50hDt36TVWhAR5.O_COz5tc2yzC8
 ONt_FWX2ZQhrpueOTVGOMpoxMD8R0RP9Y7TYOCc5Q3dnPoDEEHmPJfMtRn2hf4TGADzeWHi4lS7s
 8wyoMxxSnq2bt274QkE51GMbq7PK0BCxAC4ezP9yDZaq72F2vHBczb5rxpX0WzjVjg5cxJc.504i
 y_renKLqVKEOD1X4ZpScWDJoxtrGXFddXRpXClR31kRBKpZY54WKI8lRiVx64WBRyCCynHNeoB4w
 aRa2pjvVLH6xE48.8HPC8v4ZAhf7fiEzJ70r1SJSnC86HUjS6mHWaaoqPJSrFKqLpOMVNUSsBySD
 P0cTGlaf7lFwrJuamngvJBP6ZwPEAnuCGozUPAT42zbPxKt2jzB6quQWv5YAfa7uiqjIORHUMveH
 fp0pOAlvHBxwX.RYUYb8u.A1KjdJD1DMUhNOimhq9h0Hi3s.1jFHJpJTJXV01CAhVPG7Gd0ZPhgR
 iA5XDlbJCCJF7CGdVVfSupyDRDFldWhrTzQM4FtJxeBg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sat, 9 Nov 2019 02:58:29 +0000
Date:   Sat, 9 Nov 2019 02:58:27 +0000 (UTC)
From:   Mrs Yvonne D Balakiwal <yvonnebalakiwal02@gmail.com>
Reply-To: ivvone.balakiwal01@gmail.com
Message-ID: <885798965.1158994.1573268307617@mail.yahoo.com>
Subject: I WANT YOU TO USE THIS DONATION TO HELP THE POOR URGENT.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Sincere Greetings,

I am  Mrs Yvonne D Balakiwal, I decided to donate what I have to you for investment towards the good work of charity organization, and also to help the motherless and the less privileged ones and to carry out a charitable works in your Country and around the World on my Behalf.

I am diagnosing of throat Cancer, hospitalize for good 2 years and some months now and quite obvious that I have few days to live, and I am a Widow no child; I decided to will/donate the sum of $ 9.5 million to you for the good work of God, and also to help the motherless and less privilege and also forth assistance of the widows. At the moment I can not take any telephone calls right now due to the fact that my relatives (that have squandered the funds for this purpose before) are around me and my health status also. I have adjusted my will and my lawyer is aware.

I have willed those properties to you by quoting my Personal File Routing and Account Information. And I have also notified the bank that I am willing that properties to you for a good, effective and prudent work.

It is right to say that I have been directed to do this by God.

I will be going in for a surgery soon and I want to make sure that I make this donation before undergoing this surgery. I will need your support to make this dream come through, could you let me know your interest to enable me give you further information.And I hereby advice to contact me by this email address  ( mrslvvonebalakiwal02@citromail.hu )

Looking forward to hearing from you  soon,

Yours sincerely,                                                                                               
Mrs Yvonne D Balakiwal


