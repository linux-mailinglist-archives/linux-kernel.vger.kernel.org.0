Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A33196C74
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgC2Kdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 06:33:39 -0400
Received: from sonic314-53.consmr.mail.ne1.yahoo.com ([66.163.189.179]:41741
        "EHLO sonic314-53.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727869AbgC2Kdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 06:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585478018; bh=VQV+To5S2gWVZyYzSF6aVVNoKJSf7fw7hH7Ff0SULss=; h=Date:From:Reply-To:Subject:References:From:Subject; b=EEWdadSBaRvl2gFX/o+RLRWGE9/hDlBU57DT0EXdA0RScN3pW0bYjuHokyN4sX8CsqofrJQr+9eKapmKSAAro+8PsNshy7Dicps0edOoRPFj4N0uuJDYi8bGqLo+c0i9ah7pz2Ll1jrvrNSgOFcYJceEm+E1KcoL4PEBSdE8FBi1wsxNdWKaR8BAAO7AJ5/lorhR8nRI8e5H+FiriH8HTiEyXVCegBcD0LlVkzWmPO1EvFn42mrIG3j/LlL9fLrcir8RkI17s1XvvsIfSlP655lFccVPAk8fR2rwZByk7X5rPeiLsykaU6LGFLkG5IXRa/UcXFknfUIG9lCSVf/5Wg==
X-YMail-OSG: M5Rq1xgVM1kW93sZuoDFa9WUXAnb6H44dGFQCjbq7liEwRM3ppreDdgntWQD23l
 xM.C7w0mTVW1D0QTUXBBwtNDccDIjeez.owivp7AMKG.fJcHU1mD3k1L8NMREp.aAYgW8847bebW
 nltCahAJLwm8Izq2aY_Mkm2R3lGtUC_CVG9T1tDVGIxG6Nmpgx71A9.7w63gtb15AHy2Mm9baZkE
 sTEmNN7gSwtnBJS6CzsbZ3L2Q4PlvWUR64Qu65X3ouoRoILTuGAh54BarVnfyPp2pHMoA1RphwC5
 NiesDjTiie2Ka950dnDuW99R6NLhP9g0F24xI4amChMlxaie4FgRAXEqs4hqpqKkoCYmzkm.u6q_
 HldDb_ASftO_8C_BiL4OCkTWjt4Vi9aYsB_ZNvgLVY8h6Mb3.Wcfa1HlAQnAlhytfCcUbzL65XYj
 bYZCSVI3YuhNDcxz_hCk.ZNYml.Xl74g42XEHTdZskmxhL.wScFziC7pheDj5HYfR0X4MfcvIod1
 b0eFI3_7T3T4tRyYCRtfzNlmq7wCrmYxBX3zKYTHKCh8UqsJhUTsh3sVneC.Gy7aSiyhvIxyRC8L
 sVb2ttAnJbB2h3KnzhRSkoYgZYuZj_5KrjeiD03aFBAnL1qMMhWJ16SmehZ00brQVAH28f5w2x7X
 iqZEcElkTqB9lncj_XZAMAJgT5T6nSEZ.apy5UIJ6TidCw345QWRxEJyjw2IpZYC_3ECqkgLN8Z7
 IYn_psjOSdHn.MTVdjY7mug0UbT3xjMX8uHyQniCCNT4V4pKkUwAyNSumO1TlJwsPi.JhJ339.TX
 hZWpd92WvigOvNEG80_BoMYbCAaswssp.9l01tEPojcoZ8.sSHUWtYDZyYQe8uX4zhDUmHgQwIct
 f7rHjYFRLNBHq_plZ.8soINGrp3hXZQ2zAkEirAK0Jfse6JuSTFz.skMiGZaMjtloOYaWoONDUS7
 8.12iBIU1LN1AXWnGhAnzxMzfqLuyq6i4TrymKWDYjy4eLtqpVQHfdOCftC7Eb.4052C8KVsnDXP
 pCvx.9C94ILt4eVECfCHFSn7tkyWczcCP_OwmuguMcCZIbo_bCNxN_x1DlTroC.ImLtjI4QsRfXp
 2_ae_pcNbihRcjSTu6BUB7CFs8f.VLWWgI7oRsX1F6Cr7S.DNQOTmPR6fhZZS9xA.x_QWjZyxWIg
 aqJXj4LwuIs.FMJgFPx4nFs8kpT0TkNtNfhj813y8R_aIGci2CMZ8yKV6lJXornOGyOuWSdLKssy
 h5Q_DZ_jMvCJdSrQWyEvV.neO1TJ2WjLciZq2FUH44rFp0RJzxz.aHurINPi1aVlRYAKMUZ.hxo2
 EEmXWNxiwaOLe080JscJQz9EhTHgJyA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sun, 29 Mar 2020 10:33:38 +0000
Date:   Sun, 29 Mar 2020 10:31:36 +0000 (UTC)
From:   Wang Xiu Ying <fgfghfghgffg@gtxbm.net>
Reply-To: wying353@yahoo.com
Message-ID: <326602938.568819.1585477896915@mail.yahoo.com>
Subject: My proposal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <326602938.568819.1585477896915.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15555 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3237.0 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Good Day,
I am Wang Xiu Ying, the Director for Credit & Marketing Chong Hing Bank, Hong Kong, Chong Hing Bank Center, 24 Des Voeux Road Central, Hong Kong. I have a business proposal of USD$13,991,674 All confirmable documents to back up the claims will be made availableto you prior to your acceptance and as soon as I receive your return mail.
Best Regards,
Wang Xiu Ying
