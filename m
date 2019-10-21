Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6125CDF04E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfJUOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 10:48:47 -0400
Received: from sonic301-31.consmr.mail.ne1.yahoo.com ([66.163.184.200]:38715
        "EHLO sonic301-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbfJUOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571669325; bh=KYSdQEXXtgo6fwY7l3qxkt/qXzgJ0L5Of+W47mvZAWM=; h=Date:From:Reply-To:Subject:From:Subject; b=gZMu01XaDWgcH7aoQqXBK0I37eNgCuGA51bdgtGO8trR6jVssyw78DtZSWOtPzTbP+dY0FtRn9UKbFaMWFaTWPKEnWdJ684fuugPL2hM22rdheIVUfmO2EhyROrlqMr+DkvrBQCOsnHQ4hLwJhoAXoYlDEDjiD70UAq0W9o/QbKXogl7F2oB9hTwbd/x5PyrMWaWrpsL1GljNpfprDrp+466PM5gt9uAEctdlz95p5+CE2cV4FI3zXj2Asmoh5OYHk2xp8nkTBGYDz35pNFbQ6nxYFOfpK173WS/lZCCE+aweIYg9Z2IPobX2Hu54foal02tgL7rmmky1AQahQs5rg==
X-YMail-OSG: gN5sQNsVM1llf_WqGKBO2a_x9m_0FOEEBNbO2ledf9oH..zm.THCJ7Ld1JRvsUM
 hSso0Dy63dKRbtcOSIXq4S8uWcbCIYmieSAzgNv0YdHTq6EPcAqdactBMyutEzX53EpW5UmuqfTE
 ZDgGkHYJjBcX7pXlwXNICHHpfMQDAeh.4uj05Smv2NtD5BTOPzJRGICQ0F.sXh.nHbHJSkJKaPZE
 8VxE6c4hcKavT1U_k9ndlvs0k5qO2.DR7Xc.adQDTuev_gFYciInyZ3jlh7TSbLKE9yyqm1ioa97
 6VNfnDVCsIc2hoNSITvxDyjyNYcPJdcweAuGxykVnXRxoxZ8QkVImEmyFWf58t6n_PdPPgUx4stN
 pAunraPTwZZUG1I9dxeAoumvLxDER0rjju2NVWNTb4Vz20iFY6HrwSnXdD.ND0LxZeCiiH87i.g6
 CpLyTYTFxGlxE3Wu3nCOS5Stb6xStif.GM6Ca2P5jfE5uGzQy.peSLACRMyS_Bsy.twTBg5PmV4n
 M85L76n1UFKrCdMwwIiRBwxVqTDR6Y68oZXoK8QndOsc96xgRLSoEbfwMflUudJYMTvVfu9PhSt0
 Txgyoe_51qnJ_BFXhBmZgd2KpXi2JcaxH6T5NuWAZOziJ_Qdt_Xw84xIaGFsfPYbTgjb4NG.TZWG
 Z_wivwnykdcHZzOig6J65zi_2MnVve9PEBkcJzQUfVD0BrRZSpNpMYKNWxSLrCcegG6Hp1IT.O4x
 sv7i7ewBWddLZrJiJ_pGrtKaLPeQCjNoX3gHS6Kx16_yZjS9mhEMCH4X.ZSLradwU5daKOGCPX7_
 PYUOBfJDj7T1Jl3.warx0YZVqXUgX5lAZjge45QP2iiT4URn_czfmutabsSFbTE9fe_iMKvU6ZlH
 hitiODwHjOX..ZNTIqPg4jm8VXtIvTfD0i7INrwEK6jRhll5UjdTVD4uUVr8ggu.Z0CH9VukJmDD
 HMgykIxiOCndy6cNOroshXIAoco5Cvc9WdwPRMpQv7Gvi4RAZmHyHhLxmvhNt5zkNzv9TueTiwuO
 Ahxbmpy7tsd7WWKNF3W1QxtJoBJahLH4ed6k5KQjaQOpAq9wuFKY_6MdI9gwwCNytT5KJtcgup9B
 A4yAoRR5OYNA_zIV2UCCko6z4zMYQNihlPI4nLhKh9HpslhP1JRhoKEZ4Q93z.F9.qINlNpj24VK
 4oLTlYq9XWjCXzCfsra8dbmO_q2_kpLzoBmffqBFySV9yRQ5oEpsMpxh5LOGHdxHGlaX_MICMtl2
 qzDQunRZ.e9oTU_qOk2g0mTx5rD9LTFh3KbOKq.MOq1VdrArl5CXn5EghoiTc1ZL_cmnFijwenD8
 i8A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 21 Oct 2019 14:48:45 +0000
Date:   Mon, 21 Oct 2019 14:48:43 +0000 (UTC)
From:   Mrs Katherine Pascal <talicem9@gmail.com>
Reply-To: katherinepascal60@gmail.com
Message-ID: <1981190294.4579348.1571669323064@mail.yahoo.com>
Subject: Kindly Accept my Donation.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Beloved,

I am Mrs Katherine Pascal, an aging widow suffering from Cancer illness .I have some funds with 50Kg of Gold Which I have inherited from my late husband, the sum of ($19.9 Million Dollars) And I needed a very honest and sincere Individual or co-operate organization that will use the fund for work of humanity,

I found your email address from the Human resources data base and decided to contact you. Please if you would be able to use the funds for the work of humanity as I have stated here in order to fulfill my late husband wishes please, kindly reply me back immediately.

Thanks.
Regards,
Mrs Katherine Pascal
