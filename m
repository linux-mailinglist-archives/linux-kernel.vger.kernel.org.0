Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58436FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfFFJ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 05:27:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43801 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfFFJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:27:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id r18so1608575wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U91ywhdMkGQGI1rWUGWuzywxMAyROzIgAQcdcL6gXPY=;
        b=CM8zwYbruz7kaEk84Fz7h7aKVLQGOob0uwZVhJ3EHhXCinrSbwCyuj/+5ToxvtENaY
         jVl4XOB/vXttvU1PSqf3D+F0ZCWDu13LlfdnboF3udUDRsBemSlf1hp0InJV12WS/MA3
         jA2UQ1fJ2Z6n14ERXQf8giSEQwztrM/aMkVS2+xyo1JfVWWbW0gxrEj3JkAG6v2kB564
         BvVtxsrQh5onwMjeG6rDvD/py7e6VonCImocerR2w5zdamN3yDrDXqFhQv+ama3KYey5
         AhbuzvXDJ1DPh+M5yTb7iPF9iLnNT8TgdwXQKmziI7VEcrcQPxZWIkmDpWcqM6ET/XXI
         eqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U91ywhdMkGQGI1rWUGWuzywxMAyROzIgAQcdcL6gXPY=;
        b=KiVfDRjtZLVz9kYS9IKRI8yyHOfx4oAs2KO0SWw4G4YEElTCviPoZt3Iq6xQfItsoV
         2YY3vmNkcB5yQoT2Sa2xvM396llWBRsFcd5jksirJTsKd+e1e0wJVxk3AZTpcfzYQx7S
         Zq69DPjAKcoWvUSpt7KenmixeqdbP37QrFd0OJW6k9qlw32lIeybrv6Vc7U9ZPX8rqah
         h63jwBaoCIji09ULmcu6N/KGzNZqZU2ZawjxgiaKq0CwH6/mdk3wHzzAEAyltNQcpKSx
         a5yNt/YTQ3dr9BCtv4OfHlbH7naXehdJnO3I0x8bTKJeqOy3Nt8Y8t9NeZ9/mH5U7pPo
         odCA==
X-Gm-Message-State: APjAAAUV/RVOosxuRru3Q9m8NnqbK/civQSs710c+m/8P3RQem72M7+1
        +OiYlr7F9uh/7h5Zn49TpEY=
X-Google-Smtp-Source: APXvYqy19J5e1eE29L4WFZZfy93GbyufZjIvVJC86krHXtfPLnJhP8uzDSWMEtq0COUvAd2UjFK7fw==
X-Received: by 2002:a5d:474a:: with SMTP id o10mr2462654wrs.157.1559813252343;
        Thu, 06 Jun 2019 02:27:32 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id f10sm1575712wrg.24.2019.06.06.02.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 02:27:31 -0700 (PDT)
Date:   Thu, 6 Jun 2019 17:27:25 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, dm-devel@redhat.com,
        agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm-init: fix 2 incorrect use of kstrndup()
Message-ID: <20190606092725.GA21792@zhanggen-UX430UQ>
References: <20190529013320.GA3307@zhanggen-UX430UQ>
 <fcf2c3c0-e479-9e74-59d5-79cd2a0bade6@acm.org>
 <20190529152443.GA4076@zhanggen-UX430UQ>
 <20190530161103.GA30026@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530161103.GA30026@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 12:11:03PM -0400, Mike Snitzer wrote:
> On Wed, May 29 2019 at 11:24am -0400,
> Gen Zhang <blackgod016574@gmail.com> wrote:
> 
> > On Wed, May 29, 2019 at 05:23:53AM -0700, Bart Van Assche wrote:
> > > On 5/28/19 6:33 PM, Gen Zhang wrote:
> > > > In drivers/md/dm-init.c, kstrndup() is incorrectly used twice.
> > > > 
> > > > It should be: char *kstrndup(const char *s, size_t max, gfp_t gfp);
> > > 
> > > Should the following be added to this patch?
> > > 
> > > Fixes: 6bbc923dfcf5 ("dm: add support to directly boot to a mapped
> > > device") # v5.1.
> > > Cc: stable
> > > 
> > > Thanks,
> > > 
> > > Bart.
> > Personally, I am not quite sure about this question, because I am not 
> > the maintainer of this part.
> 
> Yes, it should have the tags Bart suggested.
> 
> I'll take care it.
> 
> Thanks,
> Mike
Hi,
Is there any updates about this patch? I want to check if it is apllied
beacause I have to write it down in my paper and the deadline is close.

Thanks
Gen
