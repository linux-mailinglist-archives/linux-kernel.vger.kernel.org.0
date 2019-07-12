Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5446698A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGLJAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 05:00:44 -0400
Received: from sonic304-21.consmr.mail.ir2.yahoo.com ([77.238.179.146]:46631
        "EHLO sonic304-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbfGLJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562922041; bh=u8XFPqNsGRdMa7huNNxSVdzYhZMLXdUTpQ5NlWpKKps=; h=Date:From:Reply-To:Subject:From:Subject; b=gxpZgqE6/Lg63foMh/Mn13knBv8dGS1ILKKaPMB6qDxyXLgVojtDFKF1pVwOe+aaixNwP2hdbxQ94kaLHF57p65i2qf6QpE7sNBu3/xCBHBbBIxFm2QYWtDyrtZBw9kbk7uNbbD7Rdv1GwM2E0VyISChmOnHkBJDadUNrXnvETsP9DM6ENBf2LWZLqqvTBNrm+6Gex3manHTq8uICPDJ23jUqTwLTFCpWcLU+ae3lhdtfB39o9WRzHQ/mAL17UCOTeq2JGMwovnV8flZw48vR+5dVx+nPIDE8Rs24lDP/vlK9+b2Ht0jrzLAjNjKFmqfRFpYufjzJaaG35fnvKL2Zw==
X-YMail-OSG: Hd00pugVM1llMLKyl87YBpA7BJMiMOQnZhs4CsqUgddM.yOTJ5t0cgd1umDEl5E
 h5q8Ssxc9Gpg5Vq6MSU_kxCG3cUpnjc209s7BWIkTsrL8g.HJVNNqqe0IyphxhUc1BIsmfFZt5dE
 7rLfEjBwoygRYFI8bWACvYG0xMBxX_ytSbJHHGYGc8yRPXgKYlXuHb8SJtrWPwtoY6dol7Zxw96o
 eupRaHCIadmyMh1O6qtiCQ_fUcpr1k3j5xAxy1tpJRPw6Bs6oRzzHtOUT7RNDRe2JJnCKLuKfcbS
 eAaNKgenqW46KUkrF6sqvwRMKHvvU_E8IsfFAR8M2KDGiUlPn00LncHqkBOTEZ7jQtw7.Ue2zEqZ
 BvEXBv686ja_MiUni14xEXjbOVQqDNwOW3G3Kn7XPPOcL31l80ByIpx0AvSY6YyZxhhsFGzx2BWh
 OCKK21RBHcvJ_znMMW0jxL9GtWA1IOCbsCRusmbs5fdY_QqGoO0n2wj.jANnFvGtkvJpPKC3lyIS
 wtvZVktmvvTG_FOY0O9ZJwalueeNOZ36WfeKmQ1qBycoFL_zv4XmUGaGOsnGofwllqIqFYnTrOnw
 j_AfQvOkobHHuxOAL9cWewrFkg6wR79OgSL6uHofiYc8VRd_eRkXuZXfvpmp.qbPNvXGrleaAwgb
 Bo3tMP8sI773BHDRnjwjAS6DNDV8BENVMn1iaAi8lBE2Mb.vTuvNse6Sfl9w9gsK1XBxvORjGeVm
 9OA21uLAOJhWJJOtJfCAfaBjVUn6lP4_skU22HK0P292ttkXKXkiLuhbE7RCFYY1WKWgY1UvWC7a
 SBVX7S5cVI7RpZ2nbK9kaAdSdmJj3BiuFwaXIFiSIx6aySjB0bVH13W9Y8IERkQ0vnGrQoLSvLbF
 0DYc5Wy8OfjdEFNQv6mZdsSU8ekZwquVnAbfQB1PBCUy5BTp_xdCa8oW9.FJMPSsXqv0jAOA.Sl2
 37aDi6oaqdrZ.XXzmxIv3bd9MFUWENB3_RYWh6dPYhjeidpDH7GRvQUgRwMM2MIpwSx8atVcsQju
 aN_VTpID6JoKhle3c4v23q553lLn0RT9oMu9gOA35a2hD7BXS98aSus9siwx1H8DZBZ8yS1UDkQQ
 PcOuCG8yob.wGmMaMBxFeh4v1oh_1fsRyue4hcO_.x6G7hHjBESGCG7AXfESCxKBX85pZuWjtkPi
 6ad4S_Bg0_zGXi4QgiHLg2qoI1n5oq6WHPfOMrDI5B5xcHUGBq.HOqtGCb9iSWa5EmD4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Jul 2019 09:00:41 +0000
Date:   Fri, 12 Jul 2019 09:00:36 +0000 (UTC)
From:   Wilson Smith <smithwil456@gmail.com>
Reply-To: smithwil456@gmail.com
Message-ID: <1472516134.165885.1562922036677@mail.yahoo.com>
Subject: HELLO! PLEASE TRY AND RESPOND SOONEST
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


My Dear Friend,

Before I introduce myself, I wish to inform you that this letter is not a h=
oax mail and I urge you to treat it serious. This letter must come to you a=
s a big surprise, but I believe it is only a day that people meet and becom=
e great friends and business partners. Please I want you to read this lette=
r very carefully and I must apologize for barging this message into your ma=
ilbox without any formal introduction due to the urgency and confidentialit=
y of this business and I know that this message will come to you as a surpr=
ise. Please this is not a joke and I will not like you to joke with it ok, =
with due respect to your person and much sincerity of purpose, I make this =
contact with you as I believe that you can be of great assistance to me. My=
 name is Mr.Wilson Smith, from London, UK. I work in Kas Bank UK branch as =
telex manager, please see this as a confidential message and do not reveal =
it to another person and let me know whether you can be of assistance regar=
ding my proposal below because it is top secret.

I am about to retire from active Banking service to start a new life but I =
am sceptical to reveal this particular secret to a stranger. You must assur=
e me that everything will be handled confidentially because we are not goin=
g to suffer again in life. It has been 10 years now that most of the greedy=
 African Politicians used our bank to launder money overseas through the he=
lp of their Political advisers. Most of the funds which they transferred ou=
t of the shores of Africa were gold and oil money that was supposed to have=
 been used to develop the continent. Their Political advisers always inflat=
ed the amounts before transferring to foreign accounts, so I also used the =
opportunity to divert part of the funds hence I am aware that there is no o=
fficial trace of how much was transferred as all the accounts used for such=
 transfers were being closed after transfer. I acted as the Bank Officer to=
 most of the politicians and when I discovered that they were using me to s=
ucceed in their greedy act; I also cleaned some of their banking records fr=
om the Bank files and no one cared to ask me because the money was too much=
 for them to control. They laundered over =C2=A35billion pounds during the =
process.

Before I send this message to you, I have already diverted (=C2=A33.5millio=
n pounds) to an escrow account belonging to no one in the bank. The bank is=
 anxious now to know who the beneficiary to the funds is because they have =
made a lot of profits with the funds. It is more than Eight years now and m=
ost of the politicians are no longer using our bank to transfer funds overs=
eas. The (=C2=A33.5million pounds) has been laying waste in our bank and I =
don=E2=80=99t want to retire from the bank without transferring the funds t=
o a foreign account to enable me to share the proceeds with the receiver (a=
 foreigner). The money will be shared 60% for me and 40% for you. There is =
no one coming to ask you about the funds because I secured everything. I on=
ly want you to assist me by providing a reliable bank account where the fun=
ds can be transferred. Make Sure You Reply To My private email: wilsnl74@gm=
ail.com
