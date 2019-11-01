Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B91EC724
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 17:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfKAQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 12:56:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50644 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfKAQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:56:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so9977945wmk.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nS/+TuNpW6A1PUyhzxZcAt0Rui/rYCvfdsnTwLIkmXw=;
        b=sk3+H7dO516bj4wsmf/aijFVggFKvvcBuKWoWWmP306tit1N5cx4Qtom236Y07f0ea
         gbRPnVHnWEUHHv4lcm6mJQ0DEJDe09DQAQiaQxkRxtI5n1CPRYhk1NitTna5L6gekVBG
         iRUT+gTn2tXf/bzdLAgVKL1tXWjgPVgYNjTs07ltD51Vs2HqC17+KocxxKXq/ZrWQshU
         kgMl5lViIosBn8ACvqZX5dZ4dtZPR0KdCR6h7sRA77FmOptA1TkPIQIkWf8hQvb5RPPk
         jF/qKqrmwU+l8KR7PXfwXujK6BJO/lo5Dkev274P+I+FtMyEDYwFYAMqhbV4Lh86hXXL
         0ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nS/+TuNpW6A1PUyhzxZcAt0Rui/rYCvfdsnTwLIkmXw=;
        b=qhC7pi394ukUEuaqfoQecScSNHE6pUTVurJjTWD1LjcBbbBQTEqWBQ/2TAbBqeXLM3
         J7aF0PdEtQfoKvGHfqK+GsEaAGCD4XO6ymHKkWI8HEb5RiTv+xUqCJcL+iHLQ16nkdNe
         TBZuXx35ladWhRHQq/Hl11yuBUQQ9PTHU3PPTGOVWnVvyTKKZIpsDOTMeu6fLhf0KjHH
         4GVxD8dYDOj8F5b/dJ4jbRgGprjRyP+J30toXS9bJyCXfSxewCs1ujMeQO1902W0gz5t
         4h9ms36Oj33w7sLUBq2MVi0lTmhCB2pZqiR9+njy8u7P99kMZATybJCI9LasjVB0xuTl
         o1lw==
X-Gm-Message-State: APjAAAWvVh2XarM97t3lIFYq3xaIoRG+ieLnNVX19GV9P/YTexzIaV4z
        +BroVsczrudXZrWosa91lkBDhg==
X-Google-Smtp-Source: APXvYqwgoXxPBgzO8xNejOYYQkCOTTUqypDnz32OSLKzeuCev+CG+dKqipu6ebYcGpFHOLeWRoyvgg==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr10445126wmj.36.1572627410927;
        Fri, 01 Nov 2019 09:56:50 -0700 (PDT)
Received: from [192.168.0.104] (88-147-66-34.dyn.eolo.it. [88.147.66.34])
        by smtp.gmail.com with ESMTPSA id h140sm3832714wme.22.2019.11.01.09.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 09:56:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20191101161506.GA28212@blackbody.suse.cz>
Date:   Fri, 1 Nov 2019 17:56:48 +0100
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        clm@fb.com, dennisz@fb.com, Josef Bacik <jbacik@fb.com>,
        kernel-team@fb.com, newella@fb.com, lizefan@huawei.com,
        axboe@kernel.dk, Rik van Riel <riel@surriel.com>,
        josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F45F2906-AB10-473D-B515-793E8FB10E6A@linaro.org>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
 <20191003145106.GC6678@blackbody.suse.cz>
 <20191003164552.GA3247445@devbig004.ftw2.facebook.com>
 <20191009153629.GA5400@blackbody.suse.cz>
 <20191014153643.GD18794@devbig004.ftw2.facebook.com>
 <20191101161506.GA28212@blackbody.suse.cz>
To:     =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 1 nov 2019, alle ore 17:15, Michal Koutn=C3=BD =
<mkoutny@suse.com> ha scritto:
>=20
> Hello
>=20

Hi Michal,

> (I realize it's likely late for the remark but I'd like to bring it up
> anyway.)
>=20
> On Mon, Oct 14, 2019 at 08:36:43AM -0700, Tejun Heo <tj@kernel.org> =
wrote:
>> We likely can talk on the subject
>> for a really long time probalby because there's no clearly =
technically
>> better choice here, so...
> I agree with you that functionally the two options are equal and also
> from configuration POV they seem both sensible.
>=20
> I checked where BFQ stores its per-device parameters and its under the
> sysfs directory of given device's iosched directory. So from the user
> perspective it'd be more consistent if all similar tunables resided
> under that location.
>=20
> (OTOH, I admit I'm not that familiar with block layer internals to
> identify the overlap between IO scheduler and IO controller.)
>=20

If useful for you to know, BFQ parameters are not meant to changed
(apart from the low_latency tunable, if one wants full control on
weights).  Parameters are a testing aid, to use in case of an anomaly.
After solving the anomaly, default values should be used again.

Thanks,
Paolo

>> Yeah, it's kinda unfortunate that it requires this many parameters =
but
>> at least my opinion is that that's reflecting the inherent
>> complexities of the underlying devices and how workloads interact =
with
>> them.
> After I learnt about the existence of BFQ tunables, I'm no longer
> concerned by the complexity of the parameter space.
>=20
> Thanks for the explanations of QoS purpose.
>=20
>> For QoS parameters, Andy is currently working on a method to =
determine
>> the set of parametesr which are at the edge of total work cliff -
>> ie. the point where tighetning QoS params further starts reducing the
>> total amount of work the device can do significantly.
> The QoS description in the Documentation/ describes the interpretation
> of the individual parameters, however, this purpose and how it works =
was
> not clear to be from that. I think the QoS policy would deserve =
similar
> description in the Documentation/.
>=20
>> Nothing can issue IOs indefinitely without some of them completing =
and
>> the total amount of work a workload can do is conjoined with the
>> completion latencies. [...]
> I may reply to this point later. However, if that provably works, I'm
> likely missing something in my understanding, so that'd be irrelevant.
>=20
> Cheers,
> Michal

