Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA69177A43
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfG0P3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 11:29:45 -0400
Received: from sonic309-20.consmr.mail.ne1.yahoo.com ([66.163.184.146]:36286
        "EHLO sonic309-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728431AbfG0P3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 11:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1564241384; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=ap7B9at7WvNVPuhB4JcTpHsIVMYAq4wdORtEvJFg5sFfKQZM6sMqZqimnUz1IZuQGaX5+2mefwrZMbCvcbJWeo/Pu+CpJ9ESRPrgAnFWRV021QjQ9K5QK+LR+OfwoBiOMO7GToTOneiTyTfvlYkPc/x3v2+BRVP3pwl/Qy2x9A6zcr3zCQA2RYbaMbRVlGthmtiMm9l9egrXsA8PCarbEiTvRryOuIrIDCh68EcgPcapDCFdFhvUkyEssq48GBdljF8sBW9ddu1RdawaxTRb8ZRTkq8Dji0P3kCZRKxeKqjahdzzSW4GkIQFuHD15drhLopG/lqHuFeEAUg4S7q+eA==
X-YMail-OSG: RYb5MrcVM1mME5Py5nISr.q79WpYA2ANfRvA9NLJ6cBSk0mq36HNaNVdAaPoAVT
 RAcrIAT8iyht9i6JMkueY0Iys1iOEPLUTOgWoJGI2oklAtWWHhwVYdxSCF6eneHIEPXCMIRLV4y2
 HWAD5uWQ6yzb.Bw0E9M7_bBZLgytsxop4IZ0LHHJQKkFDG_nJ2Bhr3imiE6YP_xZ_OtqkEoXJR8d
 OA1rWJeIDTioFHDZBXWwHDVdpS3SgiY_wCncYNbFkAgXByx5.fu9UjeekjLXEVBhmQ06m.l831Oj
 EZbAxkdiHvLS9ACjCGqfdurBvSUO3ExK.yLz_Fh5XdyvEaH2XuxngzAf9CO_bBqOqdJ4muHoRK4j
 Oh9mRFF1rzvS5zjCKHhj5pL.yokANKPhob2JYmtf1Pv_wMb1O2SGTjkRutqTLzKWSr2_iw3nPlXo
 WIjD.lHaQ1aO20rqfowJ8KfJZN_jm.MNDenehXKuisT_Ru_e45BzOKa8.KyXSaI7PyigRSbyWN70
 K1If4DSLzCo1vwTaNWWDcfLwGWspHtVlBO1M0N9S5rGh1rFbjZ4Jn85QpiCWeoVYXdb1GDog7tLF
 xuptWJW3vswaWz6D4rCiyV.NGzuAocl713g7fGCMG7NVf06.V1E55m6LyVR0QIcvSL.wxmMsUd_8
 hQR5XxRgpiRf_7Rd49HxtoiCOUtyQeDml46mHV.pB.Zc3UXulWe0VpLNnKM40hMjxNkUQyUFg5qU
 m_0AcEQ2n5awwXlkxISHLIrfMbmDQh6cTTv1r3uOa3JUeHgFpBnN5Mi4U9Qa.IsyUK1zFTjGm8WZ
 EcL6t39rBO9RiSykJ8v7DPonAK5xwyfNyPa3laODTm2dhgUixOpwpqImZgrleSPYNTGv5keonTfQ
 f9Vhn6JGRKWuIpdNKUDwzahEncEHwWOaTUPV8osbcuXjBUrR.Q1jAgigk2eb4l3TjCTJVd2VJDIU
 UHLdLt5azDv6GO_f3YSSmdSeQv.xLo47vTUlS3IkprHLU8xKciWErrymXiwVEEtWI70CAOjx6Py5
 CheLbflo6SG8qUNx6hAMWqSUdjTRJiNfGXclz4h66FMYizk9TzVt_mCp86WaEGEf8aAXbRT3TkVY
 sBn0ayAGGAFIIaciVrvS_ny3h4ial9S9OC_Hy4VOxDoB6.D3ydATVmgqO8.mRQbnTs.eEp.aGD08
 LXYkrQ1LJSMjmyqTCbw7uKIt34wMKOG2Xj.udBN8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Sat, 27 Jul 2019 15:29:44 +0000
Date:   Sat, 27 Jul 2019 15:29:41 +0000 (UTC)
From:   Aisha Gaddafi <gaddafiaisha25552@aol.com>
Reply-To: gaisha983@gmail.com
Message-ID: <344620600.3403604.1564241381626@mail.yahoo.com>
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

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
