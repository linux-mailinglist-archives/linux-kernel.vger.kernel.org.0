Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441FB145A04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 17:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAVQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 11:40:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26827 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725943AbgAVQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579711233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqHfG4M0oTw1WAYPW8dVqwjrZnqacof+6SuwGnZ6EOk=;
        b=eL0V8Hx0+G3GFfbteKlWcjHvYALSc0uGocgDQZO25n2cvqQHRy31f7vXl9Za4mMPMWbxO4
        xmNJSs0Vyd48htJwQeGZvH705mXYnSGfn+7FVlqFz7gOoo1wVeCkp02yZbO/UIS66B4ilH
        loK1WYEqVuj3TuM8KAbBkrVDAk9xPdo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-IPMzbxzONlC2W_n5wxyglQ-1; Wed, 22 Jan 2020 11:40:31 -0500
X-MC-Unique: IPMzbxzONlC2W_n5wxyglQ-1
Received: by mail-wm1-f69.google.com with SMTP id q206so74395wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqHfG4M0oTw1WAYPW8dVqwjrZnqacof+6SuwGnZ6EOk=;
        b=W7xWCcim3s7mIGt3LEDSznD8srxwcTdE98sj/D1dkKQRMNdtfpTuSI490ZoRCZbmDc
         /jhY4FAACjDSqMFnVsupFkEGLWmZr7hHwQpMBcp/dYJ9ZTmqm74likZyl3PfG6bSOfVa
         B+GSxd2N3ZOaP3Re7sVQ2PcBX0xXPUPJlx9SbKYgZKdjZEnmOEtwIOSaEn8WeG5WLxEq
         kkywGxDB5cgzrNdk5zkj6nvZlFBEsACres6QbClrvtv3AmpdhUvMUazA0GWq/5CDvyOI
         rJx+XjeSVjzZtNjaHU4ehlDeSyW8zztH/Y/Zm646mUI6ABYjCnf+Pdm5j2H9HwzCp6hl
         YOSQ==
X-Gm-Message-State: APjAAAUPWTs7HDEXNeLPrZry0Aae5UxI35OanksMpxt7QBvcg2hZ+xVM
        QNwSXabFEF2x05Ws2iermJ96DXADWB2e275nMEVxr5J4Xk2ZpRSi9iqW9IWpRO8x6lbEfJM9uGd
        Cq362J5KLgqweYQlN1l5v+3MM
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3620351wmi.146.1579711230721;
        Wed, 22 Jan 2020 08:40:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlxcCPkPXf8/I59g7+C0rJdwAgIk/Qu1HaZIoBEn1yWRSeks0GxcFaBr6+ZpRZJtcz+Ttzgg==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3620339wmi.146.1579711230491;
        Wed, 22 Jan 2020 08:40:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id q3sm59194052wrn.33.2020.01.22.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:40:29 -0800 (PST)
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization
 out of nested_enable_evmcs()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
References: <20200115171014.56405-1-vkuznets@redhat.com>
 <20200115171014.56405-3-vkuznets@redhat.com>
 <6c4bdb57-08fb-2c2d-9234-b7efffeb72ed@redhat.com>
 <20200122054724.GD18513@linux.intel.com>
 <9c126d75-225b-3b1b-d97a-bcec1f189e02@redhat.com>
 <87eevrsf3s.fsf@vitty.brq.redhat.com> <20200122155108.GA7201@linux.intel.com>
 <87blqvsbcy.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f15d9e98-25e9-2031-2db5-6aaa6c78c0eb@redhat.com>
Date:   Wed, 22 Jan 2020 17:40:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87blqvsbcy.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/20 17:29, Vitaly Kuznetsov wrote:
> Yes, in case we're back to the idea to filter things out in QEMU we can
> do this. What I don't like is that every other userspace which decides
> to enable eVMCS will have to perform the exact same surgery as in case
> it sets allow_unsupported_controls=0 it'll have to know (hardcode) the
> filtering (or KVM_SET_MSRS will fail) and in case it opts for
> allow_unsupported_controls=1 Windows guests just won't boot without the
> filtering.
> 
> It seems to be 1:1, eVMCSv1 requires the filter.

Yes, that's the point.  It *is* a hack in KVM, but it is generally
preferrable to have an easier API for userspace, if there's only one way
to do it.

Though we could be a bit more "surgical" and only remove
SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES---thus minimizing the impact on
non-eVMCS guests.  Vitaly, can you prepare a v2 that does that and adds
a huge "hack alert" comment that explains the discussion?

Paolo

