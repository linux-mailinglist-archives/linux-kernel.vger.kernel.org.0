Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668A4118378
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfLJJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:25:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33059 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:25:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so13166852lfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bwAtdmxvGyrCILPXFQvJnltIvhpI4gs5tXgbrhs6Bw8=;
        b=AAWTnfs/Eo6Hj9n5OB6phmWbD1m15J5X8zumgD18FNQPA7cz27EvX1/21ZhNTbTPUY
         XGkSjBCWioOl7cC9OShUkrEKjWSkJX+5pVSLHJxNAGJsts66j+RkjZKoV9kGHo5xR9kH
         GwHXNIfkPO4sCcaUllxE+QKhWrY0ySSM3eYgYneiUTqBcR+CyGtTLgsL3KPyQtKw0Ib8
         aeR8A4Smt36NwUgCjEfjt5srHlEM9A5By9QYXtSzyR661zdeCMX9O2ejs05kko8w2PCp
         m3RoIKrDuiJa7+GEH9hm00BQcZc0Ry7JEYWvvyK1tkUZw3KKqEB/bG3BzdJmvRp1O2aD
         B1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bwAtdmxvGyrCILPXFQvJnltIvhpI4gs5tXgbrhs6Bw8=;
        b=JHhrnbMU40gFWxsvk6VpeJl5MrE0vjOvB0cLXxgOixBNTy3Oh1u4cQA6mdPtNJG1mH
         /3I+EWYF2yu7ZJm6sGEbBfEG4+6eXnJ2SZii0AngTPQMiQ8XPB9eYXQDg72fpxmnC9SL
         KUyA5LMpSwivOmCddQd391qbk94i2BkB+ThEJqiAJNGSHK23eS9KQGirDqpZ6tKbUkLB
         fSBuNJYWhahmqQ/WNppUw8WNLquMbJcaJjqMxBoIUuehww6HcTfe49ODe8PYPPvOJsMb
         KgHVbK08Fh+bMgb0jyG7w4hYkjnkLku3DkURJiUym8XzFmC8CRoFmTbpn2R+LZMgXvn6
         NHmg==
X-Gm-Message-State: APjAAAVQJFo5b/KRQLRfIPOHGIIRpB8QLSgcpMW+cZAhcgKvFE7iPVBK
        K2+WcM7lDCl607BKi54VPSARJynKA4g=
X-Google-Smtp-Source: APXvYqzm65bVkxT4Df63k0Cw7qZ6HRx7A1/BYXwyrUoXItP8lfD75xLlEPsY+Fw6rS+ESQMXguWwjA==
X-Received: by 2002:a19:c1c1:: with SMTP id r184mr4402876lff.128.1575969902911;
        Tue, 10 Dec 2019 01:25:02 -0800 (PST)
Received: from [192.168.68.106] ([193.119.54.228])
        by smtp.gmail.com with ESMTPSA id 22sm1689626ljw.9.2019.12.10.01.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:25:02 -0800 (PST)
Subject: Re: [Patch v2] mm/hotplug: Only respect mem= parameter during boot
 stage
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mhocko@kernel.org, david@redhat.com,
        jgross@suse.com, akpm@linux-foundation.org
References: <20191210084413.21957-1-bhe@redhat.com>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <75188d0f-c609-5417-aa2e-354e76b7ba6e@gmail.com>
Date:   Tue, 10 Dec 2019 20:24:55 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210084413.21957-1-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/19 7:44 pm, Baoquan He wrote:
> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
> parameter") a global varialbe global max_mem_size is added to store
                  typo ^^^
> the value parsed from 'mem= ', then checked when memory region is
> added. This truly stops those DIMM from being added into system memory
> during boot-time.
> 
> However, it also limits the later memory hotplug functionality. Any
> memory board can't be hot added any more if its region is beyond the
> max_mem_size. System will print error like below:
> 
> [  216.387164] acpi PNP0C80:02: add_memory failed
> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> [  216.392187] acpi PNP0C80:02: Enumeration failure
> 
> From document of 'mem= ' parameter, it should be a restriction during
> boot, but not impact the system memory adding/removing after booting.
> 
>   mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
> 	          ...
> 
> So fix it by also checking if it's during boot-time when restrict memory
> adding. Otherwise, skip the restriction.
> 

The fix looks reasonable, but I don't get the use case. Booting with mem= is
generally a debug option, is this for debugging memory hotplug + limited memory?

Balbir
