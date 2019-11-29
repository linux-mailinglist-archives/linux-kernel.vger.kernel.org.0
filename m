Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9810D88A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfK2Qd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 11:33:28 -0500
Received: from sonic306-20.consmr.mail.sg3.yahoo.com ([106.10.241.140]:45244
        "EHLO sonic306-20.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727158AbfK2Qd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.ph; s=s2048; t=1575045201; bh=u+w+4enpSfCcELgOGbyxJo9ZBxERk39tL4f9H54lgiY=; h=Date:From:Reply-To:Subject:From:Subject; b=bETueXpn3N+R7KBs8Gfl1c9VrDX3Z+xUDlQHGqOAZG90V3XcPxJc9eTLBpfWWCTWu/RBLisYp8F+BBzgVeKd2Bh6OKBstfdTL1cZ6ZQG0TZQwfMp+xfA7WBK2chsoHE+v+DlINyxQHDHyWKSpccqlRGKap4fJ92gjlecmaMYVW/zblzWHNBqCWWiJkuSiUpc2g/nKCc6TegdwrI9sAtpw3DGbvGCsDahQ88W2lS9NWjJekAJwnqdV1GVlte4tL+gJgy7LUnlmtEd7G+1VyMO76QsY5PXjNLEjjKsbo3/vmj0+iTU2usbBewHHY31jP/uYYQE8ofjFDeXfOrkaIlXLw==
X-YMail-OSG: aQGzQnIVM1mbr4PEPFB0XJZkjIO24qEiDCNchn0CaoX7AOInNhix9xuPlzdJw3.
 Bcgk7rlx7ETS5f_cUSq.D2qiSimuJTgbXeG0fswmImO35EeyxNcJxX1zF9q53qRf2AMa2AAljKLf
 U0I_C9A84zE8IEwvfqfC6fNSifOfT4BYqrgxG7pFCsnbLZkwc0U35gT.TRFWzbMWAfHD7.8elCK3
 xXCN5rGK.gQ7GBASsqf_Jpqdl_9K8N9QaQ1FX1bM1KnQgWEusovTh7qi_htEjKbeor9BIuZzwhs7
 AF8d8sjw3IKP6315F5rH3zgQMjK5ak.SMSN8wqJlvaqhtQn0C3AHu5HFCpQ1TD8TjWDljxCSCcMm
 VBliOGwwjQgVFH.o1B4SxOdgHehIdSoq8KxOE4lYb_rwuA08UlXFjCTMMFP4qMqxP29N_JqnO6YH
 wyWBZclJb9dHoj8_0vBbME0aEQc1H_egUnbHMhh6X1s9fyFMfJesbzQ5P.dmuwENcD_.CitDFDos
 UcnW_XSLhK2ZR.y_N57uo99I9oe.PVoqw7FQzg2VD4WQkYHHD1PPkPLDf99LJn6dm6XCZuMCKyZx
 VWB18SRW6gWfvIElsLezUTh9P7Z2x2xfExQ_Rae7wW4mdfDWXSGegyys1EDKBbuP7TK82.AwkHBX
 x5zio7BbS8Pukh2H9wFrM3R.tsoikV2mIQk6x_QPtbNcKDfOYPZ.X10TaEAd3ZJdTyVSN8e7Egiy
 JPC9XksVhaMfzYDd5_WTV.e2Xiu9uy.TLoF99E2RfP9GKJAYHsLSz58C6V6KSphAZmnenh6lRFyV
 JvdUgCiF_Lb5b0ci4CLfklor_gayefciHtdpj2ssvswdGb1UBZsYlv4L0NvRbm29GRvbDf4MgDzb
 G9bjqO8QOKShrLulrShrcpA1Lr9VVF0TfEiLkQRSuO_fdRGErrGQGtm5CbPIY7JW3fsVhuo4A1OW
 9BKw4cULJVhEQ.z4lh2BXIY7Qr51ZYIk05VrKFsZdU9O6WF1.AUfoj99YlGy2Y97uXhg6_gpFf8V
 JjJjFAj3cvbPlbH0lFPhcqLsTmsGgNRlBdVbzleImBT3Lg3LCQ.y7eMECbnobBNyLBghxWIz85g3
 pDpX7QfZZWyIyuJrBkupr9HJmYLpf7IO90MitzqjpL_pagqcYvDHBGPe2MlbFXiBh5mfLBCrEXYE
 ll74XAzL.fD7aYQXJ3xlqLS7dIk9TXIqG1XZxvUKxBkoyqDsFpcZP4Lku2Hhn2sssr5VqyfXktxq
 AnBVYHoxiVIASrbymNdoE78WDshtiqU3KBmvtT8p0.cTZAPqLaFrwM5esSj62wXn_Ucw99sEn9aP
 zbPvniQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Fri, 29 Nov 2019 16:33:21 +0000
Date:   Fri, 29 Nov 2019 16:33:20 +0000 (UTC)
From:   Mayveline Bote <alice00631@yahoo.com.ph>
Reply-To: mayveline631@aol.com
Message-ID: <744348868.7056185.1575045200623@mail.yahoo.com>
Subject: Hello Dear,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,
 My name is Mayveline P. Bote, Please I will like to discuss a very important issue that will be of a benefit to you so please if you are interested, I will like you to respond to me in urgently,
 Please do respond to me very urgently so that we can discuss the issue in private. then nobody can read our mails or know what we are discussing.
 Thanks and I wait to hear from you urgently
 Best regards
 Mayveline


DISCLAIMER:

The message and its attachments are for designated recipient(s) only and may contain privileged, proprietary and private information. If you have received it in error, kindly delete it and notify the sender immediately.
Mrs. Mayveline P. Bote, accepts no liability for any loss or damage resulting directly and indirectly from the transmission of this e-mail message.
