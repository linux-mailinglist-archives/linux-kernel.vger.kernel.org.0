Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D468D340
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfHNMge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 08:36:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44463 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfHNMgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:36:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so110916893wrf.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 05:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wuVjOoaxyYfyWJnYmRPjrLbRW1mIiUBjkOasfY9prsg=;
        b=VhpGSUvvOXtjN0zZevcBDxQXldMnhergpPZC4TuVPVlszDN4jER+N3RHl/8REOWjP8
         NhhLgy+f0m9JGcUlQMbYJvJfk3E+8ICZ8rRDu77kvAR9JdG9Pap8ieeiki9Z4UY047Tc
         meWlpwzEqzaXSUJDjhXZhkRnKJKgukl5+mUxZm9Xay2y6kS5Xh1CjQ/S22p2s5Zm0usN
         NVXJdpx4FMQjV20FBrc7mBOyGni+gBrQkTqoqi4f+Cwaw1sX6o3aMP+F9Gjj2dRhwZz+
         iKu4VUaMjGQt5EajZbi984lXsVJQc4dmKgGdMc+Xk9RqEc7r3+0/co2JhRHte5iK21YR
         yYDw==
X-Gm-Message-State: APjAAAWoDjSrgZgDfOd68NS9yzVrNr4we0SpBrli/uWiIG91ZHg857VR
        IAqU+EpDkA2RoYbmx5EhJtfYsA==
X-Google-Smtp-Source: APXvYqzLtPHooUoQICvLxBgMLkG+W6Oap3eOZe4rPwxKBzM0VTPkTbcjTvwNLTRNTTKwxrSX7/UREw==
X-Received: by 2002:adf:f6d2:: with SMTP id y18mr51783258wrp.102.1565786191460;
        Wed, 14 Aug 2019 05:36:31 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 2sm3572989wmz.16.2019.08.14.05.36.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 05:36:30 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 0/9] Enable Sub-page Write Protection Support
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com
Cc:     mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        yu.c.zhang@intel.com, alazar@bitdefender.com
References: <20190814070403.6588-1-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5db7a1fc-994f-f95b-5813-ffe1801dbfbc@redhat.com>
Date:   Wed, 14 Aug 2019 14:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814070403.6588-1-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/19 09:03, Yang Weijiang wrote:
> EPT-Based Sub-Page write Protection(SPP)is a HW capability which allows
> Virtual Machine Monitor(VMM) to specify write-permission for guest
> physical memory at a sub-page(128 byte) granularity. When this
> capability is enabled, the CPU enforces write-access check for sub-pages
> within a 4KB page.
> 
> The feature is targeted to provide fine-grained memory protection for
> usages such as device virtualization, memory check-point and VM
> introspection etc.
> 
> SPP is active when the "sub-page write protection" (bit 23) is 1 in
> Secondary VM-Execution Controls. The feature is backed with a Sub-Page
> Permission Table(SPPT), SPPT is referenced via a 64-bit control field
> called Sub-Page Permission Table Pointer (SPPTP) which contains a
> 4K-aligned physical address.
> 
> Right now, only 4KB physical pages are supported for SPP. To enable SPP
> for certain physical page, we need to first make the physical page
> write-protected, then set bit 61 of the corresponding EPT leaf entry. 
> While HW walks EPT, if bit 61 is set, it traverses SPPT with the guset
> physical address to find out the sub-page permissions at the leaf entry.
> If the corresponding bit is set, write to sub-page is permitted,
> otherwise, SPP induced EPT violation is generated.

Still no testcases?

Paolo
