Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E466ABE00
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 18:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405932AbfIFQss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 12:48:48 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39319 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfIFQss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:48:48 -0400
Received: by mail-wm1-f48.google.com with SMTP id q12so7842235wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=WqzJM7D3m+j/VALbdXaY9LFDVmtXJLRKN7AtxDWWJro=;
        b=P0Y3Cxv9LAB60ToSE06wo5j4wfO3+9t7n2zm0e85wAAwSS7B4EOesJJ9AjJq6m8aVu
         GeU4MSkJ+yxUDK15Kg19nsThE3PeqItDz92AkUYfJA3q8Ozokj38ExioPZt7575N2ART
         4bbFpJ+Td8L8g/dTKQypJtSjikkqK6QS/GzpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=WqzJM7D3m+j/VALbdXaY9LFDVmtXJLRKN7AtxDWWJro=;
        b=Go8HWvJaU3W0eaJLbSkusj+4RgkQO1JvqoolNwXyRseMVhxwTjjmGCTH5wQ3mXZuBe
         t3UJM4NoLi3LGBEjpsCfTBXatlndzMqQd/4LdAvvjq7np2IqJoY5wiKTGjg6aC/lNxSS
         +gAH0VCnayREbfs8ipUpQ1emFvAbMKQhdt/LBe2sMh27emwGZz55A4KkHl7cjWAQlfaC
         wupo8KaVXG3N+fPGZY4C4yZTOOiui1bY5RTDWHKXIPqoyS3W8roqqmf6srmz21Q83NT/
         0zrJnQzCoeL6ACL/3IEBOCuaDlGKU05MVtcKotZsGHMbs11LrT3uSI4dGgCmOTHuWEaR
         4qYg==
X-Gm-Message-State: APjAAAXm7mnd39ycEb6EDQ3EK7mXi4uOLqT2xriRV0LywrafyMxaLj2c
        JuXHZprrHdL87Qg5pD15yvjKMzgC2vyHFWZi
X-Google-Smtp-Source: APXvYqwxjexkqE7+LZN/nSx6c13Elah68botHgYQphHqJmfC4wWyADm1J8XAaOt3unIIR1qRMjUhuA==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr8517714wmk.94.1567788525132;
        Fri, 06 Sep 2019 09:48:45 -0700 (PDT)
Received: from [10.93.12.198] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id y3sm13296858wmg.2.2019.09.06.09.48.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:48:44 -0700 (PDT)
From:   Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Linux Foundation Technical Advisory Board Elections -- Call for
 nominations
Date:   Fri, 6 Sep 2019 12:48:41 -0400
References: <DD187286-CEBE-44B3-A992-F84FC9C9CD26@labbott.name>
 <EDD7B30A-8A0D-45BF-BBD5-4AEFA5625FA1@labbott.name>
To:     linux-kernel@vger.kernel.org
In-Reply-To: <EDD7B30A-8A0D-45BF-BBD5-4AEFA5625FA1@labbott.name>
Message-Id: <16C62493-240B-4C43-9448-6D4DD1FF1828@labbott.name>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 28, 2019, at 1:48 PM, Laura Abbott <laura@labbott.name> wrote:
>=20
>=20
>> On Aug 9, 2019, at 2:26 AM, Laura Abbott <laura@labbott.name> wrote:
>>=20
>> Hello everyone,
>>=20
>> Friendly reminder that the TAB elections are coming soon:
>>=20
>> The Linux Foundation Technical Advisory Board (TAB) serves as the
>> interface between the kernel development community and the Linux
>> Foundation. The TAB advises the Foundation on kernel-related matters,
>> helps member companies learn to work with the community, and works to
>> resolve community-related problems before they get out of hand.  We
>> also support the Code of Conduct committee in their mission.
>>=20
>> The board has ten members, one of whom sits on the Linux Foundation
>> board of directors.
>>=20
>> The election to select five TAB members will be held at the 2019 =
Kernel Summit
>> in Lisbon, Portugal September 9-11. As has been announced[2], we are =
moving to
>> an electronic voting system this year. Further details about the =
exact voting
>> procedures will be coming soon. Anyone is eligible to stand for =
election,
>> simply send your nomination to:
>>=20
>> tech-board-discuss at lists.linux-foundation.org
>>=20
>> With your nomination, please include a short candidate statement. =
This candidate
>> statement should focus on why you are running and what you hope to =
accomplish
>> on the TAB. We will be collecting these statements and making them =
publicly=20
>> available.
>>=20
>> The deadline for receiving nominations is 9am GMT+1 on September 9th =
(the first
>> day of Kernel Summit). Due to the use of electronic voting, this will =
be a hard
>> deadline!
>>=20
>> Current TAB members, and their election year:
>>=20
>> Jon Corbet		2017
>> Greg Kroah-Hartman	2017
>> Steven Rostedt		2017
>> Ted Tso			2017
>> Tim Bird		2017
>>=20
>> Chris Mason		2018
>> Laura Abbott		2018
>> Olof Johansson		2018
>> Kees Cook		2018
>> Dan Williams		2018
>>=20
>> The five slots from 2017 are all up for election.  As always, please
>> let us know if you have questions, and please do consider running.
>>=20
>> Thanks,
>> Laura
>>=20
>> [1] TAB members sit for a term of two years, and half of the board is
>> up for election every year. Five of the seats are up for election =
now.
>> The other five are halfway through their term and will be up for
>> election next year.
>>=20
>> [2] =
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/0065=
82.html
>=20
> Reminder to send in your candidate statements, the current ones are
> available at=20
>=20
> =
https://docs.google.com/document/d/1E3_W1c-xJMx9o2PCnKiGt3vqs-mPh77yNO4GSq=
NipOQ


Final reminder, the deadline is Monday September 9th at  9am UTC+1
(that's 9am Lisbon time). Because we are doing electronic voting this is =
a hard deadline!=
