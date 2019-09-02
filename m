Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF81FA5CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 21:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfIBT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 15:57:09 -0400
Received: from sonic302-22.consmr.mail.ne1.yahoo.com ([66.163.186.148]:32862
        "EHLO sonic302-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727188AbfIBT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567454227; bh=yqDabFs/2ajL4+uqvl75CNrBfWTfbOsHh54Xr0A4zFM=; h=Date:From:Reply-To:Subject:From:Subject; b=Ra929z85qvL5NSy3DtTXhFT48p7LzHDF2FOc8FOWdlhF48iSSV1hvujpqEBJN14AQHVTMMEEvjekllDeI4SyMlhrL7Ls0eh4zSr/xueFvAfdTjMYdcgdHUzSR8zLfH+h8SaT+X9weh3jSpCewylH8iu5sUhWP0A43JEITGRfOKEMoyuwBOOcBATREPk97VA2p6rwwWkKMf5KTIuTG6uu7AfS9L1V4d9Ctgc20MgtcaApdjgnJMwl4oTxMtnhYX31pdVdf6ttU6dUGon+HXN45FvVeAoxsJaVRP0EIg+NlczLyZdQ7e7drmKY918Po6yO62RLKJbJ5oB+4qP8xiJDkA==
X-YMail-OSG: a5faxnAVM1mAmncQm1mZLflfb34TQk4pAdslnOyCynn.WlXSxpSlWXQ04wGgVds
 W3cMTNICC5yLOVMxLBHLkQAHngBKUOYxsc6kLjMKmq.HoBwX_MHclWYRLrjF97Ssf1AjmVyzph95
 8_0FuyReSyueLDzGZLGKr9KlCfvvjzbMVkCc1x3Jbq7qQjdL_2ZROUUnJRgzfDyBsm1durETP7XU
 JvZmH.r5PjGlUt3iOXiJqrSaLGv.5ZG.WrbiIeLslrWjPJBEJrpk9rL.0vb1kiF9_Buia0gkQHKn
 z45Uqt8RJivs370c1KKuYupTR_L2LwXHbOFlR60Jp3E8H5tlN0L5768bHyTYxC9CXxYy3YUb2W84
 y6J1Yt3GSvyVoaA0ideE.kaBxs5aVLneqMFEypHbTLxsjjY39qYF5Unp2ZzZn2xDvNXue41mUdpX
 GIq9BYB2uAqWVXOx9bcsE4DCpnygYAX3zW4zu07Z_A9a6JpxtSH8TBG3faErOxcXorkF9TLvCXPl
 .mpDaUc7ph_NptGHOeY3_dJmmfwCPKGTPa4KGRWSQz8zSkc3YRmLtVy4L4w4wyuLv5QZXH.A0uAf
 mdhR5GTiQ_Cn1YvbRk._2b18nVl.Aw1qB1pX3bBwxqoYj0rF3YD3cMsAZyOinwsLLoJMx6TkqMzh
 1l3NHD1ajJUQH7oAu6jQSgaxs9Bhs_rYu5iyYJ_edXOuoptsMe_niRLuVoCGzNiDRzUmx5rKSUWG
 gDwYzHw3ap3wakz0URailELMq05YUjWMRiLEl2_0VeKED5Pgtia_TA.RB.1kyzH0VK5S4B3bYAIh
 0x1XmrkN36O31hXVgiDPzeId74i9IwIM1rRSUe.Q4lSC97mRISHosA8J0dWFjicHZem24__16ORu
 JbQZJSWJ4FwyWY.UBEAyUgnMDOcxhyFdeqRkU2r3jZPuz7of1tgAAviT0HrWvYf_5Xlvvj2ArIVH
 PBmQxmbqZymi7knTz7KFWb_39dOSZxzGjuNplxTVGb2.ok_TOa5TR.qL4sg09OlkwFkNA3mGkGgh
 wA8xCW7LQnABNCTnwjx_TOrvWWghv4TKpymlaECCEmuWMP_WAPtya0a_c2xlJNE3EL14cCn4AIMw
 W6ZBs7Y3ZbqA0w5ds7TVO27GSfSyUcHEHBGMfgjySFKUx4BHRWBQztazA4fvUzGRpK1HiqqXel.2
 nb0Eynn4vSEtV.pNynCHVd3_kC8ZVoDQMkFiWcNl3_3MJ6Ayf9b9quxe9MOpmlgo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Sep 2019 19:57:07 +0000
Date:   Mon, 2 Sep 2019 19:57:05 +0000 (UTC)
From:   Elizabeth Edwards <mrselizabethedward1@gmail.com>
Reply-To: ee3201366@gmail.com
Message-ID: <580419624.1325005.1567454225426@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

Please forgive me for stressing you with my predicaments as I know that thi=
s letter may come to you as big surprise. Actually, as my pastor advised me=
 to reject earthly reward and thanks by handing the project to someone I ha=
ve never seen or met for a greater reward in heaven awaits for whoever can =
give such a costly donation. I came across your E-mail from my personal sea=
rch, and I decided to email you directly believing that you will be honest =
to fulfill my final wish before or after my death.

Meanwhile, I am Madam Elizabeth Edwards, 73 years, am from USA, still child=
less. I am suffering from Adenocarcinoma Cancer of the lungs for the past 8=
 years and from all indication my condition is really deteriorating as my d=
octors have confirmed and courageously advised me that I may not live beyon=
d 2 weeks from now for the reason that my tumor has reached a critical stag=
e which has defiled all forms of medical treatment.

Since my days are numbered, I=E2=80=99ve decided willingly to fulfill my lo=
ng-time vow to donate to the underprivileged the sum of Eighteen million fi=
ve hundred thousand dollars ($18.5m) I deposited in a different account ove=
r 8 years now because I have tried to handle this project by myself but I h=
ave seen that my health could not allow me to do so anymore. My promise for=
 the poor includes building of well-equipped charity foundation hospital an=
d a technical school for their survival.

If you will be honest, kind and willing to assist me handle this charity pr=
oject as I=E2=80=99ve mentioned here, I will like you to provide me your pe=
rsonal data like. Contact me through this email address (elisabethe1981@mai=
l.com) and also send me your private email address.

(1) Your full name:
(2) country:
(3) phone number:
(4) Age:

Best Regards!
Mrs. Elizabeth Edwards
