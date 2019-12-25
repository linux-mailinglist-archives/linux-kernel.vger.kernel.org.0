Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF012A6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 09:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfLYIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 03:47:20 -0500
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:43362 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfLYIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 03:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577263638; bh=E+ks7AydzaUb4ISZTuxin7s0E6gVmk5020fTLYVYB5E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=CKgZYl4cPvGy2+mFEob+ypT+VkxljF7fqL2g6QQ3Q2M4mTcEbNhA155iFXb1tFMdAOBG2zDaSYXudgMDrAM4p/DM2aue8cBBy9Qx6W9TGY1E7LnTWtM3lrtorOWO0JrSUR6M9lSMF2y3x1h26I5T/rcRCdbmIUp+6w0tvbz6tkybhOH0Z6uPJ5CCsxY0yA/S7PQjU5qP1LfDG0IQQ3eF3seQt+VRnEt9nxjVx3bRBF6vfEkvOqcFVMTqNrHqCCwXNWZQWABi1bMUnrbJ5z9GSd+J+yuRedQ0r1efTf8fjnZGeqznjpNgZ7VQSkr0VKPaAft16PsEEUarBTpHuWcFSA==
X-YMail-OSG: zi1ZF4EVM1mQRQi_xP4HHGhbBNIuVSTfWnUKRTpOe5aCJuk_P5lUvnapbGghlVF
 1flk9D4Im4m8gbzMtkXIqnDTfU1baPn8TvKGafNFUnAwmQnMGIxiX1EB6MXco0nvf0Zkd.oQRRmG
 T5.gbjvt6hjThX88vK1mhkpT0UB7ALzjUlnzNUyzm0TfYMHTPrc.TOwQsv0RJWooXLv_QV0oatT.
 h8s9895Xo0cu3kpSluhIgLO6PN3Bv_dBAjSwX1lA9VxW4m8iAgOo1zxNTJ7ax.7XNarE0CbEvvxo
 u_qD4X3Z3J78PpGxk5I0e1YdAejS1gO2ptfmOv3ipVw.D91XX2uTgIvNXXL6qFIL1Rn0xYcdm4BC
 odUc_EI_C4oAYeySh5Yk9T8naNXZd39VOI6l30kFykcEoU65_z5vvScws4VEXOp1eSQEYihzgV7b
 B2NG618HKUQq5hxIYd5INTztsfVBxvp_nidEZx4knJvhfTEaat0fPDZ06uy.2W1hWdupJfMWZoVu
 CIO7zjricc3ecokJPiNh7.IFLSBZETuWQCYhZclR3CeWSFFniAfuxlVkxM3na_HxKsb6W9eSgz10
 AMpnn2OZ26zevzt1Frlj4y6KTtDFwa1isjAxuXnHvPU4QkpW.c4bUOxE6GFbl5GHFV_x1lXjCfqo
 qzx2rppaG1KpsficdhzzqZ_GShUQNOCyQB2A3QL0Ezw1pafuwvjjdw7uz730oVaINXGsWe8Li3Y8
 tBqzSbm7cwRpw_CyumBdhNlAaYaEnL2L7lzdU_13DFF_jzI9uoZXj61aWCQ9QBcFamUsk8.uLwoc
 .vRnhizSn.ER08Ciz1vCsQVxvcMWm6NdLLIkFocLtdms0ityNbCDtw4MzQ4v0AnT9Kl.cUPQnImp
 7yc90GSJF4423VYimyxYRh9Q7ZuvTqpmtPt8cPWO.t1ZbtH_vFwUUyGVuiX_7Im0r1U9YHYl2d1P
 2MwJv5kLDXJguvrMp8n6hijYpOHj3IoXxv8EGmU6xyIPTo6t0b2GrztyE0UazVG7qGqtui3C5.az
 s6pB7HmJ_2kJx.A0kblxLue9ThNcp.WVZ_ixcx8zQCH7FKbE5atQDEAwDbNkOrvvBY8V.gezAAHT
 qXbiJgAX6EODiSjxrhMD9NPZDqYxuUl_dfjrxitVR372CWeraM35u7MO9xfW6FVjaPGUYBNy1RIZ
 McBkTkBCebM9K6GzcqmXl65I5Kd9sU7sslFeu0m0AOvjZgrorghCU0OedQKDlpCAwDJ8S21TD5In
 vs.3r2lRvsNTIHgF36PcgdHi4nnD.JGI0eOry3tgAhJJM9n9khconfvDcB0xjXWLsBP.D8b_GczN
 4056VlmlKmIZhAiycenWlg_USMFQCB.g-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 25 Dec 2019 08:47:18 +0000
Date:   Wed, 25 Dec 2019 08:47:14 +0000 (UTC)
From:   Aisha Gaddafi <gaddafi661@gmail.com>
Reply-To: gaddafia504@gmail.com
Message-ID: <1024459777.2206980.1577263634095@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1024459777.2206980.1577263634095.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:71.0) Gecko/20100101 Firefox/71.0
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
(gaddafia504@gmail.com)
