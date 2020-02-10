Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B081E157DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgBJOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 09:53:45 -0500
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:39937 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727570AbgBJOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581346423; bh=ntCsvVlsVYNXsouoo59ZH21v1wHZ5nZJzCG4NsnkusM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=gGp/Vgx7NRyLSa7Mt3nFkcNCi1bHI9rSUdKqaF8SN1B25MCXWQw0Q3AHigSR6DL4BEaUYiv5tCwxoFSptIIyzo5h8FN7IptZongOnU/GlScUqf2oR/E1pceVihnuVuB01ZDKFWZQmK6qV7XwfFIQ71lqUGulr5r0VMrLmzmG1fG2BfBVXfiAKh8liRC3LM+xPN0Du48S2P/K4IhoaDASSMbxQPqj2iEdRKVPAR7dmcows2RzparwRW0/PzZUXwSsHQQ7Tf+nyalgK3A8GJuHdCw2JihHhfGRB3C2Mzo1yHZlcnbWqIFE+uhRvZX6beE3kf3z+7c70F/2vjmlgHU4pg==
X-YMail-OSG: R1uqNBYVM1kRaY7s9Qf2URSkCJFptKHVaSBGimSOqFpnRmMVjm97cKG6rYgmldV
 _7QxYM2L.150t4x8hKCKimt8sHYmNhDtvcxAioFL4IJuXWVzgyJ_S9qwRUtxX3Ox1E5vc1Vg4cv4
 K7GZaROA2X47mjAaBXDhCZtkaMFCziuGK9QXL8Tep.4LSRQHpZMY.sm7pNPz9D.3goybjQ4sEF58
 dfCm8Gd1zRAhK2PGmwdk7D8WBwMCu1PBajDBOtkh6LwYsKHBIAcs_HCMzCeYC3ZkqJCMgFnyT3PP
 9xHeWxDEiZj3WZ39iGxC5y.PVh1c_DJ667jVOES8M1ZetLZ3N_ihb_OPs684TFumMru1zzgR7STH
 nRRE62G5epRPaLNh5VPtWic0U9H_LLVnyCWsDk_HBjjXs1W1JX.McJQ6KjRTZkWQlp331hm4T0Nl
 5DhbFdY1kitPWwxAhM_uqngePSqpg8Pj7KPWZx_Pan0F.jYyzeyKPGYn97HvBGgwcChdZQvMFk_.
 02yyx5WixTv8AOnr13e0xjzYaewAzAMNYRoEcdQuBOMGeKGTWkRqKn2M6yAPUKP6f1RR94fM_QJh
 fLwj3df3FvO8gSntX0r3tOwMPKIdiNczCdmpWDbCBArXP6nm3MZmTmEW7mOS9udQl41ZMbnHeRXo
 4s9pyX3N7rXZP4CEGVfCDRnooY5Udy4_Z2gXEzVyFKfcAxYxf.AlUqltt2loudsIKtkcPoZSbOeZ
 ulyeyHPT3MQ7NQW_9W51ttu4H.9dvA_YdM8L1MSZlOiS1m6hic08xdS5BGnpEqw3s..OT0FVjb6Y
 T7_ujTy5QCatAFNpIZUPs.pvyQDkr4HaNNjqUIlQT4w4ENpMXo.swa6UiVxURRiFgQ5TOLRAPijY
 6qkGFZ9FEohGqf4aXlFMpJZ6V3rIT2PApdUFURdjbubkSRubpH2ePgjk5_tL8E9Sfcconr5cn7SO
 49zmW7PFnHnunHo6g2RZyzuuycvmJHvVkK9_acgmwelK7KRhpMBo6NC3oolqNzS_mr2Uva9O5MJn
 F26L.MleZtgL0IXSxQbHfkVVtvuPIVQpoWBf6y4p4focLyoUyTpxlWZ6Ir.3Z3Z2Srz5Tax.6tPL
 0GhoAAYAb6vs4jYgwf_vXvTS4QIC7sMpphvZNQ.RayNwSuUj_4Jw41fI5i9GpAAw_6eIgFX8KS.x
 DT30TMEjZYUW8zLKg65Yug28HyHM5pSeAC1RP.zxslbw7V3LRNGqqQBGE7paPoMNanccakMv7G0L
 o3FzqWeEICdOtTF.c8lZw2CYSJnCoBs1BRpNuI4cZhxCTp0T_EbsRcn3a1Zfasym49HNdLg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Mon, 10 Feb 2020 14:53:43 +0000
Date:   Mon, 10 Feb 2020 14:53:42 +0000 (UTC)
From:   "Mrs. Aminatou Zainab" <jackson.jacksonn556@gmail.com>
Reply-To: miss.aminatouzainab@gmail.com
Message-ID: <1480388708.588666.1581346422044@mail.yahoo.com>
Subject: WITH DUE RESPECT YOUR ATTENTION IS VERY VERY NEEDED URGENT.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1480388708.588666.1581346422044.ref@mail.yahoo.com>
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
