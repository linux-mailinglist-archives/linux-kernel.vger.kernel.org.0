Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508C459858
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 12:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfF1K0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 06:26:52 -0400
Received: from sonic309-42.consmr.mail.bf2.yahoo.com ([74.6.129.216]:35704
        "EHLO sonic309-42.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbfF1K0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561717610; bh=j5mdRk0FDy84HzZpdNEePcyF7efRPWFS/pXKk6qNhnM=; h=Date:From:Reply-To:Subject:From:Subject; b=scSeIzHu23iG1oS5sg9IBk6d5FlIZdDroi44dxQTxsEBv9Kw6uRb83G7nnRqfjbD9gw5qcA+5lNZvqE9zr+vZDHukLBzJPknwvXnwRMqbYaAqeumNZCN8xxRbPeybc0FNhPYF5ZMp9IFfrTzKO8yE8KqjC0hLsZ7+QWRwnJneSVBWp9NYYJNtLHZnvkUdqAa2EqVsfspNCItPMmVSx9463a5t1d6ybo8X9Kd71CXUw20srHd1Al6JhXHACxyHLt3k56m8k+qMK9gF+qLj7XJmmy/80byaaQCSryNuQObBHr0Q9SBHaheYuTDDTnGZuOM3wO8fhzGkNYxK5ChrLivJQ==
X-YMail-OSG: HG2Ui.cVM1kYoPQAxYnJUUinwYSVEWSvRf4WaqVSHVJtSTEb7pyob8UclnRrv8j
 coFH3LzZuXGMqR5Spstq.6eb4spcEfBoUgc7KyaTxSMWUpT2ZcHA9ORrsc6HwBzuNubVkgiauPSV
 u_p_XT9_fA1e_7FLqyDsN4KQ9A53rNiTve88R4upTORzEIvJhIhmmINu5eRqH7A8VRGtFvOEFp1V
 hJr9ncu9NFW1shwj9k44OwTVAtUwZ7RUVIZ6hC0nnuMwlXQJ05jmQdrmYEaQ2yC72tiZXm_XcLDY
 hX5y1BpqJHVZq8SzIVi4H1DYJGETAKwVcY_YxZfUvr6_n0wRfOv0WlSEkEbgDcCdR9Wb2bLJP_8m
 XV_pjTT4slWw4CI53z6E8IyvfqYUWtP.irLlqfCXlJeD.g.cO6ANR5y6LvmFFb9OnTCF8A58bubx
 gdjPFWsClKMBIFcL_5nyZe5vZ49xZRE8B8ScyxLpskoxnAJxDsxisYUjJYp6ZaPKGlpIqMvKuZnJ
 jLooxtw_5uAvFJvBrAjVoNhOZiK5cIPE.uW11961WwmnkL1Bo8B7u.dhxHenRycQzsZ2w3imLo1n
 1y93Y7255Q0_Rh_iwkX6HBSx3xZA2yMczLM.62in.d3tZ1m5Zkxp4spuey6PrtHEQ4SfY9PnJHxf
 qMDNJravPyMzILHhbIqrl59GX.lV8AatTiK9BDgj6RVycBetjKxG0DUt8T9Mcrz0sjXIhClvi2oA
 tY9z4JdzxI.KFQElIZyfpc9rOHtVzG8bJKn4Y8Rwk9GejAwwqWXYqfuEUWKL6bp6NC0ANi67AbFk
 FkCh.gJyF0_znNBcp60WUk3exMfC5Vb.8dxZFcT0KtZIILMRq6kZjAjrO_vcXcZWd1wuHo9oegoX
 0t7MsTVsDqYglEQ23YJr3gHNc4f9qNYRA1dSdqUZ5u.m4nUgx.zbAKEmVC7Mn69pXNO0Vj15CHqg
 XSlRhQcQr8dFkKzZWWftVymAbxC7AoytWrbGtCDPH6P5H0m4XnAWccj27rGYulLv09XxQ41nOB.c
 5ijUlkjZwdPmE0k.O6lQiK6TtKoKhWCbN9ZOe4fH2sKMBcwoq4UQY2cWGlxcpp5DHz6exq7iO9QS
 t3qZ71lBpfIh02KK00EXMiYYRdZ7gwawPxT.dvs_U_lGmuNAIoS9Pt8vUIX0BPzPcduzI5uYAR.8
 0al9.wwGFNei5ExaCdnFZz3aWtHQSnW_YCpakcVhb9je1qYiH.fvru_WGymm8unVbYVVpQhCr3e.
 9a_X7ZFh3KDW2t7K00jlnSlVUmIcwo0qg8NzjZdy0LIk0gbo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Fri, 28 Jun 2019 10:26:50 +0000
Date:   Fri, 28 Jun 2019 10:24:49 +0000 (UTC)
From:   Mrs Alice Johnson <davidmark6682@gmail.com>
Reply-To: mrsalicejohnson4@gmail.com
Message-ID: <1145470982.120669.1561717489232@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear=C2=A0Friend,

I=C2=A0am=C2=A0Mrs=C2=A0Alice=C2=A0Johnson.am=C2=A0sending=C2=A0you=C2=A0th=
is=C2=A0brief=C2=A0letter=C2=A0to=C2=A0solicit=C2=A0your
partnership=C2=A0to=C2=A0transfer=C2=A0$18.5=C2=A0million=C2=A0US=C2=A0Doll=
ars.I=C2=A0shall=C2=A0send=C2=A0you=C2=A0more
information=C2=A0and=C2=A0procedures=C2=A0when=C2=A0I=C2=A0receive=C2=A0pos=
itive=C2=A0response=C2=A0from=C2=A0you.
please=C2=A0send=C2=A0me=C2=A0a=C2=A0message=C2=A0in=C2=A0my=C2=A0Email=C2=
=A0box=C2=A0(mrsalicejohnson4@gmail.com)
as=C2=A0i=C2=A0wait=C2=A0to=C2=A0hear=C2=A0from=C2=A0you.

Best=C2=A0regard
Mrs=C2=A0Alice=C2=A0Johnson
