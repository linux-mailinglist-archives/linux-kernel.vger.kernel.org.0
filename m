Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114F718D62A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCTRrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:47:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44308 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbgCTRrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584726467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ML0eP+aWk2EDnwbAIoQX4q7/RfflRtiINBCqeUEFw1o=;
        b=EKIBj0Itg5QM139y5XrZZPrY2Rgo5mT1tOK3FeLOPUeOQrZtevR7KjVPfgzSv/a3HdT1Wa
        rTYrMXJfDHc7HO1Cd3K1sQ17iO5EV9t1eN4HbgHleNpsQR1DDdvB2XZFvJhILDi4dvHhvF
        uI7w9IwWk6Ckjtdgk3LOAZ8mhifMS+4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-K55inVkEMyu6TtFGRX7fgg-1; Fri, 20 Mar 2020 13:47:46 -0400
X-MC-Unique: K55inVkEMyu6TtFGRX7fgg-1
Received: by mail-wm1-f71.google.com with SMTP id f9so2656222wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ML0eP+aWk2EDnwbAIoQX4q7/RfflRtiINBCqeUEFw1o=;
        b=oJBFxh5FldAIAeumCCnX7/FzyMOrRzqBDgNbJgb8G4gI3YyqKX+pXGkR8vnDbYsoFE
         eMtp7g/vke2mCsTLACFgX+JQnNzFgYECaYMYi6LDpVKd+4ElNYPnONPWRDKF7oQb6Uw7
         uLwhP/7QQVuUe8qYFs3LxK1IfyWHkQncajLXaStwfQmAERjpTbFcbiuvEXd/iaWLWVEi
         tM/HD28ca54BEid3j/K6pcrmXU+NoLN8Dg4ZhCcNYiU2Jaz2S8mm4tO8Q96bVLq4Vy2W
         gh6BAyki+oOqFuYKteUNX1bp54M7ya2HeeJ+/fTaTAUjxkgbk22Wfd9QjUIloYYO4CtM
         xFqA==
X-Gm-Message-State: ANhLgQ18vDfUtnsOzcLR2yJlFUGCg+9lbqXcBhEWXRR3t54lB+RBw9IC
        xzUDobyScgWhtpAR8Dxv5y2/vMOs9F9fDP4EpH3ziHQ/eKjjAbbi1tCEa5DhZzrtZenTIvutA7a
        zoMRZBaN0e0JFClK6wTr+B1DI
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr12879124wro.423.1584726465089;
        Fri, 20 Mar 2020 10:47:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtD3GpwMD8sP+05LfUA87TewOZYDlqfBu5l6LImnAPd6aN4fEy1qlayHJPiXmnC+xSyt3bNVQ==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr12879091wro.423.1584726464800;
        Fri, 20 Mar 2020 10:47:44 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id i8sm8901062wrw.55.2020.03.20.10.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 10:47:44 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: remove bogus user-triggerable WARN_ON
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200319174318.20752-1-pbonzini@redhat.com>
 <87o8sr59v9.fsf@nanos.tec.linutronix.de>
 <87lfnv59u8.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef15a35b-3e69-7922-ceda-4a4867054a44@redhat.com>
Date:   Fri, 20 Mar 2020 18:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87lfnv59u8.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 16:23, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>> The WARN_ON is essentially comparing a user-provided value with 0.  It is
>>> trivial to trigger it just by passing garbage to KVM_SET_CLOCK.  Guests
>>> can break if you do so, but if it hurts when you do like this just do not
>>> do it.
>>
>> Yes, it's a user provided value and it's completely unchecked. If that
>> value is bogus then the guest will go sideways because timekeeping is
>> completely busted. At least you should explain WHY you don't care.
> 
> Or why it does not matter....

I can change the commit message to "Guests can break if you do so, but
the same applies to every KVM_SET_* ioctl".  It's impossible to be sure
that userspace doesn't ever send a bogus KVM_SET_CLOCK and later
rectifies it with the right value.

Paolo

