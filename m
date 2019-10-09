Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF84DD1A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 22:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfJIU4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 16:56:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29068 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729535AbfJIU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570654608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=ghIP95f1Z5BF2VVaSb+qX/U3Se4vmJoP2nIW78TEjoY=;
        b=i9LVAPE8k7sOOzaX6mY+9amjngK1sP4arpp391Mdo8vJC+JeJ7rMbuNORPJcDI/2s6YtHq
        Pmy3Ht7L+ntmD+OiPmMM9lczt5mxYtagbcxemRnzppX9QQV7v2cKDTXNs2YStPUqUAU+ez
        FRadw6++MO9bRe4pxa4jb5LRCGnCAWU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-a7gJsP6aNs-AFydwhfirVQ-1; Wed, 09 Oct 2019 16:56:47 -0400
Received: by mail-wr1-f71.google.com with SMTP id o10so1637559wrm.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMFIvbI7tuwGap0RnIGe77DNy9RYz81HW2Xoa3VtEyQ=;
        b=sDOPQr6ye8yNMkY7CcFyIYUpXIbeEjt71xLj9twU0tfwAzDdueA+BBNGV2tSVlwxWE
         ybN3fsk2BxAIvNU//dPQy+emNZ4gmEWH6U+hrrSG64QJpe2lDxpi6FolZhfhRYN80sHn
         Qkoi675J2oia2NFBk9Cfo0dDo6ZULkA/PHlJSevlWcyKOTBuLMuxb7+vDaJyZiiAyQll
         s1qzUxe3rNp0xjEH0HiF8KouRRDLuNX2XINUQVE65eUrBkIgJ45CEgFdOmzQeundGMW1
         atGOe5D1afDm90Kg+p3xoQME4Sh0GWQzWH6g3KtsEcM5haLW5jZ4hNrHLmqgtq3a+YNl
         PSZA==
X-Gm-Message-State: APjAAAUAk5+fhnSURjgxh8BuJ1o7Mjq9/ZggWxdiJ4oOWWmOiQ0g7pB0
        s9iQsR3O6hhDye7h2uUXdxkMSEYSFbXFNSSGB+Mh8OltwfdLi83cVGyUFM16QMH/B24jIFqYRsm
        FBAwfCj+vIG1waakdk4N9DjzI
X-Received: by 2002:adf:dc8c:: with SMTP id r12mr4466708wrj.107.1570654606021;
        Wed, 09 Oct 2019 13:56:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZbo4bXoTjFZE108uPgBJL+qA7fSP/aC9lBHXyp9WbL/rbcJp5yfR1JCu/z5rB8uYb5DGCLQ==
X-Received: by 2002:adf:dc8c:: with SMTP id r12mr4466689wrj.107.1570654605662;
        Wed, 09 Oct 2019 13:56:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1032:7ea1:7f8f:1e5? ([2001:b07:6468:f312:1032:7ea1:7f8f:1e5])
        by smtp.gmail.com with ESMTPSA id z189sm6026703wmc.25.2019.10.09.13.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 13:56:44 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/6] psci: Add hvc call service for ptp_kvm.
To:     John Stultz <john.stultz@linaro.org>
Cc:     "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        "Justin He (Arm Technology China)" <Justin.He@arm.com>,
        nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190918080716.64242-1-jianyong.wu@arm.com>
 <20190918080716.64242-5-jianyong.wu@arm.com>
 <83ed7fac-277f-a31e-af37-8ec134f39d26@redhat.com>
 <HE1PR0801MB1676F57B317AE85E3B934B32F48E0@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <629538ea-13fb-e666-8df6-8ad23f114755@redhat.com>
 <HE1PR0801MB167639E2F025998058A77F86F4890@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <ef6ab8bd-41ad-88f8-9cfd-dc749ca65310@redhat.com>
 <a1b554b8-4417-5305-3419-fe71a8c50842@kernel.org>
 <56a5b885-62c8-c4ef-e2f8-e945c0eb700e@redhat.com>
 <HE1PR0801MB1676115C248E6DF09F9DD5A6F4950@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <1cc145ca-1af2-d46f-d530-0ae434005f0b@redhat.com>
 <HE1PR0801MB1676B1AD68544561403C3196F4950@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <6b8b59b2-a07e-7e33-588c-1da7658e3f1e@redhat.com>
 <CALAqxLVa-BSY0i007GfzKEVU1uak4=eY=TJ3wj6JL_Y-EfY3ng@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <797af843-6ed4-349c-55bf-73a0dab1249b@redhat.com>
Date:   Wed, 9 Oct 2019 22:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVa-BSY0i007GfzKEVU1uak4=eY=TJ3wj6JL_Y-EfY3ng@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: a7gJsP6aNs-AFydwhfirVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 18:05, John Stultz wrote:
> On Wed, Oct 9, 2019 at 2:13 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> John (Stultz), does that sound good to you?  The context is that
>> Jianyong would like to add a hypercall that returns a (cycles,
>> nanoseconds) pair to the guest.  On x86 we're relying on the vclock_mode
>> field that is already there for the vDSO, but being able to just use
>> ktime_get_snapshot would be much nicer.
>=20
> I've not really looked at the code closely in awhile, so I'm not sure
> my suggestions will be too useful.
>=20
> My only instinct is maybe to not include the clocksource pointer in
> the system_time_snapshot, as I worry that structure will then be
> abused by the interface users.  If you're just wanting to make sure
> the clocksource is what you're expecting, would instead putting only
> the clocksource name in the structure suffice?

Well, it would suffice but it would be quite ugly to do a string
comparison later.

What kind of abuse are you thinking of?  We already have struct
system_counterval_t for a clocksource+cycles tuple, so it seemed obvious
to me to make system_time_snapshot a superset of it...  In fact,
system_time_snapshot's cycles member is even unused currently, so it
could even be easily replaced by a struct system_counterval_t, instead
of adding an extra field.

Paolo

