Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9917718A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 09:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCCIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 03:50:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39330 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727412AbgCCIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583225439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHCYOJTmBBdpFLT9MqAvZOM7WPdtVRLxrFg9V7woKHU=;
        b=d8XyHeNuplJ0GjhI/xS+uc3spkH4I+jcRspXPf5Pxz6tniMjB6wrMuKKGAe3mynNK/SGoY
        4LZwtFGmJzvPuE1H4AypTgQ5hih4aL6bCHvTk5AynExwA0pSzJMovuWezDmveqSGojQYcZ
        /SvUeHkrfAx07PXSz8iFXZGIoPezc/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-ckiZ4UOxPUSRzO9pYpGZZA-1; Tue, 03 Mar 2020 03:50:38 -0500
X-MC-Unique: ckiZ4UOxPUSRzO9pYpGZZA-1
Received: by mail-wm1-f70.google.com with SMTP id k65so130807wmf.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHCYOJTmBBdpFLT9MqAvZOM7WPdtVRLxrFg9V7woKHU=;
        b=bD7j0C8GyF1ochA5DMxK97PasQK0UrYeuIsc+CVm8JZaMH/wsid92OzB0c/DxOnzLn
         kjfS7TMDhIat5glukXg+EIweSm0JVP8R1OyZONacydnfcw/Y7Wp3tnpLQA8k8Pncork7
         UO57DZ55qweD8S5WQK+33g2jGhNsnzu1IkeUGF92ZzNtOgZAA1iClO1wPDdjCAXvRgL7
         lKhbnvjbcG6QdiSiRRcDQZCsnbCZOp6CrlSqm6B4N5VT2LiAVQ0p7jEcLCztWFxSB0j+
         l7r0HUpYZE5oHt6HIkWvCrecW3UjbTNSo4z2xAfHDa5wYZNZksVycjPfc6u361kf36A6
         rtrA==
X-Gm-Message-State: ANhLgQ27L2Yvlflked5tqU/iXxQA2ZVWfjfmMfDmNRAoCzgcoDlR2UZR
        AexJIUBAIcrZpKgtqzqmYccyoSGMI5ay6fTOv6i9cVpF+WDhgy6pbg8oK41UOBGxYcuoPgFkUN0
        WP/D8NJTttI0oGosHYj/Hp7A3
X-Received: by 2002:a7b:c183:: with SMTP id y3mr3222182wmi.0.1583225437084;
        Tue, 03 Mar 2020 00:50:37 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsHC5SYzgpmvbQfX4p+aLP1LZEoxbKKcMdLptVUvUe1f3DxH4lN1yoJQf/QIJzqiTTL5Nejkg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr3222168wmi.0.1583225436860;
        Tue, 03 Mar 2020 00:50:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4c52:2f3b:d346:82de? ([2001:b07:6468:f312:4c52:2f3b:d346:82de])
        by smtp.gmail.com with ESMTPSA id n3sm2748163wmc.42.2020.03.03.00.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 00:50:36 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: Properly handle userspace interrupt window
 request
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>
References: <20200303062735.31868-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ba06866-b83d-969f-925d-acb2743de20d@redhat.com>
Date:   Tue, 3 Mar 2020 09:50:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303062735.31868-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 07:27, Sean Christopherson wrote:
> Odds are good that this doesn't solve all the problems with running nested
> VMX and a userspace LAPIC, but I'm at least able to boot a kernel and run
> unit tests, i.e. it's less broken than before.  Not that it matters, I'm
> guessing no one actually uses this configuration, e.g. running a SMP
> guest with the current KVM+kernel hangs during boot because Qemu
> advertises PV IPIs to the guest, which require an in-kernel LAPIC.  I
> stumbled on this disaster when disabling the in-kernel LAPIC for a
> completely unrelated test.  I'm happy even if it does nothing more than
> get rid of the awful logic vmx_check_nested_events().

Yes, userspace LAPIC is more or less constantly broken.  I think it
should be deprecated in QEMU.

Paolo

