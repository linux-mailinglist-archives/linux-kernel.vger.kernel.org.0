Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D747B25FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 21:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfIMTXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 15:23:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59418 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:23:36 -0400
Received: from [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3] (unknown [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9D41128BD60;
        Fri, 13 Sep 2019 20:23:32 +0100 (BST)
Subject: Re: [PATCH 0/4] null_blk: fixes around nr_devices and log
 improvements
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, kernel@collabora.com,
        krisman@collabora.com
References: <20190913185746.337429-1-andrealmeid@collabora.com>
 <FFDFD18F-C242-46D2-B64B-5515987AD82D@kernel.dk>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <467709ad-e174-4d4a-6906-aba5bf7a8111@collabora.com>
Date:   Fri, 13 Sep 2019 16:22:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <FFDFD18F-C242-46D2-B64B-5515987AD82D@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/19 4:03 PM, Jens Axboe wrote:
> On Sep 13, 2019, at 11:58 AM, André Almeida <andrealmeid@collabora.com> wrote:
>>
>> ﻿Hello,
>>
>> This patch series address feedback for a previous patch series sent by
>> me "docs: block: null_blk: enhance document style"[1].
>>
>> First patch removes a restriction that prevents null_blk to load with
>> (nr_devices == 0). This restriction breaks applications, so it's a bug. I
>> have tested it running the kernel with `null_blk.nr_devices=0`.
>>
>> In the previous series I have changed the type of var nr_devices, but I
>> forgot to change the type at module_param(). The second patch fix that.
>>
>> The third patch uses a cleaver approach to make log messages consistent
>> using pr_fmt and the last one add a note on how to do that at the
>> coding style documentation.
> 
> Please add Fixes tags to your patches. 
> 

I've added to [PATCH 1/4], should I add to all 4 patches?
