Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4781B125704
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLRWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 17:37:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726561AbfLRWhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576708655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyKH+GG9maQ/CDdFzTvDDSeKNGA19czyfBwyFBCr+TI=;
        b=LBsr8JY8MijAQhcTV37vyfMEcc58qGcVOA71/gUHp+GWkuGz7sNhmcklJ0E7AkcDoj/xwx
        mjT7vNhMkoKaXGq+W4sPeZ3lk2lx67tT+K0egxbLQl3AB9z6YP7J7T2XJP8BPggQ/+cmdn
        lfKv2m9kqJW6Vy3+avSc2UpBtwNMdzc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-640Oy4eJPQCzTctcW1k9Zg-1; Wed, 18 Dec 2019 17:37:34 -0500
X-MC-Unique: 640Oy4eJPQCzTctcW1k9Zg-1
Received: by mail-wr1-f69.google.com with SMTP id u12so1465833wrt.15
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nyKH+GG9maQ/CDdFzTvDDSeKNGA19czyfBwyFBCr+TI=;
        b=V6RDQt+EIAZmYjSXSNQUgfIL+onzg/A9qJrlORjS0eR+t0rUxnQsgPqflR+UwvE1Zg
         4JF4bAYLy258maXx+pTea4UC4QetOhSenzz2w+vFGBbg8D3naZprxYnj+8Mcp5LlECKJ
         GchejtVOGbwkURL9R/1alwuirpHyEGVe8IR8ZPMAe0PdyzElsV11Kfb66ROlwa8l5q+X
         ppNtn1RbC+SWBKiiisBktg+2JbK6srgpMqhgpQbORM+fHn6woWo8eYWMUzhl8AI9nzsb
         aVvJ7gYJyfaJ6kXK7cnhfrk9JGlE2dn+U0MNDFBOQd51zBgcuvDiAtbmLKgn0uRWpPl+
         E4Jw==
X-Gm-Message-State: APjAAAVj4qehvisxBqeABRiCPfXm73ZCUHL/pgkGQp9gxCaJjy1YIYqa
        JCQB1pZXId/4EDlWohcEcPrnMavMyklbx6Wsq9Adoxj+nbbInwxj9khvKKcYw6fTTozrwMzPluq
        /Ch4m1zPpXSKzEcbuYlXDqaXl
X-Received: by 2002:a1c:770e:: with SMTP id t14mr6364241wmi.101.1576708653479;
        Wed, 18 Dec 2019 14:37:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqybTuTVWzLqRLznVN+zxwbM+9s5N0zqn7/jFC4IyZ6tn5C5ybLXwXLHlPz+5TyRSgXHUStnoA==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr6364216wmi.101.1576708653263;
        Wed, 18 Dec 2019 14:37:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c? ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
        by smtp.gmail.com with ESMTPSA id w8sm4110638wmm.0.2019.12.18.14.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 14:37:32 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
 <20191210155259.GD3352@xz-x1>
 <3e6cb5ec-66c0-00ab-b75e-ad2beb1d216d@redhat.com>
 <20191215172124.GA83861@xz-x1>
 <f117d46a-7528-ce32-8e46-4f3f35937079@redhat.com>
 <20191216185454.GG83861@xz-x1>
 <815923d9-2d48-2915-4acb-97eb90996403@redhat.com>
 <20191217162405.GD7258@xz-x1>
 <c01d0732-2172-2573-8251-842e94da4cfc@redhat.com>
 <20191218215857.GE26669@xz-x1> <20191218222420.GH25201@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77b497c8-3939-58d1-166f-6c862d3a8d5b@redhat.com>
Date:   Wed, 18 Dec 2019 23:37:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191218222420.GH25201@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/19 23:24, Sean Christopherson wrote:
> I've lost track of the problem you're trying to solve, but if you do
> something like "vcpu_smm=false", explicitly pass an address space ID
> instead of hardcoding x86 specific SMM crud, e.g.
> 
> 	kvm_vcpu_write*(..., as_id=0);

And the point of having kvm_vcpu_* vs. kvm_write_* was exactly to not
having to hardcode the address space ID.  If anything you could add a
__kvm_vcpu_write_* API that takes vcpu+as_id, but really I'd prefer to
keep kvm_get_running_vcpu() for now and then it can be refactored later.
 There are already way too many memory r/w APIs...

Paolo

