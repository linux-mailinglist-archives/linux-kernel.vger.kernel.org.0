Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624A95E630
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGCONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:13:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34463 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGCONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:13:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so3031837wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 07:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ceMV6gREtUAH3s1rcTbUar/B6JUKROFXvDiwuyYeGXY=;
        b=k5r1tFD6zELecHdyQ5L+y6zPZL27e7+fY6sNs8SPhQGFYM0rmOZYoKegJKsoz3bJ4h
         GcvzbxxZVUIP8S1fnj10asudWDX0wUDRrUOxJWUUjhJubweYfCu36qsMjswJdOLXeRTF
         63WgwTLHNWppNo+HxEfgzTxsKEhu4kcOfDHb2+py1y/mPeL6i8pC7aoaphf4mZiScv0d
         o11F63E3KTYPGqZaCj8FkS7sB5Ck1UItXvQ75JYT87eKz9nRHXxEOz+YkgVMz/2r5N3Y
         2VNsv3m3SgcocvQrWLlMOpj3gP/ly9Ysu53CxtA37YXhksdZisI0TnmkKP121yHfTRPO
         cHXQ==
X-Gm-Message-State: APjAAAUjpOwfPIVHEUSrlSFBr0VmLXknCyj88RZuBbdaPoQVz80T7iRK
        JEaf8/fLRQxLxw2pCvr6ovlk+g==
X-Google-Smtp-Source: APXvYqzNc25USnquIIueAfxvqHocNLi2CDXyM4EEc7JEs2GM3KQJc87l+CG6bfH/8feI9wY5hiX4JA==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr8054265wmj.167.1562163210995;
        Wed, 03 Jul 2019 07:13:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c1d:63cc:b81d:e1a9? ([2001:b07:6468:f312:6c1d:63cc:b81d:e1a9])
        by smtp.gmail.com with ESMTPSA id o4sm2442172wmh.35.2019.07.03.07.13.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 07:13:30 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] KVM: LAPIC: Optimize timer latency consider world
 switch time
To:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1560474949-20497-1-git-send-email-wanpengli@tencent.com>
 <1560474949-20497-2-git-send-email-wanpengli@tencent.com>
 <CANRm+CzUvTTOuYhsGErSDxdNSmxVr7o8d66DF0KOk4v3Meajmg@mail.gmail.com>
 <CANRm+Cw0vmqi4s4HhnMqs=hZZixHmU87CGO_ujTGoN_Osjx76g@mail.gmail.com>
 <CANRm+Cz9Lc5rA7-2yLLX7wiemM-gdvWvQQdGVrvkYanYO9TwgA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18fd2372-45d8-0bff-79e7-373a8b7d129c@redhat.com>
Date:   Wed, 3 Jul 2019 16:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANRm+Cz9Lc5rA7-2yLLX7wiemM-gdvWvQQdGVrvkYanYO9TwgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/19 02:48, Wanpeng Li wrote:
> Hi Paolo, how about this patchset? Patch 2/2 is easy to take, do you
> have more concern about patch 1/2?

I don't know.  It seems somewhat hard to tune and in cyclictest it only
happens for preemption_timer=N.  Are you using preemption_timer=N
together with the LAPIC-timer-on-service-CPU patches?

Paolo
