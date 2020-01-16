Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71013FC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 23:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbgAPWoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 17:44:39 -0500
Received: from sonic315-21.consmr.mail.ne1.yahoo.com ([66.163.190.147]:40119
        "EHLO sonic315-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732417AbgAPWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579214678; bh=v8OBhJ6sz0n1EcNKYhxESkE/3M6bkVKDGAqY/Oav55I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=WhDvL/AQsTKOAZ/jq34iWAHPPhDShhElWC06XAV2fvMGkAYN8TiGAQ58DQkHnP98yDClMgKFrWtdGOzpaU/+TBFYLvKrhVgZGFrxFyrxViBPBFcuGzuW2uPM6mtH7jAx8hcwqvoXwSsxHY2EUj3/aZ/VVQBXEZA0qcVku7ESrajV7q1ExRWH1UoYkiD7NnaoCwGEpRrYKWcrty/3/QKaZzqmwXCM8+fFx6i0tjOIA8iKmitNe+X5hOdanJAkwmjgc9mefcqpARwshSBdWroxjyh9IHRZLllPLh6NFdtixKvlz6pdcYuvj6pPZcV/v6IK62PQTO3CbVZTA2bi06HfAg==
X-YMail-OSG: xTwdWdoVM1k7XCERQimYzJByiYsiC5Quj4CEE5gEg4SPoKGbmg3w5eSb3t2zJvX
 tS7fZTFRttBDjNphDZWJzndAAQ_VmCviSAvpvFBlHnmaTWplRumAJ5o8L4uZsyrTHli4CK0SLfm1
 RMyOyTgtYHG7mGI.XNz3ZfG7n6xhP6wr9DAIMiZJavsnQIkPqU2mayIRJeCt_urE92xkybi8eM2_
 4QW3IUzLbKtOL_an2R9.O7RSbTZ53DiAXrLPOUgYY4DsVoNy.z3OaDoRIYzG.ddIGt1zccxv20OD
 0cBER56pGXvU3Tt0jkyu2.oNLlorGZml_m_vBYn08dSq.uD8sQN27ufp8pDK6AUGjbf0SxWDOWUm
 huajFgV4a3x4EmoouV8PFLQyWpBrOBr3IiZDiCZfQUjpG8oBZxEleBBiUpFLKwHgW73zVcHIFI06
 TZAzbRbEj8qQkpu3xn2JPur1F_SZr6kUmuhUzlyY6oIvXkz70EuKg25NMODKiqU6P2X13.imxGp7
 92JNjtcYP7DXNzZSizZ0rKcvWG8Wl5DZPcXyXGfNxer4nozkvRCTlnto2nf44HRDV..RzkHA3V.q
 LV.Y7VtrSRvevtp2NF_Wh8QzNG5jY9Uo9vBhwzXGSWqXNNEqiIllQg8OiJ7PtMBgP7kpdJgaXLIY
 xSwhQjGemivJtcf6yZlobrsTDTWbwB7wYSEFHOskRYgsf3ehjbQ.J00202pGOJnb_hsgsqn5P_g_
 aGW7_tdqEmXWtlGoECgrciLIvlEXbWWO71SDQtH0u6v4d3h_xizRxFpGeMGbpWn24aIDE8A_4eA2
 bU4qKr9Z3gDx3pNr4_8LGC97nh375jUaq4..qe.vEdumbrmjcuRCvqsvM90gXXS80qdrWuYefAtN
 meFgQdqhkpaj8447lvfMpZmAvkQrqI5391eY39qig823fUrKejTKPpXelIL8iVF0C0zVog6P25ic
 aVYYQ_sFRQHEMuhibHOkkkYtabe_wzlfyUzcFstqnZj0qdYX8_4KbzcU6GEWyqEifrtaFLnDW4zA
 09J02dfN0hD9kia35wOxdpJftUxGyp2Rh0zk9cDYsIgWLaL7teNBvN1Y_4GOoHqWs2__PVnkF3ak
 NpuF1NsWmCyCowwNyZHbu.WWnAUK88KvrcYiDxV9OfGJbC89ajy54vyTmAJfXcc7FNAS6Lct4_8_
 vcqvuXX6EaUG8scOn3cgyanv5Rg7JEaOh0Q8nd2tDq2.ho5Kcuzbr_l8TdDMv9Z0IVmNClmhG09m
 cxEcjXonWP3zjtweykUf8Ls.kmX8WlQS.kbD.L3rkGpc1XRqxS8jARJaNlxGCE112a5zNtDCCOJU
 F
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Jan 2020 22:44:38 +0000
Date:   Thu, 16 Jan 2020 22:44:36 +0000 (UTC)
From:   Brian Gilvary <1brian.gilvary@gmail.com>
Reply-To: gilvarybrian@aol.com
Message-ID: <210796275.138246.1579214676876@mail.yahoo.com>
Subject: Happy New Year For Our Mutual Benefits
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <210796275.138246.1579214676876.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



As the Chief Financial Officer, British Petroleum Company Plc (BP), I am in=
 a position to facilitate immediate transfer of =C2=A348,000,000.00 (Forty =
Eight Million British Pounds Sterling), to any of your nominated bank accou=
nt in any part of the world.

Source of Funds: An over-invoiced payment from a past project executed in m=
y department. I cannot successfully achieve this transaction without presen=
ting you as foreign contractor who will provide the bank account to receive=
 the funds. Every documentation for the claim of the funds will be legally =
processed and documented, so I will need your full co-operation for our mut=
ual benefits.

We will discuss details if you are interested to work with me to secure thi=
s funds, as I said for our mutual benefits. I will be looking forward to yo=
ur prompt response.

Best regards
Brian Gilvary
Chief financial officer
BP, Plc.
Private Mobile & WhatsAPP Number: +44-753-718-0583

 Sent From Falcon Supernova iPhone 6 Pink Diamond
