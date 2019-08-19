Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F29294B27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfHSRBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 13:01:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36976 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfHSRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:01:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so199976wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EgLVjCWm2aSpBKA/h4F/AcKRq8Ac9eZqzrttroN/CvE=;
        b=htSuBtX6BfYyokdXZkXjgm8w0jFPq7+sMf/WKAx9OBM9aNodkI9VNkfNNwhcQCWee9
         uCPEZLSpShG89cAv/j0lOqKN8TRmoClw7k8Rz1uGoTTiY/RM5qZIP1QoWCVw62bh2luY
         38YmT50BpEF4rKm2c3iPuXoJGaMBoc8qE9cfrSjhHN0TRQ4WikF/oiDCfpX37ygOhQnl
         mI+OkUYfFlFmyZqgLI0hu7A5BUy0fL4o0OzsLZ2DsAm5ilgdxNgjf+g9WBevQlf0jBeU
         BZO2S+Y9Txx4ZcgXnpys2eR19KHi59Q8uJIwuwd8ODO9wsk4Xait3lvdGJTVdfYxmcUf
         D+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EgLVjCWm2aSpBKA/h4F/AcKRq8Ac9eZqzrttroN/CvE=;
        b=NJRimzBnsSnRgx3HW5rCRziqqk9mcPDmMnlkQNzoS/2yX6laqB4DnNjMfElF99ju5F
         O3VGWGhbDbBmKXaQ5CiLKfkD+7+3PxVVy+8xycpIqWzd9TVKJJQpurM71kX+WSBVPYZ2
         0czF/c8gm2jZub022WbO7gqACqfJ3YCGrgZTqzufM5p8yANFkbnjXNSK3xJeeNP9owta
         flrqgUdINkoUI74C7YawyuFOTuLBSapwF6xXiCM89wRc6VoEj6sz5WaUZdAwlqGZyJXS
         epIJrldTzLRMATJua8YUAtUyCYs0eUkJ3pPWfZEInSdNuHtJiRHNoQZcLyS/VrLc06e0
         pt/Q==
X-Gm-Message-State: APjAAAX+EcUqmAt+Z37O/z57IlmGi1SgG3SbhpSAfx9W/UIYqN0/WCF0
        1QHwx4UQGAtgwqcF9fYfpGrG0A==
X-Google-Smtp-Source: APXvYqzgx5iaNicndIPkFEVZSnPXInbI+oCk9Z8qqJnDN2Esw+KIlqm57GbgvZPMO+Kmqd3o2dlHrA==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr9616201wmj.58.1566234058567;
        Mon, 19 Aug 2019 10:00:58 -0700 (PDT)
Received: from [192.168.0.101] (88-147-64-56.dyn.eolo.it. [88.147.64.56])
        by smtp.gmail.com with ESMTPSA id b136sm32730571wme.18.2019.08.19.10.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 10:00:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: io.latency controller apparently not working
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <FE51815E-787B-474C-A6B2-ABDC8853C772@linaro.org>
Date:   Mon, 19 Aug 2019 19:00:56 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20D79D51-468A-4FA7-9213-F0EC2AD3D78A@linaro.org>
References: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
 <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
 <1842D618-3E31-47FE-8B9C-F26BF1F5349C@linaro.org>
 <20190816175931.cxpdko44cuyq7trj@MacBook-Pro-91.local>
 <88488E82-E360-45B0-B010-209190D32892@linaro.org>
 <FE51815E-787B-474C-A6B2-ABDC8853C772@linaro.org>
