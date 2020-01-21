Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC031444D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 20:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAUTJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 14:09:08 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]:44412 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAUTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:09:08 -0500
Received: by mail-qv1-f44.google.com with SMTP id n8so1992971qvg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OkhQvHS8jVFYyzSdwlzdra0fHXrxQRAP81m6ftm1DPo=;
        b=Sn/YEVabYrSO+1xwPBsT1wsX23V+Ss+TkR6cRQZP+XHVFao+nmyPXPSBpe/ZD9Hv1s
         8fT4YVNncAUSpX3hsTV4sPnOFDNe5YnLPXCBUx+ZT6AcTnOrNg2MXhwaINSUxKT8q5Eu
         e+Ef0VCok7XicUl/z3tMEfsPixu8nZ9ghOIu/s8czG5H0BWyyqYL7qnbOOa6SdadIOp4
         b2E5vJtYRt49QoI0MCXJP3m+XeqeFLt6yfK7RESy7Mvr4Z+pqb0c50hyZwhUpsnWDN2W
         RBF7c5xznWOdZ47b64d1IEqExfHkY9Bj2S/ags3M0gnNrLRozyIC2yUCS5sbYK24HJxj
         xHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OkhQvHS8jVFYyzSdwlzdra0fHXrxQRAP81m6ftm1DPo=;
        b=uVFcwz8+00PyzpX0sX0jANZGRQt62p1pnT1qxTLw7RPay4nx3lSsnxwyFYPnu3awDb
         ka+86uriar4GzO8fyRYNmRL1MCpk0BXXrYi4pO2ZIYc/ibO8FTMhDJSg7/vPb31zw9Gz
         VmyESghFGGunaq9nJdJGqRlLVA3unDNUjDHGJ5fv6X+EEumXNBG75mfksBiN5P8Wp1iH
         ok/bkUSXWc3Cgyyo/6E3fRmI/tZP3okYxuZcVjVcIVPVJAZybvVl9mZ99SNJdnJbKxlD
         dcOERjkMV2mMi+H1EWzF3oTJcWuaDryWATzBdZIUTtKtr+8+949sn+ibYqo5I1REMIll
         fCCA==
X-Gm-Message-State: APjAAAVX1beSqirpA0I8H6ETQXZ8Df/vX2IX92nBy+Bq2MnYhqJDJ4Jv
        6fbT9oQoyrplVVC0WSx6E7OfOA==
X-Google-Smtp-Source: APXvYqw0QDyCQ435rTnlGbW4snzDWcupFjquDZIIGXvun07tKi7Z0gmG+0nbTGb34WOwp8jsY+XRhA==
X-Received: by 2002:a0c:cd8e:: with SMTP id v14mr6423089qvm.182.1579633747273;
        Tue, 21 Jan 2020 11:09:07 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v24sm19554611qtq.14.2020.01.21.11.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 11:09:06 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Boot warning at rcu_check_gp_start_stall()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200121161533.GT2935@paulmck-ThinkPad-P72>
Date:   Tue, 21 Jan 2020 14:09:05 -0500
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A6B0325-64C4-4470-91B4-37104CF8DA1A@lca.pw>
References: <20200121141923.GP2935@paulmck-ThinkPad-P72>
 <A230E332-07D0-40A8-A034-33ADB4BFB767@lca.pw>
 <20200121161533.GT2935@paulmck-ThinkPad-P72>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2020, at 11:15 AM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Tue, Jan 21, 2020 at 09:37:13AM -0500, Qian Cai wrote:
>>=20
>>=20
>>> On Jan 21, 2020, at 9:19 AM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>>>=20
>>> One approach would be to boot with =
rcupdate.rcu_cpu_stall_timeout=3D300,
>>> which would allow more time.
>>=20
>> It works for me if once that warning triggered,  give a bit =
information about adjusting the parameter when debugging options are on =
to suppress the warning due to expected long boot.
>=20
> Indeed.  300 seconds as shown above is currently the maximum, but
> please let me know if it needs to be increased.  This module parameter
> is writable after boot via sysfs, so maybe that could be part of the
> workaround.
>=20
>>> Longer term, I could suppress this warning during boot when
>>> CONFIG_EFI_PGT_DUMP=3Dy, but that sounds quite specific.  =
Alternatively,
>>> I could provide a Kconfig option that suppressed this during boot
>>> that was selected by whatever long-running boot-time Kconfig option
>>> needed it.  Yet another approach would be for long-running =
operations
>>> like efi_dump_pagetable() to suppress stalls on entry and re-enable =
them
>>> upon exit.
>>>=20
>>> Thoughts?
>>=20
>> None of the options sounds particularly better for me because there =
could come up with other options may trigger this, memtest comes in =
mind, for example. Then, it is a bit of pain to maintain of unknown.
>=20
> I was afraid of that.  ;-)
>=20
> Could you please send me the full dmesg up to that point?  No =
promises,
> but it might well be that I can make some broad-spectrum adjustment
> within RCU.  Only one way to find out=E2=80=A6

https://cailca.github.io/files/dmesg.txt

