Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B272CC85F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 08:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJEGNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 02:13:45 -0400
Received: from sonic301-1.consmr.mail.bf2.yahoo.com ([74.6.129.40]:37938 "EHLO
        sonic301-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfJEGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 02:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570256023; bh=Pdj6Qgc5g9lvgIvk0piQBQlctr60E6NhcXTicQMPZds=; h=Date:From:Reply-To:Subject:From:Subject; b=MTVBZPdiU9hdLX1+612tXP/G88iULdDH8Oc0uhpaoVM1Z8XpcZQDZffeJLBikBcY7LH+Bz7W41tyTiBoDFqV/wFC2kP1frw7bz07WqexGohufmk/PXIOUc7gE3iErmRRJUPPbf4lFUwQAO/KiKMal1RuZD0SuSl42a7P09teD+zpuCOk1H5I7FbVGshAa4DzdsiCsrV6IymJwmOY2SDAReUK6AeduUHvWua0YuZnEaQRAfMHyLJODCmPNTApqgUTxtCQOHoG59gqqTje6nlM6ZmepM8HAOAM0sYHtlHe+KmjOZjSHYfmsSeTN0P+o6FxJEXQBl56nhrMoisUpkllNg==
X-YMail-OSG: Crh1T8wVM1nSW_FsvovhKoU.4HGbx6giEWmBYs.YkkOVY05yG3XBs0cT6H9yyMZ
 LBPdP0Fzz8BK9z0viFix_MUP8jdyIGtUpiSQei5_hbrgwTKbnncxZK5n9sP65wkpiKX.AbTrX5nk
 FcYjqOzJJMSrAs43d4COxoLCHgJElXI8O.Mu5zfs2dWxpZJi1kjw_zls2FhUSelYSR2pbwszMWvA
 aHIUCxY5T_p7CsZuHwaL7ehbQlYRFCXrf5iP7Jn70SERVemJaDAZfc8R0t_KIBnhZrqSrwdKEMMa
 fIK0g.c7U9BjmjgaQF5NGUhCktQv3PO1cvfprpreyfLR7_5RFcZyTwOokgG7Uz4fHad8rBtIzHJK
 49W3PniqPZ58H8bu7yup_XtLmU45P4RXv9RW2j8eC.RyG8q0vM0VYufh8hhrIVWvD6EK7185pOKw
 nUNA2hnpqccbydi2DeBK23FGqmR0b7x6ydHbVYAIqjBjdr30F4RzlK_aUt8ZDLZzPT8v2rQqW3fw
 Su8_L_FMkBPSXrHLqaQSDRXinuthFUk0rc7bUEJ4Hpflra8JKPYhXq.EQ1_aPVy414c.RjwsE3vh
 .C1Xn114fh3LhUTYuANfhQKfwyesmCUG6Pn4K8m8EHiT.lefDCv_9fh7n6x.OEsNJjiQn_SZRxCd
 Y9T8734czjYd9a4Yge0r6xFcx3UmZL623IuuQIALGF2h4pbcrKqMON3XDEkbjZ5..TAFizBiVrBZ
 a6Og0.v.gauchNLIpVB0dt7e.p0URbhOFMD9GsUGB7QPpYPCCpXUwIQkm2sWlM61hTN9Iq2XpWjY
 4X4uzzqQEI18WaQsjdfHCuJ8Tzjq0FP9naENPeqQ7E2nXXwPBxinMkwIyopSIWyBcm6cd2pz1HXL
 tYBCrjec6oqYOrhsnF2Fj_lF.6eX7PYix6VL8_IuAdZbGdDmjGJ6sk6.VFchkB4NRUrjFZ8vBLsF
 _nRskX8pqJq0Ihr2JIPN7i98mpxM8aCniKPTHYl4XVcJR9Twfnv6gYcU637f4zVh7z4v0WeIfaAc
 ZfaQbIMKOrx912KX64nIq.hkA5ZZQR4GAqXE6G82644VkjYaUE3tatKABp67xOg_tvbRpeEaE5Lm
 sj74DUMrKl8JFauKeyrWk8aHHH3eq1Z_IXGSBF.hxPr2wGBQGFyX635GBU7ZAXh82TXZs_3HFTSw
 Jg95i0nwAzwGHPXrBMgl0bA_XTRz50KFHjEuT8mtlTWHooH6sWuSaKd656TtVg3sR3Mps4So0CyE
 aZTaMYbr8UZvY_FN0wOOl3pmVtzegwgN0wnCkgDHD8G9r4hk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Sat, 5 Oct 2019 06:13:43 +0000
Date:   Sat, 5 Oct 2019 06:13:43 +0000 (UTC)
From:   Tracy William <drhahakim01@gmail.com>
Reply-To: drtrawill2010@gmail.com
Message-ID: <575414381.2569141.1570256023015@mail.yahoo.com>
Subject:  Hello Dear
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello Dear,

how are you today,I hope you are doing great.

It is my great pleasure to contact you,I want to make a new and special friend,I hope you don't mind. My name is Tracy William from the United States, Am a french and English nationality. I will give you pictures and more details about my self as soon as i hear from you in my email account bellow,

Thanks
Tracy
