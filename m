Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB3FC282
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:23:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54439 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:23:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so4848513wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 01:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BCms3BoxuxZj117QaSQEkXvp05ODrJPrbrWohMMueC4=;
        b=OfewOOhL+QAfF96fa0GKfmUbo0q4uh91B0zalam9bWDIf8f7hioWJJ+TQrEycpqJnJ
         vFbOE+LjWRY9hL0+FgnRlX8qYmb1DvBWaEet5HHxcrYaIOUcZShgzx1PNnUP8TQ7X923
         P3yHaQANLW4PeEaoIEYmAWABAhDKH2yngBSJSWAivhcNtsuUhlpibrnAFcO7eYjKF8b6
         23C4arl7O2Ahg08TUGK7qgiXcp7BKm+xAedIaavtfQni8Sf+n/Q/r1rJiz47uq9i9PfP
         ykKpVJTKcXN+DXwei7H2kXLbt5VlQWv0d0uq6urW3dij/UV6RXBjkQyGWmd02K3nMQYF
         KhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BCms3BoxuxZj117QaSQEkXvp05ODrJPrbrWohMMueC4=;
        b=i6RaZxX5ya4hPQd9Zhg5i0pY540PlndJ5ABxBrfjm8ICl5GSR2V5XnBCrbT9gu12VC
         UrLvAVjPBgaO1uIKkmuDVY4pAqgBjaUsZPx9qDyOObu3Zii2q+DSRT8BSkgRpQT3vC9e
         meQyCO0Y4ug7+8hpPHbrbGknwaDIrO4wc1Kirf6ageLu7qd6tVd7SRJbUS9bIZ9+E41i
         7ImyjubsMBXcPlmq3cq9WcucRtZjbskVUOJZ5c2sdvttubf52H+cyfnIB4gWcffn4l2L
         jFWezkaGET4mfgUQrzMjV1VnGQJrYTEV9dL/28cgX4NtDgd2X54iFMWIwMPDjmB2Tpes
         N18w==
X-Gm-Message-State: APjAAAXT3ve1MWh9sNl+fUvHXcUUpArFV74QnBxKjQUPpAH6ihphSNzU
        HEu1reiCiYT20AzbceGBME4EaQ==
X-Google-Smtp-Source: APXvYqyESXs3BB1OOtL7G36o3hJGQSngOs3IodW8l1oVTMn2lW+q2phaKMmi4kuokbdhSaLTF70XBw==
X-Received: by 2002:a05:600c:2307:: with SMTP id 7mr7293039wmo.154.1573723407147;
        Thu, 14 Nov 2019 01:23:27 -0800 (PST)
Received: from [192.168.100.210] (hipert-gw1.mat.unimo.it. [155.185.5.1])
        by smtp.gmail.com with ESMTPSA id t133sm10806453wmb.1.2019.11.14.01.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:23:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5b0b07fc8e50a1beac215230ca84d955@natalenko.name>
Date:   Thu, 14 Nov 2019 10:23:24 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C824EC38-887E-45DB-A629-A75E99ED7454@linaro.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
 <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
 <65fc0bffbcb2296d121b3d5a79108e76@natalenko.name>
 <5773ff54421ccf179ef57d96e19ef042@natalenko.name>
 <69B451DE-B04B-4E0E-9464-826C4A7619AD@linaro.org>
 <5b0b07fc8e50a1beac215230ca84d955@natalenko.name>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 14 nov 2019, alle ore 09:53, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hi.
>=20
> On 13.11.2019 18:42, Paolo Valente wrote:
>>> Il giorno 13 nov 2019, alle ore 16:01, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>> Ok, you may have given me enough information, thank you very much.
>> Could you please apply the attached (compressed) patch on top of my
>> offending patch?  For review purposes, here is the simple change:
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2728,7 +2728,8 @@ void bfq_release_process_ref(struct bfq_data
>> *bfqd, struct bfq_queue *bfqq)
>>         * freed when dequeued from service. But this is assumed to
>>         * never happen.
>>         */
>> -       if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list))
>> +       if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list) &&
>> +           bfqq !=3D bfqd->in_service_queue)
>>                bfq_del_bfqq_busy(bfqd, bfqq, false);
>>        bfq_put_queue(bfqq);
>=20
> The issue is not reproducible for me after applying this patch.
>=20

Great! I'm sending a V2 with your Tested-by.

Thank you,
Paolo

> Thank you.
>=20
> --=20
>  Oleksandr Natalenko (post-factum)

