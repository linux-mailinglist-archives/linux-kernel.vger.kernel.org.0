Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBB217A8F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCEPgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 10:36:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53181 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgCEPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583422564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDqdPfPRCfBfra2y+XwHanTcUwRD10NZ8XiVS29LNZI=;
        b=TogOhy88bINfj8HyFZjhEL327VC1yP8sqAMs1Fsh1KakwXVkbHdOWvIBzasOpNheY7GnTT
        8lEadRlEBliSbK7NlgbEc5hT71MHe5oqs+g0hnMwfwGZg4VDYYOIcn629hw3qMnnFrrWGG
        4CpYmgzC3NGT15RY+KJHNrDDDd6qaZA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-y_WCtVFYOCKu5iTH1k4_Cw-1; Thu, 05 Mar 2020 10:36:03 -0500
X-MC-Unique: y_WCtVFYOCKu5iTH1k4_Cw-1
Received: by mail-wr1-f69.google.com with SMTP id c6so2431642wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QDqdPfPRCfBfra2y+XwHanTcUwRD10NZ8XiVS29LNZI=;
        b=TPIHI4NehjV1O/452dsdKVJ0x77XfnLj6MIHlLy5Q6viCTpJF6wXwofxbwlsFaXFGd
         VvfHSDXvnKImNY+cevKM5BCQUy2kFCfmTAsJ8is4TPpOgSCxy332/V4v5XILan4T8LdO
         r4luDqn8pOXnP3e9gxF5rLiM6pG3QUVEv4sTn718eOXEszparq5eth9E+2a6ZGbhYInJ
         MJ0TByYHEms3PawOntN1cbDclz+lNEnszp5pCGmsFI5SyXOi8kHysxaLU50K2cheSHOX
         uw5GH+zbEh0Q1dCKBbs82N8X6qIJHtK2NCFLoXg02Mr4kzkxZGFWmKH/FjjgY3YSVW+R
         N/UQ==
X-Gm-Message-State: ANhLgQ1ZJpZYDkh6XiRZH16MvoOCfAJ6QH1BLwS8479sZrUkFfCOK1s2
        LVxlg0re987wOpwHPWR6+CXI9us2RjP1p3pNPEpIqaaVDq//vKN6Ru5ryE40IEouGzf9HHOMOvi
        bOlRnxHQwoKzDcGZOzXwbEKpu
X-Received: by 2002:a5d:630a:: with SMTP id i10mr10530196wru.273.1583422561516;
        Thu, 05 Mar 2020 07:36:01 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt+ijOsDEICsXiS9lUdy1zIsxfPXi4SqcI64HXJP+9IoYrSTpWafkXBLCoJkPwermHrm8OcQg==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr10530176wru.273.1583422561273;
        Thu, 05 Mar 2020 07:36:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id t124sm10410764wmg.13.2020.03.05.07.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 07:35:59 -0800 (PST)
Subject: Re: [PATCH 0/2] KVM: x86: VMX: cleanup VMXON region allocation
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200305100123.1013667-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a4d3988-3ce8-673c-5128-2ef41f8f327d@redhat.com>
Date:   Thu, 5 Mar 2020 16:35:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305100123.1013667-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 11:01, Vitaly Kuznetsov wrote:
> Minor cleanup with no functional change (intended):
> - Rename 'kvm_area' to 'vmxon_region'
> - Simplify setting revision_id for VMXON region when eVMCS is in use
> 
> Vitaly Kuznetsov (2):
>   KVM: x86: VMX: rename 'kvm_area' to 'vmxon_region'
>   KVM: x86: VMX: untangle VMXON revision_id setting when using eVMCS
> 
>  arch/x86/kvm/vmx/vmx.c | 41 ++++++++++++++++++-----------------------
>  arch/x86/kvm/vmx/vmx.h | 12 +++++++++---
>  2 files changed, 27 insertions(+), 26 deletions(-)
> 

Queued, thanks.

Paolo

