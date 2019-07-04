Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FCB5F7E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 14:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfGDMVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 08:21:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39669 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfGDMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:21:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so6408767wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 05:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IH5zFYo1I5yjDEFdSVBMphkk2e8qYCoEzKFKC+uCucg=;
        b=cBVc7hqmQwWLY6jJm24+y16+sO56cI9+6vQf3qUO7rvC7ElLrY/glj5RVxdw9IT1/S
         dQDko5gToIXNryctd5GRoUOeVVqItHwdLXNZFXM28y9ynyVL14WHWfL3trPA98HPfo8r
         GIMd8HnevQytyhuTir9p/Ny0yiSNHHrOaPe2k34mkgHCV++YOpFT+8qj+RGljno5/n37
         R9C7Ut4KzcPbuoEuVR5fNZ6LMqzRkNe0YBeDmpNup9Q/ME5mSZKKHF00NovWBnSfZdTq
         0K1FALb0uVfNoA4qxmDsIfTMoTqn33FvhRNblfcJLWqAUF+9rVRHkpNKZfSIcC6QgYuN
         xZgA==
X-Gm-Message-State: APjAAAUFYyO7OWBJbbTi4at/rsLHrAJ1wqkwD6lfzDS6iL+ffF3IjTH5
        zAEyjpgPDVc1dhTFepn0iWRC0Q==
X-Google-Smtp-Source: APXvYqyjO1a9mpW7A6dWRWc0jAR3JNhppp4YOZ0mcNfqSvhVO8tXA5JBoRVCHUfbrijja++M6EUxeg==
X-Received: by 2002:adf:f591:: with SMTP id f17mr35262462wro.119.1562242913349;
        Thu, 04 Jul 2019 05:21:53 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id u6sm1683941wrw.15.2019.07.04.05.21.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 05:21:52 -0700 (PDT)
Subject: Re: [PATCH 0/4] kvm: x86: introduce CONFIG_KVM_DEBUG
To:     wang.yi59@zte.com.cn
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
References: <201907041011168747592@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02bdc233-b846-3350-2f6c-2d578d735c0e@redhat.com>
Date:   Thu, 4 Jul 2019 14:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201907041011168747592@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/19 04:11, wang.yi59@zte.com.cn wrote:
>> For MMU_DEBUG, the way to go is to add more tracepoints, but then
>> converting all pgprintk occurrences to tracepoints would be wrong.  You
>> can only find the "right" tracepoints when debugging MMU code.  I do
>> have a couple patches in this area, I will send them when possible.
> 
> Agreed. Hoping your patches.

I sent them earlier, see "KVM: some x86 MMU cleanup and new tracepoints".

Paolo
