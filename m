Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39C98086
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfHUQqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 12:46:48 -0400
Received: from sonic311-1.consmr.mail.ir2.yahoo.com ([77.238.176.244]:34659
        "EHLO sonic311-1.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729328AbfHUQqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1566406004; bh=BmcJ2yhK542dtQ9xlQ6VUUs/U3LQpFQvo8+s/U+P3cI=; h=Date:From:Reply-To:Subject:From:Subject; b=XTB648ubFD7SjxuUhoRLWQK57EFRE3M1KJSOR7VtRtIRscePA/1RsCdvL+MfFc67p5++y6As3Al12fXhb0RESfIQ6pezEH0YomGNKi3pKWXZTYcDBGBVqF7vJGKlTYYyHJek7ZxiFHeKX6Xz+7BW85e0XnhWIajh1UHaacwvF2tzMOjTDm/hC77gPpK6AnLo4F3EPN74u41D24c3NGvkOp4P8VDXGPmDLpMj2wmvJAyxldc47UL56GQcInLFmmGvVwjMp3RcE7G1K2Zy5QYXUQzRjxPr5T4sx7lU2TQR/V59pNXNkyHmV9XeXdNCmRBEtO8QzsFIU4tdLRZ/EpBAGA==
X-YMail-OSG: jnZ4TugVM1mKTRPtR9.KF3.wAQPaSqHGmCDPFXfll_Gq0xleplyCcrDU2dwJUpU
 UyMLUqBIBP3Jn75SCh4zonahoMaDSmBvhjQuNrLxGU6_xSwcX4yTE962WQ.uMdcuTVueW0cF_cAl
 pSiUJltOZV_1uZll_QnZn1FAjZUIi9HGmw0bgwJkWh2QOVsQufgc_wsC5COhYmTIDf2jJkiaGOU_
 0XlkS.vGewpsDqBrldXmoUhn3R.ur3UV2.DzRfPOdyAFmkY6Yk4bqB9koYJPr4N2jfnGOypS29zE
 bPAKOLsOyu9LQQPjvaixe1cKprast0dwkBYQA4HCgP0kLYh1LgwVlvxCG3IRm8a9qmsgoLNUm4ia
 F6HoRwRbVF3kNaQrxwTE3g679dvpWdzjuQwiSjV0KslFvRIrqwkKZKHacHWtRqfxmSaXvU_5ah4t
 zzmoatZfP1ogsZokwrmXzy5aRhr2HWSQg3KkEr9Y7GP35GnqIL5VKpoGwadtTgU5301z6u6Dva20
 2pjzsh6WPs2W3yUULSvRhPh5KpBI3l3kNttvgz13bZi7rE.h9mwyvJXf_j55CvzWr_fOH50ukpnn
 l9wrtXh0uGGNfxjmDqQfD3MYXvVDmbMGYmHaqmgHGe.wekzYJXnMCU8CY8MwUIbio5B63avuDfS3
 LZVsFuzU9wL6yQL9RxHI8kKMB28PWt7CeRq5uTiQldAdo.CMzypNjidCQ9T3JWtbTO1OL38WHQCc
 hI3yTUeQuXvvoGDCF_RhHGDwgcXtKBMue.eTrkptFaj6d7kvu5qrBrupJ4iN6RHZSwdvZdRHu4le
 jMj3SuzK8pxyVJDAvhaqggR19kDAEqCkeK2adrb2ab7xDC.BEQUIrfYjlenxYlmZHca7CcUoIqHV
 MkI7m5wzsbTOhqJYbdWUW_w5HWYbyAPLXbmB0.6RtdaC2S_a7YBB_ALpmjbpFGCIz95fLPwwL0m0
 _4tiKl1ykGBVskhLeBDWuKp52ZbdVFarxnxG1mPDAuytPbElHhpUtCdbJz7sijh8M0CbwmKbLQ_h
 QDT1MRtyLA9D0rbYV8v9q2cxIlgs2lMTAOKFys9TttWfvXXqHwDi2CON4NvW1z8uereTfV.Tc9zf
 Ns0SzhkP6XaZ8inZONKg777tTYUy.817EjQwHkrYbHUrobXEGyQV2dyLxL_YYvOAihj9lNV9w5ws
 27PR_BURmM3rCZpd1svTX6uvAf9OLmAxLyqAbTgKKeJU2c0HvnlAvUWpyPJ1AwHztlbAta5XEKSW
 7DwBsiGGfxUuSK4Jdym7FTQpgDRBjPY2NjYsNXkg6ZR0PHcm3MJxO0J4zY2CHr.dogNlsLYLSN3t
 G2qPS2SuwjihTUx6K
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 21 Aug 2019 16:46:44 +0000
Date:   Wed, 21 Aug 2019 16:44:43 +0000 (UTC)
From:   Mrs Maria Ibrahim <preshjq66@gmail.com>
Reply-To: mrsmariaibrahim@gmail.com
Message-ID: <1696005834.11654043.1566405883166@mail.yahoo.com>
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



I am Mrs Maria Ibrahim. am sending you this brief letter to solicit your

partnership to transfer $4.5 million US Dollars.I shall send you more

information and procedures when I receive positive response from you.

please send me a message in my Email box (mrsmariaibrahim@gmail.com)

as i wait to hear from you.



Best regard

Mrs Maria Ibrahim.
