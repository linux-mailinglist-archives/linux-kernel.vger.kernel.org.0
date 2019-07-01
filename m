Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7A4714C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFOQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 12:40:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45542 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfFOQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 12:40:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so5543895wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1kclzBY5PNZTommgGhPdgVS2cfCmzWZVTfht0vXTwCQ=;
        b=JZ6U04ArpLq8AS2xkzrb4Pt5Fh1RnVZ1qP63J/hDTfXcvt46/6V+A2mg/PyQWgKfsR
         GSSztIEC1ibdqHNVmLvYNhUsG6UgTdk13cSbTXafmpSnzexoF5W4xl2DC7cGup58lH9v
         LLMxv1QPKGGHY/0M0xexLH+xkvU4+ghDlrT7En/w0khyRuSHpTi2dcpNXK6mHkwy0xye
         vNc/oHqJsz7Sl0mKUtk8+JZkgsB5LRPcIPWZCv9aJxx1dEGpY56wUxCDDbXNLYclFQmO
         aEQQtZCeSI51njJCbs5ScHGrunWce2jOttYa44FgYtMZ7uqhAD4xGn1dkbQ3FihaUxsE
         ANsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1kclzBY5PNZTommgGhPdgVS2cfCmzWZVTfht0vXTwCQ=;
        b=nhm//fAoCKHUAISlbOwrygsGBynL11wITe3wskLuGJSUFtEOf2AtobBJl8m+RnIeqd
         T1kAAJ1zAWoExiBaxGovs/OnBoO3glcqcumW0ixzbu3OkiwKAGuHAvKdR0+5JlHfFpc1
         WyyV07BKrjxBlV4Fc7qBl0mWw5Eu1Ih54TQwtc29tcxsixr9n/rKsxw7MxO0k23AjuxB
         oL/5bu1RYcu3llrsk1uJ+Iv8BcQa+jFI16q5XjxMe/Um6WRfqiWFGqo5FC2XEckaw6p4
         EFun6Rk+/OuWN8/ASnP+vBoTzQ7UdaRdW+qtdLFebkqzo2C0Ag1axEKZYKdZeYenHOVW
         UZSQ==
X-Gm-Message-State: APjAAAWNHlCiSSyzCvf5ySUjcIPaER9EwU3U1ZmEnu6PMH6RzWxuSrOQ
        4MU+R6G1V1PrSVNV6zFyQ1CWBhj/DhJFK56c
X-Google-Smtp-Source: APXvYqy9WEGALvrPT9COz+kWlbL9LXsbakuQb82aL5RDScZUgcY1zebZfqdZqPWKvssB7JsPXoZ9GQ==
X-Received: by 2002:adf:ec49:: with SMTP id w9mr1610492wrn.303.1560616818338;
        Sat, 15 Jun 2019 09:40:18 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id v18sm4121746wrs.80.2019.06.15.09.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 09:40:17 -0700 (PDT)
Subject: Re: [PATCHSET block/for-linus] Assorted blkcg fixes
To:     Tejun Heo <tj@kernel.org>
Cc:     jbacik@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com, dennis@kernel.org,
        jack@suse.cz
References: <20190613223041.606735-1-tj@kernel.org>
 <5d5835d3-d0e4-f4cc-19b1-841b4ad46a9a@kernel.dk>
 <20190615155055.GE657710@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30e86027-ea36-02c5-b3bf-b1f3ce1a9d98@kernel.dk>
Date:   Sat, 15 Jun 2019 10:40:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190615155055.GE657710@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/19 9:50 AM, Tejun Heo wrote:
> Hello,
> 
> On Sat, Jun 15, 2019 at 01:40:50AM -0600, Jens Axboe wrote:
>>> Please refer to each patch's description for details.  Patchset is
>>> also available in the following git branch.
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-fixes
>>>
>>> Thanks.  diffstat follows.
>>
>> Are you fine with these hitting 5.3?
> 
> Yeah, none of them are very urgent.  5.3 should be fine.

OK great, added for 5.3, thanks.

-- 
Jens Axboe