To:     Josef Bacik <josef@toxicpanda.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 19 ago 2019, alle ore 18:41, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 16 ago 2019, alle ore 20:17, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>>=20
>>=20
>>> Il giorno 16 ago 2019, alle ore 19:59, Josef Bacik =
<josef@toxicpanda.com> ha scritto:
>>>=20
>>> On Fri, Aug 16, 2019 at 07:52:40PM +0200, Paolo Valente wrote:
>>>>=20
>>>>=20
>>>>> Il giorno 16 ago 2019, alle ore 15:21, Josef Bacik =
<josef@toxicpanda.com> ha scritto:
>>>>>=20
>>>>> On Fri, Aug 16, 2019 at 12:57:41PM +0200, Paolo Valente wrote:
>>>>>> Hi,
>>>>>> I happened to test the io.latency controller, to make a =
comparison
>>>>>> between this controller and BFQ.  But io.latency seems not to =
work,
>>>>>> i.e., not to reduce latency compared with what happens with no =
I/O
>>>>>> control at all.  Here is a summary of the results for one of the
>>>>>> workloads I tested, on three different devices (latencies in ms):
>>>>>>=20
>>>>>>          no I/O control        io.latency         BFQ
>>>>>> NVMe SSD     1.9                   1.9                0.07
>>>>>> SATA SSD     39                    56                 0.7
>>>>>> HDD          4500                  4500               11
>>>>>>=20
>>>>>> I have put all details on hardware, OS, scenarios and results in =
the
>>>>>> attached pdf.  For your convenience, I'm pasting the source file =
too.
>>>>>>=20
>>>>>=20
>>>>> Do you have the fio jobs you use for this?
>>>>=20
>>>> The script mentioned in the draft (executed with the command line
>>>> reported in the draft), executes one fio instance for the target
>>>> process, and one fio instance for each interferer.  I couldn't do =
with
>>>> just one fio instance executing all jobs, because the weight =
parameter
>>>> doesn't work in fio jobfiles for some reason, and because the =
ioprio
>>>> class cannot be set for individual jobs.
>>>>=20
>>>> In particular, the script generates a job with the following
>>>> parameters for the target process:
>>>>=20
>>>> ioengine=3Dsync
>>>> loops=3D10000
>>>> direct=3D0
>>>> readwrite=3Drandread
>>>> fdatasync=3D0
>>>> bs=3D4k
>>>> thread=3D0
>>>> filename=3D/mnt/scsi_debug/largefile_interfered0
>>>> iodepth=3D1
>>>> numjobs=3D1
>>>> invalidate=3D1
>>>>=20
>>>> and a job with the following parameters for each of the =
interferers,
>>>> in case, e.g., of a workload made of reads:
>>>>=20
>>>> ioengine=3Dsync
>>>> direct=3D0
>>>> readwrite=3Dread
>>>> fdatasync=3D0
>>>> bs=3D4k
>>>> filename=3D/mnt/scsi_debug/largefileX
>>>> invalidate=3D1
>>>>=20
>>>> Should you fail to reproduce this issue by creating groups, setting
>>>> latencies and starting fio jobs manually, what if you try by just
>>>> executing my script?  Maybe this could help us spot the culprit =
more
>>>> quickly.
>>>=20
>>> Ah ok, you are doing it on a mountpoint.
>>=20
>> Yep
>>=20
>>> Are you using btrfs?
>>=20
>> ext4
>>=20
>>> Cause otherwise
>>> you are going to have a sad time.
>>=20
>> Could you elaborate more on this?  I/O seems to be controllable on =
ext4.
>>=20
>>> The other thing is you are using buffered,
>>=20
>> Actually, the problem is suffered by sync random reads, which always
>> hit the disk in this test.
>>=20
>>> which may or may not hit the disk.  This is what I use to test =
io.latency
>>>=20
>>> https://patchwork.kernel.org/patch/10714425/
>>>=20
>>> I had to massage it since it didn't apply directly, but running this =
against the
>>> actual block device, with O_DIRECT so I'm sure to be measure the =
actual impact
>>> of the controller, it all works out fine.
>>=20
>> I'm not getting why non-direct sync reads, or buffered writes, should
>> be uncontrollable.  As a trivial example, BFQ in this tests controls
>> I/O as expected, and keeps latency extremely low.
>>=20
>> What am I missing?
>>=20
>=20
> While waiting for your answer, I've added also the direct-I/O case to
> my test.  Now we have also this new case reproduced by the command
> line reported in the draft.
>=20
> Even with direct I/O, nothing changes with writers as interferers,
> apart from latency becoming at least equal to the case of no I/O
> control for the HDD.  Summing up, with writers as interferers (latency
> in ms):
>=20
>            no I/O control        io.latency         BFQ
> NVMe SSD     3                     3                 0.2
> SATA SSD     3                     3                 0.2
> HDD          56                    56                13
>=20
> In contrast, there are important improvements with the SSDs, in case
> of readers as interferers.  This is the new situation (latency still
> in ms):
>=20
>            no I/O control        io.latency         BFQ
> NVMe SSD     1.9                   0.08              0.07
> SATA SSD     39                    0.2               0.7
> HDD          4500                  118               11
>=20

I'm sorry, I didn't repeat tests with direct I/O for BFQ too.  And
results change for BFQ too in case of readers as interferes.  Here
are all correct figures for readers as interferers (latency in ms):

           no I/O control        io.latency         BFQ
NVMe SSD     1.9                   0.08              0.07
SATA SSD     39                    0.2               0.2
HDD          4500                  118               10

Thanks,
Paolo


> Thanks,
> Paolo
>=20
>> Thanks,
>> Paolo
>>=20
>>> Thanks,
>>>=20
>>> Josef

