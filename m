Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC387D31D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfJJUO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 16:14:57 -0400
Received: from sonic317-32.consmr.mail.ne1.yahoo.com ([66.163.184.43]:43319
        "EHLO sonic317-32.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbfJJUO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570738495; bh=dRX5d8v++xfAAoPIT3VpAbTnk4dfpHOyQKhLrN2OBJk=; h=Date:From:Reply-To:Subject:From:Subject; b=kFE/00wL2O6RXKjcgIvEOP+39mOWapQgBoAXWKQshiLwHAaxkAGq9ZCarRSFCP8eWnOLFz8Nfh2rM6Y/4eiwUAzHREYkTAcYyjAJEPmzNtSFVy+6DFfA1u21MQs4nvE2cPHGtIyQEbxaYulZYe5NCM773o8AcI+53vqWKPMZdpIb3Eir9ZgquxzWJ3HPphS9lZMZF+gkqB/TMyMaL7//aptOFsGV3nQA/+MOnMVkBmL5W/5nkFEAOxt032a0jvD/Ij34zXSJ3s7bOIQWnaxgFd7ePK42X/jCJs9b7YWUoe6l6uXxkUqpGeqIXUluCDL0XmYVnQDGYxAESk/yqSg30g==
X-YMail-OSG: UEQ6Ll0VM1mowvJvMqCl55YallAkB.sjy7_WVMH4wSlOi2Hui.o1LiwVDMVdHp1
 1mCT_CLEPAGtBuvEnfdjFG4EMmOrnsIY8_cGg3NCgvlXkFwLGhq7y3UNiVpJVyugrTGeck_CpDyU
 .hQ.Inzh9Xiygd5EFe9BdPW9RMTtSbJ4yk3JlJhB7_zDU_bj2U1e05_Qw9EvgcB9FmFHi1tVIEUG
 vj2UE2CInyyUpACEHlXs7TM5SqiLyiMqMAMIcRjFt0C3FH4ze6AdiKgvxviYJ8WBdH7uWGbIgyBQ
 2Ui8SnC96X9sDG5Gej7fXzE.Kpi3jOHNLwxbSPRYOV.cwayKx1nt_C.RJe6xFmmrRHAYdGHJuSGP
 sNgiuNGLwwwOnEpYz5xAfl.4j13LXoCZKXyVgEeOHmVkp8tjvIaM_N1G0w8H4DFGcO_vAb8akj2r
 9a4jWlB8gXdfXRBvFUg08En3CalCxy8ja_yJcp6oFg18JQkpEKNWC3vMh1G8OFeZUWBaVk8On9iC
 slossbalS67MAUw6X9KSXj8X.xDu2dLETTEP_SfZhRww3Slm8F0kPv2asUkTN0A.b2Q0AYAh6c22
 Fosb9j8rJFcI1jbcOKqVWIIPCTyfRJxo5mChbwkJqaEZmGP71WW8uNA4Fo.W3c3XhLfwAalF66Xi
 eunoPrvAQnZahXVqx6Rl8Fqt549CK4GABgJuP18iBLVtAsPM5MnuS86bGGO7q0awZW6JuIA5AWdl
 _FjNEwJb1_CLBl4mfKBnunvPcv0h9uPapG8.rN6Fy6F.muYGfQHvaNBGzDF1oFJI5pnkQmUPrB5D
 Xs7uHXFwGgnpZae79rakGKjW8T6zBomDc502LWMj39LRSMjSpe0P1rPu2qKhx9AxeDhaFKrbYJDO
 hC3t5JxAcZsOmgQI0oSaMgZQzSMccQRCAZ0WFJaWBmahqkrQDjJlSx6LTZdbnk65NlTIMsfkc_p3
 v9BJz6jo_YC6Gxt5gunC8p3tAlZ8.Oeyduxkks8UTg.MmbAt0MklWAFPE3OamiBAojkGwhgqB2a9
 PV6ACvmQ1yx7_kBxxLgpt5F7d98.b6XWSrJT0DEEDPyJrtv4_xmu26FAMllOjOlba46le7jlSuvC
 g1fNnhn7CD4Z7uyogo5nI2VBLdiB0CxXr3Ecl6LAtygHdWT_9ZGMPHACuBPALb4XZCLX8doqZn6P
 Gw7yTRfsilXR_s6sRKQ4fkqUvqDFVDoHNbXa7mof7lVFteukSQJ7FhB_HTqu5kE4C79IAQRFt9t4
 SGvOo6qoapW9AUdKqx7FaU0cOwN4Bh9bKNnXWYRG73aFdsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Oct 2019 20:14:55 +0000
Date:   Thu, 10 Oct 2019 20:14:53 +0000 (UTC)
From:   Miss Abibatu Ali <abibatuali01@gmail.com>
Reply-To: abibatu22ali@gmail.com
Message-ID: <1181728683.6620294.1570738493367@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I'm "Mrs.Abibatu Ali" married to Mr. Ali ( an International Contractor and Oil Merchant/ jointly in Exposition of Agro  Equipment ) who died in  Burkina Faso attack,  i am 64 years old and diagnosed of cancer for about 2 years ago  and my husband informed me that he deposited the sum of (17.3Million USD Only) with a Finance house) in  UAGADOUGOU BURKINA FASO.

I want you to help me to use this money  for a charity project before I die, for the Poor, Less-privileged and  ORPHANAGES in
your country.  Please kindly respond

quickly for further details.

Yours fairly friend,
Mrs. Abibatu Ali 
