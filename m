Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85110961B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfHTN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:56:30 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:50773 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730197AbfHTN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:56:30 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46CXQN57Y8z206n;
        Tue, 20 Aug 2019 15:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1566309388; bh=G05mkwqx5m4yIkkKX3ZwMIHgTqda2Tzgn+twNEiuRR4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=bw9DlNpRy4JRQ97zXKVygurMVQ8s7YZQZfgtfRyXtxmnB6A5oQwYc1S+YHJWFAB0j
         lZJudT+CBV8DJT59G3uk6zg2iw95wfbeAqkhAigwgpxmH/QBqUQ3HV7Kii2U3z3LMm
         U80SnTtLp8VdA4IbZOEF7GmYLU52jJLgQs1UHwgKIKTbsYXXU+iTBCpxpXIEt5Abaq
         9ubM0nuRgqiDX2+h4+N2enWOtZJZT4iP0IL3xDEAFcQiv3iwTdQ0BzaE/IED26KZNT
         GuQJV2/IhXNFnr5YQwdEAM4liSAywY5lE6ppXQGkuFE7oM2pExs2Qxxh+aCwBw5ik5
         nt9/g6vtwSdeQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 109.41.192.99
Received: from [192.168.43.238] (ip-109-41-192-99.web.vodafone.de [109.41.192.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/DC0T+rbhSwNecnpaeQL6Lhl+qDNJu4S4=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46CXQL1LwJz1yRv;
        Tue, 20 Aug 2019 15:56:26 +0200 (CEST)
Subject: Re: Status of Subsystems
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
 <20190820131422.2navbg22etf7krxn@pali>
From:   Sebastian Duda <sebastian.duda@fau.de>
Message-ID: <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
Date:   Tue, 20 Aug 2019 15:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820131422.2navbg22etf7krxn@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.19 15:14, Pali Rohár wrote:
> On Tuesday 20 August 2019 15:05:51 Sebastian Duda wrote:
>> Hello Pali,
>>
>> in my master thesis, I'm using the association of subsystems to
>> maintainers/reviewers and its status given in the MAINTAINERS file.
>> During the research I noticed that there are several subsystems without a
>> status in the maintainers file. One of them is the subsystem `ALPS PS/2
>> TOUCHPAD DRIVER` where you're mentioned as reviewer.
>>
>> Is it intended not to mention a status for your subsystems?
>> What is the current status of these systems?
>>
>> Kind regards
>> Sebastian Duda
> 
> Hi Sebastian! ALPS PS/2 is a driver for ALPS touchpad. They can be
> found on more laptops. And ALPS PS/2 itself is not separate subsystem.
> It is just driver which is part of kernel input subsystem with mailing
> list linux-input@vger.kernel.org.
> 
Hi Pali,

so the status of the files is inherited from the subsystem `INPUT 
MULTITOUCH (MT) PROTOCOL`?

Is it the same with the subsystem `NOKIA N900 POWER SUPPLY DRIVERS` 
(respectively `POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS`)?

Kind regards
Sebastian Duda
