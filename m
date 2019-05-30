Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9871301FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfE3Se5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 14:34:57 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:38286
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfE3Se4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559241295; bh=FCjWGTqDRXQUUN8ivg02MDhbiDKrvltOcpc7W52q/3U=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mUyi3clUg3Xnomaf+YhTA9gRwVLNbbs3R3A3WW8HW5dpOGLDVhsxU5uxPhXQFHoQ8C3rANLoO0MfBxeJ6c9FKq4Vd4o0pC3hk/c/jbq9v9Pf9A20gqXDfMPQY5ej3pl5kgKnEm+2TqnZb/0SnHJSekMO8qr4N9bDD/tZx+jd8i39lWWOq/PzkrAEDDu6yzNgB7DWAciNICY2NGlAyEt4U9KJ6UcF9wTBlYevjBjzHK6I4fbAtnUs0u4RUN/6TTIxd1IxcR8MKomOE42w5rqVFEXsnqpfwK5J81GcssJ2eKiWL7Ii/TcrjydB/EQrWbHKsNXMfA5zO5QH0xXHjpDx2A==
X-YMail-OSG: .mvfc9cVM1kGhp.9789tMdQGm_j7aTPmHvrhLWnjTdWn1rvD4KFPJCClrervGDs
 cMuZkgfy8JN4fj6zGaJR4KKHCtUv7XUD2QCaIuA1d3j3gFSJokCZxvqKN4.uu9vFE8RcEBQqNMt_
 OYm1veoC7f2901RGyg7fYeawUMyhQXON_a34joVgayDT_LiJA8.VpRGc4.VDbLRtQJlEmOUx8dX5
 KWjVXpahq9K0_lptw2pTY3LeAnxpy4jcuxDaOivRfjIrmV5udj_KVO2nRLd0GdpU2C3O.jC4im_o
 FH2KeecWN8xynLcU4BluTz8wqgRsnHjCCgOrgtTLk6pPL9nmsIKVBObgIa4nUiDIf.aLLre_X3vU
 Hn.v_kMVMo6r1NYjB5ns0SZERYIpz4arozVa4hdsyynEXoabr2qo8RksWxSgT4tSrWMTQUTqWNZ6
 uSVJ227_oXJ3bZICS0keUw._y_GkE6cxucTLMPpV7YUGbBxDijPTijNdkkWXy1ryXns8b48Qppir
 PVZOEGRdFFU8Chgb5rt02xD1TG0RPWETcLkXaRjJi2gjQeAt3hJm8eD9JHFZa1wVl26_7JQXVIgS
 w_5lZwad30GQpOPUl58RYtIF9I35xFY6nQdjOrRGKBhbjYCPZuE1BmjJ.FhCT0Y4rZeZv_.MNcev
 PTanVw7143OTH_6nLLric_eTvSdxRa8SHblCSkiGWAsVDpa6oiFqizPFOvdWFwVFVF_7NeAbuaWo
 MdmmbZTeb4zCX.CJFlCvPJ7CraHjryxHB3Da22aB9AvFSLqAh4m2FZNzqH8uRlGRE6c8GUGI_Jp.
 xS8I5ERTLjGRtqGmsE430ZErOvMHXIzOHZBjNA9fh1D2Aza9iyqoU_00_q778b99gTQsnwixpt1R
 RV1TGWCaIFW771kyLWoexwCDHGd244swxubdP9cQ.AtpHpPmnyDO6bU72Fr2egr1IxqMwAo0lhpR
 8qd.Wrkihdm0YlYhR3leoa5i6RIEtqFMXeUwv5zOtSBPl0jmZdb5Ocyf2DA0qFk262PFNO2Zazx5
 L2XjSiPkVAx2nX3kSDr2KkNatQBOHxNCZB2bD8wXz5dP6.gXSbQws7pZoOnAuDi_Ils5BcHVpIHo
 616FmVnuHIQ0X3NoPr.CuWgrDGiJGoPTzHwb_z72lTOyP0iyxvlhH4c_bGmHdk84fbbGkxkki9ut
 WwvZs9w2VisAjsnYWi6XQq7BVnb_MdshtMQLA4EdIEp7WpRmGjYzAY9HZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Thu, 30 May 2019 18:34:55 +0000
Date:   Thu, 30 May 2019 18:34:51 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh101@gmail.com>
Reply-To: Ms Lisa Hugh <ms.lisahugh000@gmail.com>
Message-ID: <305145471.6881930.1559241291101@mail.yahoo.com>
Subject: URGENT REPLY FOR THIS BUSINESS...
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <305145471.6881930.1559241291101.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am  Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank,

There is this fund that was keep in my custody years ago,please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment and the amount is  (US$4.5M DOLLARS).

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
