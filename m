Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8B850954
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 12:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfFXK6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 06:58:24 -0400
Received: from gecko.sbs.de ([194.138.37.40]:42687 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfFXK6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:58:24 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x5OAw6vg021376
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:06 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x5OAw5ja021035;
        Mon, 24 Jun 2019 12:58:05 +0200
Subject: Re: PREEMPT_RT_FULL on x86-32 machine
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-rt-users@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, mwhitehe@redhat.com
References: <20190622081954.GA10751@amd>
 <2804bc5b-18c1-2793-171c-045c0725a6a7@siemens.com>
 <20190624105340.GA21414@amd>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <903a1932-c530-5c45-31ab-a3b4d61d48eb@siemens.com>
Date:   Mon, 24 Jun 2019 12:58:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190624105340.GA21414@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.19 12:53, Pavel Machek wrote:
> Hi!
> 
>>> Is full preemption supposed to work on x86-32 machines?
>>>
>>> Because it does not work for me. It crashes early in boot, no messages
>>> make it to console. Similar configuration for x86-64 boots ok.
>>>
>>
>> Maybe you can also tell which version(s) you tried, and in which
>> configuration(s), and how the crash looked like.
> 
> I wanted to know if the configuration is supposed to work at all
> before starting heavy debugging. From your reply I assume that it
> should work.

We still have at least one 4.4-based 32-bit-only target on RT. But there is 
likely more, even though I'm promoting to use at least a 64-bit kernel on 64-bit 
capable hw for many years, irrespective of RT.

Jan

> 
> I tried 4.19.13-rt1-cip1 among others. Crash is early in boot, I can
> try some early printing...
> 
> Best regards,
> 									Pavel
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
