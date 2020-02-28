Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D441734A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 10:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1J5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 04:57:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26105 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbgB1J5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:57:36 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-WZaAI-opPNCY3__hcJiY0A-1; Fri, 28 Feb 2020 04:57:33 -0500
X-MC-Unique: WZaAI-opPNCY3__hcJiY0A-1
Received: by mail-wr1-f71.google.com with SMTP id z1so1116431wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d8+GwUHzIftWzqoVbVQjzy/I+4cuxvvj+bnHjbB7E24=;
        b=hgWm+n8gkNOBdrzdudACoi72gjH3I9cdZuYfmSJxYr7/WncWVwdJptBbH8A0Bpwz6y
         Cvw+pj19NNoBdOyspsnHvYm+whTEgEmsMNO6xFDG7cIcyPveoTFCShXRFu8vgvq03LOT
         XeSnQtk9aa34EJdoYTf6ZpAlOreSPDC8WHO6dTIdIrfZMpoJW897eG4OAL93DwIV0wBR
         BuXDcrwVmc2aEzQ4LJoFF71oDja6QKU2u15o2exTIgzIVtuSkQprDu+YdiSQh+XK6I0O
         iKM4KjFk4D8wecBaINXZgVCMbgUKuFlvLvDgi8eAwpn1f8s3BYEx1qIWez6Dc3bL+MlL
         2XrQ==
X-Gm-Message-State: APjAAAX+ZFEoJEtWpMZHqzI/Mdg4ssfH6ThJH3Zz+wruLRyr0RFaQWCj
        6Wp4fOR6W9U1JSLYtk7w98BZvMjkPlcwpEJUfJXNz3hZXodJ88q7puqRhQI873ivnHMQ4LJqu1r
        jLq+HMMxSECnVhWg7q+tr6Y6s
X-Received: by 2002:adf:fa86:: with SMTP id h6mr3984573wrr.418.1582883852390;
        Fri, 28 Feb 2020 01:57:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqgS9rDQqsKiBqjZd3BIt0aCW27gk2+4hbj//MY004AmWXLLy+jIX2/mdKC4rzAbqEFnh7jA==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr3984549wrr.418.1582883852092;
        Fri, 28 Feb 2020 01:57:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id h81sm788075wme.12.2020.02.28.01.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 01:57:31 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: Consult only the "basic" exit reason when
 routing nested exit
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200227174430.26371-1-sean.j.christopherson@intel.com>
 <ee8c5eb6-9e3d-620b-d51f-bf0534a05d43@oracle.com>
 <20200227205153.GC17014@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10a7327c-4f2b-bf44-1590-a33ae1cad604@redhat.com>
Date:   Fri, 28 Feb 2020 10:57:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227205153.GC17014@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/20 21:51, Sean Christopherson wrote:
> So part of me thinks the best way to resolve the printing would be to
> modify VMX_EXIT_REASONS to do "| VMX_EXIT_REASONS_FAILED_VMENTRY" where
> appropriate, i.e. on INVALID_STATE, MSR_LOAD_FAIL and MCE_DURING_VMENTRY.
> The downside of that approach is it breaks again when new modifiers come
> along, e.g. SGX's ENCLAVE_EXIT.  But again, the modifier is likely useful
> information.
> 
> I think the most foolproof and informative way to handle this would be to
> add a macro and/or helper function, e.g. kvm_print_vmx_exit_reason(), to
> wrap __print_symbolic(__entry->exit_code, VMX_EXIT_REASONS) so that it
> prints both the name of the basic exit reason as well as the names for
> any modifiers.
> 
> TL;DR: I still like this patch as is, especially since it'll be easy to
> backport.  I'll send a separate patch for the tracepoint issue.

Agreed, thanks.  I queued this one.

Paolo

