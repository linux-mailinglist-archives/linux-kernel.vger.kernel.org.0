Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21A6107FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 19:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKWSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 13:15:11 -0500
Received: from sonic317-32.consmr.mail.ne1.yahoo.com ([66.163.184.43]:35481
        "EHLO sonic317-32.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbfKWSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574532909; bh=vLkiBUFFdSYaNKVyMQWndPbf7F5YdSjLkabW1cFAHBw=; h=Date:From:Reply-To:Subject:From:Subject; b=Sfeie9bHEYRxZMd2iJpge+UsWYqftYsJyAxOPfLAdQjBERkrJ7nJEaopQ0pwiLRhsrPu1p5IDOMymppEWpxuCnNkdi3GvzO8xWYBTEhCzCzgKSQavyWZvUwTZvLj+VvsBBhdViL1DBkVDg+lXRpNoUGKKuualzRlgXZCDqXVop0rxROCq5Az3YTmE+D1YprcwsP7bQj5cjc2UgL0J27SBSVK6vg6vVQ0gHBC3nQ7DVkzz0WWxznn3RS935Q0WaZEn81F3qXRf41RQRa8BxHbfraf73CRNqhdvjRPAJRcO4ySNvxp/5+CioI+R97DPmfd/X3Gex/depr44EOzRPJhog==
X-YMail-OSG: yo_4tkYVM1mQ3bnL.kFEd71QRb5b.3hByiTfO3XD4OQZ7_qTXsMp846s8jIwx5L
 2cDMP4gj4llafYESxcv3f0KCH79FWFF67zYxmaUFGxQZUccTi5OMFs46xmBrfeiwJ1rramsjfWPW
 9KFNtq0YB646jq_lM7cq1Oc2XRgbbYaNB37LSk.Et44SeBNU3ItMoKZUeaFDfeI0QWQdCQyHGKaq
 DH9_gAUzFOCjK.J9ueXufhIpG.Pss6BpINKOkSQS05LTB_sgxRVsMHAt0TE82BCdzkRdhirmnWFK
 8ZDCduCAswJMi4IQvalDQ9ZldBj9DHuLfM9Ik_urY10wFHvoxCLFwtUr84_cV4.GZ6YCPLsI0Z3T
 Jw7mtkvfwX9uPECzFrCnoEG9IUoOW1MuLPgIEuJ_mi.QKHzFAN0Xy_VgY42pFzmTK7N35p6JNdoa
 8oCkG7JYyYXcmGgwumHt0ABK0AZ03DgMDzvd9eHllHUD5gwlB7Ezdd5ZRjSO7hNyYNJiApptKy4J
 vlbhUwvV5foIT.SX5mHPa6oJk8UAtUwWx8OJifHfpUq9zzZZbnaCKYqOm.KStD8dXUd0SrjqVanZ
 y7W6xyvkHq3r_hcpfoq8l587JYrSNZaV6mxwfyEAJpkFzPbiZZuOZWWH6_E9a1qrTjNsV7E2Aem6
 BCL4fUbSpSw97g9i0ITKzGQVwd0.8HNAjMvOdkN874.ioQUQdIChTjyH.ftqizsyTSFTYFD6ZX.x
 ZYCS7vkoR7.SXWmQap9EecjUThMiZbZA2x2wKYphZLafLc2rcL1LSjK0Y.W.psgVO8IdpvtQFv2J
 6VuqliTwVbtbcpXonY25iDfQHvwTPSiyxOg8H5ccoVcDpRyTGd7rv60bXl4tMMcpMvYsaODDdtZG
 5fVbdbXKsGTQHlOjsDPdZnUXpcPtrWShb0uSDGqxVGrMEUbNK8n9kvjqcUwcpWLLxtoLGU5paWD1
 41jikc71qWi7lKJmmyIGPd3ef.fJx7Bpa5HrYWay44tNGxaTAQVkNN05f.xglMrVMGuJRQky_xvW
 WPT6oqRmUu3wA1NPHGS.QSk3wPy2kpal32JrkWQO6cKp7nOaEWSgtUgjR7EIDJZ_v0IpJ30Ivxon
 ncUz1V1eu_JqhPuRb3gL7RY3cz.xAwpX8Naink8HdrCsoSj3zszACTF76d_bOWGJsklBImf6yDNe
 w6C09GP6ZzM3vuZCDbqD5.Ic8WEx.jQtsj6YSFMWH8_RI1ddFNGNWZ3XF0BK_7csz5wG..CPkI37
 hhOAdrawpxXtrv6rTK8TNdkzVf5TuAWZNwMj8PDQsZmdcEEjFhe0NRJOMsyGbnwlnGeO8TH4MX_7
 BtH8HEv.Pdt7BVTuK5UzJJxHjJIWq9.N1P5SStwT6ww--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 23 Nov 2019 18:15:09 +0000
Date:   Sat, 23 Nov 2019 18:15:08 +0000 (UTC)
From:   Barr Kummar Faso <mrrobisonb60@gmail.com>
Reply-To: wu.paymentofic@fastservice.com
Message-ID: <1845773801.4487563.1574532908019@mail.yahoo.com>
Subject: YOUR GIFT WESTERN UNION PAYMENT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATTN;BENEFICIARY:


You=C2=A0are=C2=A0welcome=C2=A0to=C2=A0Western=C2=A0UNION

office=C2=A0Burkina=C2=A0Faso.



Am=C2=A0Barr=C2=A0Kummar=C2=A0Faso=C2=A0by=C2=A0name,=C2=A0The=C2=A0new=C2=
=A0director=C2=A0of=C2=A0Western=C2=A0Union=C2=A0Foreign=C2=A0Operation.


I=C2=A0resumed=C2=A0work=C2=A0today=C2=A0and=C2=A0your=C2=A0daily=C2=A0tran=
sfer=C2=A0file=C2=A0was=C2=A0submitted=C2=A0as=C2=A0pending=C2=A0payment=C2=
=A0in=C2=A0our=C2=A0Western=C2=A0union=C2=A0Bank=C2=A0and=C2=A0after=C2=A0m=
y=C2=A0verification,=C2=A0I=C2=A0called=C2=A0the=C2=A0formal=C2=A0Accountan=
t=C2=A0Officer=C2=A0in-charge=C2=A0of=C2=A0your=C2=A0payment=C2=A0to=C2=A0f=
ind=C2=A0out=C2=A0the=C2=A0reason=C2=A0why=C2=A0they=C2=A0are=C2=A0delaying=
=C2=A0your=C2=A0daily=C2=A0transfer=C2=A0and=C2=A0he=C2=A0explained=C2=A0th=
at=C2=A0you=C2=A0was=C2=A0unable=C2=A0to=C2=A0activate=C2=A0your=C2=A0daily=
=C2=A0installment=C2=A0account=C2=A0fully.



However,=C2=A0I=C2=A0don't=C2=A0know=C2=A0your=C2=A0financial=C2=A0capabili=
ty=C2=A0at=C2=A0this=C2=A0moment=C2=A0and=C2=A0it=C2=A0was=C2=A0the=C2=A0re=
ason=C2=A0why=C2=A0I=C2=A0decided=C2=A0to=C2=A0help=C2=A0in=C2=A0this=C2=A0=
matter=C2=A0just=C2=A0to=C2=A0make=C2=A0it=C2=A0easy=C2=A0for=C2=A0you=C2=
=A0to=C2=A0start=C2=A0receiving=C2=A0your=C2=A0daily=C2=A0transfer=C2=A0bec=
ause=C2=A0I=C2=A0know=C2=A0that=C2=A0when=C2=A0you=C2=A0receive=C2=A0the=C2=
=A0total=C2=A0sum=C2=A0$900.000.00=C2=A0usd=C2=A0that=C2=A0you=C2=A0will=C2=
=A0definitely=C2=A0compensate=C2=A0me.



I=C2=A0don't=C2=A0want=C2=A0you=C2=A0to=C2=A0lose=C2=A0this=C2=A0fund=C2=A0=
at=C2=A0this=C2=A0stage=C2=A0after=C2=A0all=C2=A0your=C2=A0efforts.=C2=A0Mo=
st=C2=A0wise=C2=A0people=C2=A0prefer=C2=A0to=C2=A0use=C2=A0this=C2=A0medium=
=C2=A0western=C2=A0union=C2=A0money=C2=A0transfer=C2=A0now=C2=A0as=C2=A0the=
=C2=A0best=C2=A0and=C2=A0reliable=C2=A0means=C2=A0of=C2=A0transfer,Kindly=
=C2=A0take=C2=A0control=C2=A0of=C2=A0yourself=C2=A0and=C2=A0leave=C2=A0ever=
ything=C2=A0to=C2=A0God=C2=A0because=C2=A0I=C2=A0know=C2=A0that=C2=A0from=
=C2=A0now=C2=A0on,=C2=A0you=C2=A0will=C2=A0be=C2=A0the=C2=A0one=C2=A0to=C2=
=A0say=C2=A0that=C2=A0our=C2=A0lord=C2=A0is=C2=A0good,=C2=A0so=C2=A0I=C2=A0=
will=C2=A0advice=C2=A0you=C2=A0to=C2=A0send=C2=A0me=C2=A0your=C2=A0direct=
=C2=A0phone=C2=A0number=C2=A0your=C2=A0address,country,Pass=C2=A0port=C2=A0=
because=C2=A0I=C2=A0will=C2=A0text=C2=A0you=C2=A0the=C2=A0MTCN=C2=A0through=
=C2=A0SMS=C2=A0and=C2=A0attach=C2=A0other=C2=A0information=C2=A0and=C2=A0se=
nd=C2=A0to=C2=A0you=C2=A0through=C2=A0your=C2=A0email=C2=A0box,=C2=A0Sender=
=C2=A0name=C2=A0Sender=E2=80=99s=C2=A0address=C2=A0with=C2=A0including=C2=
=A0all=C2=A0documents=C2=A0involve=C2=A0in=C2=A0the=C2=A0transaction.


For=C2=A0this=C2=A0moment=C2=A0I=C2=A0will=C2=A0be=C2=A0very=C2=A0glad=C2=
=A0for=C2=A0your=C2=A0quick=C2=A0response=C2=A0by=C2=A0sending=C2=A0sum=C2=
=A0of=C2=A0$25.00=C2=A0so=C2=A0that=C2=A0I=C2=A0will=C2=A0quickly=C2=A0do=
=C2=A0the=C2=A0needful=C2=A0and=C2=A0finalize=C2=A0everything=C2=A0within=
=C2=A01:43pm=C2=A0our=C2=A0local=C2=A0time=C2=A0here,=C2=A0I=C2=A0am=C2=A0g=
iving=C2=A0you=C2=A0every=C2=A0assurance=C2=A0that=C2=A0as=C2=A0soon=C2=A0a=
s=C2=A0I=C2=A0receive=C2=A0the=C2=A0$25.00=C2=A0that=C2=A0I=C2=A0will=C2=A0=
activate=C2=A0your=C2=A0daily=C2=A0installment=C2=A0account=C2=A0and=C2=A0p=
roceed=C2=A0with=C2=A0your=C2=A0first=C2=A0transfer=C2=A0of=C2=A0$7,000.00=
=C2=A0before=C2=A01:43pm=C2=A0our=C2=A0local=C2=A0time=C2=A0because=C2=A0I=
=C2=A0will=C2=A0close=C2=A0once=C2=A0its=C2=A06:30pm.



Contact=C2=A0person=C2=A0Barr=C2=A0Faso=C2=A0Kummar
contact=C2=A0Email:=C2=A0wu.paymentofic@fastservice.com




Be=C2=A0aware=C2=A0that=C2=A0all=C2=A0verification's=C2=A0and=C2=A0arrangem=
ent=C2=A0involve=C2=A0in=C2=A0this=C2=A0transfer=C2=A0has=C2=A0being=C2=A0m=
ade=C2=A0in=C2=A0your=C2=A0favour.=C2=A0So=C2=A0I=C2=A0need=C2=A0your=C2=A0=
maximum=C2=A0co-operation=C2=A0to=C2=A0ensure=C2=A0that=C2=A0strictest=C2=
=A0confidence=C2=A0is=C2=A0maintained=C2=A0to=C2=A0avoid=C2=A0any=C2=A0furt=
her=C2=A0delay.


Send=C2=A0the=C2=A0$25.00=C2=A0through=C2=A0Western=C2=A0Union=C2=A0Money=
=C2=A0Transfer=C2=A0to=C2=A0below=C2=A0following=C2=A0information=C2=A0and=
=C2=A0get=C2=A0back=C2=A0to=C2=A0me=C2=A0with=C2=A0copy=C2=A0of=C2=A0the=C2=
=A0Western=C2=A0Union=C2=A0slip=C2=A0OK?




Receiver's=C2=A0Name...
Country....=C2=A0Burkina=C2=A0Faso
Text=C2=A0Question..........Good
Answer.............News
Amount=C2=A0.......$25=C2=A0USD
MTCN............


I=C2=A0felt=C2=A0pains=C2=A0after=C2=A0going=C2=A0through=C2=A0your=C2=A0pa=
yment=C2=A0file=C2=A0and=C2=A0found=C2=A0the=C2=A0reason=C2=A0why=C2=A0you=
=C2=A0have=C2=A0not=C2=A0start=C2=A0receiving=C2=A0your=C2=A0fund=C2=A0from=
=C2=A0this=C2=A0department=C2=A0and=C2=A0ready=C2=A0to=C2=A0do=C2=A0my=C2=
=A0utmost=C2=A0to=C2=A0make=C2=A0sure=C2=A0you=C2=A0receive=C2=A0it=C2=A0al=
l=C2=A0OK?

Be=C2=A0rest=C2=A0assured=C2=A0that=C2=A0I=C2=A0will=C2=A0activate=C2=A0you=
r=C2=A0daily=C2=A0installment=C2=A0account=C2=A0and=C2=A0post=C2=A0your=C2=
=A0first=C2=A0$7,000=C2=A0USD=C2=A0for=C2=A0you=C2=A0to=C2=A0pick-up=C2=A0t=
oday=C2=A0as=C2=A0soon=C2=A0as=C2=A0we=C2=A0receive=C2=A0the=C2=A0fee=C2=A0=
from=C2=A0you.

Please=C2=A0do=C2=A0not=C2=A0hesitate=C2=A0to=C2=A0contact=C2=A0us=C2=A0aga=
in=C2=A0should=C2=A0you=C2=A0require=C2=A0additional=C2=A0information=C2=A0=
or=C2=A0call=C2=A0+226=C2=A063=C2=A031=C2=A074=C2=A073=C2=A0for=C2=A0furthe=
r=C2=A0urgent=C2=A0attention,=C2=A0as=C2=A0we=C2=A0are=C2=A0here=C2=A0to=C2=
=A0serve=C2=A0you=C2=A0the=C2=A0best.
