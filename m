Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DED90745
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfHPRwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:52:44 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52070 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfHPRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:52:44 -0400
Received: by mail-wm1-f52.google.com with SMTP id 207so4690395wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k+xusRflpFP0QFvrEvHkmFM6lrPCmbIUxPJWx8KxgCk=;
        b=Ued4AmBDCouf3VdaxlwBFg/PIZRnFcpYnyY1bfhJvN5WGInd6hoi0GPTazl2MaRUCJ
         xsDP//6xOfG4NGmdUhC2z8TR5Rr3pMS5p3JMaVo0ed8Pr4eB9Nvw1c6L2VcbQIQWO4tH
         Z4qezU/ygkmeGIsq81ZAauw5lMGrDT/rXxpjBl40gepR42Qf+lElNzc8FNrPiVeT9QX/
         YsSSz+aAMZkAuB6EPiVeRuiJ+p71MI6vgRepnNw2SYUOSUS880q+mkYYGeN7m3x1EpIQ
         XkE5nYE/FAEp/SE4x7jPhuCnm21r9PvwKcAvAEwsO+3DKPkxQW3hDghikRDx2HTwNz9p
         UA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k+xusRflpFP0QFvrEvHkmFM6lrPCmbIUxPJWx8KxgCk=;
        b=Gd5xFH4a4JKTBYrcBKEOZSedx9UlTBSV7zlxLkDAZc65hmyqIqeVDAeWZxGlWezJYD
         46Hk9XIwlciX3cGJAS7IemP8hwMoDQR69U+NN7LZCaraC9P5QBFST14f++m5kKVHWSA3
         jalYNaPyaZD8v9JAOQ2sideLnBreJfoADv+6UBl1PrcUExKAoE1QnNljkuGGvJXS6Tdj
         U3/7HY1bbuPtgdeO4JEUzIpI5x45aD7N+eBVaSbDjcaD36NKtD7y9x+hFbXsKq1tJN4z
         lV7/DbD/AwiTrpis125y5ajF/LP/h7dGHd+htQbH3wJoPCilGgk6/knFI7x7NaEcdY8D
         x+EA==
X-Gm-Message-State: APjAAAUfq2i3iDI8BJ9mhr0xPfX4PesRMVCPQzhzsa0bK2L11tLAn39M
        lKALS5hhwQ+QV3SyFuW7WLkQ3A==
X-Google-Smtp-Source: APXvYqxQJgAArOlNcboXKAbS4+sOWkkZnADm2KthRsNyunmnj0lkmenB7nqdclIHJstotG/zGp6IZw==
X-Received: by 2002:a05:600c:1087:: with SMTP id e7mr8593857wmd.19.1565977962239;
        Fri, 16 Aug 2019 10:52:42 -0700 (PDT)
Received: from [192.168.0.101] (88-147-32-115.dyn.eolo.it. [88.147.32.115])
        by smtp.gmail.com with ESMTPSA id f70sm9044482wme.22.2019.08.16.10.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 10:52:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: io.latency controller apparently not working
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
Date:   Fri, 16 Aug 2019 19:52:40 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1842D618-3E31-47FE-8B9C-F26BF1F5349C@linaro.org>
References: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
 <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
To:     Josef Bacik <josef@toxicpanda.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 16 ago 2019, alle ore 15:21, Josef Bacik =
<josef@toxicpanda.com> ha scritto:
>=20
> On Fri, Aug 16, 2019 at 12:57:41PM +0200, Paolo Valente wrote:
>> Hi,
>> I happened to test the io.latency controller, to make a comparison
>> between this controller and BFQ.  But io.latency seems not to work,
>> i.e., not to reduce latency compared with what happens with no I/O
>> control at all.  Here is a summary of the results for one of the
>> workloads I tested, on three different devices (latencies in ms):
>>=20
>>             no I/O control        io.latency         BFQ
>> NVMe SSD     1.9                   1.9                0.07
>> SATA SSD     39                    56                 0.7
>> HDD          4500                  4500               11
>>=20
>> I have put all details on hardware, OS, scenarios and results in the
>> attached pdf.  For your convenience, I'm pasting the source file too.
>>=20
>=20
> Do you have the fio jobs you use for this?

The script mentioned in the draft (executed with the command line
reported in the draft), executes one fio instance for the target
process, and one fio instance for each interferer.  I couldn't do with
just one fio instance executing all jobs, because the weight parameter
doesn't work in fio jobfiles for some reason, and because the ioprio
class cannot be set for individual jobs.

In particular, the script generates a job with the following
parameters for the target process:

 ioengine=3Dsync
 loops=3D10000
 direct=3D0
 readwrite=3Drandread
 fdatasync=3D0
 bs=3D4k
 thread=3D0
 filename=3D/mnt/scsi_debug/largefile_interfered0
 iodepth=3D1
 numjobs=3D1
 invalidate=3D1

and a job with the following parameters for each of the interferers,
in case, e.g., of a workload made of reads:

 ioengine=3Dsync
 direct=3D0
 readwrite=3Dread
 fdatasync=3D0
 bs=3D4k
 filename=3D/mnt/scsi_debug/largefileX
 invalidate=3D1

Should you fail to reproduce this issue by creating groups, setting
latencies and starting fio jobs manually, what if you try by just
executing my script?  Maybe this could help us spot the culprit more
quickly.

>  I just tested on Jens's most recent
> tree and io.latency appears to be doing what its supposed to be doing. =
 We've
> also started testing 5.2 in production and it's still working in =
production as
> well.

I tested 5.2 too, same negative outcome.

Thanks,
Paolo

>  The only thing I've touched recently was around wakeups and shouldn't
> have broken everything.  I'm not sure why it's not working for you, =
but a fio
> script will help me narrow down what's going on.  Thanks,
>=20
> Josef

