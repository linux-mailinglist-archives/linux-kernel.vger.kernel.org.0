Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF85159B17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 22:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBKV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 16:28:23 -0500
Received: from sonic308-2.consmr.mail.bf2.yahoo.com ([74.6.130.41]:36632 "EHLO
        sonic308-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727675AbgBKV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1581456502; bh=B+qUant9zxaSySoUSH4LDR6FflTfsnHsa6B91Xilm9U=; h=Date:From:Reply-To:Subject:References:From:Subject; b=O4KxXQJysO47LEQVBlRH1TOyk2kY5RekQuPTU6xSczp47ZtwKKCRzLMKLbHVePIyMpoqxxxsjom3CefZ2F9zHSbr3cfq/VKnD6SmgXfidjdqZYx5UioPf8Qu0besd3ExgQWI2ihzcOLD7E8gfCWlts2PHDfvKBMFpIWIix3UCYQwFpfDNOb5Js+K269c66/3+eEp7ACJuNuicFfr+3vE9V0Mwqy0w2sGwTQ+kblcOrF8G+mZq32CMcUs0aspBQ5aMRfsbXpiUGhwvs+I1UqZsTev2fFlq2BKNNxBktEnXwPp05ZB9udsmfzssa0e30w5MTVaIT46GzE2PzYBLuQr2w==
X-YMail-OSG: fF4oj8AVM1mntNw5UEo1crNnHp7FiPe63iolrcFY9toP8FRfOiUbaQ8Q5TqW8Pg
 6A_BRvGoXw9gg98D28X38_clVBDQzTWnwxVwl_jAOgahOWwNt5WfthlRSsXzU_zCIOrxVesJGt3I
 qhztkU.gUmXKCQ6LtH5_m4SO7uXp95Eiw0zVEoqM2DUBSfbd_PEx31geBkb7OfVScPDd7_dh6NNf
 Wp9wnQFKitqy.k.Kmyur12y9kwx3CU1IUYTa8D_E7SPdIOwO3SUwmsksaQERBR18G8GJbkDlkOKc
 dmJgW2CCmM_Ex3jBDFFqDXqtEbuUF6pQxEsPj3cCyfucFvdtlpetUEWWdlQ6UUROYeHEXlf9zsvQ
 YD.f0jjav1Uyi6JCKqkkafzx.F0WLgBZibr7sl2m9D2qR3krLkpuyZGkshHP9rU4tvOTuOq4wpog
 _hRWdD0jKkPFlvPb_D6pR5Fz0PpltLCWeOTaAd.Q9p9gxdEl2OfMKRB02b6rBhzROMJd41vUfVbg
 _OE4AxW.01BVMLWonyvEtGwD.CZbWJED9NV3Fq9jE0AlyZ59kZNayrp9oCiCP54NF87yrl899Ma6
 __w.Ie.atLzC62zo1PdB7O.VjjrJiTD6DEBp3AtXZyaev0yaQ0aLBnIaEv2MFIu_6eD1nJ5TzhNU
 gsi5DBiVsA_bTUY0zCf1OcGzNlq_TSRPZVc145sXUnCx18Yi1PN7XyOPHYMO5nPFZxBl6JBbdPnY
 waJSB6XFQZ9wZTmchLQMaaK9MdVaw7Jg.zgA1PTlQpH5vjDcoM_nVSEl5AMNmNUALxsSrhcRhlbA
 Sss8R111vUe.0fledQYhtwPJyz1FeSf8tKddqD.eivajhOcRthMuzkdJN4hkNWx0ve9.MOn99dso
 3CLBQhZZhvoh0XA2yg85BATjmTp3xxCC4NoACkN4SrVcUL9jiNbXQhr8tAVnBD62fhtZxKwpNlg8
 P7ZyVl0GjIkr4KLyW4vd3ZT7EBeuGqLmjjUPVSYlIC1959YCFxmw9tlkr.AA6uvUS9ZjOAykFfjN
 WXDBTlCo7Z05AQAU7XbnLIEOimTBNPd1mOMoV5LgJbxytpoPo0UriReKLbH04tSYwurEohvLlN6a
 HEKbPV7reQ_S9HMwF7Cqno1aZdkjKVfOeze4zAYJLbvCKFCuL_1uiDQAOsCW9BEw3WczKYfMsZ3_
 d2YbyAJqNT3wARNPqs2iGLo3o34Hhys52mni.A_BwZSpwliAlLBFupeWoj.ZPZngU7vYoq9xyC2N
 ZeSrHAgujv81l2w9wNl_k2aMrYk.ehEtNuyQg5jfMkfSvh8ld6lci_REt9.DhTAPBFQJiOavzNne
 Sa11c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 11 Feb 2020 21:28:22 +0000
Date:   Tue, 11 Feb 2020 21:18:19 +0000 (UTC)
From:   Linda cbally <lindacbally@aol.com>
Reply-To: lindacbally@aol.com
Message-ID: <295242989.1161128.1581455899297@mail.yahoo.com>
Subject: My Dear
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <295242989.1161128.1581455899297.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.100 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear

With warm heart, I offer my friendship and greetings, I hope this message meet you in good time. However, Mine names are Ms. Linda Ibrahim Coulibaly. I am 24 years old female. I have sent you mail twice but you never replied any of them. I humbly ask that you reply this message, to enable me disclose the reason while I have been trying to reach out to you. I do apologize for infringing on your privacy.

greetings Linda Ibrahim Coulibaly
