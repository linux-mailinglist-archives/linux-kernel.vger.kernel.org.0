Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56E97EF72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404334AbfHBIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:38:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404322AbfHBIiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:38:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so76299961wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 01:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P3tN8hyVu/1rvIEnIJgiZUpPyry7kC//HDrNGU4LrOY=;
        b=bU/VkAOl8ucM4ZoHvZ9DXgRDkyID+EfiwBThmNXLK6DYw44ii4sJQPtqYKiWmSEYWl
         dbITlj/ncVDc4Fw37TOO+uK1HYt37aFX+BJICYWRkrbkEzABbNWq4EyN27hsIPP21hgn
         PkOQQKH2Ax0e3VblSHszNwgtw6krBe4DNms19MxzzUfmIWNkwnrS2d2GcTfEyL89GH28
         fst68RUMYBb+0giMZEj4mXPb+6CymHW0znQ97f8Rh+Mltm411W5F3iK+Pc3RgvzbAG2P
         GJi5xL7CjCBI/GotxMdZVxTazQpSohPAgqsi4UeiM5AHlKcdrDXNh16vuyjcl7gbY8wd
         k7wQ==
X-Gm-Message-State: APjAAAUGk0z1oIKfJMPSJ/Nkw27OySttYZoLqVS3ncAfijuS3hay/id+
        BtI4sRgB67C5CpmbxIkd7XoMsA==
X-Google-Smtp-Source: APXvYqz/g6gdVXMJql0snDFkEgsVaPP5ySOr1zSYLcZjwfcT2WdfDBfS1404UrPoIEPcrPsHrjtU0A==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr55322693wru.280.1564735133718;
        Fri, 02 Aug 2019 01:38:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id i13sm67487079wrr.73.2019.08.02.01.38.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 01:38:53 -0700 (PDT)
Subject: Re: [PATCH] KVM: Disable wake-affine vCPU process to mitigate lock
 holder preemption
To:     Dario Faggioli <dfaggioli@suse.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1564479235-25074-1-git-send-email-wanpengli@tencent.com>
 <04700afaf68114b5ab329f5a5182e21578c15795.camel@suse.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <36f54918-171d-cf72-818e-dc8cec7cd3b0@redhat.com>
Date:   Fri, 2 Aug 2019 10:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <04700afaf68114b5ab329f5a5182e21578c15795.camel@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/19 14:57, Dario Faggioli wrote:
> Can't we achieve this by removing SD_WAKE_AFFINE from the relevant
> scheduling domains? By acting on
> /proc/sys/kernel/sched_domain/cpuX/domainY/flags, I mean?
> 
> Of course this will impact all tasks, not only KVM vcpus. But if the
> host does KVM only anyway...

Perhaps add flags to the unified cgroups hierarchy instead.  But if the
"min_cap close to max_cap" heuristics are wrong they should indeed be fixed.

Paolo
