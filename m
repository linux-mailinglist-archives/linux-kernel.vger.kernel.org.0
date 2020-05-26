Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51D119B754
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 22:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgDAU6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 16:58:03 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39827 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgDAU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:58:02 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so591798pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fZlAHuk2F4d+ui8wzDEPDHhQjgx4bVSsKz7V3eRN6zU=;
        b=ntwMk4TwHZyi+YIrdJXmmutszHrw3D7uhGoyvjG2NW3PSTNjpBPD/o95N/ZobQm8FA
         1Hb7zByes/olaCd6YXvQXBrUNjr8Up3jwlzV6Q6uKUYN0ao4ZqxImWNo04jLaNUVFWMW
         NSCkQ/2pW97trg4ZMzLo40ocqlIOCq+feXkNcrjNUmrSkxA4REpmd4gq0QwqsnfcUsyu
         Vv28eiQhjW+k0YaVCzo0cSO1EImshPCELWypCGaLEyt+FeDdhSsYp0i3dIY+cSDsVCVQ
         TSNAuPsr2Fg4gF5O49xTxuuXxZzEe76tmybptdJEQg1n7WXiG4tJdsok5RsSGYxzjllx
         pb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZlAHuk2F4d+ui8wzDEPDHhQjgx4bVSsKz7V3eRN6zU=;
        b=bryL04FgafyKzrvJEcBH/Q0pJv5CN/jrz0Y3PAldQq6Ouzj6wSpXdTcT7MOF3Ny4kD
         3XRXQXU8E8VpxkWAx5cqiF084DlYreXZXUUtmgRIMWqDnaEx013Ce5JkQ3VmhkRqSYHB
         O1eFb8b+nGk6Qm5rV7iAqPTxu9ytzvtIzb2CooaWv3DqGgFdvh3m+eEkWY1/553MzE5l
         0KYzbwRAMcJbrVV91uMiURq4B6uCYb6wTmPv0QpbcjgeM+/DUlkrAIiGYAwgCbQyGfQV
         TbSomfyjoo8D0jBLUQrAbwlwDTjVEvtzbVBZSx42EfVW/j0lOEne9fxZ3+iLP6Sv6spF
         HvUQ==
X-Gm-Message-State: AGi0PuZNLdXjY3snAExy02XHU4z2NE5w2eZIZ/WQLpfZ5mGT6cD4jFtE
        uCT6OvC72LTmXbvNCpPHHfvPIA==
X-Google-Smtp-Source: APiQypIqopE53bk4l6iIo4tURhe7HYELlSR8NaJ5FLGfoJeQhB/tEBql8Fsz+q4b/YN1bwrOzM2+2Q==
X-Received: by 2002:a17:90a:8d17:: with SMTP id c23mr6753014pjo.187.1585774681993;
        Wed, 01 Apr 2020 13:58:01 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d14sm2227724pfq.29.2020.04.01.13.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 13:58:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] blkcg: don't offline parent blkcg first
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20190724173517.GA559934@devbig004.ftw2.facebook.com>
 <20190724173722.GA569612@devbig004.ftw2.facebook.com>
 <20190724173755.GB569612@devbig004.ftw2.facebook.com>
 <20200401203551.GV162390@mtj.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9ffddda-80e4-2759-e518-99def5ed8156@kernel.dk>
Date:   Wed, 1 Apr 2020 14:57:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401203551.GV162390@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 2:35 PM, Tejun Heo wrote:
> On Wed, Jul 24, 2019 at 10:37:55AM -0700, Tejun Heo wrote:
>> blkcg->cgwb_refcnt is used to delay blkcg offlining so that blkgs
>> don't get offlined while there are active cgwbs on them.  However, it
>> ends up making offlining unordered sometimes causing parents to be
>> offlined before children.
>>
>> Let's fix this by making child blkcgs pin the parents' online states.
>>
>> Note that pin/unpin names are chosen over get/put intentionally
>> because css uses get/put online for something different.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Jens, these two patches slipped through the cracks. Can you please take a look
> at them?

Huh indeed, looks fine to me. I'll add for 5.7, thanks.

-- 
Jens Axboe

