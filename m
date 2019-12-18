Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39C5123B47
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 01:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLRADB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 19:03:01 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:51778 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRADA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:03:00 -0500
Received: by mail-pj1-f48.google.com with SMTP id j11so4385pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5nJ+jJHzCJTI6fI9kgUKUKhNPF63RFbng1tOaU2bTXk=;
        b=Vz+/nqLNL2ztWQbnOrYZ2bYroFYW3yLJIJutl4Nuxd/HHZ4jVMfPaT0zYEIauzhtwX
         1fd/lfzxFiV70TZfM9yalhCktpeA4qIhSytgLItkSpfByAnbyjPGqa9jadPbMYolvmHw
         juKokiJNcOtO2AAUd7VfOtPaUkUISDuBuntarlFeh3kqaKjsz3n4CsE1Xh8uURAuNSXn
         Wg+dFp6qrK+MRYfH6PQi7HdhjMAvkZBc+8egZP7PskZPE6LGzl3UnvRKksQNhE4nJgRI
         f4VHhrMAdF0wYWOnjXJ9K7TDM/Jq1nBLsf9GVAOESGVTBv6n8xx6Z98N+fW1rvpwnD0n
         eAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5nJ+jJHzCJTI6fI9kgUKUKhNPF63RFbng1tOaU2bTXk=;
        b=fw8uqhrdP85cYzmzQOc2jA6ztukR4Su+R9hUEwih7E4TvPs9Yo9F3bo2sx3QSiUOwf
         PVF6UB1CAdc4o9wCX8Zo2vfBClGhiyhTBW/pQGTLYvN37QQFzJZgLRcKqmbyHCw7sa3d
         NK6AqUrlcKLk6UJq8XYOFTN6FuvDYQlJ61fcGQ4NjXEdpg6npyP6IbukSkSA5wPeHUbr
         pcUWcBJTNzPs9hl4PbksdhfTN3Deyb5KZKdfwNDLcQbV3NGLEoii4Qujt5YtgxW3EBkP
         SHfWdraP8V1255g681fRjmBBjzupsB7AZ6uGl1q97mxls1peZNPUaCtI4dfPWIIr/lxh
         JYEQ==
X-Gm-Message-State: APjAAAXUE72rBn+L/D2PEW2ij0qVPODDIVGB9lSDlBaFwO/KYiAsbOqt
        BrboE1wz590f54NLwoT8e+c4RrzC3bo=
X-Google-Smtp-Source: APXvYqyer7SSfxCJCfuc/q08fRBQh2cvjZTzzf1GB+/hS63zzq/Et3sw4HyTUgZxfSK8W+iBylCOYw==
X-Received: by 2002:a17:90a:ff12:: with SMTP id ce18mr140958pjb.117.1576627379651;
        Tue, 17 Dec 2019 16:02:59 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::13f4? ([2620:10d:c090:180::6446])
        by smtp.gmail.com with ESMTPSA id t30sm127292pgl.75.2019.12.17.16.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 16:02:59 -0800 (PST)
Subject: Re: [PATCH 2/2] io_uring: batch getting pcpu references
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1576621553.git.asml.silence@gmail.com>
 <b72c5ec7f6d9a9881948de6cb88d30cc5e0354e9.1576621553.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ae04c15-e410-5ecc-660a-389fbb03d8ea@kernel.dk>
Date:   Tue, 17 Dec 2019 17:02:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b72c5ec7f6d9a9881948de6cb88d30cc5e0354e9.1576621553.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 3:28 PM, Pavel Begunkov wrote:
> percpu_ref_tryget() has its own overhead. Instead getting a reference
> for each request, grab a bunch once per io_submit_sqes().
> 
> basic benchmark with submit and wait 128 non-linked nops showed ~5%
> performance gain. (7044 KIOPS vs 7423)

Confirmed about 5% here as well, doing polled IO to a fast device.
That's a huge gain!

-- 
Jens Axboe

