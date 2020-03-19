Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8318ADE4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 09:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCSIEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 04:04:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60047 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgCSIEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584605043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEl0pLZ4r8+wodwkJbIhx3HKM8VKZet5zd3tcPqDYD8=;
        b=QYk3LCaYz9azsXw7kRkMsc8kmjnnNOtRsglvWehSZgyKcE4qukmXGDK6h9qMHbuxz+SEud
        Y7CFT4PhvXXT2QaBG6oblpnPTJ6P72H2YpOm3X2a/hh0xqqJYH0Xa6EcNMdZz4mfbLEtEu
        XsW8vRUB5cdjsiTp9md9ak7EiUSxkGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-oHzY-zSLP4SjqiwewEHa4g-1; Thu, 19 Mar 2020 04:04:02 -0400
X-MC-Unique: oHzY-zSLP4SjqiwewEHa4g-1
Received: by mail-wm1-f72.google.com with SMTP id i24so389460wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 01:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lEl0pLZ4r8+wodwkJbIhx3HKM8VKZet5zd3tcPqDYD8=;
        b=MhmHcxpbtVFZRam9eVadcpml77pZkQuRqRUyGurk6olKocHLl/myrFlbAe2j+0j8O5
         1bnFUGCIbxkLQBESLn3ZHTIAbf05NXCGCaQitBAJHqU7E5+La/jqeV2XI2cFJUfLfoEF
         PvXHtnXRWC/LKwi8w9x/Qw6wkk7mDdIW+g5zoFzXHMWs2uxmTi0B1sqBUnCIYyEuv8ct
         2BZkUxVEozM28FtxveTpg8B9chNZFFKjYEAl8YtDGUuXEOVMfY9YAN+FyZbL3AtCThMC
         kpM2trVuajpQFZ+gLsvBoEpw9mcMlbj/yQ0Z5aKu4hnNDN+SpgV7ik/LNkvJirWwzTxE
         pszA==
X-Gm-Message-State: ANhLgQ04oKNcXxKT43jhXOEsiJ8/zLKY5BIhnN0RyIX5sehiprJddwNZ
        BEHXHtAd3Q+bnZwpQySgC8Gflok70BJnsL9hT7ANd3xSF1NaLodPPbuUqe12Zc+2l8hTnda6N/3
        JbbJCYCR3gmwKUXRbqWlm+1f1
X-Received: by 2002:a1c:f213:: with SMTP id s19mr2143434wmc.116.1584605040910;
        Thu, 19 Mar 2020 01:04:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vspjTqd899Yf1k8PJgtS8xeSIL+IQ2/QCXdXuJ0YaFvyxcyC7BgMkEzKsgBlQ9bG+1311wMJw==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr2143400wmc.116.1584605040676;
        Thu, 19 Mar 2020 01:04:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s15sm2462514wrr.45.2020.03.19.01.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 01:04:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "ltykernel\@gmail.com" <ltykernel@gmail.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic callback
In-Reply-To: <MW2PR2101MB10529A60AF5185BBD7B02E04D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com> <20200317132523.1508-2-Tianyu.Lan@microsoft.com> <871rpp3ba8.fsf@vitty.brq.redhat.com> <MW2PR2101MB10529A60AF5185BBD7B02E04D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Thu, 19 Mar 2020 09:03:57 +0100
Message-ID: <87mu8c22ky.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

>> > --- a/drivers/hv/vmbus_drv.c
>> > +++ b/drivers/hv/vmbus_drv.c
>> > @@ -53,9 +53,12 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned
>> long val,
>> >  {
>> >  	struct pt_regs *regs;
>> >
>> > -	regs = current_pt_regs();
>> > +	vmbus_initiate_unload(true);
>> >
>> > -	hyperv_report_panic(regs, val);
>> > +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>> 
>> With Michael's effors to make code in drivers/hv arch agnostic, I think
>> we need a better, arch-neutral way.
>
> Vitaly -- could you elaborate on what part is not arch-neutral?  I don't see
> a problem.  ms_hyperv and the misc_features field exist for both the x86
> and ARM64 code branches.  It turns out the particular bit for
> GUEST_CRASH_MSR_AVAILABLE is different on the two architectures, but
> the compiler will do the right thing.
>

Ah, apologies, missed the fact that we also call it
'HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE' - I have to admit I was confused
by the 'MSR' part. We can probably rename this to something like
HV_FEATURE_GUEST_CRASH_REGS_AVAILABLE - but not as part of the series.

-- 
Vitaly

