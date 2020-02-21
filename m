Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3208168527
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 18:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgBURhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 12:37:45 -0500
Received: from sonic301-3.consmr.mail.bf2.yahoo.com ([74.6.129.42]:44052 "EHLO
        sonic301-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgBURhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582306663; bh=wAc60N6vLjQHYjkwN/FPZ2a336n5fQmyKBZ7D/QmUmw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=B7eNxmv/gOidirAnszimugU+NKCGcuNpR7kLg0eZvHBEdXIzrLLyaZZDdwKAzul1iQDiqoR5rYQPcsidPLwcWMYOo7SR963ML1IJWsTlQUvlcx7kgqkUXkuml7qEly9zJ5YE5oVYlb1EkqR3m6Dv1/ZphBiGLEXqBWaFq8jqLlHYpkk2yL1qRZZGGFbMHHvageDO8Xke8UDqQEhivOEl7tPLoe9/7l8Xk9zQ906xz7H60vly39YHSlzRxc/KwFwI7WZoafuOhdWXj/+JJljQNE+vbhhzTBvGRqJ/8a0s2eLO1F4FWGPiGVdmDdYBFiuWTh0Wy5IbAot9YVp1yNWlVQ==
X-YMail-OSG: OcwHIR0VM1kpcdLQ_ekdkEkbo3ebJlzxBNlwD2bX6cgU05bXvDdhM60C7RRxMI_
 jftQ7Wsyk6bKXwje6BXYfCq7tldvtPpfVZ.CwtFz2BGcZY8pgiHxrp5RVpTslKCrU8Q4XS_raiyz
 w1Y8k6Y2AvAm6fqE9RPROL.SKGxbjcUz2Yi69VYUDAG0NSgiRzyoheaa1_Luj99Ks_xQsFkaoLcc
 FxMcELVLg7zhLDLo9tF5F9r_ZgWab08LPd5AEZVeQHAPMEo21MTYwyvH37Vfxh25TXj23VR80gez
 HTcqJMQFziRHrF7j12sWS4VhrgjYRBbjbYznLaQqT7CBfwyE0kMbr30lCsRnOQGuCEq6C7XPSHR4
 IS_SED8pVXMQV9YHk5M6lqth2bA55dD7zBOqHyaiA7RmIs2zMigUtyGcl_MnaBhhVglcxJiJmLVG
 hVtoiQMmZtgf8bbBNHl2xYMZ6rO0n6irjvqdE8y6_ZhEjGW27blzcaq9tmhDHY8egaSp0606ASuh
 xkW1.D7Z7Q4eXMcT0aSOTMa1Y7_6X7UNuZCB8ULLjid4SfVj9E9C3wW7ZaYO7ndu6bLfhhbLTSTv
 gw.IfzZ.9SMwsuxbxs3rRWvNmPuNl5_U51EIcrftnq6ceIhqMnfJvqEeO0ncYwWD9vvbXuY_3hUs
 UGpKgQJ9zcJ8bAoqKRgX2h83RG.3Pz2fKDzEHnqBMERWQ3HsXmo7Dg6VRC2hd.T8Oy3BiILhTnxM
 xORy_ImYFD7X3c9552399n.gBcr2LWDq4r.6New1W.JVGQhfOskOrXuxxB5zkHgmFK7YvDcveca7
 J9oHznGnfzReReq178Iht4lzgpRA2vOk9xKlWtnXDem3iuOlnTFHuNg2Ji3bdiKBGcgG5D4HPe0p
 _M6HEetruuVs08Tp2XNDjUYE4exzT2HSa2RDHQVotdU80NbA2o1z53MKifGA1noyotQXxr3sZ5Yp
 Fzrv7QNFF9Lrk0uJeA_OsTSx0faqESqaeeAiZsyptfllRstTqedJvoCFRVHy91V3R7HD36qQ.QsG
 1V91xl3u6Tw3qO76Q.YlhHtAu3CjdCkCuuDhrE3s0GpaCq0x8oxaaqtTJQQS5P9HgAYj5QhEPQds
 7Te55Sst5ZO8NOYMeOxB75mi..8zppvCtWh4HnpSwqnjmvQs1tmEsyb.0zx4vcj2JVxyLkCbplT1
 7rQ4ISdC_AYpERLcY3E61zD.MxL2dTo7i2.lxzEGWKGt0zARgwlJfHuLfVQd26D6InHxg.DynzPS
 ExxRybeuPQHcU0Xuxj2EYBxQ7bT9oW.k.TSkBix5EF7qmXmc4XpobJ3ZrxFkMgyo84PTvzRVk2DW
 1spzV
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Feb 2020 17:37:43 +0000
Date:   Fri, 21 Feb 2020 17:37:38 +0000 (UTC)
From:   Mrs Elodie Antoine <mrselodieantoine@gmail.com>
Reply-To: antoinm93@yahoo.com
Message-ID: <960857917.4611270.1582306658055@mail.yahoo.com>
Subject: Greeting from Mrs Elodie Antoine,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <960857917.4611270.1582306658055.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:73.0) Gecko/20100101 Firefox/73.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greeting from Mrs Elodie Antoine,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS CHRIST the giver of every good thing. Good day,i know this letter will definitely come to you as a huge surprise, but I implore you to take the time to go through it carefully as the decision you make will go off a long way to determine my future and continued existence. I am Mrs Elodie Antoine
aging widow of 59 years old suffering from long time illness. I have some funds I inherited from my late husband,

The sum of (US$4.5 Million Dollars) and I needed a very honest and God fearing who can withdraw this money then use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the internet after honest prayers to the LORD to bring me a helper and i decided to contact you if you may be willing and interested to handle these trust funds in good faith before anything happens to me.
I accept this decision because I do not have any child who will inherit this money after I die. I want your urgent reply to me so that I will give you the deposit receipt which the COMPANY issued to me as next of kin for immediate transfer of the money to your account in your country, to start the good work of God, I want you to use the 15/percent of the total amount to help yourself in doing the project.


I am desperately in keen need of assistance and I have summoned up courage to contact you for this task, you must not fail me and the millions of the poor people in our todays WORLD. This is no stolen money and there are no dangers involved,100% RISK FREE with full legal proof. Please if you would be able to use the funds for the Charity works kindly let me know immediately.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish. I want you to take 15 percent of the total money for your personal use while 85% of the money will go to charity.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish.


kindly respond for further details.

Thanks and God bless you,

Mrs Elodie Antoine
