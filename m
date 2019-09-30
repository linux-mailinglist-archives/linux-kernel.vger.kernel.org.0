Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761ABC1DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfI3JFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 05:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfI3JFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:05:50 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 792D68553F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:05:50 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id d1so4885468plj.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 02:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w21r0Zb12wAoVhXzm3M8FXreooAqskSe2A2BpWXrpxY=;
        b=kM9zgUlJBUt/JNXQ/mr5NBKt2+ClZ49yOKKKPcfblcq7KDCZdISuqAzbcTRgXihco4
         qUIKT7og2pXVEAgsms9F1gWdDqyq3EXqo/N1Ni7/KQGLJ+O65y8878nwHcrTHwPUrdlP
         urGPckP08Mz89L+Eljt4v6aURy++dKCgOTpZpAuKjMCeNgky4uqDpdEN6ew5bDA0VNk/
         RAPDUdsf0XOTBEaPtpQwFOpg+jSHveN9Q4FRr+d5ur3B4+aVR9fbNE5RWqIqqleOMr8F
         1479VFa3Be7iEzPJaQMMOCuNj/sLt49K33fpxOK3YbCIHJD16XPTt94gzZliZkMKzVhh
         AKJw==
X-Gm-Message-State: APjAAAWWtQ7jB2oHJkqN4T8ErTkPwgwUwyVNsbeDMI4wqeCiTGCmhqES
        5C9Y2AATOnA1Sxv1TyBOUKlK+1j9HcZbk7kSpAlIFnUZBN6DaIvI+QN7bsEF87R43S9cqcJ3RHv
        BX5UDoEIRnN8+UsD/Aajun6if
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr25005615pjt.108.1569834349793;
        Mon, 30 Sep 2019 02:05:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYU0VXOKT7nU3DIGlLi/lr9dxOJtQzNphen86nDz5xnGw2xjMfzF1oWem7MIubOvtfXj/f+A==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr25005591pjt.108.1569834349353;
        Mon, 30 Sep 2019 02:05:49 -0700 (PDT)
Received: from [10.76.0.223] ([125.16.200.50])
        by smtp.gmail.com with ESMTPSA id y7sm12546514pgj.35.2019.09.30.02.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:05:48 -0700 (PDT)
Reply-To: mgandhi@redhat.com
Subject: Re: [PATCH] scsi: core: Log SCSI command age with errors
To:     Martin Wilck <mwilck@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com
References: <20190923060122.GA9603@machine1>
 <471732f03049a1528df1d144013d723041f0a419.camel@suse.de>
 <3a8ee584f9846fba94d98d0e6941fefdcbed5d71.camel@redhat.com>
 <f2c97e860f895613ba81b69c962660b0c712723a.camel@suse.de>
From:   "Milan P. Gandhi" <mgandhi@redhat.com>
Organization: Red Hat
Message-ID: <31eb5bb6-ca4e-1c6c-3013-7d94ff49623d@redhat.com>
Date:   Mon, 30 Sep 2019 14:35:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f2c97e860f895613ba81b69c962660b0c712723a.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 2:12 PM, Martin Wilck wrote:
> On Fri, 2019-09-27 at 13:45 -0400, Laurence Oberman wrote:
>>
>> Hi Martin
>>
>> Agreed about log extraction, but turning that on with a busy workload
>> in a production environment is not practical. We cant do it with
>> systems with 1000's of luns and 1000's of IOPS/sec.
>> Also second resolution is good enough for the debug we want to see.
> 
> I gather that you look at a specific problem where second resolution is
> sufficient. For upstream, the generic usefulness should be considered,
> and I don't think we can say today that better-than-second resolution
> will never be useful, so I still vote for milliseconds.

Ok, I will change it to ms.

> Wrt the enablement of the option on highly loaded systems, I'm not sure
> I understand. You need to enable SCSI logging anyway, don't you?

By default we keep the SCSI debug logging disabled or am I missing 
something?

>Is it an issue to have to set 2 sysfs values rather than just one?

The idea here is to capture the above debug data even without 
any user interventions to change any sysfs entries or to enable 
debug logging on busy, critical production systems.

Also, we are not changing the existing text in SCSI command error log,
but we are only adding one single word at the end of message. Ideally
the user scripts are written to grep specific pattern from the logs.
Since we are not replacing any existing text from the logs, the 
scripts should still work with this change as well.

Thanks,
Milan.
