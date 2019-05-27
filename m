Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481AC2B420
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfE0MEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 08:04:34 -0400
Received: from sonic307-1.consmr.mail.bf2.yahoo.com ([74.6.134.40]:44050 "EHLO
        sonic307-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbfE0MEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558958670; bh=zS4B1yRTnNuvY3t+UCspgZgSTCynme8L74fJQbF/Eug=; h=Date:From:Reply-To:Subject:References:From:Subject; b=O0ZCEEpshtowqwR+ll3NZuKjBCfLZJbCM3rT5CnxgLsdx/2KoHn8EES0tuiLnjn2mWOYgfTYA3qhKp76o7nphRf3bRTGJvdO7nm9iTu5Cgh08XXHostqB1/h2OsrRv+wkSWCetC5+AaH+KhAFAfPM3nTA6E0Y3uM1cuVpgAREWXUGXuHj0WJySiTUXI9b5GMgy80LckN+6O/DCS5zQtLBwtMvLUUpyzyClniq2lo3wFuZ4B4xn5PLiWlDaKkbkj8saNqnj7Qym0xWSulMTkNq5/+1R2dVGqtE87b5Cfn8OlcZkBnNXc4VcPKOy3YemlJN6dtgS/dghssRRvVNNXcpg==
X-YMail-OSG: ivDeX2gVM1lmch_iU8yZy7wNUfeWQ_YmQ6eIPsxnBLTaIK4eo_I5RyDS9kqFwG_
 .9pOXZ9qZZgeAs8QN3S925rwI_SsjylEZCpIUrol8QlhtOohmhHKyLAZQXNeElIyzGMGzY78uEV4
 Baa5zp1ka0o7zilcakyaKCinWgPDBng1uaQQGHtbaLl15TSSxqHM3.P41bLzRmUwY.HClClIegg7
 UMM2D8_Pf2PLqJa.qNGzTsCt_2FfcmL9CLxnzREC_83e1d5O4P6GGrv4XDO2.A0s0voxYu4HrbzN
 zTYgC6Tlw0Br0rTymimYnjUKes.sKkGrjZ7Bm2tgrx5YI6uboW7XEjGqT8TsKCLOFJHmesk1r1eb
 lmSyxpwdnaql5j7dG_0y8z2iebd.3wzj2KK6MnoYN5WOd4djrXxBP2Cn2kpYqNUeyZrBkGCHLLrc
 cTPjNMZTJNT9663ZMTW7KOiNok515D1HJfcfIgNQsk0U89B3mNPFTGwe.4dq3HlzOexRJ7cWsOsP
 vK9gn7YILNYnLSIZiPXLVM9PUYIY9l7ikNJsb5Ldp55.9aTjzLVSZO_l0ucrxtu7WDnKog7KGiXo
 FjhR_uPbT1mGBUrs8K_Bc.CJFQcZpMwNut7dnoZb9A8G7Zep6o6HMl4Xmo4E1VZ7nq7PLYlV.r7V
 hDTw.jTtNwxeoCdCJBCFjOpJCuJtwT7T4d9kJkTz8sc5.eQqv1rrCiOu2Xna5g1DE5bUg.wdxaap
 lBqQb2QaNeNh_VjDC5nl.KRoeHIhqsF3gvU605Art4nnfiMYSuRLtm1BZGP2AmXNCwg1fCNYCbZM
 8p308kYuB_RHnv1G82vNQxs_5kbA4DW8rCxiQVwWWy0ZNZ3Md6fIJKkNj6Pt77e6pflgz2O5KM6j
 UT9cZ6cW1lnhyB84CxxJkctOZdh4CBHOyUif4.o_Ght9GRlu4jMwGfF2WJ3iJ_PW4ryH1kP19lIq
 bXFpM2wyM5c3fGQQIpnNlezSqm1S6yB51HypCHWKIBefpj7LgsbpkYrNi74AvfUXBl3gDmSnN4Ay
 XAjkBMw83V0azt84bcqJx33A0C9NxAPmKiHa7_PpJX7Mmy59rV_RCvXPvECPDkZKtrO77Lblv9w5
 5FAV9r3f1RiJFgr1KeXqHlrrc1f.N.Jz2o_ZLhSYy1TR5iVm4ptjd2iW.WB5tPv2HBRtlTBQS4k0
 uUVDd0xsF.rtiFRXEzZcxowOuPH6ej9cqAUGBSyOicgQ8c73jOs0dgP03Fz7JsB1R3IHFDW92pXe
 OJhQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Mon, 27 May 2019 12:04:30 +0000
Date:   Mon, 27 May 2019 12:04:28 +0000 (UTC)
From:   MRS SABAH IBRAHIM <mrssabah511@gmail.com>
Reply-To: MRS SABAH IBRAHIM <mrsablaadam1@gmail.com>
Message-ID: <281592895.5253697.1558958668882@mail.yahoo.com>
Subject: Compensation for your effort
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <281592895.5253697.1558958668882.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

How are you I hope you are very fine with your entire family? If so glory be to  Almighty God.
I'm happy to inform you about my success in getting those funds transferred under the cooperation of a new partner from  GREECE, Presently i'm in GREECE for a better treatment  and building of the orphanage home projects with the total  money.

Meanwhile, I didn't forget your past efforts and attempts to assist me in transferring those funds and use it for the building of the orphanage home and helping the less privilege.

Please contact my nurse in Burkina Faso, her  name is Mrs. Manal Yusuf , ask her to send you the compensation of $600,000.00USD which i have credited with  the ECOBANK bank into an ATM card before i traveled for my treatment, you will indicate your contact as my else's business associate that tried to help me, but it could not work out for us, and I appreciated your good efforts at that time very much. so feel free and get in touched with the nurse Mrs. Manal Yusuf (email: mrs1manalyusuf@gmail.com ) and instruct her the address where to send the ATM card to you.

Please i am in the hospital here, i would not have much time to check emails or  respond to you, but in case you have any important message do send me as an update, i might instruct the doctor to check it and respond to you, meanwhile, once you received the ATM CARD,  do not delay to inform me.

Finally, remember that I had forwarded an instruction to the nurse on your behalf to deliver the ATM  card to you, so feel free to get in touch with her by email  she will send the ATM card to you without any delay.

Thank you and God bless you.
MRS SABAH IBRAHIM
