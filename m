Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82DDA156411
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBHLxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 06:53:03 -0500
Received: from sonic301-31.consmr.mail.ne1.yahoo.com ([66.163.184.200]:34712
        "EHLO sonic301-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbgBHLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581162782; bh=kF/pcEfBOtAsQv2cevtwzcgZM9hROTAeAjeZe7aoPd4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=g8QFfWmwadiB+bsUwq5zqXEnCmUA1LhVc8HEeABnTwK64hJrB1zobCCvpbMgBAMAlj20JWCt7wyktcB3O1eRfQIjyPdSJhESXCalLpqwxIFPso27Yai9KjWhII5X+Ady+Cg5ydyJAU5UZfhXh4LPYvetK0Cn2+ASAVyevA2VUuLmgYRQ+3E7ysOK/LQepDw9zh29eTGlXHcfufTxqbhtks3jlqW+pDV8ptYQ30Ru7L9zPY6B//u5wp7NiZMg/hophrmqgTxoQQEC2R7UviOfbVJcP4s8yz+8geHjPvdkkQR4Y1idh96IkKotMSxoL+Lmv+WdWtizU72jtP5SqC7Kqg==
X-YMail-OSG: 7ULh7LkVM1lN9gGMyoPMdJx9Kx.1jIjCe_43ceLT5.h_zpceF_fv1UBdHlGfI40
 Cqp7eF.DEfTXOoJY1dfYVfI9pPNbxud24p_7r1SJMbAdrPvZcZUc6IIicL__Ej41HMeOGnebrLYD
 GegiY4wdkox2Dz3XJFr_E04Dz3WRAriOVr7gmIbiUPUXpzlZJ8qVEKQBRjZiuNEr39_l4jQ4F7cy
 c_lT6_j59Xi2SfHWetEwrQltAMagHQElmcvEGrVioNBT8Xsp1QXr7QogvvQzrzwwEyjjtUbLYhyU
 P._yI1ShFR5LSsdotpsDZp5Y7OcedJDuP4P7z6.kT5FZ.Sg2PL5_1YXBNaxx7ItvylGqY8RmgUap
 29TAEF2dVjHsFouq_8KAf2.9mLn63HeVQweTAq.nGIbAAUtqiOB5y.UcOKnr4frvigkzkpuCo0Dz
 ty__o6qukPIeCj5alwDzwanVIpI7QyNT2BMaIX1yNircqTOV81BmjD6b3vWb9Go5d3UXySbxD2xd
 Y21pncum6MXRC_MJ8AHeGS9N0gAsq48UGIbNF5LutdZws9aoaOrdxZf11UzNdf_dwvkPGiCOsnsi
 4Ac5eOUUg3v85H5Q8G5LJVoSZAoSdzRJO1fRTqHrs5cZkN8_CbwVtT2UjlcrOPOQ_Oy3rjM2L6Sm
 cPXW6ZadeDp9OePDaRqW_1evlnQOB4QJvd0DiZwhC2r88IFDRxI6l_4vM757a.BBdwlI_OFmWzhZ
 YDzqWfNqSJvm5mkjyycnX67T5RvNMDswfipH31NjkzscyLbCyALMre6wPfLda2nsm9DE.m0eCT1_
 .lGzIphzNPLx_KzLYiEqPAZf_3Vt2eenQL5MdZuDa_Pyia2qnyWCa9G9aCsTPNhFmFnvghd5T9RX
 HUj2iihapmqnRy6QSP.htdMXRtCg1cNGMsEk1UvclWi.SMQVbUMvPdh1boTWhDwzcYnEriVUibu2
 avr2.6gbwzrZFsthpdHuu5zl5EXq8zyZgHAWdUJI_OGz7wW5PdCaEG9nnT099nDUS3ztMANnyuWj
 qEtllEm3V0uUGru27jKibWMh1pHWREOLqEapaOl7Tu.i3Kgft7SePVCIGL2ajTR6F8ERynfNrwNE
 xfXhHd94c53l_S1Me8feoNnGQ6ecjdV8xvvG.14J8.MXNHZoE_OfgWQT9aXEvDzEThGbXfT491lA
 v7YKYHbhZYYSI3VozM_sIFn6LUKSIxlplBqAosfWnozLi1mMXXA45iLC10Kr9V1rUh2ZrXpfFEwm
 D_Hl_kCI7vo2IYrMf0E_UEwwn4Gk.KG_MYlTdk0Jt.nBVkasNSe8qMGv2LHtc.._JBMEptGmEgeq
 YkQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sat, 8 Feb 2020 11:53:02 +0000
Date:   Sat, 8 Feb 2020 11:53:01 +0000 (UTC)
From:   "Mrs. Aminatou Zainab" <lampia.jacki@gmail.com>
Reply-To: miss.aminatouzainab@gmail.com
Message-ID: <1452484684.128720.1581162781985@mail.yahoo.com>
Subject: ATTENTION: DEAR BENEFICIARY CONGRATULATIONS TO YOU,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1452484684.128720.1581162781985.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ATTENTION: DEAR BENEFICIARY CONGRATULATIONS TO YOU,

I RECEIVE YOUR CONTENT OF YOUR EMAIL FROM FEDEX ATM CARD OFFICES YOUR FUNDS SUM OF $10.500,000, 000. MILLION DOLLARS, HAS DISCOVER HERE AFTER THE BOARD OF DIRECTORS MEETINGS, THE UNITED NATIONS GOVERNMENT HAVE DECIDED TO ISSUE YOU YOUR (ATM CARD) VALUED @ TEN MILLION FIVE HUNDRED THOUSAND DOLLARS ($) COMPENSATION FUND THROUGH THIS (ATM) CARD.

THIS IS TO BRING TO YOUR NOTICE THAT YOUR VALUED SUM OF 10.5 MILLION DOLLARS HAS BEING CREDITED IN YOUR NAME AS BENEFICIARY TO THIS (ATM CARD), AND HAS BEEN HANDLE TO THE FOREIGN REMITTANCE DEPARTMENT TO SEND IT TO YOU IN YOUR FAVOR IMMEDIATELY WITHOUT ANY DELAY,

YOU HAVE ACCESS TO MAKE DAILY WITHDRAWALS OF ($5,500) UNITED STATE DOLLARS DAILY.

WE RECEIVE YOUR INFORMATIONS AND YOUR HOME ADDRESS OF YOUR COUNTRY AND WE WILL SEND TO YOU YOUR (ATM CARD), WE HAVE ALSO RECEIVED A SIGNAL FROM THE SWISS WORLD BANK TO TRANSFER YOUR BELONGING (ATM) TO YOU WITHIN ONE WEEK, WITHOUT ANY DELAY AS WE RECORD.

WE HAVE JUST FINISHED OUR ANNUAL GENERAL MEETING WITH BANK OF AMERICA (BOA).

FOR MORE INFORMATION PLEASE GET BACK TO ME AS SOON AS POSSIBLE.

YOURS
SINCERELY.

DIRECTOR FEDEX SERVICE (USA).
MRS. AMINATOU. Z. MAKEL.
