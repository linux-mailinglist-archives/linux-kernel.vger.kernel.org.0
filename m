Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04095ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfHTJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 05:12:51 -0400
Received: from sonic302-21.consmr.mail.gq1.yahoo.com ([98.137.68.147]:43666
        "EHLO sonic302-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbfHTJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1566292370; bh=4n2MLlDGwctk7N5df3nYF8RFE7N2on1wJCPfJ77hv1E=; h=Date:From:Reply-To:Subject:From:Subject; b=dnkXfRF3LXhQ6EULhmvNPLSaUYg5SqXCJNUZJ/so87e69TnvWgtNJk7fxvFwo+1IrVu9g/EpYvjrEs+qJMh/L4ibMAbDb+kooLMSYp8iPAn22c5JXrLUHZNYfGZ82+VcQCMD2yhUQfAJsfpgRf2SDzcUUkyaAeuQbY0ZJRA9iBbKXokFfpyc968Wb9Dx6KYv6vgUb2zbcYBHMDmaM24N1qysiDc2IXPhfXxZ3VM4UTaqAlTPkRfmxKJ2rvR6U4Qt5jIduUu8rR4vi7JzZlhv3X/xMxZA7sAMfj9DMhQCPqcIWlDyN0fAP+2ls/LWu4ebH6nkcKMU/e+s0AqZmN+U5Q==
X-YMail-OSG: Xn8G18MVM1lP8fEM8xZodY2Th33pWb3b5axYk18IFdbgCBTYqWXulzD0kl4tG39
 y5K8.VACYP_VHKJMbYXCodZ_AxWYjzFtZVn026JQVqo2cWvhj0KAPkieX7kjBb7cKES9WUfU3Jbw
 DFdoeBQsgwkClEmozDkpOLZhgVgJdNd9pMcQlv6ZvU78bCM0VbeuGouBMUsOuxFG1zqIWMF0GdYO
 5KUkc5ZUkDsbhgr32oC8YMedu0sx7JzU7isWx3rGvyGdApFPVHE_95c8nhPhR_jEvfFkK.aQJ6tS
 k18469Nx9kiP3ISZQSttm9zumT1xrVRtVWPbEYxvvzugZomHqIfJU0MwvoKNzUqpEe_V0ipjEEAa
 LOl_M.h0fZGCUfVzJ1VdruxLeZLLuUVzk3P3Bi1mbI5sUU1WzqKEUUoQ.RH82NJ3KERS3T7EsRyV
 GC6dVIBsjTDndcKX5Gn8d40tsX.OYQ_FQfbeoba1Dp_MWiBqGQ9jC2HkQcbMXJc7ptJYxqYD9MDw
 2q2U.638u8CrirlLKtpUyFgJ1uvYXHzwKLrak9aXVwqBb7D9tjmCwDUO294j3TBDouGHyqbR5Cnx
 IrPzDVXm50TgL0f36JF7ta0UmzQbvM6re8MYiMZHYPLkp24eQ6xfR6mH.UotX2KHG4TJkrsH.TLh
 vpVDcimwlFwBUYQpInw_akbmlucjjxgcjpU9cdlkVewjZjBcZ_LXPprJMVHQWIEpxHCEzyZKCmX0
 TcbtrxZ.spuoW1SGKDPnbtbrxXOdxCYwbez4SgKZbtq2fFGyX.98e6U4ZTExoZkp.saGr7Sj7YFE
 Yp4HF69ZhdB0N0yWckTG6E5kKxhZPX4b6EF_L_j_elLsQdcUGohf9SZdCr6nXJuKnShEvfNO775l
 QzdhXpI9Yqv14DvdkGPeT5ssB8Bcy6CgDCGMud2SBfPE0VR8HO.bCUrOG7tWkj87bCjs0uK2ChKs
 Yf5D427waAhpbqHFrN5linGkJDfaLPTDoHIK13TUg5xtLpPyGQobO05ZOyqtlotlWrHV5VtSri2.
 vAn1abJRug7kH8hWi.m2VhNGrSyQbBV9EHgQFr56HjjKp4V60N11Q69dZPrJic6izRmQB0G65l2w
 zIkkUR.X4DUSeVQC_k13E3XgOi_L38m2utQsENDXByGvX8g8SY4vk1nMo02pHsUf629XNvOdnMFD
 ABRS065JVw5BKlWupiCLRkr73E39Yol_wIqFQ3DkXYKOQnsSXeCpps.TMkB.jDODl
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 20 Aug 2019 09:12:50 +0000
Date:   Tue, 20 Aug 2019 09:12:48 +0000 (UTC)
From:   "Mr.Mohammed Sanik" <dibsankarra@gmail.com>
Reply-To: dibsankaraa@gmail.com
Message-ID: <1085482564.2388113.1566292368136@mail.yahoo.com>
Subject: Good Day,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,
 
Please accept my apologies for writing you a surprise letter.I am Mohammed Sanik, account Manager with an investment bank here in Burkina Faso.I have a very important business I want to discuss with you.There is a draft account opened in my firm by a long-time client of our bank.I have the opportunity of transferring the left over fund (17.8 Million UsDollars)Seventeen Million Eight Hundred Thousand United States of American Dollars of one of my Bank clients who died at the collapsing of the world trade center at the United States on September 11th 2001.
 
I want to invest this funds and introduce you to our bank for this deal.All I require is your honest co-operation and I guarantee you that this will be executed under a legitimate arrangement that will protect us from any breach of the law.I agree that 40% of this money will be for you as my foreign partner,50% for me while 10% is for establishing of foundation for the less privilleges in your country.If you are really interested in my proposal further details of the fund transfer will be forwarded to you as soon as i receive your willingness mail for a successful transfer.
 
Yours Sincerely,
Mohammed Sanik.
