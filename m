Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA6B18923B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 00:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCQXhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 19:37:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43991 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgCQXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 19:37:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id x18so15639251qki.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=efrxms/lgbeWU/ht4DbMjddPv2cvhd4eDWsLcCs+9wc=;
        b=BYGRtL9Z+xSirwpOnTcId3wsbFsePUgk+T7mkVWtaSfj4elbtwT0ILDhi5PQO4szlq
         k8h7p5onIMGS+cPCN9VnvOOfau9ry5bjm8q25NIu3h+8PvxGxtVsHrDdsy+vvjc0vDn6
         x4YaUbReAs0qbfN2AyOjIjkQak9HDAC7MA1e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=efrxms/lgbeWU/ht4DbMjddPv2cvhd4eDWsLcCs+9wc=;
        b=X9OqYFgwsq+T1GkRdniPtPRgjTYWu4LiTyhj10MbjTDQUWNRR0mwY6hpXsatEZgX0S
         oQCDxdLulU3+c4okOQslue7UxM5CgxlA0rNgfpDz5x+VjphK0PuMaASwNcl53oHtugxz
         rUj/2cGtdnIQnMCuzva2tC/87PKihO8W01zSfRofgeWUZrR2MNNQD8QVDiiJ5FDJA7y3
         bBJu/6/LxZP/UTy2x02HK2GO958xcRJr/1NwZRY7PqVgQevEhTPEUU02E9sWi8oHMA9G
         6Srv2qcOUKmwJSfvRRGYQA4quxY1HsbrLjURA1OALiz15EyeXYhiBfkFBOSRHMMwHjU6
         uOkA==
X-Gm-Message-State: ANhLgQ05z1vYIEJvKgRZD+xGCnL/TEVLTvZk0RSFeXJLMkkW6jqNO/O8
        zB+EmPcUnriTJa+wlVTxcF5cPw==
X-Google-Smtp-Source: ADFU+vviYYwduyWwVBJyzF/cegtNFQa17R/O+unpT8Wumt19sZAp593zp8ZCDjYlIXJEujhG73n8wQ==
X-Received: by 2002:ae9:e897:: with SMTP id a145mr1421172qkg.458.1584488270357;
        Tue, 17 Mar 2020 16:37:50 -0700 (PDT)
Received: from ?IPv6:2600:1003:b859:47ef:4eab:4a1f:4139:85b7? ([2600:1003:b859:47ef:4eab:4a1f:4139:85b7])
        by smtp.gmail.com with ESMTPSA id k11sm3193034qti.68.2020.03.17.16.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 16:37:49 -0700 (PDT)
Date:   Tue, 17 Mar 2020 19:37:47 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20200317224820.GP3199@paulmck-ThinkPad-P72>
References: <20200316163228.62068-1-joel@joelfernandes.org> <20200317210822.GM3199@paulmck-ThinkPad-P72> <20200317214502.GA29184@paulmck-ThinkPad-P72> <CAEXW_YQxKfcGf3UgEn_8hdWHdMx09RvD90z6zo=kk-iRinYjng@mail.gmail.com> <20200317224820.GP3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 rcu-dev 1/3] rcuperf: Add ability to increase object allocation size
To:     paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
From:   joel@joelfernandes.org
Message-ID: <A6C6D60E-9E01-40FC-8396-9F2FF2803E2E@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 17, 2020 6:48:20 PM EDT, "Paul E=2E McKenney" <paulmck@kernel=2Eo=
rg> wrote:
>On Tue, Mar 17, 2020 at 06:30:51PM -0400, Joel Fernandes wrote:
>> On Tue, Mar 17, 2020 at 5:45 PM Paul E=2E McKenney <paulmck@kernel=2Eor=
g>
>wrote:
>> >
>> > On Tue, Mar 17, 2020 at 02:08:22PM -0700, Paul E=2E McKenney wrote:
>> > > On Mon, Mar 16, 2020 at 12:32:26PM -0400, Joel Fernandes (Google)
>wrote:
>> > > > This allows us to increase memory pressure dynamically using a
>new
>> > > > rcuperf boot command line parameter called 'rcumult'=2E
>> > > >
>> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes=2Eorg>
>> > >
>> > > Applied for testing and review, thank you!
>> >
>> > But testing did not go far:
>> >
>> > kernel/rcu/tree=2Ec: In function =E2=80=98kfree_rcu_shrink_count=E2=
=80=99:
>> > kernel/rcu/tree=2Ec:3120:16: warning: unused variable =E2=80=98flags=
=E2=80=99
>[-Wunused-variable]
>> >   unsigned long flags, count =3D 0;
>>=20
>> I fixed the warning already but did not resend since it was just the
>> one unused variable warning=2E The patches are otherwise good to apply=
=2E
>> Sorry, and I can resend it soon if you are not reapplying right now=2E
>
>So remove "flags, " and all is well?

Yes, that's right=2E I dropped the lock but forgot to remove it=2E

>If so, I can just as easily fix that as take a new series=2E  But next
>time, please give a fella a warning=2E  ;-)

Will do, my bad=2E Thank you ;-)

- Joel

>
>							Thanx, Paul

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
